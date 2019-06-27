class Jit < Formula
  desc "Simple pure Ruby git implementation"
  homepage "https://shop.jcoglan.com/building-git/"
  url "https://rubygems.org/downloads/jit-1.0.0.gem"
  sha256 "c0a45ddd7f1ce41ab97d654b7e11911198790f8cb0e09896d8968159f673b1a1"

  def install
    # This is a gem, but it has no dependencies, so we can
    # just install the files into the prefix.
    system "tar", "-xf", "jit-1.0.0.gem"
    system "tar", "-xzf", "data.tar.gz"
    prefix.install "bin", "lib"
  end

  test do
    cd HOMEBREW_REPOSITORY
    system "#{bin}/jit", "log"
  end
end
