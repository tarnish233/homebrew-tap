class Gitpic < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic-cli"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.4.0/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "c18da195f2d34367b41b1d8bf898272c3a035f4cc45dc6b4faf27e9a29b9dc03"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.4.0/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "55ce08b64f992a6766058818246bd11a5c46d9ae27a17cba975dac88017240d8"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.4.0/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "e869deeca86c18223da4174cf7b69f85dbd17e777957aa365904d235c60496a5"
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
