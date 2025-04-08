class RedisStackService < Formula
  desc "Service wrapper for redis-stack-server cask"
  homepage "https://redis.io/"
  version "7.4.0-v3"

  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  def install
    (buildpath/"README.md").write <<~EOS
      # redis-stack-server service
      This formula provides a service for the redis-stack-server cask.
    EOS

    (buildpath/"redis-stack-service").write <<~EOS
      #!/bin/bash
      CASK_BIN="#{HOMEBREW_PREFIX}/bin/redis-stack-server"
      CASK_CONF="#{HOMEBREW_PREFIX}/etc/redis-stack.conf"
      
      if [ ! -f "$CASK_BIN" ]; then
        echo "Error: redis-stack-server binary not found at $CASK_BIN"
        echo "Please install with: brew install --cask redis-stack-server"
        exit 1
      fi
      
      if [ ! -f "$CASK_CONF" ]; then
        echo "Error: redis-stack.conf not found at $CASK_CONF"
        echo "Please install with: brew install --cask redis-stack-server"
        exit 1
      fi
      
      exec "$CASK_BIN" "$CASK_CONF" "$@"
    EOS

    bin.install "redis-stack-service"
    chmod 0755, bin/"redis-stack-service"
    
    prefix.install "README.md"

    (var/"db/redis-stack").mkpath
    (var/"log").mkpath
    (var/"run").mkpath
  end

  service do
    run [opt_bin/"redis-stack-service"]
    keep_alive true
    error_log_path var/"log/redis-stack.log"
    log_path var/"log/redis-stack.log"
    working_dir var
  end

  def post_install
    unless File.exist?("#{HOMEBREW_PREFIX}/bin/redis-stack-server")
      ohai "redis-stack-server cask is not installed"
      ohai "Please install it with: brew install --cask redis-stack-server"
    end
  end
end 
