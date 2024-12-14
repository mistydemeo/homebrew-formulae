class Ctrtool < Formula
  desc "General purpose reading/extraction tool for Nintendo 3DS file formats"
  homepage "https://github.com/3DSGuy/Project_CTR"
  url "https://github.com/3DSGuy/Project_CTR/archive/refs/tags/ctrtool-v1.1.1-r2.tar.gz"
  version "1.1.1"
  sha256 "3badb6291abcb47ccc451cede099e04ec55960904d6a12268d348d043e8aff02"

  def install
    chdir "ctrtool" do
      system "make", "deps"
      system "make"
      bin.install "bin/ctrtool"
    end
  end

  test do
    assert_match("CTRTool v#{version} (C) jakcron", shell_output("#{bin}/ctrtool 2>&1", 1))
  end
end
