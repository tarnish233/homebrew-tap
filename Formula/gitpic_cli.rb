class GitpicCli < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.20.6/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "a9e0558063398484cfbb96b7fc45cd4f791dd8ee74a3b8b591081f94e16c1fce"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.20.6/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "bae95a399a957d0cfcab7e3bfb64866ed5d3ef502a7e840c7e0ddf0d58c703af"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.20.6/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4e6f1627e3e1b021333cb650f68a35386576beb8499e134b09537377c4c5b8d6"
    end
  end

  def install
    bin.install "gitpic"
    # Auto-generate & install shell completions (bash, zsh, fish)
    generate_completions_from_executable(bin/"gitpic", "completion")
  end

  test do
    assert_match "gitpic #{version}", shell_output("#{bin}/gitpic --version")
  end
end
