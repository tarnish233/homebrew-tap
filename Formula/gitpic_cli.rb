class GitpicCli < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.17.0/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "259089127b845dbe06178d2c006ef37aabefe3149609ce2c596b8980a7a5dbb7"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.17.0/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "94f5d5304dce29c39ab49170251ad2acd7fda72ce738e170f6a4aabac8abbd25"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.17.0/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "aca9814cda326ed89fc6f8e5f25b96830435dcfe1e851483a93a21086e024a75"
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
