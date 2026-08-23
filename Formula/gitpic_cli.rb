class GitpicCli < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.16.0/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "bfffa67082d3d86f8120bb15264f737ff033691cbd5af49a1f839d6ac1310235"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.16.0/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "c07928ead9319a8b893b4f817c63e1678e56cac99ae1f81e10957f8672fa8260"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.16.0/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "80f96bdaf608c3bb9cb63e66723075c828f3efe03daa27fd06097d082d3344ea"
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
