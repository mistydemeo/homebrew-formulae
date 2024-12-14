class DreamSparer < Formula
  desc "Simple tool for extracting chunks from little-endian RIFX files"
  homepage "https://github.com/hikari-no-yume/dream-sparer"
  license "MIT"
  head "https://github.com/hikari-no-yume/dream-sparer.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    system "#{bin}/dream-sparer", "--help"
  end
end
