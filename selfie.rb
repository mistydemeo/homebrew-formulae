class Selfie < Formula
  desc "Easy-peasy selfie-taking script"
  homepage "https://gitlab.com/grapegravity/dotfiles/"
  head "https://gitlab.com/grapegravity/dotfiles.git"

  depends_on "imagesnap"

  def install
    bin.install %w[platform/all/bin/selfie platform/all/bin/zdate]
    man1.install "platform/all/man/man1/selfie.1"
  end
end
