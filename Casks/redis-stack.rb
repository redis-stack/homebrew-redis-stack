cask "redis-stack" do

  homepage "https://redis.io"
  desc "Placeholder description"
  version "0.0.1"

   # FIXME PLACEHOLDER
  url "https://redismodules.s3.amazonaws.com/redis-stack/snapshots/redis-stack-server-99.99.99-1.catalina.zip"
  sha256 "d6ff5c52b0cabdf3575f5e4613923059ed778b966e76db3d1e05274a1daedbec"

  depends_on cask: "redis-stack-server"
  depends_on cask: "redis-stack-redisinsight"

  # TODO add an uninstall for the dependencies

end
