cask "lobehub@canary" do
  version "2.3.5-canary.2"
  sha256 "8adeb53e82d1ff7e670c5032d3221562f2d9229f2d1214c41fee30fcbb78e7cc"

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
