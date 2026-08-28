class GitpicCli < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.20.9/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "2ab62da630ccc065a71702d2c1c8e1e1401682c9b28486f96176b0f8e7f57696"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.20.9/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "0d6bb06f631cab369a94dd2e7f25615bdff3b44c7c8eabebae8f19313fe48e48"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.20.9/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a5d8407f94a21ae63cd343795e0e6ff716ed32ac12833435afbdee053b613411"
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
