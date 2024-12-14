class Xmdp < Formula
  desc "Clone of the FutureCrew MusicDiskPlayer"
  homepage "https://github.com/cmatsuoka/xmdp"
  url "https://github.com/cmatsuoka/xmdp.git", :revision => "e45538c8be5b11302155fd8009fe449aed0acbb7"
  version "e45538c8be5b11302155fd8009fe449aed0acbb7"

  depends_on "libxmp"
  depends_on "sdl"

  def install
    system "make", "CC=#{ENV.cc}", "LD=#{ENV.cc}",
      "CFLAGS=#{ENV.cflags}"
    bin.install "xmdp"
  end
end
