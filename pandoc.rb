require 'formula'

class Pandoc < Formula
  homepage 'http://johnmacfarlane.net/pandoc/'
  url 'https://pandoc.googlecode.com/files/pandoc-1.11.1.dmg'
  sha1 '00fc2bde8a51e6d004e20948ac9b4a6fca466daf'

  def install
    mount = "dmg"
    system "hdiutil", "attach", "pandoc-#{version}.dmg", "-mountpoint", mount
    archive = "#{mount}/pandoc-#{version}.pkg/Contents/Archive.pax.gz"
    system "pax", "--insecure", "-rz", "-f", archive, "-s", ",./usr/local,#{prefix},"
    system "hdiutil", "eject", mount
  end

  test do
    system bin/'pandoc', '--version'
  end
end
