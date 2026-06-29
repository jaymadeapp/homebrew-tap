class ClaudePresence < Formula
  desc "macOS daemon aggregating live Claude Code activity into one Discord Rich Presence"
  homepage "https://github.com/jaymadeapp/claude-presence"
  version "0.1.4"
  license "MIT"

  depends_on :macos

  on_arm do
    url "https://github.com/jaymadeapp/claude-presence/releases/download/v0.1.4/claude-presence-aarch64-apple-darwin.tar.gz"
    sha256 "88fbc02e81b2efca61af5593e4ab7f53b02ba6e08612cfea6f334401e7a581c0"
  end

  on_intel do
    url "https://github.com/jaymadeapp/claude-presence/releases/download/v0.1.4/claude-presence-x86_64-apple-darwin.tar.gz"
    sha256 "135d991afd40fc7c3fe5d84814372dbaffde5c6bc52a286bc3eea7cc4a430ad4"
  end

  def install
    bin.install "claude-presence"
  end

  def caveats
    <<~EOS
      claude-presence is a CLI plus a headless launchd agent. Homebrew installs only
      the binary — finish setup once by wiring the launchd agent, the statusLine
      wrapper and the Claude Code hooks:

        claude-presence install

      The installer asks whether to hide your project and the running command.

      Turn the presence off / on without uninstalling:

        claude-presence disable   # alias: off  (clears the Discord card; survives reboot)
        claude-presence enable    # alias: on

      To remove everything, UNWIRE FIRST, then uninstall the binary (brew cannot boot
      out launchd or unchain your hooks):

        claude-presence uninstall
        brew uninstall claude-presence

      Requires the Discord desktop app to be running. Diagnose with:

        claude-presence doctor
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/claude-presence --version")
  end
end
