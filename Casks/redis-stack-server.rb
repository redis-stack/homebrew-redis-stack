cask "redis-stack-server" do

  homepage "https://redis.io"
  desc "Placeholder description"
  license "Redis Shared Use"
  version "0.0.1"

  url "https://redismodules.s3.amazonaws.com/redis-stack/snapshots/redis-stack-server-99.99.99-1.catalina.zip"
  sha256 "8791be02c15ef338280070e291dd50e19a7f55e5bde6dcec0dcfaf30b0852182"

  depends_on formula: "openssl@1.1"

  binaries = ['redis-cli', 'redis-benchmark', 'redis-check-aof', 'redis-check-rdb', 'redis-sentinel', 'redis-server']

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