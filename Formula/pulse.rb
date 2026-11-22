class Pulse < Formula
  desc "Static analyzer and Quality Gate for AI assets: instructions, agents, prompts, skills, MCP configs and hooks"
  homepage "https://github.com/SamueleMoscatelli/pulse"
  version "1.2.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/SamueleMoscatelli/pulse/releases/download/v1.2.2/pulse-cli-aarch64-apple-darwin.tar.xz"
      sha256 "400b5b68416157ec9a2a307193a95ff49d8a3b0556de503fc01d9c1655bff16c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/SamueleMoscatelli/pulse/releases/download/v1.2.2/pulse-cli-x86_64-apple-darwin.tar.xz"
      sha256 "71c6acd51c40301da0153dd385f16558b4dcd5c7bd2500724a9559cef1f77987"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/SamueleMoscatelli/pulse/releases/download/v1.2.2/pulse-cli-aarch64-unknown-linux-musl.tar.xz"
      sha256 "b2fff74ac3e715c2813d26862453c46e8e0fa18cf00785b050df3a1b79d1c6da"
    end
    if Hardware::CPU.intel?
      url "https://github.com/SamueleMoscatelli/pulse/releases/download/v1.2.2/pulse-cli-x86_64-unknown-linux-musl.tar.xz"
      sha256 "ec196fbc6a9fabd6d67ac0a7e8592b49ff818ef239d848a4749e4b81b5f5e444"
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
