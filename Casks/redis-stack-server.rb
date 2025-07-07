cask "redis-stack-server" do
  arch arm: "sonoma.arm64", intel: "ventura.x86_64"

  version "7.4.0-v6"
  sha256 arm:   "bce6489df999f6f562e6c2d42a69211f4af700f672d61ae4847520ce846dcf78",
         intel: "60157a0649b0fcf5c3d076d8e793901b08dd3699161baa84af2792d444b4de52"

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
