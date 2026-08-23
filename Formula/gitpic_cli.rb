class GitpicCli < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.18.1/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "91ffaf0a7f072997b57607259f008f6b94247f62daad5970062e892b80612091"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.18.1/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "b03e9d2e791c4958c6cfe793b1a27e4bfee7f376b586d982b6723c8e8d68e625"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.18.1/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "33eb2aa7e6b76e272cbe042836b4d535f925e1a02232cd75589c696b78707e4a"
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
