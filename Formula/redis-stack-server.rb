class RedisStackServer < Formula
  desc "Placeholder description"
  homepage "https://redis.io"
  url "https://redismodules.s3.amazonaws.com/redis-stack/snapshots/redis-stack-server-99.99.99-1.catalina.zip"
  sha256 "8f27c7d6b642cf80ccb5a45fb9872d2f4139478243ecf65857e5bb330c96614b"
  license "MIT"

  conflicts_with "redis", because: "redis also ships a redis-server and redis-tools binaries"

  def install
    bin.install "bin/redis-cli"
    bin.install "bin/redis-server"
    bin.install "bin/redis-benchmark"
    bin.install "bin/redis-check-aof"
    bin.install "bin/redis-sentinel"
    bin.install "bin/redis-check-rdb"
  end

  def uninstall
    bin.uninstall "bin/redis-cli"
    bin.uninstall "bin/redis-server"
    bin.uninstall "bin/redis-benchmark"
    bin.uninstall "bin/redis-check-aof"
    bin.uninstall "bin/redis-sentinel"
    bin.uninstall "bin/redis-check-rdb"
  end

  test do
    system "#{bin}/redis-server", "--version"
  end
end
