class Cue2ccd < Formula
  desc "Tool to convert BIN/CUE disc images to CCD/IMG/SUB"
  homepage "https://www.mistys-internet.website/cue2ccd/"
  version "1.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mistydemeo/cue2ccd/releases/download/v1.1.0/cue2ccd-aarch64-apple-darwin.tar.xz"
      sha256 "4758ebc10542526f5c8da1fa93c8e35f14e2b2affa4da37b559597e51ac035ac"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mistydemeo/cue2ccd/releases/download/v1.1.0/cue2ccd-x86_64-apple-darwin.tar.xz"
      sha256 "1e789a39cccc8b5fd328ef846164ae7795ac750cacf76fdbfa3a32119837ac4e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mistydemeo/cue2ccd/releases/download/v1.1.0/cue2ccd-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b9d7f9f9f939a643a47fbc5a30ccbe077a06e9828d7b4430faefef1fe1dca416"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mistydemeo/cue2ccd/releases/download/v1.1.0/cue2ccd-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1884a81cf31a0371655fae56928e8eca418fe3342a3555d2dd39648fdfb45e5a"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-pc-windows-gnu":    {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
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
    bin.install "cue2ccd" if OS.linux? && Hardware::CPU.arm?
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
