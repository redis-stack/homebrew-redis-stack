cask "redis-stack-redisinsight" do
  arch arm: "arm64", intel: "x64"

  version "2.70.1"
  sha256 arm:   "e4fc7221b3647de7431d4468c5006de295b91cdea8743e8a670e5cbbbe857d57",
         intel: "62c63f3114d7bffaf0f6b40345ccbd5a28d5c6ff1f4ead9d328c5b798bfde6d3"

  url "https://s3.amazonaws.com/redisinsight.download/public/releases/#{version}/redisstack/Redis-Insight-app-darwin.#{arch}.tar.gz"
  name "RedisInsight"
  desc "Graphical tool for visualizing data and managing Redis databases"
  homepage "https://redis.com/redis-enterprise/redis-insight/"

  app "Redis Insight.app"
end
