class Gitpic < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic-cli"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.9.0/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "6025ffbeec4a35d90a17ace3e2f86b801b1d28b5b7d65b6608fc965642e4f259"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.9.0/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "f382e4e821e331577b1bc74dc435eb8fad145666f0705180dd1d5685f8ee39a0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.9.0/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "33600877705be5f4b10cdcd961c1dd1cb8f4b5d388445b3e2c065945a0cd4e3a"
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
