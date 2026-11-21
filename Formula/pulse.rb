class Pulse < Formula
  desc "Static analyzer and Quality Gate for AI assets: instructions, agents, prompts, skills, MCP configs and hooks"
  homepage "https://github.com/SamueleMoscatelli/pulse"
  version "1.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/SamueleMoscatelli/pulse/releases/download/v1.2.1/pulse-cli-aarch64-apple-darwin.tar.xz"
      sha256 "98524cee2fa6eedfc40169a081e1fee731ac6f09c62d6636a7af9046e6bc5ed2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/SamueleMoscatelli/pulse/releases/download/v1.2.1/pulse-cli-x86_64-apple-darwin.tar.xz"
      sha256 "4040b0d0f8eecc53c32f3c0c1d6befbb92cf18faf44602ad17e8ae09b558dc18"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/SamueleMoscatelli/pulse/releases/download/v1.2.1/pulse-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "20e9490d70ed16ad53baaa5aec37aaae3c3c07d0307a6163e4ea7ddf36f5ffe7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/SamueleMoscatelli/pulse/releases/download/v1.2.1/pulse-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "b1f2acfc889e5e304925b1d96d6b8abe456aea82459c3ca5e68994672b1b4e76"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

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
