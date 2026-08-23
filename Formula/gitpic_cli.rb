class GitpicCli < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.14.1/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "3a8c85993f8e82babc4bdbfce256f4738cfa64699db083ccbe51a7192f33ed8e"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.14.1/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "34f5a202145eb328d95114caf909e540d865bcaf91b6ed0e7e09c33415ed8994"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.14.1/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "040e4cd4397b5fe91f2f29be8a82f3b8b1a4aa280ca1d5d4b719bab174702fb2"
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
