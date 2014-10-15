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
    url "https://github.com/mistydemeo/mosaic-ck/commit/32eb14ee8d65616c953e965c6a8b1d754eedc7a0.diff"
    sha1 "1ffaeb455ff1b06bc06943ffa55eee9f63db069c"
  end

  # Fix redirects for URLs on the same domain
  patch do
    url "https://github.com/duckinator/mosaic-ck/commit/ffbb7ad9166da3f5d3524d63fb30469ba12c85e6.diff"
    sha1 "89dfb7b7c238fb2c061f31aa3186a719d6ad409e"
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
