class Ymfmidi < Formula
  desc "OPL3 MIDI player using the ymfm emulation core"
  homepage "https://github.com/devinacker/ymfmidi"
  url "https://github.com/devinacker/ymfmidi.git", ref: "0.6.0"
  version "0.6.0"
  license "BSD-3-Clause"
  head "https://github.com/devinacker/ymfmidi.git", branch: "master"

  depends_on "sdl2"

  def install
    # This rpath flag isn't compatible with Apple's ld.
    # https://github.com/devinacker/ymfmidi/pull/2
    # Note: it may end up getting removed in future versions of ymfmidi.
    inreplace "Makefile", "-Wl,-rpath=.", "-Wl,-rpath ."
    system "make"
    bin.install "ymfmidi"
  end
end
