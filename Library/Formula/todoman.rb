class Todoman < Formula
  desc "Simple icalendar based, cli task and todo manager."
  homepage "https://github.com/pimutils/todoman"
  url "https://pypi.python.org/packages/source/t/todoman/todoman-1.5.2.tar.gz"
  sha256 "fc9b813d112b3a5b0669a0ce016fa9dc18cb1e5d2506b7a08affce3ff59a902b"

  bottle do
    cellar :any_skip_relocation
    sha256 "a16a360d2a7ede6c8b1bd8bbbd8cd2c35c6f19aa4445fdd47f82091fa8925133" => :el_capitan
    sha256 "c7449542c557bf6b3811c613059bd1b5cefd3a026a9087e6247169304f391a69" => :yosemite
    sha256 "913747585138e99fbf333185674d044f03981e7fd773fd28e7b92b7d03a1cda8" => :mavericks
  end

  depends_on :python3

  resource "click" do
    url "https://pypi.python.org/packages/source/c/click/click-6.4.tar.gz"
    sha256 "6eb86ac0e44e60b3085e7b87797fe2adf745dbea38b78d7db1f17ec96ca016ed"
  end

  resource "icalendar" do
    url "https://pypi.python.org/packages/source/i/icalendar/icalendar-3.9.2.tar.gz"
    sha256 "0b2d2610e039404e22a0a72fe5a59614374e7bd15ed824ead6ef6f8d36b41e2f"
  end

  resource "urwid" do
    url "https://pypi.python.org/packages/source/u/urwid/urwid-1.3.1.tar.gz"
    sha256 "cfcec03e36de25a1073e2e35c2c7b0cc6969b85745715c3a025a31d9786896a1"
  end

  resource "pyxdg" do
    url "https://pypi.python.org/packages/source/p/pyxdg/pyxdg-0.25.tar.gz"
    sha256 "81e883e0b9517d624e8b0499eb267b82a815c0b7146d5269f364988ae031279d"
  end

  resource "atomicwrites" do
    url "https://pypi.python.org/packages/source/a/atomicwrites/atomicwrites-1.0.0.tar.gz"
    sha256 "1b977e9a6cbf8ae36a4e259e6da28d98fda6ab81cbf9634258eee0700e512e05"
  end

  resource "ansi" do
    url "https://pypi.python.org/packages/source/a/ansi/ansi-0.1.3.tar.gz"
    sha256 "ef1eff1d52ee5db71e0954e515c32ec0a65933326c8bf887f698eebfc021c61b"
  end

  resource "parsedatetime" do
    url "https://pypi.python.org/packages/source/p/parsedatetime/parsedatetime-2.1.tar.gz"
    sha256 "17c578775520c99131634e09cfca5a05ea9e1bd2a05cd06967ebece10df7af2d"
  end

  resource "setuptools_scm" do
    url "https://pypi.python.org/packages/source/s/setuptools_scm/setuptools_scm-1.10.1.tar.bz2"
    sha256 "1cdea91bbe1ec4d52b3e9c451ab32ae6e1f3aa3fd91e90580490a9eb75bea286"
  end

  resource "pytz" do
    url "https://pypi.python.org/packages/source/p/pytz/pytz-2016.3.tar.bz2"
    sha256 "c193dfa167ac32c8cb96f26cbcd92972591b22bda0bac3effdbdb04de6cc55d6"
  end

  resource "python-dateutil" do
    url "https://pypi.python.org/packages/source/p/python-dateutil/python-dateutil-2.5.2.tar.gz"
    sha256 "063907ef47f6e187b8fe0728952e4effb587a34f2dc356888646f9b71fbb2e4b"
  end

  resource "six" do
    url "https://pypi.python.org/packages/source/s/six/six-1.9.0.tar.gz"
    sha256 "e24052411fc4fbd1f672635537c3fc2330d9481b18c0317695b46259512c91d5"
  end

  def install
    version = Language::Python.major_minor_version "python3"
    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python#{version}/site-packages"
    resources.each do |r|
      r.stage do
        system "python3", *Language::Python.setup_install_args(libexec/"vendor")
      end
    end

    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python#{version}/site-packages"
    system "python3", *Language::Python.setup_install_args(libexec)

    bin.install Dir["#{libexec}/bin/*"]
    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end

  test do
    system "#{bin}/todo", "--version"
  end
end
