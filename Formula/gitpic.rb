class Gitpic < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic-cli"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.1.8/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "0a2ce5a9e70151106c944e6fd0bfdc8a280f3e717e05aa63484920916dfa832a"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.1.8/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "18ea19f574c61a5291813f7eb2d7a41f9397fbe95ab6f6b374ea5f6faf2f8fd1"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.1.8/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "627b25b44db2042b0ce1965b5ee6168d40bac0e61315432839ef8eb5aa84c402"
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
