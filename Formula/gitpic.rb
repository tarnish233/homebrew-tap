class Gitpic < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic-cli"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.7.0/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "371a03fcc720c3476ac11de5b80fc9090a0a8629cd508b5b39d0ad5823a49bfd"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.7.0/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "12aaa3c4713bd8ecba9239690e1e121b11dff3e7592d67d7bf482c116f9482e3"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.7.0/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a356259c970ee3a45edac3a09fb9ddf9d419c7a6886a872d1e424127e42c4098"
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
