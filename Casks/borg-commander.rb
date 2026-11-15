cask "borg-commander" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "apple-darwin", linux: "unknown-linux-musl"

  version "0.11.1"
  sha256 arm:          "17bf4aa715658b676ffafba4cb323485c3cc4c2e1b8ea75667126fb528493918",
         intel:        "190bbe9f66fb04f36e60f876de829bb377bef21944727f89c2abfdeaa716f6b3",
         arm64_linux:  "a8fb7b6c5bbe9eed4dacc2cb189d39d459cd76d592bcc15986599ce047a34b86",
         x86_64_linux: "0888f2ae35ed334088a1c9d2b5efe750a1bc561f43d19365e7a00bd12e58fe86"

  url "https://github.com/0xcd21h/borg-commander/releases/download/v#{version}/borg-#{version}-#{arch}-#{os}.tar.gz"
  name "Borg Commander"
  desc "Two-panel terminal file commander with a real shell behind it"
  homepage "https://github.com/0xcd21h/borg-commander"

  binary "borg-#{version}-#{arch}-#{os}/borg"
  binary "borg-#{version}-#{arch}-#{os}/borg", target: "borgcmd"
  artifact "borg-#{version}-#{arch}-#{os}/fonts",
           target: "#{HOMEBREW_PREFIX}/share/borg-commander/fonts"
  artifact "borg-#{version}-#{arch}-#{os}/SYNTAX-LICENSES.md",
           target: "#{HOMEBREW_PREFIX}/share/borg-commander/SYNTAX-LICENSES.md"

  postflight do
    if OS.mac?
      system_command "/usr/bin/xattr",
                     args: ["-d", "com.apple.quarantine", "#{staged_path}/borg-#{version}-#{arch}-#{os}/borg"]
    end
  end

  caveats <<~EOS
    Borg Commander runs as `borg` and as `borgcmd`. BorgBackup also installs a `borg`
    command, and where it is installed, Homebrew keeps `borg` for BorgBackup.
  EOS
end
