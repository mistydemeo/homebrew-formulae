class Ruby182 < Formula
  desc "Powerful, clean, object-oriented scripting language"
  homepage "https://www.ruby-lang.org/en/"
  url "http://cache.ruby-lang.org/pub/ruby/1.8/ruby-1.8.2.tar.gz"
  mirror "https://mirrorservice.org/sites/ftp.ruby-lang.org/pub/ruby/1.8/ruby-1.8.2.tar.bz2"
  sha256 "34cf95791323c96dc92c672c16daaef69f00a0ba69e1c43bab893ae38b7eeb3e"
  revision 1

  bottle do
    sha256 "4e918f3ec701769e0e0ddfb459fb3d45a3072fe4732ac589496c316f73beb85d" => :yosemite
    sha256 "47684646fc21d058141fba06b3b54068ac1a852f6e1c9fc9df4b4335fcc2567d" => :mavericks
    sha256 "7791867a6be241be8af20d25727a4730040a738e66a2c21cd7046ce117be2fad" => :mountain_lion
  end

  keg_only :provided_by_macos

  option :universal
  option "with-suffix", "Suffix commands with '182'"
  option "with-doc", "Install documentation"
  option "with-tcltk", "Install with Tcl/Tk support"

  depends_on "pkg-config" => :build
  depends_on "libyaml"
  depends_on "openssl"
  depends_on :x11 if build.with? "tcltk"
  depends_on "readline" => :recommended
  depends_on "gdbm" => :optional

  # First patch fixes up a few incompatibilities with modern OpenSSL
  # ossl_x509stctx_set_time() definition taken from 1.8.6
  # Second patch backports a compatibility fix from Ruby 1.8.7 for newer OpenSSL versions
  # Third patch fixes the type of a macro, also taken from 1.8.7
  # Fourth patch fixes another OpenSSL macro, taken from Ruby 2.1.4
  patch :DATA

  def install
    # Otherwise it will try to link against some other libruby,
    # instead of the one it just built
    ENV.prepend "LDFLAGS", "-L."

    args = %W[--prefix=#{prefix} --mandir=#{man} --enable-shared --with-openssl-dir=#{Formula["openssl"].opt_prefix}]

    if build.universal?
      ENV.universal_binary
      args << "--with-arch=#{Hardware::CPU.universal_archs.join(",")}"
    end

    args << "--program-suffix=182" if build.with? "suffix"
    args << "--with-out-ext=tk" if build.without? "tcltk"
    args << "--disable-install-doc" if build.without? "doc"
    args << "--disable-dtrace" unless MacOS::CLT.installed?
    args << "--with-sitedir=#{HOMEBREW_PREFIX}/lib/ruby/site_ruby"

    system "./configure", *args

    # Ruby has been configured to look in the HOMEBREW_PREFIX for the
    # sitedir directory; however we don't actually want to create
    # them during the install.
    #
    # These directories are empty on install; sitedir is used for non-rubygems
    # third party libraries
    inreplace "instruby.rb" do |s|
      s.gsub! "makedirs [bindir, libdir, rubylibdir, archlibdir, sitelibdir, sitearchlibdir]",
              "makedirs [bindir, libdir, rubylibdir, archlibdir]"
    end

    system "make"
    system "make", "install"
    system "make", "install-doc" if build.with? "doc"
  end

  def post_install
    # Create the sitedir that was skipped during install
    mkdir_p `#{bin}/ruby -rrbconfig -e 'print Config::CONFIG["sitearchdir"]'`
  end

  test do
    hello_text = shell_output("#{bin}/ruby -e 'puts :hello'")
    assert_equal "hello\n", hello_text
  end
end

__END__
diff --git a/ext/openssl/openssl_missing.h b/ext/openssl/openssl_missing.h
index caf1bfe..cde9c6f 100644
--- a/ext/openssl/openssl_missing.h
+++ b/ext/openssl/openssl_missing.h
@@ -112,8 +112,8 @@ int X509_CRL_add0_revoked(X509_CRL *crl, X509_REVOKED *rev);
 int BN_mod_sqr(BIGNUM *r, const BIGNUM *a, const BIGNUM *m, BN_CTX *ctx);
 int BN_mod_add(BIGNUM *r, const BIGNUM *a, const BIGNUM *b, const BIGNUM *m, BN_CTX *ctx);
 int BN_mod_sub(BIGNUM *r, const BIGNUM *a, const BIGNUM *b, const BIGNUM *m, BN_CTX *ctx);
-int BN_rand_range(BIGNUM *r, BIGNUM *range);
-int BN_pseudo_rand_range(BIGNUM *r, BIGNUM *range);
+int BN_rand_range(BIGNUM *r, const BIGNUM *range);
+int BN_pseudo_rand_range(BIGNUM *r, const BIGNUM *range);
 char *CONF_get1_default_config_file(void);
 int PEM_def_callback(char *buf, int num, int w, void *key);
 
diff --git a/ext/openssl/ossl_x509store.c b/ext/openssl/ossl_x509store.c
index 138e710..79fa341 100644
--- a/ext/openssl/ossl_x509store.c
+++ b/ext/openssl/ossl_x509store.c
@@ -535,17 +535,11 @@ static VALUE
 ossl_x509stctx_set_time(VALUE self, VALUE time)
 {
     X509_STORE_CTX *store;
+    long t;
 
-    if(NIL_P(time)) {
-	GetX509StCtx(self, store);
-	store->flags &= ~X509_V_FLAG_USE_CHECK_TIME;
-    }
-    else {
-	long t = NUM2LONG(rb_Integer(time));
-
-	GetX509StCtx(self, store);
-	X509_STORE_CTX_set_time(store, 0, t);
-    }
+    t = NUM2LONG(rb_Integer(time));
+    GetX509StCtx(self, store);
+    X509_STORE_CTX_set_time(store, 0, t);
 
     return time;
 }

diff --git a/ext/openssl/ossl.h b/ext/openssl/ossl.h
index 8dfd8da..25a62bc 100644
--- a/ext/openssl/ossl.h
+++ b/ext/openssl/ossl.h
@@ -107,6 +107,13 @@ extern VALUE eOSSLError;
 } while (0)
 
 /*
+* Compatibility
+*/
+#if OPENSSL_VERSION_NUMBER >= 0x10000000L
+#define STACK _STACK
+#endif
+
+/*
  * String to HEXString conversion
  */
 int string2hex(char *, int, char **, int *);

