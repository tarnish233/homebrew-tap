class Gitpic < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic-cli"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.1.6/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "bac538694ea9cded2b4b0f528df678f127b59b26bda057c13b7ec8e52d94a100"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.1.6/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "631515fdb67068d3ea820a548bed12d29e958e20dd0aa16893a805b4f10a872f"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.1.6/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "9e11653406c0a6762c3d56bebc60da796e846891be46ea21906501ce5fda391b"
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
