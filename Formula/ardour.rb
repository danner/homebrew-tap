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
  # Clone Ardour repository is handled by `head`

  # Build Ardour
  system "./waf", "configure", "--prefix=#{prefix}", "--with-backends=jack"
  system "./waf"

  # Install Ardour
  system "./waf", "install", "--destdir=#{prefix}"

  # Create .app bundle
  cd "tools/osx_packaging" do
    system "./osx_build", "--public"
  end

  # Move the .app bundle to the prefix directory
  app_bundle = Dir.glob("tools/osx_packaging/*.app").first
  prefix.install app_bundle if app_bundle
end

test do
  # Verify the installation by checking the version
  assert_match "Ardour", shell_output("#{bin}/ardour --version")
end