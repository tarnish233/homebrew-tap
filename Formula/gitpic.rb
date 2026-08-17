class Gitpic < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic-cli"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.2.1/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "48f5b76203ec172135366f2bab49d5575a85b971a1680c0d52d4432159331a1e"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.2.1/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "f3487cd402b2ab21476e16591c869ee3b72299f43a6643399670d1a47aabc363"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.2.1/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ff78d5dea7f80150b382138b081d3a4ce5469b89cf3f00395e93845bde5e8ba9"
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
