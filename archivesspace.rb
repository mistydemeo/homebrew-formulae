class Archivesspace < Formula
  homepage "http://archivesspace.org/"
  url "https://github.com/archivesspace/archivesspace/releases/download/v1.1.2/archivesspace-v1.1.2.zip"
  version "1.1.2"
  sha1 "7a000e0af9765842f7da1a06fcf102d9c2199213"

  depends_on :java => "1.6"

  def install
    libexec.install Dir["*"]
    bin.install_symlink "#{libexec}/archivesspace.sh" => "archivesspace"
  end

  def plist; <<-EOS.undent
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
    <dict>
      <key>Label</key>
      <string>#{plist_name}</string>
      <key>ProgramArguments</key>
      <array>
        <string>#{opt_bin}/archivesspace</string>
      </array>
      <key>RunAtLoad</key>
      <true/>
    </dict>
    </plist>
    EOS
  end
end
