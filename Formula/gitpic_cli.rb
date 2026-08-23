class GitpicCli < Formula
  desc "Upload images to a GitHub repository and print Markdown links"
  homepage "https://github.com/tarnish233/gitpic"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.18.0/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "605c49a37a38fcc55908aedd807511e81fbe1cf95d7f729797cef05930175137"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.18.0/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "d9c39d915889d2fea6996bc71a22d6f58e9a5fcdfa3b2d5b2ef3df2a4cd1b966"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic/releases/download/v0.18.0/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "5f5515295e1395b9280d7e5216bb9c2083c4387b0999e9ede37491fd120429d9"
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
