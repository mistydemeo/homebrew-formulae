class Slimlib < Formula
  desc "Tool to flash Neoflash SlimLoader IV on non-Windows OSes"
  homepage "https://github.com/jounikor/slimlib"
  url "https://github.com/jounikor/slimlib/archive/11378aeeeeff90229593125916fa6275a8e1b6f9.tar.gz"
  version "2016-09-17-1+git11378aeeeeff9022"
  sha256 "bad9eb834860078fcc8db0d4cdd58bf711fdbd568e418762175b305df924efb1"

  depends_on "libusb"

  def install
    inreplace "Makefile", "/usr/local/lib/libusb-1.0.a", "-lusb-1.0"
    system "make", "LIBUSB=#{Formula["libusb"].opt_include}/libusb-1.0"
    bin.install "sl4lib"
  end

  test do
    system "#{bin}/sl4lib"
  end
end
