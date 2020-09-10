class Pygopherd < Formula
  desc "Python Gopher server"
  homepage "http://gopher.quux.org:70/devel/gopher/pygopherd"
  url "https://github.com/jgoerzen/pygopherd/archive/debian/2.0.18.3.tar.gz"
  sha256 "e13307bd66c7cd0c4d09127e57744f2b32c819c5d5921d1fa6897164f4363e1e"
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
