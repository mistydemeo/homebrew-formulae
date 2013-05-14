require 'formula'

class ArgyllCms < Formula
  homepage 'http://www.argyllcms.com/'
  url 'http://www.argyllcms.com/Argyll_V1.5.1_osx10.6_x86_64_bin.tgz'
  sha1 '505c3ec48119e2cb318f4a9a60cba220302213ba'
  version '1.5.1'

  def install
    rm "bin/License.txt" # no, we don't want this in bin/
    prefix.install Dir['*']
  end
end
