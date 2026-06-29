class ClaudePresence < Formula
  desc "macOS daemon aggregating live Claude Code activity into one Discord Rich Presence"
  homepage "https://github.com/jaymadeapp/claude-presence"
  version "0.1.5"
  license "MIT"

  depends_on :macos

  on_arm do
    url "https://github.com/jaymadeapp/claude-presence/releases/download/v0.1.5/claude-presence-aarch64-apple-darwin.tar.gz"
    sha256 "f93ddb297b7b411038bf16dae6e26d27373179870fa99daddeb2cb481ef6fda4"
  end

  on_intel do
    url "https://github.com/jaymadeapp/claude-presence/releases/download/v0.1.5/claude-presence-x86_64-apple-darwin.tar.gz"
    sha256 "39bbae18bbc477c6a531de53e39527499a2582b9378fe9f25d8954078eccae93"
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
