class LibcueStatic < Formula
  desc "Statically-build version of libcue"
  homepage "https://github.com/lipnitsk/libcue"
  url "https://github.com/lipnitsk/libcue/archive/v2.3.0.tar.gz"
  sha256 "cc1b3a65c60bd88b77a1ddd1574042d83cf7cc32b85fe9481c99613359eb7cfe"
  license "GPL-2.0"

  depends_on "cmake" => :build

  uses_from_macos "bison" => :build
  uses_from_macos "flex" => :build

  keg_only "Copy of libcue library"

  def install
    system "cmake", ".", "-DBUILD_SHARED_LIBS=OFF", *std_cmake_args
    system "make"
    (pkgshare/"tests").mkpath
    cp_r "t/.", pkgshare/"tests"
    system "make", "test"
    system "make", "install"
  end

  test do
    cp_r (pkgshare/"tests").children, testpath
    Dir["*.c"].each do |f|
      system ENV.cc, f, "-o", "test", "-L#{lib}", "#{lib}/libcue.a", "-I#{include}"
      system "./test"
      rm "test"
    end
  end
end
