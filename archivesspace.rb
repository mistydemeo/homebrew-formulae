class Archivesspace < Formula
  homepage "http://archivesspace.org/"
  url "https://github.com/archivesspace/archivesspace/releases/download/v1.1.1/archivesspace-v1.1.1.zip"
  version "1.1.1"
  sha1 "aa74577b7da97dac18f1d98251145d398a2d170e"

  depends_on :java => "1.6"

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/archivesspace.sh" => "archivesspace"
  end
end
