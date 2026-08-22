class GitpicCli < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic-cli"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.11.4/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "38e5223431d2e06b96b51bd97489f7c5550e47d4e87b23547b323508f7be4024"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.11.4/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "836f2687f3ef8d7afcb702f31aaa4769c2eb7ebbcec0a880ef185a50797e8412"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.11.4/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7c785e87084df7b04bf864dbac9402e12e62895415476dd084b0dfe5a4a77573"
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
