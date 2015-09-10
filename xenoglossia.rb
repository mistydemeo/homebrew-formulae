class Xenoglossia < Formula
  desc "Robust(?) string-manipulation language"
  homepage "https://github.com/mistydemeo/xenoglossia"
  url "https://github.com/mistydemeo/xenoglossia/archive/v0.1.tar.gz"
  sha256 "98140be14f086a0ce48abc4b4b2802c191d09addee258c32aa93332909fc9dd3"

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
