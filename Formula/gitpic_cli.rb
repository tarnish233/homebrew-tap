class GitpicCli < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.14.0/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "1b15a69598adc2a0751b51b8671a08c11a408a7562794d2e29b1a3cc1cc7d320"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.14.0/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "44392962c638222f3ada64573026208af5c8e19a535f1ec4a9225d1b07e47573"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.14.0/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1e1372b06d25cdf3138e3f424a1b485b1b733c96f7e2100c8b85d28814632946"
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
