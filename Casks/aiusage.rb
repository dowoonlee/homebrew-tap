cask "aiusage" do
  version "0.1.4"
  sha256 "9d88887be1d3b835204f14c5fae3eaab0a8e1f171ae40fcd126c8e9f8f5a11d3"

  url "https://github.com/dowoonlee/ai-service-usage/releases/download/v#{version}/AIUsage.zip"
  name "AI Usage"
  desc "macOS floating widget for Claude and Cursor usage"
  homepage "https://github.com/dowoonlee/ai-service-usage"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"

  app "AIUsage.app"

  # ad-hoc 서명 앱: quarantine 비트 제거해서 첫 실행 시 Gatekeeper 차단을 우회
  postflight do
    system_command "/usr/bin/xattr",
                   args:         ["-dr", "com.apple.quarantine", "#{appdir}/AIUsage.app"],
                   sudo:         false,
                   must_succeed: false
  end

  zap trash: [
    "~/Library/Application Support/ClaudeUsage",
    "~/Library/Preferences/com.dwlee.AIUsage.plist",
  ]
end
