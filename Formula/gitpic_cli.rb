class GitpicCli < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.20.5/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "6428ca4717385f2f5c92c8319884c0dc09619bed02912dd5cf710efd23ccb099"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.20.5/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "4f176778aa46fa227c8dca90b659efdc60f7dcca4cb7881b1c763e9fc5f51981"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.20.5/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d1296a6f591e7039a4cfc5b8c265a571e80bd67a1f6eaa0e50ef3a49d380e199"
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
