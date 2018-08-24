class FrogsOfWar < Formula
  desc "1-8 player action game"
  homepage "http://www.fullsack.com/frogs/frogs.html"
  url "http://www.fullsack.com/frogs/fow-2.2.tar.gz"
  sha256 "5ba216d5df2b8b3bfb9709d6a487e986f18a931c8e2ae519828363742b576999"

  depends_on "sdl"
  depends_on "sdl_image"
  depends_on "sdl_mixer"

  def install
    cd "src" do
      system "make"
      libexec.install "frogs"
    end
    libexec.install ["bmp", "wav", "doc"]
    (bin/"frogs").write <<~EOS
      #!/bin/sh
      set -e

      cd "#{libexec}"
      exec ./frogs "$@"
    EOS
  end

  test do
    system "#{bin}/frogs", "--help"
  end
end
