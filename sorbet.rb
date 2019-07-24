class Sorbet < Formula
  desc "Fast, powerful type checker designed for Ruby"
  homepage "https://sorbet.org"
  url "https://rubygems.org/downloads/sorbet-static-0.4.4497-universal-darwin-18.gem"
  version "0.4.4497"
  sha256 "0cd3ea90529285f954913b5137f0442a125bd19ca9bd5d674da0773e53cd9851"

  # At some point I really need to get this building from source. :(
  def install
    system "tar", "-xf", "sorbet-static-#{version}-universal-darwin-18.gem"
    system "tar", "-xzf", "data.tar.gz"
    bin.install "libexec/sorbet"
  end

  test do
    assert_equal "No errors! Great job.", shell_output("#{bin}/sorbet -e '1 + 1' 2>&1").chomp
  end
end
