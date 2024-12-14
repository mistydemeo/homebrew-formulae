class Npasoriv < Formula
  desc "Command-line PaSori client"
  homepage "http://pub.ks-and-ks.ne.jp/prog/npasoriv.shtml"
  url "http://pub.ks-and-ks.ne.jp/prog/pub/npasoriv-0.03.tar.gz"
  sha256 "d5d396cfdbf0faa388d7563876661307bbc30edfcf93b7a76c6db6b28a7cc08c"

  depends_on "libpafe"

  def install
    system "make", "install", "INSTALLDIR=#{bin}"
  end

  test do
    system "#{bin}/npasoriv", "--help"
  end
end
