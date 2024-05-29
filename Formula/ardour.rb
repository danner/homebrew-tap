class Ardour < Formula
  desc "A digital audio workstation"
  homepage "https://ardour.org/"
  url "https://github.com/Ardour/ardour/archive/refs/tags/8.6.tar.gz"
  version "8.6"
  sha256 "482846caa27df5c966e3f3b755ffe788f40ed600abcb7cd1f0767f7e5fc535cb" # Replace with actual SHA256 hash of the 8.6 tarball
  head "https://github.com/Ardour/ardour.git", branch: "8.6"

  depends_on "pkg-config" => :build
  depends_on "aubio"
  depends_on "boost"
  depends_on "fftw"
  depends_on "glib"
  depends_on "glibmm"
  depends_on "gtkmm"
  depends_on "jack"
  depends_on "libarchive"
  depends_on "liblo"
  depends_on "libsndfile"
  depends_on "libusb"
  depends_on "lrdf"
  depends_on "lilv"
  depends_on "lv2"
  depends_on "pangomm"
  depends_on "rubberband"
  depends_on "serd"
  depends_on "sord"
  depends_on "sratom"
  depends_on "taglib"
  depends_on "vamp-plugin-sdk"

  def install
    system "./waf", "configure", "--prefix=#{prefix}", "--with-backends=jack"
    system "./waf"
    system "./waf", "install"

    # The following block may not be necessary unless specific macOS packaging steps are required
    cd "./tools/osx_packaging" do
      system "./osx_build", "--help"
    end
  end

  test do
    # Verify the version of the installed Ardour
    assert_match "Ardour 8.6", shell_output("#{bin}/ardour8 --version")
  end
end