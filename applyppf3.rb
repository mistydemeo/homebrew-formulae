class Applyppf3 < Formula
  desc ""
  homepage ""
  url "http://rescene.wdfiles.com/local--files/ppf-o-matic/pdx-ppf3.zip"
  sha256 "5201d979e720d59750a1341fac9cb2a1f1d57dc4cf49218f6c17a1b560ee1213"
  # depends_on "cmake" => :build

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
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test applyppf3`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
