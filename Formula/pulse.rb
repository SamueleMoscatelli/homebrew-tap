class Pulse < Formula
  desc "Static analyzer and Quality Gate for AI assets: instructions, agents, prompts, skills, MCP configs and hooks"
  homepage "https://github.com/SamueleMoscatelli/pulse"
  version "1.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/SamueleMoscatelli/pulse/releases/download/v1.2.0/pulse-cli-aarch64-apple-darwin.tar.xz"
      sha256 "f6cdaf7846e98d73c90e0ee7e13ae634d93cb710a7fff470eac2d235521abb34"
    end
    if Hardware::CPU.intel?
      url "https://github.com/SamueleMoscatelli/pulse/releases/download/v1.2.0/pulse-cli-x86_64-apple-darwin.tar.xz"
      sha256 "b6d8089a0711e290b8787d009bfa9b008919b3e5fca29aa83b8e41729a1ba59b"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/SamueleMoscatelli/pulse/releases/download/v1.2.0/pulse-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "e286eaa8897d7ed9637d73fa572aad4a58313cd8b7324346f460646f589d151d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/SamueleMoscatelli/pulse/releases/download/v1.2.0/pulse-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "fd58c1f8ae0bf1c5d61c14cad84677a22c701ed8ef5e1819eda4be0d7f8bf720"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin": {},
    "aarch64-unknown-linux-gnu": {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static": {},
    "x86_64-apple-darwin": {},
    "x86_64-pc-windows-gnu": {},
    "x86_64-unknown-linux-gnu": {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static": {}
  }

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "pulse"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "pulse"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "pulse"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "pulse"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
