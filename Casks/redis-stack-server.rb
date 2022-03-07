cask "redis-stack-server" do

  homepage "https://redis.io"
  desc "Placeholder description"
  version "0.0.1"

  url "https://redismodules.s3.amazonaws.com/redis-stack/snapshots/redis-stack-server-99.99.99-1.catalina.zip"
  sha256 "d6ff5c52b0cabdf3575f5e4613923059ed778b966e76db3d1e05274a1daedbec"

  depends_on formula: "openssl@1.1"

  binaries = ['redis-cli', 'redis-benchmark', 'redis-check-aof', 'redis-check-rdb', 'redis-sentinel', 'redis-server', 'redis-stack-server']

  uninstall_preflight do
    binaries.each {|item|
      dest = "/usr/local/bin/#{item}"
      if File.exists?(dest)
        if File.readlink(dest).include?("redis-stack")
          File.delete(dest)
        end
      end
    }
  end

  postflight do
    binaries.each { |item|
      dest = "/usr/local/bin/#{item}"
      if !File.exists?(dest)
        File.symlink("#{caskroom_path}/#{version}/bin/#{item}", dest)
      end
    }
  end

end
