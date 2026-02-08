cask "brainfm-presence" do
  version :latest
  sha256 :no_check

  url "https://github.com/xdkid1337/brainfm-presence/releases/latest/download/Brain.fm-Presence.dmg"
  name "Brain.fm Presence"
  desc "Discord Rich Presence for Brain.fm — shows your focus session in Discord"
  homepage "https://github.com/xdkid1337/brainfm-presence"

  depends_on macos: ">= :monterey"

  app "Brain.fm Presence.app"

  zap trash: [
    "~/Library/Caches/com.brainfm.presence",
    "~/Library/Preferences/com.brainfm.presence.plist",
  ]

  caveats <<~EOS
    Brain.fm Presence runs in your menu bar — there is no Dock icon or window.
    Make sure both Brain.fm Desktop and Discord are running.
  EOS
end
