class Gitpic < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic-cli"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.2.0/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "cc8f18fc933ff1988ad478d57d20d13182b4708aaed234af4123189488189ed6"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.2.0/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "19924bb4976fab478d95ebd7d66d299824ec039ed0377f78afa374d97a6d008e"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.2.0/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "cbf740681481e5f71908e8b6312029d978a2bac3c8d6f1e156b69fabdd86303c"
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
