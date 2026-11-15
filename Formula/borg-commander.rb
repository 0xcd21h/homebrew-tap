class BorgCommander < Formula
  desc "Two-panel terminal file commander with a real shell behind it"
  homepage "https://github.com/0xcd21h/borg-commander"
  version "0.11.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/0xcd21h/borg-commander/releases/download/v0.11.1/borg-0.11.1-aarch64-apple-darwin.tar.gz"
      sha256 "17bf4aa715658b676ffafba4cb323485c3cc4c2e1b8ea75667126fb528493918"
    end
    on_intel do
      url "https://github.com/0xcd21h/borg-commander/releases/download/v0.11.1/borg-0.11.1-x86_64-apple-darwin.tar.gz"
      sha256 "190bbe9f66fb04f36e60f876de829bb377bef21944727f89c2abfdeaa716f6b3"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/0xcd21h/borg-commander/releases/download/v0.11.1/borg-0.11.1-aarch64-unknown-linux-musl.tar.gz"
      sha256 "a8fb7b6c5bbe9eed4dacc2cb189d39d459cd76d592bcc15986599ce047a34b86"
    end
    on_intel do
      url "https://github.com/0xcd21h/borg-commander/releases/download/v0.11.1/borg-0.11.1-x86_64-unknown-linux-musl.tar.gz"
      sha256 "0888f2ae35ed334088a1c9d2b5efe750a1bc561f43d19365e7a00bd12e58fe86"
    end
  end

  def install
    bin.install "borg" => "borgcmd"
    bin.install_symlink "borgcmd" => "borg" unless borgbackup_installed?
    (share/"borg-commander").install "fonts" if File.directory?("fonts")
    (share/"borg-commander").install "SYNTAX-LICENSES.md" if File.file?("SYNTAX-LICENSES.md")
  end

  def borgbackup_installed?
    (HOMEBREW_CELLAR/"borgbackup").directory?
  end

  def caveats
    <<~EOS
      Borg Commander runs as `borg` and as `borgcmd`. BorgBackup also installs a `borg`
      command, so where BorgBackup is installed, Borg Commander runs only as `borgcmd`.
      If you install BorgBackup later, run `brew reinstall borg-commander` first and then
      `brew link borgbackup`.
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/borgcmd --version")
  end
end
