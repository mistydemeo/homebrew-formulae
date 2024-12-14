class LibusbLegacy < Formula
  desc "0.1 branch of the library for USB access"
  homepage "http://libusb.info"
  url "https://downloads.sourceforge.net/project/libusb/libusb-0.1%20%28LEGACY%29/0.1.12/libusb-0.1.12.tar.gz"
  sha256 "37f6f7d9de74196eb5fc0bbe0aea9b5c939de7f500acba3af6fd643f3b538b44"
  license "LGPL-2.1-or-later"

  keg_only "This is an older version of libusb."

  option :universal

  def install
    ENV.libstdcxx # not even going to *try* libc++ on something this old
    ENV.universal_binary if build.universal?
    ENV.deparallelize # 2002, natch

    system "./configure", "--prefix=#{prefix}", "--disable-dependency-tracking"
    system "make", "install"
  end

  test do
    system "#{bin}/libusb-config", "--libs"
  end
end
