class GitpicCli < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.20.2/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "eccb205f9398f3665ea85d3332a0fce20d1e17e118b487aff9fd63242d64a484"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.20.2/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "b77426b37846ed788d0e3251e00610ed9e1e56ed68dc11fd529c03a1b9da5db3"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.20.2/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "023d8bfcbec07393226bfe708b8b475b43ea12c0a0155b092947b3157627296c"
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
