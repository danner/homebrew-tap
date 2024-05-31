class Ardour < Formula
  desc "A digital audio workstation"
  homepage "https://ardour.org/"
  head "https://github.com/danner/ardour.git", branch: "master"


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
    # Build Ardour
    system "./waf", "configure", "--strict", "--prefix=#{prefix}", "--with-backends=jack,coreaudio,dummy", "--ptformat", "--optimize"
    system "./waf"
    
    # Internationalization support
    system "./waf", "i18n"
    
    # Install Ardour
    system "./waf", "install", "--destdir=#{prefix}"

    # Create .app bundle
    cd "tools/osx_packaging" do
      # Ensure required directories exist
      mkdir_p "#{buildpath}/source/tools/osx_packaging/Ardour8.app/Contents/Resources/media"
      
      system "./osx_build", "--nls", "--public"
    end

    # Move the .app bundle to the prefix directory
    app_bundle = Dir.glob("tools/osx_packaging/*.app").first
    prefix.install app_bundle if app_bundle
  end

  test do
    # Verify the installation by checking the version
    assert_match "Ardour", shell_output("#{bin}/ardour --version")
  end
end