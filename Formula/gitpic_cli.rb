class GitpicCli < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.20.1/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "1b45fc1e1b48db95d3d4854ff3ed0dd748c83050ff5de2218c11bfd47b111e3e"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.20.1/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "6a5ea6c6f978f16d950a37caf445c3503a99c3fd6b03bebb47759bb698e657fe"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.20.1/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d059d99264ba3a540e1e97c02548b5b7adcdfc949c61716f95d09978362380c9"
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
