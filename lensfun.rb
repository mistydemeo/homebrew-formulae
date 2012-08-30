require 'formula'

class Lensfun < Formula
  homepage 'http://lensfun.berlios.de/'
  url 'http://download.berlios.de/lensfun/lensfun-0.2.6.tar.bz2'
  version '0.2.6'
  sha1 '0d7ffbae5c54159308114f69a9e2bc5f4d24d836'

  depends_on 'doxygen' => :optional
  depends_on 'glib'
  depends_on 'gettext'

  def patches
    {:p0 => "https://trac.macports.org/export/97200/trunk/dports/graphics/lensfun/files/patch-build-tibs-target-mac-mak.diff"}
  end

  def install
    # without this, it tries to pass "@VERSION@" as a literal string
    # rather than as a variable
    inreplace "build/tibs/target/mac.mak", "@VERSION@", version

    system "./configure", "--prefix=#{prefix}"
    system "make", "install", "GCC.LD=#{ENV.cxx}", "GCC.LDFLAGS=#{ENV.ldflags}"
  end
end
