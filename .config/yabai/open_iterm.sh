if ! pgrep -f "iTerm" > /dev/null; then
    open -a "iTerm"
else
    osascript -e 'tell application "iTerm" to create window with default profile'
fi

