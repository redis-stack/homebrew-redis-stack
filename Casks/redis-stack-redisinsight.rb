cask "redis-stack-redisinsight" do
  arch arm: "arm64", intel: "x64"

  version "2.64.1"
  sha256 arm:   "2da08a97de6d7349622401a78b6323bca1a1f1c29079b91e937e9eaeec56f628",
         intel: "5adb0f72fe0f5751bfeb43783cf0655dc8645099685dc48d372d811b2946286f"

  url "https://s3.amazonaws.com/redisinsight.download/public/releases/#{version}/redisstack/Redis-Insight-app-darwin.#{arch}.tar.gz"
  name "RedisInsight"
  desc "Graphical tool for visualizing data and managing Redis databases"
  homepage "https://redis.com/redis-enterprise/redis-insight/"

  app "Redis Insight.app"
end
