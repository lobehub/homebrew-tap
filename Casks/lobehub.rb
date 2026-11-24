cask "lobehub" do
  arch arm: "arm64", intel: "x64"

  version "2.3.6"
  sha256 arm:   "79dab4f31d17ecf3a380369792c6d41ab72fafc7e5caa572e38ebb8906ef4e94",
         intel: "3281d8916f02b77adf540d62be539ad6cc3ee7472f937186dd1e3dde640f23b3"

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
