class NukedSc55 < Formula
  desc "Roland SC-55 series emulation"
  homepage "https://github.com/nukeykt/Nuked-SC55"
  url "https://github.com/nukeykt/Nuked-SC55.git", tag: "0.3.1"
  license "MAME"
  head "https://github.com/nukeykt/Nuked-SC55.git", branch: "master"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "sdl2"

  # Fixes configuration file path on macOS
  patch do
    url "https://github.com/nukeykt/Nuked-SC55/pull/86.patch"
    sha256 "25c683287aa8816eb49d02d68091edf141d18bb18843c12df283f8d7db38e59a"
  end

  # Ensures it sets up a virtual MIDI-in port if there's no hardware MIDI-in
  patch do
    url "https://github.com/nukeykt/Nuked-SC55/pull/90.patch"
    sha256 "2347e70e26afb8db4180e1e17bfba12a90e5e4c3cd7f6beb2bbf9a0a11725e08"
  end

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    cd "build" do
      system "make", "install"
    end
    pkgshare.mkpath
  end

  test do
    system bin/"nuked-sc55", "--help"
  end

  def caveats; <<~EOS
    To use nuked-sc55, you'll need to obtain a valid set of ROMs
    and place them in #{pkgshare}
    EOS
  end
end
