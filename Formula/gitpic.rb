class Gitpic < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic-cli"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.11.0/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "ad377f90b262aa7af849d2df80c909b1e2a359bb59d7d4343f89ed6074531245"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.11.0/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "0c7e9b7656f05b2055227f61c372c4e1636f3ab2568a103c7381452143e4d189"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.11.0/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "2fca12ebff5123ba403d66f77e25c6e8cd182d658af94361f04b7a35f35694d3"
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
