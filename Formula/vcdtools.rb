class Vcdtools < Formula
  desc "Tools to create VCDs from the commandline"
  homepage "http://web.archive.org/web/20110505013838/http://www.os2world.com/cdwriting/vcdtools/readme.htm"
  url "http://old-releases.ubuntu.com/ubuntu/pool/universe/v/vcdtools/vcdtools_0.4.orig.tar.gz"
  sha256 "8eaf537bcf788a2bb7ef6e814d319e4150ae7d96a2eda9274e80a0e9d200dd56"
  license "GPL-2.0-or-later"

  def install
    system "make", "clean" # yep, comes with binaries...
    system "make"
    bin.install "mkvcdfs", "vcdmplex"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test vcdtools`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
