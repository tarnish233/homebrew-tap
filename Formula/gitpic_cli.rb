class GitpicCli < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.20.4/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "357ea7c5d890021ea27055b62b9d214b208578ff92c143a3815afa6ac6f3fabe"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.20.4/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "ae7e1a585baa1003e46fd124d595dabd53edc0ab6e7f189da51d97a777e0059e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.20.4/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "79c391f3214cd81e2ff3cfc3a0befeb46a0d5250024a5f05387b99cc6e902863"
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
