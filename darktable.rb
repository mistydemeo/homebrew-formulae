class Darktable < Formula
  homepage "http://www.darktable.org/"
  url "https://github.com/darktable-org/darktable/releases/download/release-1.6.6/darktable-1.6.6.tar.xz"
  sha256 "f85e4b8219677eba34f5a41e1a0784cc6ec06576326a99f04e460a4f41fd21a5"

  head "https://github.com/darktable-org/darktable.git",
       :branch => "darktable-1.6.x"

  depends_on "cmake" => :build
  depends_on "intltool" => :build
  depends_on "flickcurl" => :optional
  depends_on "graphicsmagick" => :optional
  depends_on "libsecret" => :optional
  depends_on "libsoup" => :optional
  depends_on "lua" => :optional
  depends_on "webp" => :optional
  depends_on "atk"
  depends_on "babl"
  depends_on "d-bus"
  depends_on "exiv2"
  depends_on "fop"
  depends_on "gettext"
  depends_on "gegl"
  depends_on "gtk+3"
  depends_on "jpeg"
  depends_on "json-glib"
  depends_on "lensfun"
  depends_on "libgphoto2"
  depends_on "librsvg"
  depends_on "libtiff"
  depends_on "little-cms2"
  depends_on "openexr"
  depends_on "sqlite"
  depends_on :x11

  def install
    # The default interpolation results in -D_DARWIN_C_SOURCE being
    # incorrectly prepended with a semicolon
    inreplace "CMakeLists.txt" do |s|
      s.gsub! "${CMAKE_C_FLAGS} -D_DARWIN_C_SOURCE",
        "${CMAKE_C_FLAGS}-D_DARWIN_C_SOURCE"
      s.gsub! "${CMAKE_CXX_FLAGS} -D_DARWIN_C_SOURCE",
        "${CMAKE_C_FLAGS}-D_DARWIN_C_SOURCE"
    end

    args = %W[
      --prefix #{prefix}
      --buildtype Release
    ]
    args << "--disable-webp" if build.without? "webp"
    args << "--disable-lua" if build.without? "lua"
    args << "--disable-flickr" if build.without? "flickr"

    system "./build.sh", *args
    cd "./build" do
      system "make", "install"
    end
  end

  test do
    system bin/"darktable-cli", test_fixtures("test.png"),
           testpath/"out.jpg", "--width", "4px"
    assert_match "4",
                 shell_output("sips -g pixelWidth #{testpath}/out.jpg")
  end
end
