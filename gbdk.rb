class Gbdk < Formula
  homepage "http://gbdk.sourceforge.net/"
  head "https://github.com/qatsindio/gbdk.git"

  patch :p0 do
    url "https://raw.githubusercontent.com/co-me/gbdk/c8dc0a57e94a5c68555355585649f83c6c0b5032/macosx.patch"
    sha256 "7ffa454a3b99538d69fef0823bf3607177164ce2b7844d81fccedf80ed2aee12"
  end

  def install
    ENV.deparallelize
    mkdir "sdcc/bin" # makefile forgets to make this directory
    system "make", "install", "TARGETDIR=#{libexec}", "TARGETCC=#{ENV.cc}", "TARGETCXX=#{ENV.cxx}"

    bin.install_symlink Dir["#{libexec}/bin/*"]
  end
end
