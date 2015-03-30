class Gbdk < Formula
  homepage "http://gbdk.sourceforge.net/"
  head "https://github.com/qatsindio/gbdk.git"

  patch :p0 do
    url "https://raw.githubusercontent.com/co-me/gbdk/c8dc0a57e94a5c68555355585649f83c6c0b5032/macosx.patch"
    sha256 "7ffa454a3b99538d69fef0823bf3607177164ce2b7844d81fccedf80ed2aee12"
  end

  # Apply SDCC.y changes to patched copy
  patch :DATA

  def install
    ENV.deparallelize
    mkdir "sdcc/bin" # makefile forgets to make this directory
    system "make", "install", "TARGETDIR=#{prefix}", "TARGETCC=#{ENV.cc}", "TARGETCXX=#{ENV.cxx}"
  end
end

__END__
diff --git a/sdcc/src/SDCCy.c b/sdcc/src/SDCCy.c
index 65d3566..19acb34 100644
--- a/sdcc/src/SDCCy.c
+++ b/sdcc/src/SDCCy.c
@@ -2494,8 +2494,7 @@ case 173:
 		     DCL_TYPE(yyvsp[0].lnk) = EEPPOINTER;
 		     break;
 		 default:
-		   // this could be just "constant" 
-		   // werror(W_PTR_TYPE_INVALID);
+         ;
 		 }
 	     }
 	     else 
