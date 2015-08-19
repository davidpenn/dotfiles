
add_app() {
defaults write com.apple.dock persistent-apps -array-add "
<dict>
  <key>tile-data</key>
  <dict>
    <key>file-data</key>
    <dict>
      <key>_CFURLString</key>
      <string>${1}</string>
      <key>_CFURLStringType</key>
      <integer>0</integer>
    </dict>
  </dict>
</dict>"
}

defaults write com.apple.dock persistent-apps -array

add_app "/Applications/iTerm.app"
add_app "/Applications/Google Chrome.app"
add_app "/Applications/Slack.app"
add_app "/Applications/Contacts.app"
add_app "/Applications/Notes.app"
add_app "/Applications/Reminders.app"
add_app "/Applications/Todoist.app"
add_app "/Applications/Maps.app"
add_app "/Applications/Tower.app"
add_app "/Applications/Atom.app"
add_app "/Applications/Sublime Text.app"
add_app "/Applications/Sequel Pro.app"
add_app "/Applications/Photos.app"
add_app "/Applications/Messages.app"
add_app "/Applications/iTunes.app"
add_app "/Applications/Spotify.app"
add_app "/Applications/App Store.app"
add_app "/Applications/System Preferences.app"

killall Dock
