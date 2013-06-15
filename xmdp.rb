require 'formula'

class Xmdp < Formula
  homepage 'https://github.com/cmatsuoka/xmdp'
  url 'https://github.com/cmatsuoka/xmdp/archive/497484a0b348016d2b87b7493f01e19257f8e92e.tar.gz'
  sha1 '74f77ebd89c0827ae4b8a102c80ad5a16e949c97'
  version '497484a0b348016d2b87b7493f01e19257f8e92e'

  depends_on 'pkg-config' => :build
  depends_on 'libxmp'
  depends_on 'sdl'

  # SDL on Mac requires some extra flags to link
  # Submitted upstream: https://github.com/cmatsuoka/xmdp/pull/1
  def patches; DATA; end

  def install
    system "make", "CC=#{ENV.cc}", "LD=#{ENV.cc}",
      "CFLAGS=#{ENV.cflags}"
    bin.install 'xmdp'
  end
end

__END__
diff --git a/Makefile b/Makefile
index 6f2dc0f..a97f6d0 100644
--- a/Makefile
+++ b/Makefile
@@ -5,6 +5,10 @@ LD = gcc
 LDFLAGS =
 LIBS = -L../../lib -lxmp -lm
 
+ifeq (Darwin,$(shell uname -s))
+ LDFLAGS := -framework Cocoa -lSDLmain
+endif
+
 all: xmdp
 
 xmdp: mdp.o font1.o font2.o
