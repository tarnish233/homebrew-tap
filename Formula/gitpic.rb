class Gitpic < Formula
  desc "Upload local/clipboard images to a GitHub repo (image host) and get a Markdown link"
  homepage "https://github.com/tarnish233/gitpic-cli"
  version "0.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.1.1/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "6af7d91a55ab508db8b25ea8fdce03ea6dc38700f71dbfffc1212fd960f57ea7"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.1.1/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "ba73ca591190058fad7d9bc30ff7e69c1b3b371753ff2af5d72b9994b295cfc4"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.1.1/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "31990c40b893bd2217be21b870e84d383f2a9ac17af4aa772d045424301c0e9b"
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
