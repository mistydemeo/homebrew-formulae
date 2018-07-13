class LibcueStatic < Formula
  desc "Statically-build version of libcue"
  homepage "https://github.com/lipnitsk/libcue"
  url "https://github.com/lipnitsk/libcue/archive/v2.2.1.tar.gz"
  sha256 "f27bc3ebb2e892cd9d32a7bee6d84576a60f955f29f748b9b487b173712f1200"

  depends_on "cmake" => :build

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
