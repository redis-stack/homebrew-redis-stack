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

  binaries = %w[redis-cli redis-benchmark redis-check-aof redis-check-rdb redis-sentinel redis-server
                redis-stack-server]

  postflight_steps do
    mkdir_p "{{HOMEBREW_PREFIX}}/etc"

    # Seed the user-editable config on first install only — never overwrite
    # an existing file (mirrors the original `unless File.exist?(conffile)`).
    unless_path_exists "{{HOMEBREW_PREFIX}}/etc/redis-stack.conf" do
      copy "{{caskroom_path}}/{{version}}/etc/redis-stack.conf",
           "{{HOMEBREW_PREFIX}}/etc/redis-stack.conf"
    end

    # Link each binary from the caskroom into HOMEBREW_PREFIX/bin.
    # `remove_on_uninstall: true` tells Homebrew to remove these symlinks
    # automatically during uninstall, matching the original behavior.
    symlink "{{caskroom_path}}/{{version}}/bin/redis-cli",
            "{{HOMEBREW_PREFIX}}/bin/redis-cli", remove_on_uninstall: true
    symlink "{{caskroom_path}}/{{version}}/bin/redis-benchmark",
            "{{HOMEBREW_PREFIX}}/bin/redis-benchmark", remove_on_uninstall: true
    symlink "{{caskroom_path}}/{{version}}/bin/redis-check-aof",
            "{{HOMEBREW_PREFIX}}/bin/redis-check-aof", remove_on_uninstall: true
    symlink "{{caskroom_path}}/{{version}}/bin/redis-check-rdb",
            "{{HOMEBREW_PREFIX}}/bin/redis-check-rdb", remove_on_uninstall: true
    symlink "{{caskroom_path}}/{{version}}/bin/redis-sentinel",
            "{{HOMEBREW_PREFIX}}/bin/redis-sentinel", remove_on_uninstall: true
    symlink "{{caskroom_path}}/{{version}}/bin/redis-server",
            "{{HOMEBREW_PREFIX}}/bin/redis-server", remove_on_uninstall: true
    symlink "{{caskroom_path}}/{{version}}/bin/redis-stack-server",
            "{{HOMEBREW_PREFIX}}/bin/redis-stack-server", remove_on_uninstall: true

    # Symlink every .so from the caskroom into HOMEBREW_PREFIX/lib.
    # `source_glob: true` expands the glob and creates one symlink per match,
    # replacing the original `Dir[".../*.so"].each` loop.
    symlink "{{caskroom_path}}/{{version}}/lib/*.so",
            "{{HOMEBREW_PREFIX}}/lib",
            source_glob: true, remove_on_uninstall: true
  end

  uninstall_postflight do
    basepath = HOMEBREW_PREFIX.to_s

    binaries.each do |item|
      dest = "#{basepath}/bin/#{item}"
      next unless File.exist?(dest)

      File.delete(dest) if File.readlink(dest).include?("redis-stack")
    end

    # unlink libraries
    caskbase = "#{caskroom_path}/#{version}"
    Dir["#{caskbase}/lib/*.so"].each do |item|
      lib = File.basename(item)
      destlib = "#{basepath}/lib/#{lib}"
      File.delete(destlib)
    end
  end
end
