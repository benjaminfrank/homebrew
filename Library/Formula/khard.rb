class Khard < Formula
  desc "Console carddav client."
  homepage "https://github.com/scheibler/khard"
  url "https://github.com/scheibler/khard/archive/v0.4.0.tar.gz"
  sha256 "4140fb06a1da63a5eb26edc7d3e3c01b99c464276a9e590b57ee2451c4416f77"

  depends_on :python if MacOS.version <= :snow_leopard

  resource "vobject" do
    url "https://pypi.python.org/packages/source/v/vobject/vobject-0.8.1c.tar.gz"
    sha256 "594113117f2017ed837c8f3ce727616f9053baa5a5463a7420c8249b8fc556f5"
  end
  resource "configobj" do
    url "https://pypi.python.org/packages/source/c/configobj/configobj-5.0.6.tar.gz"
    sha256 "a2f5650770e1c87fb335af19a9b7eb73fc05ccf22144eb68db7d00cd2bcb0902"
  end
  resource "argparse" do
    url "https://pypi.python.org/packages/source/a/argparse/argparse-1.3.0.tar.gz"
    sha256 "b3a79a23d37b5a02faa550b92cbbbebeb4aa1d77e649c3eb39c19abf5262da04"
  end

  def install
    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python2.7/site-packages"
    %w[vobject configobj argparse].each do |r|
      resource(r).stage do
        system "python", *Language::Python.setup_install_args(libexec/"vendor")
      end
    end

    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python2.7/site-packages"
    system "python", *Language::Python.setup_install_args(libexec)

    bin.install Dir["#{libexec}/bin/*"]
    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end

  test do
    system "#{bin}/khard", "--version"
  end
end
