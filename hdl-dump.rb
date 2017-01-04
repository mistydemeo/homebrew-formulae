class HdlDump < Formula
  desc "CLI tool to interact with Open PS2 Loader over a network"
  homepage "https://bitbucket.org/AKuHAK/hdl-dump"
  head "https://bitbucket.org/AKuHAK/hdl-dump", :using => :hg

  def install
    system "make", "RELEASE=yes", "IIN_OPTICAL_MMAP=no"
    bin.install "hdl_dump"
  end
end
