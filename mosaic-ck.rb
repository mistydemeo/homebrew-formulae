require "formula"

class MosaicCk < Formula
  homepage "http://www.floodgap.com/retrotech/machten/mosaic/"
  url "http://www.floodgap.com/retrotech/machten/mosaic/mosaic27ck9.tar.gz"
  sha1 "36766c1fd0c2ac3569e671837a6c9c1005f983c7"
  version "2.7ck9"

  depends_on :x11
  depends_on "jpeg"
  depends_on "lesstif"
  depends_on "libpng"

  # Fixes build against modern libpng
  patch do
    url "https://github.com/mistydemeo/mosaic-ck/commit/aa25bb3512604578a5add62df59604c338848331.diff"
    sha1 "4e4636d97902d4ddc4d7706e5bcdc566b9fa2627"
  end

  def install
    # Hardcodes library paths and attempts to link directly against
    # static libs, via their full paths, instead of
    # specifying -l and letting the linker find them.
    inreplace "makefiles/Makefile.osx" do |s|
      s.change_make_var! "pngdir", Formula["libpng"].opt_prefix
      s.change_make_var! "jpegdir", Formula["jpeg"].opt_prefix
      s.gsub! "$(jpegdir)/lib/libjpeg.a", "-ljpeg"
      s.gsub! "$(pnglibdir)/libz.a", "-lz"
      s.gsub! "$(pnglibdir)/libpng.a", "-lpng"
      s.change_make_var! "knrflag", "-Wno-return-type" if ENV.compiler == :clang
    end

    system "make", "osx"
    bin.install "src/Mosaic"
  end
end
