cask "redis-stack" do

  homepage "https://redis.io"
  desc "Placeholder description"
  license "Redis Shared Use"
  version "0.0.1"

   # FIXME PLACEHOLDER
  url "https://redismodules.s3.amazonaws.com/redis-stack/snapshots/redis-stack-server-99.99.99-1.catalina.zip"
  sha256 "8791be02c15ef338280070e291dd50e19a7f55e5bde6dcec0dcfaf30b0852182"

  depends_on cask: "redis-stack-server"
  depends_on cask: "redis-stack-redisinsight"

  # TODO add an uninstall for the dependencies

end