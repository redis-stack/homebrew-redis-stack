cask "redis-stack-redisinsight" do
  arch arm: "arm64", intel: "x64"

  version "2.66.0"
  sha256 arm:   "3a51e4bba14ba1d0348c9566f9bc57414eece16c92852585ab656e6e60a4bb06",
         intel: "f6ac62d3125b683b377f1588deef3c9e17d7758ce46e4cefb502f45f62f2ee98"

  url "https://s3.amazonaws.com/redisinsight.download/public/releases/#{version}/redisstack/Redis-Insight-app-darwin.#{arch}.tar.gz"
  name "RedisInsight"
  desc "Graphical tool for visualizing data and managing Redis databases"
  homepage "https://redis.com/redis-enterprise/redis-insight/"

  app "Redis Insight.app"
end
