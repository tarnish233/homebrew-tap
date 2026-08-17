class Gitpic < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic-cli"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.2.2/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "7d1063671588d3f7ba3a4400216f70e67bfedc517ec8e35b36642967f7b27413"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.2.2/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "1d65e518d8d6d5bcafcbcee6c2894161bf27f2036e091ce575b68b1a909d9030"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.2.2/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "3aec4d18e123d46229c17b08e4fd50aeb28c2ce3d37ac3b19e247073fc015e25"
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
