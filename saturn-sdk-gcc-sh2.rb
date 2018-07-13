class SaturnSdkGccSh2 < Formula
  def arch
    if Hardware::CPU.type == :intel
      if MacOS.prefer_64_bit?
        "x86_64"
      else
        "i686"
      end
    elsif Hardware::CPU.type == :ppc
      if MacOS.prefer_64_bit?
        "powerpc64"
      else
        "powerpc"
      end
    end
  end

  def osmajor
    `uname -r`.chomp
  end

  desc "GCC cross-compiler for Sega Saturn"
  homepage "https://segaxtreme.net/threads/another-saturn-sdk.23781/"
  head "https://github.com/SaturnSDK/Saturn-SDK-GCC-SH2.git"

  depends_on "coreutils" => :build # for realpath

  # All of these are normally downloaded by the download.sh script;
  # they're specified here as :nounzip resources so we can model and download them instead.
  resource "binutils" do
    url "http://ftpmirror.gnu.org/binutils/binutils-2.27.tar.bz2", :using => :nounzip
    mirror "https://ftp.gnu.org/gnu/binutils/binutils-2.27.tar.bz2"
    sha256 "369737ce51587f92466041a97ab7d2358c6d9e1b6490b3940eb09fb0a9a6ac88"
  end

  resource "gcc" do
    url "http://ftpmirror.gnu.org/gcc/gcc-6.2.0/gcc-6.2.0.tar.bz2", :using => :nounzip
    mirror "https://ftp.gnu.org/gnu/gcc/gcc-6.2.0/gcc-6.2.0.tar.bz2"
    sha256 "9944589fc722d3e66308c0ce5257788ebd7872982a718aa2516123940671b7c5"
  end

  resource "gmp" do
    url "https://gmplib.org/download/gmp/gmp-6.1.1.tar.bz2", :using => :nounzip
    sha256 "a8109865f2893f1373b0a8ed5ff7429de8db696fc451b1036bd7bdf95bbeffd6"
  end

  resource "libmpc" do
    url "http://ftpmirror.gnu.org/mpc/mpc-1.0.3.tar.gz", :using => :nounzip
    mirror "http://multiprecision.org/mpc/download/mpc-1.0.3.tar.gz"
    sha256 "617decc6ea09889fb08ede330917a00b16809b8db88c29c31bfbb49cbf88ecc3"
  end

  resource "newlib" do
    url "ftp://sourceware.org/pub/newlib/newlib-2.4.0.tar.gz", :using => :nounzip
    sha256 "545b3d235e350d2c61491df8b9f775b1b972f191380db8f52ec0b1c829c52706"
  end

  resource "mpfr" do
    url "http://ftpmirror.gnu.org/mpfr/mpfr-3.1.5.tar.bz2", :using => :nounzip
    sha256 "ca498c1c7a74dd37a576f353312d1e68d490978de4395fa28f1cbd46a364e658"
  end

  # ld: internal error: atom not found in symbolIndex(__ZN3vecINSt3__14pairIjPKcEE7va_heap6vl_ptrE7reserveEjb) for architecture x86_64
  fails_with :clang

  def install
    resources.each do |r|
      (buildpath/"download").install r
    end

    ENV["SRCDIR"] = "#{buildpath}/source"
    ENV["BUILDDIR"] = "#{buildpath}/build"
    ENV["TARGETMACH"] = "sh-elf"
    ENV["BUILDMACH"] = "#{arch}-apple-darwin#{osmajor}"
    ENV["HOSTMACH"] = "#{arch}-apple-darwin#{osmajor}"
    ENV["INSTALLDIR"] = prefix.to_s
    # Ensures the temporary cross-compiler doesn't get moved to
    # outside a sandbox-writeable directory
    ENV["INSTALLDIR_BUILD_TARGET"] = "#{buildpath}/build_target"
    ENV["SYSROOTDIR"] = "#{prefix}/sysroot"
    ENV["ROOTDIR"] = buildpath.to_s
    # we've already downloaded the resources
    ENV["SKIP_DOWNLOAD"] = "1"
    ENV["DOWNLOADDIR"] = "#{buildpath}/download"
    ENV["PROGRAM_PREFIX"] = "saturn-sh2-"

    system "./build-elf.sh"

    # The rest of the build is sandboxed appropriately, but this clashes with `gcc`
    (prefix/"share/gcc-6.2.0/python").rmtree
    (prefix/"share/info").rmtree
  end

  test do
    (testpath/"hello-c.c").write <<~EOS
      #include <stdio.h>
      int main()
      {
        puts("Hello, world!");
        return 0;
      }
    EOS
    system "#{bin}/saturn-sh2-elf-gcc", "-o", "hello-c", "hello-c.c"
    assert_match /hello-c: ELF 32-bit MSB executable/, shell_output("/usr/bin/file hello-c")

    (testpath/"hello-cc.cc").write <<~EOS
      #include <iostream>
      int main()
      {
        std::cout << "Hello, world!" << std::endl;
        return 0;
      }
    EOS
    system "#{bin}/saturn-sh2-elf-g++", "-o", "hello-cc", "hello-cc.cc"
    assert_match /hello-cc: ELF 32-bit MSB executable/, shell_output("/usr/bin/file hello-cc")
  end
end
