class GitpicCli < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.13.1/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "69529f352c9e880ded3c6a0f24c38d8e94b5448d1efdd12358e3f0db57f90b9f"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.13.1/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "777bb80da2b2df2b227210cbe1fe5ffb7c7c985fb6db77344f5cfaddcde0aa9b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.13.1/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "284fa8f9938b37e94a97a4b2b627599bb39d0b244fc599bba0a655fb3acba8b7"
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
