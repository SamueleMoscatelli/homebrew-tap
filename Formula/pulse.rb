class Pulse < Formula
  desc "Static analyzer and Quality Gate for AI assets: instructions, agents, prompts, skills, MCP configs and hooks"
  homepage "https://github.com/SamueleMoscatelli/pulse"
  version "1.2.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/SamueleMoscatelli/pulse/releases/download/v1.2.3/pulse-cli-aarch64-apple-darwin.tar.xz"
      sha256 "62746a4d0689e61ca4f9557abd23f82f84674490ea6a68237cbb5464e1d9aa3f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/SamueleMoscatelli/pulse/releases/download/v1.2.3/pulse-cli-x86_64-apple-darwin.tar.xz"
      sha256 "d9390d8cc21eb3c03eee059f6798f79c6dab18ba79668354b40a0552acd57f6c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/SamueleMoscatelli/pulse/releases/download/v1.2.3/pulse-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "a6a76d6f472f43178eeb4b5292a0832c88b339185f9c12e72101bf5102f8d370"
    end
    if Hardware::CPU.intel?
      url "https://github.com/SamueleMoscatelli/pulse/releases/download/v1.2.3/pulse-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "943f2861ac420c938b1eead71f21653c4fe26c564acee40069696cea0aa9a8cf"
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
