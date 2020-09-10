class Gopher < Formula
  desc "Curses-based Gopher client"
  homepage "http://gopher.quux.org:70/give-me-gopher/"
  url "http://archive.ubuntu.com/ubuntu/pool/universe/g/gopher/gopher_3.0.16.tar.gz"
  sha256 "7af661f7cce7d3b11ef2b595230d5b575f7ecb9f840a5edfaea6d284369b57bb"
  license "GPL-2.0-or-later"

  def install
    # This is tremendously ugly!
    # Gopher includes stub headers for compatibility with various OSs, and
    # distinguishes them by capitalizing them. Obviously that does nothing on
    # a case-sensitive OS, so gopher ends up with only its stubs and not the real things.
    # This is documented in the README, whose advice is simply to build on UFS on OS X.
    inreplace "object/Dirent.h", "dirent.h", "#{MacOS.sdk_path}/usr/include/dirent.h"
    inreplace "object/Locale.h", "locale.h", "#{MacOS.sdk_path}/usr/include/locale.h"
    inreplace "object/Regex.h", "regex.h", "#{MacOS.sdk_path}/usr/include/regex.h"
    inreplace "object/String.h", "string.h", "#{MacOS.sdk_path}/usr/include/string.h"
    inreplace "object/Stdlib.h", "stdlib.h", "#{MacOS.sdk_path}/usr/include/stdlib.h"

    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/gophfilt", "gopher://quux.org"
  end
end
