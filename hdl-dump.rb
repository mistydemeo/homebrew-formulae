class HdlDump < Formula
  desc "CLI tool to interact with Open PS2 Loader over a network"
  homepage "https://github.com/AKuHAK/hdl-dump"
  url "https://github.com/AKuHAK/hdl-dump/archive/v47.tar.gz"
  sha256 "8f946862e645896d298089fb1518ccbb30264fb8bdcd3f4bba0477c0fb893e68"
  head "https://github.com/AKuHAK/hdl-dump"

  def install
    system "make", "RELEASE=yes", "IIN_OPTICAL_MMAP=no"
    bin.install "hdl_dump"
  end
end
