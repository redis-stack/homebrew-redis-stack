cask "redis-stack-server" do
  arch arm: "sonoma.arm64", intel: "ventura.x86_64"

  version "7.4.0-v8"
  sha256 arm:   "4b063a410120843f6e493fa52d433b17ad79b57adc751b9f8050aa81874f04da",
         intel: "7a1d6cfcfd80c6285e114c3169562a4a2fb0f2a2b70f2a65badf0ca689a4722d"

  url "https://packages.redis.io/redis-stack/redis-stack-server-#{version}.#{arch}.zip"
  desc "Installs a Redis server with additional database capabilities"
  homepage "https://redis.io/"

  depends_on formula: "openssl@3"
  depends_on formula: "libomp"

  postflight_steps do
    mkdir_p "etc", base: :homebrew_prefix
    mkdir_p "bin", base: :homebrew_prefix
    mkdir_p "lib", base: :homebrew_prefix

    unless_path_exists "etc/redis-stack.conf", base: :homebrew_prefix do
      copy "etc/redis-stack.conf", "etc/redis-stack.conf",
           target_base: :homebrew_prefix,
           overwrite:   false
    end

    # Preserve the existing policy of skipping occupied executable paths.
    unless_path_exists "bin/redis-cli", base: :homebrew_prefix do
      symlink "bin/redis-cli", "bin/redis-cli",
              target_base:         :homebrew_prefix,
              remove_on_uninstall: true
    end

    unless_path_exists "bin/redis-benchmark", base: :homebrew_prefix do
      symlink "bin/redis-benchmark", "bin/redis-benchmark",
              target_base:         :homebrew_prefix,
              remove_on_uninstall: true
    end

    unless_path_exists "bin/redis-check-aof", base: :homebrew_prefix do
      symlink "bin/redis-check-aof", "bin/redis-check-aof",
              target_base:         :homebrew_prefix,
              remove_on_uninstall: true
    end

    unless_path_exists "bin/redis-check-rdb", base: :homebrew_prefix do
      symlink "bin/redis-check-rdb", "bin/redis-check-rdb",
              target_base:         :homebrew_prefix,
              remove_on_uninstall: true
    end

    unless_path_exists "bin/redis-sentinel", base: :homebrew_prefix do
      symlink "bin/redis-sentinel", "bin/redis-sentinel",
              target_base:         :homebrew_prefix,
              remove_on_uninstall: true
    end

    unless_path_exists "bin/redis-server", base: :homebrew_prefix do
      symlink "bin/redis-server", "bin/redis-server",
              target_base:         :homebrew_prefix,
              remove_on_uninstall: true
    end

    unless_path_exists "bin/redis-stack-server", base: :homebrew_prefix do
      symlink "bin/redis-stack-server", "bin/redis-stack-server",
              target_base:         :homebrew_prefix,
              remove_on_uninstall: true
    end

    # Keep this list in sync with lib/*.so in both release archives.
    # Explicit targets let Homebrew remove only matching links on uninstall.
    symlink "lib/libredisgears_v8_plugin.so", "lib/libredisgears_v8_plugin.so",
            target_base:         :homebrew_prefix,
            remove_on_uninstall: true
    symlink "lib/redisbloom.so", "lib/redisbloom.so",
            target_base:         :homebrew_prefix,
            remove_on_uninstall: true
    symlink "lib/rediscompat.so", "lib/rediscompat.so",
            target_base:         :homebrew_prefix,
            remove_on_uninstall: true
    symlink "lib/redisearch.so", "lib/redisearch.so",
            target_base:         :homebrew_prefix,
            remove_on_uninstall: true
    symlink "lib/redisgears.so", "lib/redisgears.so",
            target_base:         :homebrew_prefix,
            remove_on_uninstall: true
    symlink "lib/redistimeseries.so", "lib/redistimeseries.so",
            target_base:         :homebrew_prefix,
            remove_on_uninstall: true
    symlink "lib/rejson.so", "lib/rejson.so",
            target_base:         :homebrew_prefix,
            remove_on_uninstall: true
  end
end
