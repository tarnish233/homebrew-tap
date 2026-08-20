class Gitpic < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic-cli"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.6.0/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "0d637dbfbab23511e8c6826d1bd19135f94e3e7556c13498d80af0b56227ad89"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.6.0/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "31e6af5041cc3360b5c2d7c00c6dd4aa090f7065f5850944ff8963005edf2c58"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.6.0/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a7fd9c36fb30a11266c2642e008e4b6ecdac57525999c9e691198bee0cff1b45"
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
