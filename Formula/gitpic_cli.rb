class GitpicCli < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic-cli"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.11.2/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "daa83fd4b4f6eed42124240f95a9beffb7594dddf1c355de673b19b42cc79b23"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.11.2/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "3888a4e62e49be6ea5dd4bfac685f837fb637f2fbc61d43e5a108c99d2143ef2"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.11.2/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "493c276686c4ae77264f539212da3f2cd6e3177646dfeae74aab636d053e08f8"
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
