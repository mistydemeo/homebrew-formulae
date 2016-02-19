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

  # All of these are normally downloaded by the download.sh script;
  # they're specified here as :nounzip resources so we can model and download them instead.
  resource "binutils" do
    url "http://ftpmirror.gnu.org/binutils/binutils-2.25.1.tar.bz2", :using => :nounzip
    mirror "https://ftp.gnu.org/gnu/binutils/binutils-2.25.1.tar.bz2"
    sha256 "b5b14added7d78a8d1ca70b5cb75fef57ce2197264f4f5835326b0df22ac9f22"
  end

  resource "gcc" do
    url "http://ftpmirror.gnu.org/gcc/gcc-5.3.0/gcc-5.3.0.tar.bz2", :using => :nounzip
    mirror "https://ftp.gnu.org/gnu/gcc/gcc-5.3.0/gcc-5.3.0.tar.bz2"
    sha256 "b84f5592e9218b73dbae612b5253035a7b34a9a1f7688d2e1bfaaf7267d5c4db"
  end

  resource "gmp" do
    url "https://gmplib.org/download/gmp/gmp-6.1.0.tar.bz2", :using => :nounzip
    sha256 "498449a994efeba527885c10405993427995d3f86b8768d8cdf8d9dd7c6b73e8"
  end

  resource "libmpc" do
    url "http://ftpmirror.gnu.org/mpc/mpc-1.0.3.tar.gz", :using => :nounzip
    mirror "http://multiprecision.org/mpc/download/mpc-1.0.3.tar.gz"
    sha256 "617decc6ea09889fb08ede330917a00b16809b8db88c29c31bfbb49cbf88ecc3"
  end

  resource "newlib" do
    url "ftp://sourceware.org/pub/newlib/newlib-2.3.0.20160104.tar.gz", :using => :nounzip
    sha256 "c92a0e02904bd4fbe1dd416ed94e786c66afbaeae484e4c26be8bb7c7c1e4cd1"
  end

  resource "mpfr" do
    url "http://ftpmirror.gnu.org/mpfr/mpfr-3.1.3.tar.bz2", :using => :nounzip
    sha256 "f63bb459157cacd223caac545cb816bcdb5a0de28b809e7748b82e9eb89b0afd"
  end

  # ld: internal error: atom not found in symbolIndex(__ZN3vecINSt3__14pairIjPKcEE7va_heap6vl_ptrE7reserveEjb) for architecture x86_64
  fails_with :clang

  def install
    resources.each do |r|
      (buildpath/"download").install r
    end

    inreplace %w[build.sh build-canadian.sh] do |s|
      # we've already downloaded the resources
      s.gsub! "./download.sh", ""
    end

    ENV["SRCDIR"] = "#{buildpath}/source"
    ENV["BUILDDIR"] = "#{buildpath}/build"
    ENV["TARGETMACH"] = "sh-elf"
    ENV["BUILDMACH"] = "#{arch}-apple-darwin#{osmajor}"
    ENV["INSTALLDIR"] = prefix.to_s
    # Ensures the temporary cross-compiler doesn't get moved to
    # outside a sandbox-writeable directory
    ENV["INSTALLDIR_BUILD_TARGET"] = "#{buildpath}/build_target"
    ENV["SYSROOTDIR"] = "#{prefix}/sysroot"
    ENV["ROOTDIR"] = buildpath.to_s
    ENV["DOWNLOADDIR"] = "#{buildpath}/download"
    ENV["PROGRAM_PREFIX"] = "saturn-sh2-"
    # TODO: is parallel build still broken now we're not using clang anymore?
    ENV["NCPU"] = "1"

    system "./build-elf.sh"

    # The rest of the build is sandboxed appropriately, but this clashes with `gcc`
    (prefix/"share/gcc-5.3.0/python").rmtree
  end

  test do
    (testpath/"hello-c.c").write <<-EOS.undent
      #include <stdio.h>
      int main()
      {
        puts("Hello, world!");
        return 0;
      }
    EOS
    system "#{bin}/saturn-sh2-elf-gcc", "-o", "hello-c", "hello-c.c"
    assert_match /hello-c: ELF 32-bit MSB executable/, shell_output("/usr/bin/file hello-c")

    (testpath/"hello-cc.cc").write <<-EOS.undent
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
