cask "lobehub" do
  arch arm: "arm64", intel: "x64"

  version "0.0.0"
  sha256 arm:   "0000000000000000000000000000000000000000000000000000000000000000",
         intel: "0000000000000000000000000000000000000000000000000000000000000000"

  url "https://github.com/lobehub/lobehub/releases/download/v#{version}/LobeHub-#{version}-#{arch}.dmg",
      verified: "github.com/lobehub/lobehub/"
  name "LobeHub"
  desc "AI chat client supporting multiple model providers"
  homepage "https://lobehub.com/"

  livecheck do
    url "https://github.com/lobehub/lobehub/releases.atom"
    strategy :github_latest
  end

  auto_updates true
  app "LobeHub.app"

  zap trash: [
    "~/Library/Application Support/LobeHub",
    "~/Library/Preferences/com.lobehub.lobehub-desktop.plist",
    "~/Library/Saved Application State/com.lobehub.lobehub-desktop.savedState",
    "~/Library/Logs/LobeHub",
    "~/Library/Caches/com.lobehub.lobehub-desktop",
  ]
end
