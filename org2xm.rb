require "formula"

class Org2xm < Formula
  homepage "http://rrrola.wz.cz/downloads.html"
  url "http://rrrola.wz.cz/files/org2xm.zip"
  version "1.0"
  sha1 "a0c64aa12a01fc580193764491ee3153fa99e05e"

  # -fnested-functions won't coerce clang to build this.
  fails_with :clang do
    cause "clang does not permit nested function definitions"
  end

  def install
    # gcc-4.2 will complain about nested functions by default,
    # while clang simply refuses to compile it at all
    ENV.append_to_cflags "-fnested-functions"

    cd "src" do
      system "make", "org2xm", "wave100"
      bin.install "org2xm", "wave100"
    end

    cd "samples" do
      system bin/"wave100" rescue nil # exits 255 on success!
    end

    # Full Cave Story soundtrack, plus requisite samples
    (share/"org2xm").install "org", "samples"
  end
end
