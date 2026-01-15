cask "high-vibes" do
  version "0.1.0"
  sha256 "ea7f39cfec41431aad1be4abb55dc56e9ee752b77d138f3dae420404aad498b6"

  # Releases hosted in separate public repo (main repo is private)
  url "https://github.com/LightBytes/high-vibes-releases/releases/download/v#{version}/HighVibes-#{version}.dmg"
  name "High Vibes"
  desc "Desktop orchestration service for AI agents"
  homepage "https://github.com/LightBytes/homebrew-high-vibes"

  livecheck do
    url "https://github.com/LightBytes/high-vibes-releases/releases/latest"
    strategy :github_latest
  end

  app "High Vibes.app"

  zap trash: [
    "~/Library/Application Support/high-vibes",
    "~/.high-vibes",
  ]
end
