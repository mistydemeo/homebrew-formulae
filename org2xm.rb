require "formula"

class Org2xm < Formula
  homepage "http://rrrola.wz.cz/downloads.html"
  url "http://rrrola.wz.cz/files/org2xm.zip"
  version "1.0"
  sha256 "988f4dd1a98757433dafb664adf259f833621926b5c011e185b6af4b013a52fb"

  fails_with :clang do
    cause "clang does not permit nested function definitions"
  end

  def install
    # gcc-4.2 will complain about nested functions by default,
    # while clang simply refuses to compile it at all
    ENV.append_to_cflags "-fnested-functions"

    cd "src" do
      system "make", "org2xm", "wave100"
      libexec.install "org2xm", "wave100"

      # org2xm has to be run in a specific directory; this wrapper
      # lets it be called from anywhere
      (bin/'org2xm').write <<-EOS.undent
      #!/usr/bin/env ruby

      ARGV[0] = File.expand_path(ARGV[0]) if ARGV[0]
      # org2xm must be run in this directory in order to find its samples.
      Dir.chdir "#{share}/org2xm"
      exec "#{libexec}/org2xm", *ARGV
      EOS
    end

    cd "samples" do
      system libexec/"wave100" rescue nil # exits 255 on success!
    end

    # Full Cave Story soundtrack, plus requisite samples
    (share/"org2xm").install "org", "samples"
  end

  def caveats; <<-EOS.undent
    The full Cave Story soundtrack has been installed to:
      #{share}/org2xm/org
  EOS
  end
end
