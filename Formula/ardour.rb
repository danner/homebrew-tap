class Ardour < Formula
  desc "A digital audio workstation"
  homepage "https://ardour.org/"
  url "https://github.com/Ardour/ardour/archive/refs/tags/8.6.tar.gz"
  version "8.6"
  sha256 "84d79d73d749cf05a223feb74d5fdfcacfef520e185169752e33fb9bfcbce7b3" # Replace with actual SHA256 hash of the 8.6 tarball
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
    # Check if .waf is available before executing waf commands
    waf_path = "./waf"
    if !File.executable?(waf_path)
      odie ".waf is not available. Please make sure it is installed and accessible."
    end
    
    system waf_path, "configure", "--prefix=#{prefix}", "--with-backends=jack"
    system waf_path, "install"

    cd "./tools/osx_packaging" do
      system waf_path, "--help"
    end
  end

  test do
    # Verify the version of the installed Ardour
    assert_match "Ardour 8.6", shell_output("#{bin}/ardour8 --version")
  end
end