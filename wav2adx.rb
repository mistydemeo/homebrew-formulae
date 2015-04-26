class Wav2adx < Formula
  homepage "http://www.geocities.co.jp/Playtown/2004/dcdev/index.html"
  url "http://www.geocities.co.jp/Playtown/2004/dcdev/wav2adx.lzh"
  sha256 "311e868ea03aa4abd1ea2d46e08f34d5b29f436a5f51e54bb47a07fd4c77ef4f"
  version "2001-01-25"

  depends_on "lha" => :build

  # Fix return type of convert function
  patch :DATA

  def install
    system "make", "wav2adx"
    bin.install "wav2adx"
  end
end

__END__
diff --git a/wav2adx.c b/wav2adx.c
index 9d8b956..09e3cd8 100644
--- a/wav2adx.c
+++ b/wav2adx.c
@@ -30,7 +30,7 @@ typedef struct {
 //#define	BASEVOL	0x11e0
 #define	BASEVOL	0x4000
 
-int convert(unsigned char *adx,short *wav,PREV *prev)
+void convert(unsigned char *adx,short *wav,PREV *prev)
 {
 	int scale;
 	int i;
