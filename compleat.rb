class Compleat < Formula
  homepage "https://github.com/mbrubeck/compleat"
  head "https://github.com/mbrubeck/compleat.git"

  depends_on "cabal-install" => :build
  depends_on "ghc" => :build

  def install
    system "./Setup.lhs", "configure", "--prefix=#{prefix}"
    system "./Setup.lhs", "build"
    system "./Setup.lhs", "install"
  end
end
