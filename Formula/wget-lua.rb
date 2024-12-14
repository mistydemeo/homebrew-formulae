class WgetLua < Formula
  desc "Modern Wget with Lua, Zstandard WARC compression and URL-agnostic deduplication"
  homepage "https://www.archiveteam.org/"
  url "https://github.com/ArchiveTeam/wget-lua/archive/refs/tags/v1.21.3-at.20220528.01.tar.gz"
  sha256 "0910f2f617dff5526c065174ecad20e37a9b22d1269b95f23b10ef89be71130f"
  license "GPL-3.0-or-later"

  head do
    url "https://github.com/ArchiveTeam/wget-lua.git", branch: "v1.21.3-at"

    depends_on "xz" => :build
  end

  depends_on "autoconf" => :build
  depends_on "autoconf-archive" => :build
  depends_on "automake" => :build
  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "libidn2"
  depends_on "lua@5.1"
  depends_on "openssl@1.1"
  depends_on "zstd"

  resource "gnulib" do
    url "https://git.savannah.gnu.org/git/gnulib.git", branch: "master"
  end

  def install
    bootstrap_args = ["--skip-po"]

    # Avoid needing to do a git checkout of the stable release
    # by providing our own copy of gnulib
    unless build.head?
      (buildpath/"gnulib").install resource("gnulib")
      ENV["GNULIB_SRCDIR"] = buildpath/"gnulib"
      bootstrap_args << "--no-git"
    end

    # ENV.append_to_cflags "-I#{Formula["lua"].include}/lua@5.1"

    system "./bootstrap", *bootstrap_args
    system "./configure", "--prefix=#{prefix}",
                          "--sysconfdir=#{etc}",
                          "--with-ssl=openssl",
                          "--with-libssl-prefix=#{Formula["openssl@1.1"].opt_prefix}",
                          "--disable-pcre",
                          "--disable-pcre2",
                          "--without-libpsl",
                          "--without-included-regex",
                          "--program-suffix=-lua"
    # doesn't ask autoconf where it was found
    inreplace "src/luahooks.c" do |s|
      s.gsub! "lua.h", "lua-5.1/lua.h"
      s.gsub! "lauxlib.h", "lua-5.1/lauxlib.h"
      s.gsub! "lualib.h", "lua-5.1/lualib.h"
    end
    system "make"
    # Doesn't seem to respect --program-suffix, so just install manually
    bin.install "src/wget" => "wget-lua"
  end

  test do
    system bin/"wget-lua", "-O", "/dev/null", "https://google.com"
  end
end
