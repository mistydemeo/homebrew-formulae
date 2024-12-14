class MosaicCk < Formula
  desc "NCSA Mosaic for modern Macs"
  homepage "http://www.floodgap.com/retrotech/machten/mosaic/"
  url "http://www.floodgap.com/retrotech/machten/mosaic/mosaic27ck11-src.zip"
  # Homebrew gets confused about the real version number
  version "2.7-11ck"
  sha256 "4ca13a471e86b06ec69e41b5142f1333df9b3d0cdf17cc9fea2105ce6cbcad10"

  depends_on "jpeg"
  depends_on "libpng"
  depends_on "openmotif"
  depends_on "libx11"
  depends_on "libxpm"

  # Fixes build against modern libpng
  patch do
    url "https://github.com/mistydemeo/mosaic-ck/commit/32eb14ee8d65616c953e965c6a8b1d754eedc7a0.diff?full_index=1"
    sha256 "9e20e8362ab21182839572a1b58b0ae7d092bf67b1a6b03ebfe55f258c037b1d"
  end

  # Fix redirects for URLs on the same domain
  patch do
    url "https://github.com/duckinator/mosaic-ck/commit/ffbb7ad9166da3f5d3524d63fb30469ba12c85e6.diff?full_index=1"
    sha256 "0d91e372e64e46cf37ba347894a854c5fed143891c7981308b7576e852e8fb27"
  end

  # Restores prebuilt XPM files that were deleted from 2.7-11ck
  patch do
    url "https://github.com/mistydemeo/mosaic-ck/commit/971273faecec338e4a6a57a072172e18fa08f090.diff?full_index=1"
    sha256 "ddf6c8dfa5050419061b85c7db214843f0f856c5867623376ffe97db14634598"
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
