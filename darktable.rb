class Darktable < Formula
  homepage "http://www.darktable.org/"
  url "https://downloads.sourceforge.net/project/darktable/darktable/1.0/darktable-1.0.5.tar.gz"
  sha256 "0c18530446d2f2459fe533a1ef6fc2711300efe7466f36c23168ec2230fb5fbd"
  license "GPL-3.0-or-later"

  depends_on "cmake" => :build
  depends_on "intltool" => :build
  depends_on "atk"
  depends_on "babl"
  depends_on "gegl"
  depends_on "exiv2"
  depends_on "gettext"
  depends_on "gtk+"
  depends_on "jpeg"
  depends_on "libtiff"
  depends_on "sqlite"
  depends_on "openexr"
  depends_on "libgphoto2"
  depends_on "dbus"
  depends_on "fop"
  depends_on "librsvg"
  depends_on "flickcurl"
  depends_on "lensfun"
  depends_on "libx11"

  def install
    # The default interpolation results in -D_DARWIN_C_SOURCE being
    # incorrectly prepended with a semicolon
    inreplace "CMakeLists.txt" do |s|
      s.gsub! "${CMAKE_C_FLAGS} -D_DARWIN_C_SOURCE",
        "${CMAKE_C_FLAGS}-D_DARWIN_C_SOURCE"
      s.gsub! "${CMAKE_CXX_FLAGS} -D_DARWIN_C_SOURCE",
        "${CMAKE_C_FLAGS}-D_DARWIN_C_SOURCE"
    end

    Dir.mkdir "build"
    cd "build" do
      # yep, cmake returns non-0 for success here
      system "cmake", "..", *std_cmake_args rescue true
      system "make", "install"
    end
  end
end
