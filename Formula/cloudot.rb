class Cloudot < Formula
  desc "Sync dotfiles across Macs through Git"
  homepage "https://github.com/tarnish233/cloudot"
  url "https://github.com/tarnish233/cloudot/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "1b60aab10ffde4ae7c3749cbba31c65fd3087d34b1edc8f88cd0bcbddfa96a2b"
  license "MIT"

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args(path: "crates/cloudot-cli")
  end

  test do
    assert_match "cloudot #{version}", shell_output("#{bin}/cloudot --version")
    assert_match "Usage:", shell_output("#{bin}/cloudot --help")
  end
end
