class LobehubCli < Formula
  desc "CLI for LobeHub agents, workspace data and topics"
  homepage "https://github.com/lobehub/lobehub"
  url "https://registry.npmjs.org/@lobehub/cli/-/cli-0.0.136.tgz"
  sha256 "ea25afcd755d56bce4495f24a85776643b119f4fec2bbb88cbad6642b7d5ea08"
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
