cask "redis-stack-redisinsight" do
  arch arm: "arm64", intel: "x64"

  version "2.70.1"
  sha256 arm:   "b2e087db180c590efdb5c08fc4cba29009996a4c7e2e6bbf44ecc0c3373e2d67",
         intel: "985008e5c465ad6c468ef40e5c85e2fe16cb77de990521e5ee4a0d62d7a672fc"

  url "https://s3.amazonaws.com/redisinsight.download/public/releases/#{version}/redisstack/Redis-Insight-app-darwin.#{arch}.tar.gz"
  name "RedisInsight"
  desc "Graphical tool for visualizing data and managing Redis databases"
  homepage "https://redis.com/redis-enterprise/redis-insight/"

  app "Redis Insight.app"
end
