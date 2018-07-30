class Pcdtojpeg < Formula
  desc "Kodak Picture CD conversion tool"
  homepage "https://pcdtojpeg.sourceforge.io/Home.html"
  url "https://cfhcable.dl.sourceforge.net/project/pcdtojpeg/pcdtojpeg/pcdtojpeg%201.0.12/pcdtojpeg_1_0_12.zip"
  sha256 "99dff025349550b42d8db2666f9c6011a327d1db137d6083aa0b84a440963cf6"

  depends_on "jpeg"

  def install
    cd "pcdtojpeg_1_0_12" do
      cd "src" do
        system ENV.cxx, "main.cpp", "pcdDecode.cpp", "-ljpeg", "-o", "pcdtojpeg"
        bin.install "pcdtojpeg"
      end
      doc.install Dir["Documentation/*"]
    end
  end

  # Can't test real functionality without a Photo CD file. There are no
  # open-licensed example images available, and there's no encoder available.
  test do
    system "#{bin}/pcdtojpeg", "-h"
  end
end
