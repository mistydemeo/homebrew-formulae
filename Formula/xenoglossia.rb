class Xenoglossia < Formula
  desc "Robust(?) string-manipulation language"
  homepage "https://github.com/mistydemeo/xenoglossia"
  url "https://github.com/mistydemeo/xenoglossia/archive/v0.2.tar.gz"
  sha256 "0c26359a05d2feaa7ae5c90c3d68819aa5d36faa1307f531b66b37fdbef1703c"
  license "WTFPL"

  depends_on :python if MacOS.version <= :snow_leopard

  def install
    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python2.7/site-packages"
    system "python", *Language::Python.setup_install_args(libexec)

    bin.install Dir[libexec/"bin/*"]
    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end

  test do
    assert_equal "This is a successful test",
                 shell_output("#{bin}/xg -i 'This is a test' 'sub \"test\" \"successful test\"'").chomp
  end
end
