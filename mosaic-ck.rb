require "formula"

class MosaicCk < Formula
  homepage "http://www.floodgap.com/retrotech/machten/mosaic/"
  url "http://www.floodgap.com/retrotech/machten/mosaic/mosaic27ck9.tar.gz"
  sha1 "36766c1fd0c2ac3569e671837a6c9c1005f983c7"
  version "2.7ck9"

  depends_on :x11
  depends_on "jpeg"
  depends_on "lesstif"

  # non-void function 'hw_do_color' should return a value
  fails_with :clang

  # Makes extensive use of direct struct access,
  # which doesn't work with libpng 1.4+
  resource "libpng" do
    url "ftp://ftp.simplesystems.org/pub/libpng/png/src/libpng12/libpng-1.2.51.tar.gz"
    sha1 "5175be08c4fa767b0d3d025f636e73e78780f988"
  end

  def install
    # mosaic will statically link against libpng, so don't bother
    # installing to the cellar.
    resource("libpng").stage do
      system "./configure", "--disable-dependency-tracking",
                            "--disable-silent-rules",
                            "--prefix=#{buildpath}/libpng"
      system "make install"
    end

    # Hardcodes library paths and attempts to link directly against
    # static libs, via their full paths, instead of
    # specifying -l and letting the linker find them.
    inreplace "makefiles/Makefile.osx" do |s|
      s.change_make_var! "pngdir", "#{buildpath}/libpng"
      s.change_make_var! "jpegdir", Formula["jpeg"].opt_prefix
      s.gsub! "$(jpegdir)/lib/libjpeg.a", "-ljpeg"
      s.gsub! "$(pnglibdir)/libz.a", "-lz"
    end

    system "make", "osx"
    bin.install "src/Mosaic"
  end
end
