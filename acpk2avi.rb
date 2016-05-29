class Acpk2avi < Formula
  desc "Tools to convert Sega Saturn .cpk and .adp files"
  homepage "http://web.archive.org/web/19990508055825/http://www.yl.is.s.u-tokyo.ac.jp/%7Enayuta/S/acpk2avi/index-ja.html"
  url "http://segasaturn.co.uk/dd/progs/acpk2avi.zip"
  sha256 "2af080b622004f4e9432ff10b44e8d5e37073a9da2ae12f7d0db8bfa3b185d73"
  version "1.19"

  # Removes unnecessary use of a GCC internal header
  patch :DATA

  def install
    bin.mkpath

    cd "SOURCE" do
      system "clang++", "ACPK2AVI.CXX", "-o", "#{bin}/acpk2avi"
      system "clang", "ADP2WAV.C", "-o", "#{bin}/adp2wav"
    end
  end
end

__END__
diff --git a/SOURCE/ACPK2AVI.CXX b/SOURCE/ACPK2AVI.CXX
index f582062..a1fa874 100644
--- a/SOURCE/ACPK2AVI.CXX
+++ b/SOURCE/ACPK2AVI.CXX
@@ -25,7 +25,7 @@ extern "C"
 typedef int BOOL;
 const int TRUE = 1;
 const int FALSE = 0;
-#if defined(__GNUC__)
+#if 0
   #include <_G_config.h>
   typedef _G_int64_t INT64;
 #elif defined(_WIN32)
