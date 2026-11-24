cask "lobehub" do
  arch arm: "arm64", intel: "x64"

  version "2.3.5"
  sha256 arm:   "021ecc6a192b245d67eb5cabfbc1f6890637c81bf432e9e9ef4d5ead06c8120e",
         intel: "be624a41b051a527891ebc070d7e26c79719c866bd516208d6683acb2bdb76cb"

  url "https://github.com/lobehub/lobehub/releases/download/v#{version}/LobeHub-#{version}-#{arch}.dmg"
  name "LobeHub"
  desc "Desktop client for LobeHub super-agents"
  homepage "https://lobehub.com/"

  livecheck do
    url "https://github.com/lobehub/lobehub/releases/latest"
    strategy :github_latest
  end

  auto_updates true
  conflicts_with cask: "lobehub@canary"
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
