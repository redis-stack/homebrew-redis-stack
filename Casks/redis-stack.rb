cask "redis-stack" do

  homepage "https://redis.io"
  desc "Placeholder description"
  version "1.0.1"

  # FIXME PLACEHOLDER
  url "https://redismodules.s3.amazonaws.com/redis-stack/.donotremove"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  depends_on cask: "redis-stack-server"
  depends_on cask: "redis-stack-redisinsight"

end
