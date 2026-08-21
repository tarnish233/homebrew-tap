class Gitpic < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic-cli"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.10.0/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "1372940348769e57623688ce5424ea391058d8ac22eb486aa30207d9969f26b8"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.10.0/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "58a5eca7e15aa06f82a98e44bd29248387bfc096bbc7b7bd8044b81d1124261c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.10.0/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3112d25fcfb89edad40d29b327a02fbf85719df7800d9d9d661cec5f25dc1d97"
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
