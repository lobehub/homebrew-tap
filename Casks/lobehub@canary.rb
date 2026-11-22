cask "lobehub@canary" do
  version "2.3.5-canary.3"
  sha256 "6710a787fdb68de31d719fcd8f8ccf60ff2477456b8f4ddb0b19748f8e1a1ea2"

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
