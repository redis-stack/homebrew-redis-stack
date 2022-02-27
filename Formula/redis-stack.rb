class RedisStack < Formula
  desc "Placeholder description"
  homepage "https://redis.io"
  url "https://redismodules.s3.amazonaws.com/redis-stack/snapshots/redis-stack-server-99.99.99-1.catalina.zip"
  sha256 "8f27c7d6b642cf80ccb5a45fb9872d2f4139478243ecf65857e5bb330c96614b"
  license "MIT"

  conflicts_with "redis", because: "redis also ships a redis-server and redis-tools binaries"

  depends_on 'redis-stack-server'
  depends_on cask: 'redisinsight'

end
