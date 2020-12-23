class Mksdiso < Formula
  desc "Create Dreamcast SDISOs from Homebrew, CDI or ISO files"
  homepage "https://github.com/nold360/mksdiso"
  url "https://github.com/Nold360/mksdiso/archive/v0.9.2.tar.gz"
  sha256 "de80c68d73de03d2c111765dd82251626c681f6c5127acff77ba27befb2059f1"
  license "BSD-2-Clause"

  depends_on "cdirip"
  depends_on "cdrtools"
  depends_on "p7zip"

  def install
    pkgshare.install Dir["mksdiso/*"]

    inreplace "bin/mksdiso", "DATADIR=$HOME/.mksdiso", "DATADIR=#{pkgshare}"

    bin.install "bin/burncdi", "bin/mksdiso"

    cd "src" do
      # This function is needed on macOS too
      inreplace "isofix/isofix.h", "__linux__", "__APPLE__"
      # Build with UPX packing off
      system "make", "PACKER=true"

      # The makefile's install target is more or less useless
      bin.install "binhack/bin/binhack32"
      bin.install "isofix/isofix"
      bin.install "makeip/makeip"
      bin.install "scramble/scramble"
    end
  end
end
