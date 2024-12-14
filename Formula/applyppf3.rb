class Applyppf3 < Formula
  desc "Tools to use and create PPF3 patches"
  homepage ""
  url "https://rescene.wdfiles.com/local--files/ppf-o-matic/pdx-ppf3.zip"
  sha256 "5201d979e720d59750a1341fac9cb2a1f1d57dc4cf49218f6c17a1b560ee1213"

  def install
    cd "ppfdev" do
      cd "applyppf_src" do
        system "make", "applyppf3_linux"
        bin.install "applyppf3_linux" => "applyppf3"
      end

      cd "makeppf_src" do
        system "make", "makeppf3_linux"
        bin.install "makeppf3_linux" => "makeppf3"
      end
    end
  end

  test do
    assert_match "ApplyPPF v3.0 by =Icarus/Paradox=", shell_output("#{bin}/applyppf3")
  end
end
