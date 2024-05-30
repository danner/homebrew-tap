class Ardour < Formula
  desc "A digital audio workstation"
  homepage "https://ardour.org/"
  url "https://github.com/danner/ardour.git"


  depends_on "aubio"
  depends_on "boost"
  depends_on "fftw"
  depends_on "glib"
  depends_on "glibmm"
  depends_on "jack"
  depends_on "libarchive"
  depends_on "liblo"
  depends_on "libsndfile"
  depends_on "libusb"
  depends_on "lrdf"
  depends_on "lv2"
  depends_on "pangomm"
  depends_on "pkg-config" => :build
  depends_on "rubberband"
  depends_on "serd"
  depends_on "sord"
  depends_on "sratom"
  depends_on "gtkmm"
  depends_on "lilv"
  depends_on "taglib"
  depends_on "vamp-plugin-sdk"
    
  def install
    # Clone Ardour repository
    system "git", "clone", "https://github.com/danner/ardour.git", "source"

    # Build Ardour
    cd "source" do
      system "./waf", "configure"
      system "./waf"

      # Install Ardour
      system "./waf", "install"

      # Create .app bundle
      cd "tools/osx_packaging" do
        system "./osx_build", "--public"
      end
    end
  end

  test do
    # Verify the version of the installed Ardour
    assert_match "Ardour 8.6", shell_output("#{bin}/ardour8 --version")
  end
end