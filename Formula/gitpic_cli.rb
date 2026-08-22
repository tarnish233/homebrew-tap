class GitpicCli < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.13.2/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "733df71a456135c3d98a26f3c5a09186a25793dfc579f490ed63ea827f948719"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.13.2/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "620d7be7d283aa7bdef617d78e4566355bc13b25ce8e75528fd6dbe6c412348c"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.13.2/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "b5133840fc3bd37e2e089cadba9271ca0b02478eeef2a0d31d49890e1e0e0e9d"
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
