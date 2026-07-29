class Gitpic < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic-cli"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.1.5/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "00ef4c7082b2985863f165f00d55457deb9d70aee9b5532c5ab05f826e05d3fe"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.1.5/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "0dc3dce7576558521a69d2e1119abb1527cca66799be41d212a40094962c0c43"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.1.5/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4ec20abb61e5b9f1f292af131e2fd360818b1845ebbbdb0448a8d6a15035041e"
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
