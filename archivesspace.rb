class Archivesspace < Formula
  homepage "http://archivesspace.org/"
  url "https://github.com/archivesspace/archivesspace/releases/download/v1.2.0/archivesspace-v1.2.0.zip"
  version "1.2.0"
  sha256 "c555b485c61a593002b9030c52b24245c64c803c392b33fcab9d145b7d8354aa"
  license "ECL-2.0"

  depends_on "openjdk"

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/archivesspace.sh" => "archivesspace"
  end
end
