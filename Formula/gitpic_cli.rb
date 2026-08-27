class GitpicCli < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.20.7/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "e2f2e5809e14f720d0e9137b0787dd38456fb685d75528aabc5a5df586caa4d5"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.20.7/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "3cc66959f87d9cadbecc5773494b78660c5c273eb46eb0f4c5930b6314c8774a"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.20.7/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "f8937df85c8cd4a548d481ff3958331e0336981e2536a36c79ffbde76a050e03"
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
