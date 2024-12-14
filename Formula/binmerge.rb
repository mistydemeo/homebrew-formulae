class Binmerge < Formula
  desc "Tool to merge multiple bin/cue tracks into one"
  homepage "https://github.com/putnam/binmerge"
  url "https://github.com/putnam/binmerge/releases/download/1.0.1/binmerge-1.0.1.zip"
  sha256 "bb7da721cf447b4a06ed1635b71a8001557eb80407983219d461e4990cfa7b3d"
  license "GPL-2.0-only"

  def install
    bin.install "binmerge"
  end

  test do
    assert_match("Copyright (C) 2021 Chris Putnam", shell_output("#{bin}/binmerge -l"))
  end
end
