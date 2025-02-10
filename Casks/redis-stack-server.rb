cask "redis-stack-server" do
  arch arm: "sonoma.arm64", intel: "ventura.x86_64"

  version "7.4.0-v3"
  sha256 arm:   "fc427d53d137d8813c6feeeb9fb6843b8034b8ac4c15e8f35c5c1510a2c79634",
         intel: "aa751bc245336f4c726b5a898a78c957737a0485efebd4ba982ac9bc24ab208f"

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
