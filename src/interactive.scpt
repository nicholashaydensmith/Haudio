#!/bin/sh 
osascript <<END 
tell application "Terminal"
    do script "ghci"
end tell
END
