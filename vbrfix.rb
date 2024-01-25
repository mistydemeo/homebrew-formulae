class Vbrfix < Formula
  desc "Fixes VBR MP3s for playback on older devices"
  homepage "https://web.archive.org/web/20090504050906/http://www.willwap.co.uk/Programs/vbrfix.php"
  # Original source code here: https://web.archive.org/web/20091121082530/http://gna.org/projects/vbrfix
  url "https://launchpad.net/ubuntu/+archive/primary/+sourcefiles/vbrfix/0.24-7/vbrfix_0.24.orig.tar.gz"
  sha256 "02d6363949407ac0e4b39ed76c60e49de0c286dbdce4f15363f771320430b364"
  license "GPL-2.0-or-later"

  resource "manpage" do
    url "https://launchpad.net/ubuntu/+archive/primary/+sourcefiles/vbrfix/0.24-7/vbrfix_0.24-7.debian.tar.gz"
    sha256 "78dcfe0b9646fbed05df0f0292b83b3c8d3650cabb10c1ac19d7f6411cad76f0"
  end

  def install
    system "./configure", *std_configure_args, "--disable-silent-rules"
    system "make", "install"

    resource("manpage").stage do
      man1.install "vbrfix.1"
    end
  end

  test do
    mp3 = test_fixtures("test.mp3")
    assert_match(/Fixing #{mp3}->vbrfix.tmp/, shell_output("#{bin}/vbrfixc -lameinfo -makevbr #{mp3} out.mp3 2>&1"))
  end
end
