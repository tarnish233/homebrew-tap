class Gitpic < Formula
  desc "Upload local/clipboard images to a GitHub repo (image host) and get a Markdown link"
  homepage "https://github.com/tarnish233/gitpic-cli"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.1.0/gitpic-aarch64-apple-darwin.tar.gz"
      sha256 "f4e7a89e21b2502628a68cff448001ac160d5a75d1731fa749a8be1e690a8b2e"
    end
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.1.0/gitpic-x86_64-apple-darwin.tar.gz"
      sha256 "a4033895b6f745d61eb8d664db60d96fea9152f83825d214e313139f9566ad2d"
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/tarnish233/gitpic-cli/releases/download/v0.1.0/gitpic-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "c218c54b930eaa5fc77fbf6ae984dd6c46beea88220a1beec3771e5434e31535"
    end
  end

  def install
    bin.install "gitpic"
  end

  test do
    assert_match "gitpic", shell_output("#{bin}/gitpic --version")
  end
end
