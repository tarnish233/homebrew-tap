class Gitpic < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic-cli"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.5.1/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "5cc4dbb78e3c77b91e4510cde70caf6ce6cdecf3e87f05e1773074c57ded0d07"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.5.1/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "521343bbd99bf4fa102409fa14509d0e109818c0676dd75db6d6c5198a066c19"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.5.1/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "eb4213279d6fbfa86124f77d5eead21e30d2fc7eb7841e109f6032347b0db519"
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
