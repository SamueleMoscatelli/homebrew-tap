class Pulse < Formula
  desc "Static analyzer and Quality Gate for AI assets: instructions, agents, prompts, skills, MCP configs and hooks"
  homepage "https://github.com/SamueleMoscatelli/pulse"
  version "1.2.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/SamueleMoscatelli/pulse/releases/download/v1.2.4/pulse-cli-aarch64-apple-darwin.tar.xz"
      sha256 "5426a8a346081fe8834cd9853bd4eccabef4db179b38eabe53052d84a952b0cc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/SamueleMoscatelli/pulse/releases/download/v1.2.4/pulse-cli-x86_64-apple-darwin.tar.xz"
      sha256 "a9de452b25e16cc5a110b19dd69f4946a7ea05d0f5fc677bdf30d0ffa114f5b5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/SamueleMoscatelli/pulse/releases/download/v1.2.4/pulse-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "c653fdbfac927d81b98059e4d22e610f43990aaa3490a0746b72dc436d33f0d3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/SamueleMoscatelli/pulse/releases/download/v1.2.4/pulse-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "4382143448a741ba7ee53726cab4026e641e75d5951169bce2cc7d0105a0ccd2"
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
