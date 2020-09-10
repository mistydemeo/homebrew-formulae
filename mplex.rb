class Mplex < Formula
  desc "MPEG-1 multiplexer"
  homepage "https://web.archive.org/web/19990824182819/https://www.leo.org/pub/comp/general/graphics/mpeg/mplex/"
  url "http://hnw.jp/archive/mplex-1.1.tar.gz"
  sha256 "d88dce2bac31b2516a3740602c786f35b1c61871a2e134460fdfd66e9cc8f900"
  license "GPL-2.0-or-later"

  def install
    system "make"
    bin.install "mplex" => "mplex-mpeg1"
  end

  test do
    assert_match "MPEG1/SYSTEMS", shell_output("#{bin}/mplex-mpeg1", 1)
  end
end
