class Adx2wav < Formula
  homepage "http://www.geocities.co.jp/Playtown/2004/dcdev/index.html"
  url "http://www.geocities.co.jp/Playtown/2004/dcdev/adx2wav02.lzh"
  version "02"
  sha256 "957b5f2029aeda2bcc367478cd484bb375b9cb7ee1749d9025ded8767a5dabfe"

  def install
    system "make", "adx2wav", "afs_extract"
    bin.install "adx2wav", "afs_extract"
  end
end
