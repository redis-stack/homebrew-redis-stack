cask "redis-stack-redisinsight" do
  version "2.34.0"
  name "RedisInsight"
  desc "A graphical tool for visualizing data and managing Redis databases"
  homepage "https://redis.com/redis-enterprise/redis-insight/"

  # platform = RUBY_PLATFORM.split('-')[0].split('.')[1]
  platform = nil
  baseos = 'darwin'
  if RUBY_PLATFORM.index('darwin') != nil
    is_x86 = RUBY_PLATFORM.index("x86")
    if is_x86 != nil
      platform = 'x64'
    else
      platform = 'arm64'
    end
  end

  url "https://s3.amazonaws.com/redisinsight.download/public/releases/#{version}/redisstack/RedisInsight-v2-app-#{baseos}.#{platform}.tar.gz"
  app "RedisInsight-v2.app"

  uninstall_preflight do
    if RUBY_PLATFORM.index('x86') != nil
      basepath = '/usr/local/bin'
    else
      basepath = '/opt/homebrew/bin'
    end
    File.delete("#{basepath}/redisinsight")
  end

  postflight do
    if RUBY_PLATFORM.index('x86') != nil
      basepath = '/usr/local/bin'
    else
      basepath = '/opt/homebrew/bin'
    end
    dest = "#{basepath}/redisinsight"
    File.open(dest, 'w+') { |f|
      f.write("#!/bin/sh\n\n")
      f.write("open /Applications/RedisInsight-v2.app\n")
    }
    FileUtils.chmod(0755, dest)
  end
end
