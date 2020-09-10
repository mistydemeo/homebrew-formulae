class Php1 < Formula
  desc "Artisinal, ancient PHP"
  homepage "http://php.net"
  url "http://museum.php.net/php1/php-108.tar.gz"
  version "1.08"
  sha256 "e7404c9c60021eeec20c77ee75d46db01328f00b549dbf5f6c6f490cca5a211a"
  license "GPL-2.0-or-later"

  def install
    system "make"
    bin.install Dir["*.cgi"]
  end
end
