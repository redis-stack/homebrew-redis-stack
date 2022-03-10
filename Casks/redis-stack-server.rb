cask "redis-stack-server" do

  homepage "https://redis.io"
  desc "Placeholder description"
  version "99.99.99-1"

  baseos = 'darwin'
  if RUBY_PLATFORM.index('darwin') != nil
    is_x86 = RUBY_PLATFORM.index("x86")
    if is_x86 != nil 
      platform = 'x86_64'
      osnick = 'catalina'
      sslversion = "1.1"
    else
      platform = 'arm64'
      osnick = 'monterey'
      sslversion = "3"
    end
  end

  url "https://redismodules.s3.amazonaws.com/redis-stack/snapshots/redis-stack-server-#{version}.#{osnick}.#{platform}.zip"

  depends_on formula: "openssl@#{sslversion}"

  binaries = ['redis-cli', 'redis-benchmark', 'redis-check-aof', 'redis-check-rdb', 'redis-sentinel', 'redis-server', 'redis-stack-server']

  uninstall_postflight do
    if RUBY_PLATFORM.index('x86') != nil
      basepath = '/usr/local'
    else
      basepath = '/opt/homebrew'
    end
    binaries.each { |item|
      dest = "#{basepath}/bin/#{item}"
      if File.exists?(dest)
        if File.readlink(dest).include?("redis-stack")
          File.delete(dest)
        end
      end
    }

    # unlink libraries
    caskbase = "#{caskroom_path}/#{version}"
    Dir["#{caskbase}/lib/*.so"].each { |item|
      lib = File.basename(lib)
      destlib = "#{basepath}/lib/#{lib}"
      File.delete(destlib)
    }

  end

  postflight do
    if RUBY_PLATFORM.index('x86') != nil
      basepath = '/usr/local'
    else
      basepath = '/opt/homebrew'
    end

    confdir = "#{basepath}/etc"
    if !Dir.exists?(confdir)
      FileUtils.mkdir(confdir)
    end

    conffile = "#{confdir}/redis-stack.conf"
    src = "#{caskroom_path}/#{version}/etc/redis-stack.conf"
    if !File.exists?(conffile)
      FileUtils.cp(src, conffile)
    end

    caskbase = "#{caskroom_path}/#{version}"
    # link binaries
    binaries.each { |item|
      dest = "#{basepath}/bin/#{item}"
      if !File.exists?(dest)
        File.symlink("#{caskbase}/bin/#{item}", dest)
      end
    }

    # link libraries
    Dir["#{caskbase}/lib/*.so"].each { |item|
      lib = File.basename(item)
      File.symlink(item, "#{basepath}/lib/#{lib}")
    }
  end

end
