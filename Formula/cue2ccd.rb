class Cue2ccd < Formula
  desc "Tool to convert BIN/CUE disc images to CCD/IMG/SUB"
  homepage "https://www.mistys-internet.website/cue2ccd/"
  version "1.0.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mistydemeo/cue2ccd/releases/download/v1.0.1/cue2ccd-aarch64-apple-darwin.tar.xz"
      sha256 "525f58481e6671500eacce58bd63433aeafaa857e4c1d026b9a06dfaf098025c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mistydemeo/cue2ccd/releases/download/v1.0.1/cue2ccd-x86_64-apple-darwin.tar.xz"
      sha256 "1c7e3220c0b49a35b85a0b13d551092d0fb0fc52d03314a710647d3f4fdb7dab"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/mistydemeo/cue2ccd/releases/download/v1.0.1/cue2ccd-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "27a8dd360a15c987084803ef5f9478eb58e467c8a61a7cad1b53b4200729f660"
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
