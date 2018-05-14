class FloatingIps < Formula
  desc "IPS and BPS patching tool"
  homepage "https://github.com/Alcaro/Flips"
  head "https://github.com/Alcaro/Flips.git"

  stable do
    url "https://dl.smwcentral.net/11474/floating.zip"
    version "1.31"
    sha256 "1e28e9217084b81ba53d51c4b5d29179a6c1f9d2e0f900c08c55df1666298c80"

    # Fixes an issue with a function name by backporting a change from
    # the next release.
    # We can't make this a real patch because the source code is a
    # ZIP file inside of the main archive.
    resource "patch" do
      url "https://gist.githubusercontent.com/mistydemeo/9374c6338b771911b9373cf116b097a3/raw/9febbd8dab1463a43c2ee4e50bd2ac45da6ebf5b/flips_template.patch"
      sha256 "2ade7be0cc656ee6980119f9ae09da3ce0a42330ab53ea8c9ae0e3c06533a62e"
    end
  end

  def install
    if build.stable?
      system "unzip", "src.zip"
      buildpath.install resource("patch")
      system "patch -p1 < flips_template.patch"
    end

    system "make", "TARGET=cli"
    bin.install "flips"
  end

  test do
    assert_equal "Flips v#{version}", shell_output("#{bin}/flips -v").chomp
  end
end
