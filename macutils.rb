class Macutils < Formula
  desc "Used to unpack and translate Mac files to a *nix."
  homepage "http://ibiblio.org/pub/linux/utils/compress"
  url "http://ibiblio.org/pub/linux/utils/compress/macutils.tar.gz"
  version "2.0b3"
  sha256 "43970ae3c82bc5a9f125a27d980d422b886b9e2cb322f7bf36685197c77781ef"

  patch :DATA

  def install
    system "make"
    bin.install "binhex/binhex", "comm/frommac", "comm/tomac", "crc/makecrc",
                "hexbin/hexbin", "macunpack/macunpack",
                "mixed/macsave", "mixed/macstream"
    man1.install Dir["man/*.1"]
  end

  test do
    system "#{bin}/macunpack", "-H"
  end
end

__END__
diff --git a/macunpack/lzh.h b/macunpack/lzh.h
index 5ebf8e5..8396453 100755
--- a/macunpack/lzh.h
+++ b/macunpack/lzh.h
@@ -58,10 +58,3 @@ typedef struct fileHdr { /* 58 bytes */
 #define  lz5 7
 #define  lzs 8
 
-extern char *lzh_pointer;
-extern char *lzh_data;
-extern char *lzh_finfo;
-extern int lzh_fsize;
-extern int lzh_kind;
-extern char *lzh_file;
-
