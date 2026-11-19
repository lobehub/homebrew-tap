cask "lobehub" do
  arch arm: "arm64", intel: "x64"

  version "2.3.4"
  sha256 arm:   "f36e2b7c34986b49d571e3d7b44824ee71cb5978efcd1c31c80a30e0b8d965c1",
         intel: "95348b5bb452ec4ca7cd540c36bc4f8775a0abf58ea9e907e6fab767bcbfe840"

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
