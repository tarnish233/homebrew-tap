class GitpicCli < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.20.3/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "9d754cd60cdcf61b64a36d6f3f756653f35ce1d072ebd27f858d3c20f5c19f23"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.20.3/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "e8d0d26b7aabfa7c86a6267f540c057999888a8a034ef0c1e7b4e32f5e059878"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.20.3/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6a89ebf3264c309d87509a4ec5845826470e35a183454032a38f18334ea39e53"
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
