class CdReplace < Formula
  desc "Replace files in ISO images"
  homepage "https://github.com/mistydemeo/cd-replace"
  url "https://github.com/mistydemeo/cd-replace/archive/v0.1.0.tar.gz"
  sha256 "4839230dc4203c01b95847e7a75332def270e547c919c63a6b4ca17bc34dc391"

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end
end
