class GitpicCli < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.15.0/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "5016454af31042b3d438581d0068542ca7a27a1803341e4c348bce0c62d3958c"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.15.0/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "29b4156b41b4280e4e465882f5373b68557a59e19918b8aad220b0710f3eb50f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.15.0/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "70b85768e813edf95e44cf38749f7894f3d0da4168f1c08726e774b5ccb081f7"
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
