class LobehubCli < Formula
  desc "CLI for LobeHub agents, workspace data and topics"
  homepage "https://github.com/lobehub/lobehub"
  url "https://registry.npmjs.org/@lobehub/cli/-/cli-0.0.222.tgz"
  sha256 "f9b6863929cf73b25e6f7d39a237bb5288f6ce8d38f50bd4cb28f11df41ec62b"
  license "MIT"

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")

    man1.install Dir["#{libexec}/lib/node_modules/@lobehub/cli/man/man1/*.1"]
  end

  test do
    # `lh --version` may print a banner; just make sure the binary runs.
    assert_match "lh", shell_output("#{bin}/lh --help 2>&1")
  end
end
