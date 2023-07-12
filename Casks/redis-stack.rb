cask "redis-stack" do

  homepage "https://redis.io"
  name "Redis Stack"
  desc "Redis server with additional database capabilities and the visualisation tool RedisInsight."
  version "6.2.6-9"

  # FIXME PLACEHOLDER
  url "https://redismodules.s3.amazonaws.com/redis-stack/.donotremove"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  depends_on cask: "redis-stack-server"
  depends_on cask: "redis-stack-redisinsight"

end
