class GitpicCli < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.20.11/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "007c3d0cb92e8ce2b52be37bf9508d5174a62e91e5bf06c1197eeff663bc7192"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.20.11/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "8837a87d656684969783198628f1a48a71ce934f741bebe220710ff05570b368"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.20.11/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "57a236b1853570ad4a8249a180c090e0fc3f00b5004f4f8217bfd509479c4965"
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
