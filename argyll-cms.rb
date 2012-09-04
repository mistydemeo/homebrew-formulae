require 'formula'

class ArgyllCms < Formula
  homepage 'http://www.argyllcms.com/'
  url 'http://www.argyllcms.com/Argyll_V1.4.0_osx10.4_i86_bin.tgz'
  sha1 '6cd8e44678b8983bb31ae3bbe9fdce42f35d5108'
  version '1.4.0'

  def install
    rm "bin/License.txt" # no, we don't want this in bin/
    prefix.install Dir['*']
  end
end
