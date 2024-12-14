class Lstcp < Formula
  homepage "https://github.com/ticky/dotfiles"
  url "https://github.com/ticky/dotfiles.git", :revision => "6b06b92bc554da3fb8031f3c74ddf1f8aa63406d"
  version "2017-09-11+git6b06b92bc554da3fb8031f3c74ddf1f8aa63406d"
  license "MIT"

  def install
    bin.install "platform/darwin/bin/lstcp"
    man1.install "platform/darwin/man/man1/lstcp.1"
  end
end
