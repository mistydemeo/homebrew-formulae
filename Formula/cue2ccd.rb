class Cue2ccd < Formula
  desc "Tool to convert BIN/CUE disc images to CCD/IMG/SUB"
  homepage "https://www.mistys-internet.website/cue2ccd/"
  version "1.0.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mistydemeo/cue2ccd/releases/download/v1.0.0/cue2ccd-aarch64-apple-darwin.tar.xz"
      sha256 "e7157ee2b70a497f3b950e2ae1c6cab9209ecf2ae3b4b8d09d35bc737c0f7bd8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mistydemeo/cue2ccd/releases/download/v1.0.0/cue2ccd-x86_64-apple-darwin.tar.xz"
      sha256 "3e6a30a7e7a37a5fc1b8a1913993fe9a6eef13515c184f8040db58cdee45be59"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/mistydemeo/cue2ccd/releases/download/v1.0.0/cue2ccd-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "8552e49478bfa7e4e5689a0e15095f5779458e1d18c442252011dd1b6a7256f0"
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
