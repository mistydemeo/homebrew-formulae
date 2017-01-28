class MosaicCk < Formula
  homepage "http://www.floodgap.com/retrotech/machten/mosaic/"
  url "http://www.floodgap.com/retrotech/machten/mosaic/mosaic27ck10.tar.gz"
  sha256 "6d95d5e3ce34fe04c0eac7bdb81fc5cf7970f35f4f0e872add63d9ec729f5710"
  # Homebrew gets confused about the real version number
  version "2.7-10ck"

  depends_on :x11
  depends_on "openmotif"
  depends_on "jpeg"
  depends_on "libpng"

  # Fixes build against modern libpng
  patch do
    url "https://github.com/mistydemeo/mosaic-ck/commit/32eb14ee8d65616c953e965c6a8b1d754eedc7a0.diff"
    sha256 "a3b2aa7014769d3a36fda3b8de137db5d100ee182a5520982ff87b85c0fe9556"
  end

  # Fix redirects for URLs on the same domain
  patch do
    url "https://github.com/duckinator/mosaic-ck/commit/ffbb7ad9166da3f5d3524d63fb30469ba12c85e6.diff"
    sha256 "4afb89c3c3541403b673e893bc4bc140a6901a7deae9c039fabf1617635e1ab6"
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
