class LibcueStatic < Formula
  desc "Statically-build version of libcue"
  homepage "https://github.com/lipnitsk/libcue"
  url "https://github.com/lipnitsk/libcue/archive/v2.2.0.tar.gz"
  sha256 "328f14b8ae0a6b8d4c96928b53b88a86d72a354b4da9d846343c78ba36022879"

  depends_on "cmake" => :build

  keg_only "Copy of libcue library"

  def install
    # Shared library is hardcoded
    inreplace "CMakeLists.txt", "ADD_LIBRARY(cue SHARED", "ADD_LIBRARY(cue STATIC"

    system "cmake", ".", *std_cmake_args
    system "make"
    (pkgshare/"tests").mkpath
    cp_r "t/.", pkgshare/"tests"
    system "make", "test"
    system "make", "install"
  end

  test do
    cp_r (pkgshare/"tests").children, testpath
    Dir["*.c"].each do |f|
      system ENV.cc, f, "-o", "test", "-L#{lib}", "-lcue", "-I#{include}"
      system "./test"
      rm "test"
    end
  end
end
