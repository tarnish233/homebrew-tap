class GitpicCli < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.20.8/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "3ed20f50b2042121d484aeeeec55c0f9d8193539882a51234dbd741799e89725"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.20.8/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "af491bf6d110caa2966d6a68115c151e72eb07fd60b4e65da34e9c2ffa0a9cf2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.20.8/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0b85e49afe7da2273c48de3a95a2552cb25733b230f740406b405c7891a5c08f"
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
