class Badpng < Formula
  desc "Corrupt PNG files"
  homepage "https://github.com/mcclure/bitbucket-backup/tree/archive/repos/badpng"
  head "https://github.com/mcclure/bitbucket-backup.git", branch: "archive"
  license "CC0-1.0"

  def install
    cd "repos/badpng/contents" do
      system "make"
      bin.install "badpng"
      man1.install "badpng.1"
    end
  end

  test do
    test_png = HOMEBREW_LIBRARY/"Homebrew/test/support/fixtures/test.png"
    system "badpng", test_png, "out.png"
  end
end
