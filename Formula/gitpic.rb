class Gitpic < Formula
  desc "Upload local/clipboard images to a GitHub repo (image host) and get a Markdown link"
  homepage "https://github.com/tarnish233/gitpic-cli"
  version "0.1.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.1.2/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "7a300ec1008cc17ec210daa1f68af25fa1f33684ac78ee4e2c2ac940695c50c0"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.1.2/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "45e44488d517819ddadc255062c85228dc311b6c4e8f0752676f2067f5935e23"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.1.2/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "82dae8f3ea6b93db1bb5d85a063995acbf05361a366802499ec40421de0bfefc"
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
