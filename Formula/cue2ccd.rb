class Cue2ccd < Formula
  desc "Tool to convert BIN/CUE disc images to CCD/IMG/SUB"
  homepage "https://www.mistys-internet.website/cue2ccd/"
  version "1.0.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mistydemeo/cue2ccd/releases/download/v1.0.3/cue2ccd-aarch64-apple-darwin.tar.xz"
      sha256 "5cc199efca44e4616377c76901b672ad9a27534b42349418c13ce8bcd88000f2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mistydemeo/cue2ccd/releases/download/v1.0.3/cue2ccd-x86_64-apple-darwin.tar.xz"
      sha256 "857cef7bf0fd7f5267dac7ee68fa3bce514c7ff4577011c4b7da638a75289b15"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/mistydemeo/cue2ccd/releases/download/v1.0.3/cue2ccd-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "4643bcb7d227b8871d665f3250e516f45522eb4a3a885473850df96cb5523dfd"
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
