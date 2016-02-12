class Munt < Formula
  desc "Roland MT-32 emulator library and MIDI conversion tool"
  homepage "https://github.com/munt/munt"
  url "https://github.com/munt/munt/archive/munt_1_5_0.tar.gz"
  sha256 "5298b0987df9a27f70232e8a1229949edf84cc7a6dc881817907dee524f7d341"

  depends_on "cmake" => :build

  def install
    cd "mt32emu" do
      system "cmake", ".", *std_cmake_args
      system "make", "install"
    end

    cd "mt32emu_smf2wav" do
      system "cmake", ".", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    # Can't test real functionality without copyrighted ROMs
    system "mt32emu-smf2wav", "-h"
  end
end
