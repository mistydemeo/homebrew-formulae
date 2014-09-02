require "formula"

class Badpng < Formula
  homepage "https://bitbucket.org/runhello/badpng"
  head "https://bitbucket.org/runhello/badpng", :using => :hg

  def install
    system "make", "BUILD=#{ENV.cc}"
    bin.install "badpng"
  end

  test do
    test_png = HOMEBREW_LIBRARY/"Homebrew/test/fixtures/test.png"
    system "badpng", test_png, "out.png"
  end
end
