class ClaudePresence < Formula
  desc "macOS daemon aggregating live Claude Code activity into one Discord Rich Presence"
  homepage "https://github.com/jaymadeapp/claude-presence"
  version "0.1.3"
  license "MIT"

  depends_on :macos

  on_arm do
    url "https://github.com/jaymadeapp/claude-presence/releases/download/v0.1.3/claude-presence-aarch64-apple-darwin.tar.gz"
    sha256 "5e82139f23884ffa3583ea216bf5e122427ffd73ed447541873dc12661efb9fd"
  end

  on_intel do
    url "https://github.com/jaymadeapp/claude-presence/releases/download/v0.1.3/claude-presence-x86_64-apple-darwin.tar.gz"
    sha256 "48d851b46eef4ae7e01df1f5bfb196089ea73f1e2e1b9dff055316278fe9a634"
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
