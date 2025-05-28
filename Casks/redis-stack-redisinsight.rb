cask "redis-stack-redisinsight" do
  arch arm: "arm64", intel: "x64"

  version "2.70.0"
  sha256 arm:   "8db50a12a64a5bbafc8e39077d192b7209d7df7d2b82635ee4cbdcd8f821dfbb",
         intel: "3ccf129ef1179ddd13ff048907ea77a5e7d6f9c1c2dfda496e6cd596b6d04310"

  url "https://s3.amazonaws.com/redisinsight.download/public/releases/#{version}/redisstack/Redis-Insight-app-darwin.#{arch}.tar.gz"
  name "RedisInsight"
  desc "Graphical tool for visualizing data and managing Redis databases"
  homepage "https://redis.com/redis-enterprise/redis-insight/"

  app "Redis Insight.app"
end
