cask "redis-stack-redisinsight" do
  version "2.0.4-preview"
  name "RedisInsight"
  desc "Placeholder"
  homepage "https://redis.com/redis-enterprise/redis-insight/"

  url "https://s3.amazonaws.com/redisinsight.test/public/rs-ri-builds/redisinsight.app-darwin-x64.tar.gz"
  sha256 "f82e6c210673a2439e42429342b9b35cb5bfdc8b00a88a45e0f4bc2b34b331e3"

  app "RedisInsight-preview.app"

  uninstall_preflight do
    File.delete('/usr/local/bin/redisinsight')
  end

  postflight do
    File.symlink("/Applications/RedisInsight-preview.app/Contents/MacOS/RedisInsight-preview", "/usr/local/bin/redisinsight")
  end
end
