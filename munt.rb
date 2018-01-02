class Munt < Formula
  desc "Roland MT-32 emulator library and MIDI conversion tool"
  homepage "https://github.com/munt/munt"
  url "https://github.com/munt/munt/archive/munt_2_3_0.tar.gz"
  sha256 "73bd1f4f67bfec241748ed86d882df12a12b33ac33b9770a65fd37c399c81c2f"

  depends_on "cmake" => :build
  depends_on "glib"

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
