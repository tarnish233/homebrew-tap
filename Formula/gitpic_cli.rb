class GitpicCli < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic-cli"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.11.3/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "5b6545f8f2476c72d8c8c85ab1b1ee085022f427a0bc4c93e7d1437106695ec4"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.11.3/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "5224371e723e71f6e87d9e7a3520cff27f50b1be882f5aeb13b61908c5d204e0"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.11.3/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b7a31d54a579ac9444fee188a12e8fe0ac0d53bad43b07bd3dcda89581db36df"
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
