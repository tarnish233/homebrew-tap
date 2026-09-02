class GitpicCli < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.20.12/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "e5912e5a5425a6c1c3e86e5d8901eb5a45300e1b997b2d86b305e68938d7fc32"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.20.12/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "2b6c93a58c12686fdea9d6d79897f2dcdb55131dece6b4780a9e4e101a22d5c2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.20.12/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "caf2d0821b97a9549c535915b716e165582dcf280c1c18ef61bddd1c735ba2b7"
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
