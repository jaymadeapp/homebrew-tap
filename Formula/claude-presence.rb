class ClaudePresence < Formula
  desc "macOS daemon aggregating live Claude Code activity into one Discord Rich Presence"
  homepage "https://github.com/jaymadeapp/claude-presence"
  version "0.1.1"
  license "MIT"

  depends_on :macos

  on_arm do
    url "https://github.com/jaymadeapp/claude-presence/releases/download/v0.1.1/claude-presence-aarch64-apple-darwin.tar.gz"
    sha256 "e840e89dbcf3f1d91aff46d261c55e6aa333e5a5cfa87f5c7de35842430cf4fb"
  end

  on_intel do
    url "https://github.com/jaymadeapp/claude-presence/releases/download/v0.1.1/claude-presence-x86_64-apple-darwin.tar.gz"
    sha256 "e258d64a3ff47172342bf031981f493efbcd30a94beb95db10e33fe4d7c7cc12"
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
