cask "redis-stack" do
  version "7.4.0-v3"

  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
  name "Redis Stack"
  desc "Redis server with additional database capabilities and the visualisation tool RedisInsight"
  homepage "https://redis.io/"

  depends_on cask: "redis-stack-server"
  depends_on cask: "redis-stack-redisinsight"
  depends_on formula: "redis-stack-service"
end