diff --git a/ext/openssl/ossl.c b/ext/openssl/ossl.c
index 1b8f76a..73fdd03 100644
--- a/ext/openssl/ossl.c
+++ b/ext/openssl/ossl.c
@@ -92,7 +92,7 @@ ossl_x509_ary2sk(VALUE ary)
 
 #define OSSL_IMPL_SK2ARY(name, type)	        \
 VALUE						\
-ossl_##name##_sk2ary(STACK *sk)			\
+ossl_##name##_sk2ary(STACK_OF(type) *sk)			\
 {						\
     type *t;					\
     int i, num;					\

diff --git a/ext/openssl/ossl_ssl.c b/ext/openssl/ossl_ssl.c
index c4569c7..d6f8822 100644
--- a/ext/openssl/ossl_ssl.c
+++ b/ext/openssl/ossl_ssl.c
@@ -96,13 +96,16 @@ struct {
     const char *name;
     SSL_METHOD *(*func)(void);
 } ossl_ssl_method_tab[] = {
-#define OSSL_SSL_METHOD_ENTRY(name) { #name, name##_method }
+#define OSSL_SSL_METHOD_ENTRY(name) { #name, (SSL_METHOD *(*)(void))name##_method }
     OSSL_SSL_METHOD_ENTRY(TLSv1),
     OSSL_SSL_METHOD_ENTRY(TLSv1_server),
     OSSL_SSL_METHOD_ENTRY(TLSv1_client),
+#if defined(HAVE_SSLV2_METHOD) && defined(HAVE_SSLV2_SERVER_METHOD) && \
+        defined(HAVE_SSLV2_CLIENT_METHOD)
     OSSL_SSL_METHOD_ENTRY(SSLv2),
     OSSL_SSL_METHOD_ENTRY(SSLv2_server),
     OSSL_SSL_METHOD_ENTRY(SSLv2_client),
+#endif
     OSSL_SSL_METHOD_ENTRY(SSLv3),
     OSSL_SSL_METHOD_ENTRY(SSLv3_server),
     OSSL_SSL_METHOD_ENTRY(SSLv3_client),
