class Gitpic < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic-cli"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.5.0/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "e0c48e53d32a52bd8b72ec42776129af44cf47286806e1eb87d10482f835d798"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.5.0/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "2ff0aeace90738ddb4416c40716f724467e8a9fe5a754956451d08e13a961fc3"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.5.0/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9ccb81d4ecb3260bf1205478c65cb254671b5d4892d550f96ec783ae5ed9af94"
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
