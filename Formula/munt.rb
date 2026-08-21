class Munt < Formula
  desc "Roland MT-32 emulator library and MIDI conversion tool"
  homepage "https://github.com/munt/munt"
  url "https://github.com/munt/munt/archive/libmt32emu_2_8_2.tar.gz"
  sha256 "d4778cf89b054ba7ab410ffcb02ecf1629fa32b5b60838addec99eb93804fdcb"
  license "GPL-3.0-or-later"

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

      # Installs with broken rpath
      system "install_name_tool", "-change",
                                  "@rpath/libmt32emu.2.dylib",
                                  "#{Formula["munt"].opt_lib}/libmt32emu.2.dylib",
                                  "#{Formula["munt"].bin}/mt32emu-smf2wav"
    end
  end

  test do
    # Can't test real functionality without copyrighted ROMs
    system "#{bin}/mt32emu-smf2wav", "-h"
  end
end
