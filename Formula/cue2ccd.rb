class Cue2ccd < Formula
  desc "Tool to convert BIN/CUE disc images to CCD/IMG/SUB"
  homepage "https://www.mistys-internet.website/cue2ccd/"
  version "1.0.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mistydemeo/cue2ccd/releases/download/v1.0.2/cue2ccd-aarch64-apple-darwin.tar.xz"
      sha256 "6f198ec50e2a9d2331a0515e93567e65398550f5a6aa10ea0442013245ea5af1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mistydemeo/cue2ccd/releases/download/v1.0.2/cue2ccd-x86_64-apple-darwin.tar.xz"
      sha256 "a04d741f3e9b3053ab48583ccd6514c8b8f15c34b1c7e3f767043a6849b22381"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/mistydemeo/cue2ccd/releases/download/v1.0.2/cue2ccd-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "ced32d40b01511198c5987f37c78b28d690b1a3b44a605c4903c8981bef2e882"
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "aarch64-pc-windows-gnu":   {},
    "x86_64-apple-darwin":      {},
    "x86_64-pc-windows-gnu":    {},
    "x86_64-unknown-linux-gnu": {},
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
    bin.install "cue2ccd" if OS.mac? && Hardware::CPU.arm?
    bin.install "cue2ccd" if OS.mac? && Hardware::CPU.intel?
    bin.install "cue2ccd" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
