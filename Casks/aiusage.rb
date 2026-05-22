cask "aiusage" do
  version "0.8.9"
  sha256 "499e9a4352eecce2458a59ad7fac1b0faeb50bbc3339d51acd15bd9c71e36f9e"

  url "https://github.com/dowoonlee/ai-service-usage/releases/download/v#{version}/AIUsage.zip"
  name "AI Usage"
  desc "macOS floating widget for Claude and Cursor usage"
  homepage "https://github.com/dowoonlee/ai-service-usage"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :ventura"

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
