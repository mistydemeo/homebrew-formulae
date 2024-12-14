class Vcdgear < Formula
  desc "VCD authoring tools"
  homepage "http://vcdgear.com"
  url "http://vcdgear.com/files/vcdgear177-041114_macosx.zip"
  sha256 "aa786b31838bd057628c11272026d845c046768fa48df75bd77f754a2635fd62"
  version "1.7.7-041114"

  def install
    bin.install "vcdgear"
  end
end
