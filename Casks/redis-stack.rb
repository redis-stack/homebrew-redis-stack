cask "redis-stack" do
  version "7.4.0-v4"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  # FIXME: PLACEHOLDER
  url "https://redismodules.s3.amazonaws.com/redis-stack/.donotremove"
  name "Redis Stack"
  desc "Redis server with additional database capabilities and the visualisation tool RedisInsight"
  homepage "https://redis.io/"

  depends_on cask: "redis-stack-server"
  depends_on cask: "redis-stack-redisinsight"
end
