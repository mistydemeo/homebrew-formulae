class Acpk2avi < Formula
  desc "Tools to convert Sega Saturn .cpk and .adp files"
  homepage "http://web.archive.org/web/19990508055825/http://www.yl.is.s.u-tokyo.ac.jp/%7Enayuta/S/acpk2avi/index-ja.html"
  url "https://github.com/mistydemeo/acpk2avi/archive/v1.21.tar.gz"
  sha256 "4ecdae10e9f8bae2f9073613b2323045efeb1de6952c5c52d0806904cc9eff89"

  def install
    bin.mkpath

    cd "source" do
      system "clang++", "acpk2avi.cxx", "-o", "#{bin}/acpk2avi"
      system "clang", "adp2wav.c", "-o", "#{bin}/adp2wav"
    end
  end
end
