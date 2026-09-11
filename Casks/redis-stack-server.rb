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

  postflight do
    basepath = HOMEBREW_PREFIX.to_s

    confdir = "#{basepath}/etc"

    FileUtils.mkdir_p(confdir)

    conffile = "#{confdir}/redis-stack.conf"
    src = "#{caskroom_path}/#{version}/etc/redis-stack.conf"
    FileUtils.cp(src, conffile) unless File.exist?(conffile)

    caskbase = "#{caskroom_path}/#{version}"
    # link binaries
    binaries.each do |item|
      dest = "#{basepath}/bin/#{item}"
      File.symlink("#{caskbase}/bin/#{item}", dest) unless File.exist?(dest)
    end

    # link libraries
    Dir["#{caskbase}/lib/*.so"].each do |item|
      lib = File.basename(item)
      File.symlink(item, "#{basepath}/lib/#{lib}")
    end
  end

  uninstall_postflight_steps do
    # Only remove a binary symlink if it actually points into the caskroom —
    # mirrors the original File.readlink().include?("redis-stack") check.
    # Paths use the {{HOMEBREW_PREFIX}} template (not Ruby interpolation),
    # which the steps DSL substitutes at load time.
    remove "{{HOMEBREW_PREFIX}}/bin/redis-cli",          symlink_target_contains: "redis-stack"
    remove "{{HOMEBREW_PREFIX}}/bin/redis-benchmark",    symlink_target_contains: "redis-stack"
    remove "{{HOMEBREW_PREFIX}}/bin/redis-check-aof",    symlink_target_contains: "redis-stack"
    remove "{{HOMEBREW_PREFIX}}/bin/redis-check-rdb",    symlink_target_contains: "redis-stack"
    remove "{{HOMEBREW_PREFIX}}/bin/redis-sentinel",     symlink_target_contains: "redis-stack"
    remove "{{HOMEBREW_PREFIX}}/bin/redis-server",       symlink_target_contains: "redis-stack"
    remove "{{HOMEBREW_PREFIX}}/bin/redis-stack-server", symlink_target_contains: "redis-stack"

    # The postflight symlinks every .so from caskroom into {{HOMEBREW_PREFIX}}/lib.
    # Only remove the symlinks whose target references redis-stack so any
    # user-installed libraries at the same path are preserved.
    remove "{{HOMEBREW_PREFIX}}/lib/*.so", symlink_target_contains: "redis-stack"
  end
end
