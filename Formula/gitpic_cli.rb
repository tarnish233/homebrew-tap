class GitpicCli < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.11.5/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "f1439689549cadc51b41a21e72a0f8340720182f614409703f3c82e15859d408"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.11.5/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "c1f0792dbe99d9bed415a9ad33c0f7b8641010b5751c773b3456fdddbce2b6cd"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.11.5/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "11c9c0f804383946a539b65da88e2c277abc0f5ef2216fce63c5e106b3e956ac"
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
