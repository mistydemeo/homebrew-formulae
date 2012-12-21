require 'formula'

class Compleat < Formula
  homepage 'https://github.com/mbrubeck/compleat'
  head 'https://github.com/mbrubeck/compleat.git'

  depends_on 'haskell-platform'

  def install
    system "./Setup.lhs", "configure", "--prefix=#{prefix}"
    system "./Setup.lhs", "build"
    system "./Setup.lhs", "install"
  end
end
