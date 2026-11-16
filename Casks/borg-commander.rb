cask "borg-commander" do
  arch arm: "aarch64", intel: "x86_64"
  os macos: "apple-darwin", linux: "unknown-linux-musl"

  version "0.12.0"
  sha256 arm:          "30b049a860b02cd301fb1e0cbb782d91d4e4aeb06877afab92ebc1bba98c4aa5",
         intel:        "8ebe536c1920013f1b1c591410ec9613f36a241bf5b03401af278d7f990c2ac7",
         arm64_linux:  "0937df1ffaf948e1eaee6087da8923ffab002de6b1ff15decee60082015a73e4",
         x86_64_linux: "8b7dead6b79a43cca74c28c08306fbb7afaf602d385c1d4adb2be30b53e0686b"

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

  postflight_steps do
    on_macos do
      run "/usr/bin/xattr",
          args:         ["-d", "com.apple.quarantine", "{{staged_path}}/borg-{{version}}-{{arch}}-apple-darwin/borg"],
          must_succeed: false
    end
  end

  caveats <<~EOS
    Borg Commander runs as `borg` and as `borgcmd`. BorgBackup also installs a `borg`
    command, and where it is installed, Homebrew keeps `borg` for BorgBackup.
  EOS
end
