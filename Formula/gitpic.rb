class Gitpic < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic-cli"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.2.3/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "b6e31d228d6268db9a536960a346871163ba960c454d21bca156e3e4937822f5"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.2.3/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "9db63f9a78789a3f7d01411eb3f46387c3140a78eaf7b2bb63a2bd7cb3011bed"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.2.3/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2fffb4efb145b7517305771991686be56c458b717e11f7e9f204dbb0fadbd9fe"
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
