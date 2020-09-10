class Cdirip < Formula
  desc "Tool to extract tracks from DiscJuggler images"
  homepage "http://web.archive.org/web/20091027000203/http://es.geocities.com/dextstuff/cdirip/news.html"
  url "http://dcemulation.org/1-files/tools/pc/mac/cdirip-0.6.3.zip"
  sha256 "816b1abf724dcc83c7b65d7259735972102a5a60a2a006d5938ef66bebb26acc"

  def install
    system "make"
    bin.install "cdirip"
  end
end
