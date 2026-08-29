class GitpicCli < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.20.10/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "79c9b5a228db821f47fc15f109bbc38ebc3d664e4e3ab8fed7de27f847c7d35a"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.20.10/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "ac37cc9175db906e0a3275e7e6585b5d82603034fecf89d6f2f2d3f94406cc1c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.20.10/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "48e0e5aa94cc98404c064fd4e0637e21ea77b92a382996e517ad692d1959a9fb"
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
