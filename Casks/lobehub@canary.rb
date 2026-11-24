cask "lobehub@canary" do
  version "2.3.6-canary.1"
  sha256 "3ccd7fc7c38bce47548bd8ecc1f67ef51f67b934c65b8a89220dac404c1c64bf"

  url "https://github.com/lobehub/lobehub/releases/download/v#{version}/LobeHub-#{version}-arm64.dmg"
  name "LobeHub Canary"
  desc "Desktop client for LobeHub super-agents (canary channel)"
  homepage "https://lobehub.com/"

  livecheck do
    skip "Canary releases are prereleases and are bumped from the GitHub releases API"
  end

  auto_updates true
  conflicts_with cask: "lobehub"
  depends_on arch: :arm64
  depends_on macos: :ventura

  app "LobeHub.app"

  zap trash: [
    "~/Library/Application Support/com.lobehub.lobehub-desktop",
    "~/Library/Application Support/LobeHub",
    "~/Library/Caches/com.lobehub.lobehub-desktop",
    "~/Library/Caches/LobeHub",
    "~/Library/HTTPStorages/com.lobehub.lobehub-desktop",
    "~/Library/HTTPStorages/com.lobehub.lobehub-desktop.binarycookies",
    "~/Library/Logs/LobeHub",
    "~/Library/Preferences/com.lobehub.lobehub-desktop.plist",
    "~/Library/Saved Application State/com.lobehub.lobehub-desktop.savedState",
    "~/Library/WebKit/com.lobehub.lobehub-desktop",
  ]
end
