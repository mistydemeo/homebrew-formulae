require "formula"

class Badpng < Formula
  homepage "https://github.com/mcclure/bitbucket-backup/tree/archive/repos/badpng"
  head "https://github.com/mcclure/bitbucket-backup.git", branch: "archive"

  def install
    cd "repos/badpng/contents" do
      system "make"
      bin.install "badpng"
      man1.install "badpng.1"
    end
  end

  test do
    test_png = HOMEBREW_LIBRARY/"Homebrew/test/fixtures/test.png"
    system "badpng", test_png, "out.png"
  end
end
