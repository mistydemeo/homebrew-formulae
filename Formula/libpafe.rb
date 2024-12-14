class Libpafe < Formula
  desc "Library to interface with Sony PaSori readers"
  homepage "https://github.com/rfujita/libpafe"
  license "GPL-2.0-only"
  head "https://github.com/rfujita/libpafe.git"

  depends_on "libusb"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end
end
