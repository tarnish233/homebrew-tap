class Cloudot < Formula
  desc "Sync dotfiles across Macs through Git"
  homepage "https://github.com/tarnish233/cloudot"
  url "https://github.com/tarnish233/cloudot/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "aa2a04bcb405a951a313af9381ecb2ccfb5d6d1fe2998555f4b753ef93c24c73"
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
