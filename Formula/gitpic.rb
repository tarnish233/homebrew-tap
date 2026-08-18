class Gitpic < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic-cli"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.3.0/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "2833117f8a5a0f5396f0a941eaaad00bf92d27f985fca719a9edf2d6a0edd666"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.3.0/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "1025f4b3a4023aa60927ed630c006f0016a905e95119d2f639f8d57baca4c45b"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.3.0/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fbd49067736489fd0217c3f751496395ea8df53ba2932aa4d721a063ccf8c08d"
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
