class GitpicCli < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.19.0/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "f116c1f5515d1ba3d8272254f82bbcfe546b1d9cac33bd2eec7b1af34b73ec81"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.19.0/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "9f321f4b4895b7655c8bf01347809ea406661f9daf69c6ad24deda921bd51a6f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.19.0/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "20729d279f868bd6e05d7450bf782a24bd402e05e4fe33357aaab442f6902524"
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
