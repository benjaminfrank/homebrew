class Muttvcardsearch < Formula
  desc "A small mutt carddav search utility for Owncloud or SOGo server"
  homepage "https://github.com/BlackIkeEagle/muttvcardsearch"
  url "https://github.com/BlackIkeEagle/muttvcardsearch/archive/v1.9.tar.gz"
  sha256 "4c099938dd02f577d8289bbc5e82f0af6f290a564a30f6fdcb5cc880cd02fc8d"

  option "with-debug", "build debug version"
  depends_on "cmake" => :build
  depends_on "sqlite"

  def install
    mkdir "build" do
      args = std_cmake_parameters.split
      if build.include? "enable-debug"
        args.delete "-DCMAKE_BUILD_TYPE=None"
        args << "-DCMAKE_BUILD_TYPE=Debug"
      end
      system "cmake", "..", *args
      system "make"
      bin.install "muttvcardsearch"
    end
  end

  test do
    system "muttvcardsearch"
  end
end
