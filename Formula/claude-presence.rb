class ClaudePresence < Formula
  desc "macOS daemon aggregating live Claude Code activity into one Discord Rich Presence"
  homepage "https://github.com/jaymadeapp/claude-presence"
  version "0.1.2"
  license "MIT"

  depends_on :macos

  on_arm do
    url "https://github.com/jaymadeapp/claude-presence/releases/download/v0.1.2/claude-presence-aarch64-apple-darwin.tar.gz"
    sha256 "9c1096955fd1f81852d38eb509a6260e2e0f276e5a09bc1ec46491d947359652"
  end

  on_intel do
    url "https://github.com/jaymadeapp/claude-presence/releases/download/v0.1.2/claude-presence-x86_64-apple-darwin.tar.gz"
    sha256 "b700ae1908a1f1702f8a9e985a8669bc03ee0e6bf498f5daf5bb86952d2c9fc2"
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
