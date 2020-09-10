class Pygopherd < Formula
  desc "Python Gopher server"
  homepage "http://gopher.quux.org:70/devel/gopher/pygopherd"
  url "https://github.com/jgoerzen/pygopherd/archive/debian/2.0.18.4.tar.gz"
  sha256 "32b330d72afa3d4b44b2257af0235fc22f9ffbd302daf2f7054e25b3be8f2126"
  license "GPL-2.0"

  def install
    inreplace %w[bin/pygopherd setup.py],
      "/etc/pygopherd", "#{etc}/pygopherd"

    inreplace "conf/pygopherd.conf" do |s|
      s.gsub! "/var/run", "#{var}/run"
      s.gsub! "/var/gopher", "#{var}/gopher"
      s.gsub! "/etc/", "#{etc}/"

      # Allow pygopherd to run as the user account by default
      s.gsub! /^port = 70/, "port = 7070"
      s.gsub! "setuid = gopher", "# setuid = gopher"
      s.gsub! "setgid = gopher", "# setgid = gopher"
      s.gsub! "usechroot = yes", "usechroot = no"
    end

    system "python", "setup.py", "install", "--prefix=#{prefix}"

    mkdir_p "#{var}/gopher"
  end

  def caveats; <<~EOS
    pygopherd has been configured to run under port 7070 in order to not
    require root. Settings can be customized by editing:
        #{etc}/pygopherd/pygopherd.conf

    The gopher document root is located in:
        #{var}/gopher
    EOS
  end
end
