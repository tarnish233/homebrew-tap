class Gitpic < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic-cli"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.11.1/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "fe6734f8debe659683b4675bf8a367ff11d9b9695ffaca6039a2fb81c3160668"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.11.1/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "e6fa24a20fc7fa985c6b0634c45f89987b0f32928cbbb4b512c44ad9011a5acd"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.11.1/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "62c626a357c74c8d30abb7d7fb44fa127dbf936934e3eae23e7ebc6ba4fd5472"
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
