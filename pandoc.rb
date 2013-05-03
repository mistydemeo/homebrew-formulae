require 'formula'

class Pandoc < Formula
  homepage 'http://johnmacfarlane.net/pandoc/'
  url 'https://pandoc.googlecode.com/files/pandoc-1.11.1.dmg'
  sha1 '00fc2bde8a51e6d004e20948ac9b4a6fca466daf'

  def install
    dev, name = `hdiutil attach pandoc-1.11.1.dmg`.scan(%r[^(/dev/\w+).+(/Volumes/.+)$]).pop
    dev.gsub!(/s.$/, '')
    cp_r name+'/pandoc-1.11.1.pkg', '.'
    cd 'pandoc-1.11.1.pkg/Contents' do
      system "pax", "--insecure", "-rz", "-f", "Archive.pax.gz", "-s", ",./usr/local,#{prefix},"
    end
    system "hdiutil", "eject", dev
  end

  test do
    system bin/'pandoc', '--version'
  end
end
