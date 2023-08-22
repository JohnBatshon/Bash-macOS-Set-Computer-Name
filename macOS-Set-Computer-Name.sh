#!/bin/sh

# Utilizes osascript command to display a dialog box to the user throthrough the SystemUIServer application.
# The dialog asks the user to enter their Asset Tag Number and then click "Submit."
computerName=$(osascript -e 'tell application "SystemUIServer"
set myComputerName to text returned of (display dialog "Please enter your Company Asset Tag Number and then click Submit.

Example:

If your asset tag was FA123456 then you would enter FA123456" default answer "" with title "Computer Name" buttons {"Submit"} with icon caution)
end tell')

# The provided script uses the macOS command-line tool scutil to set the Computer Name, Local Host Name, and Host Name of the system to a value stored in the ${computerName} variable.
# This effectively changes the identification and networking names of the computer to the specified value.

/usr/sbin/scutil --set ComputerName "${computerName}"
/usr/sbin/scutil --set LocalHostName "${computerName}"
/usr/sbin/scutil --set HostName "${computerName}"

# The bash script clears the system's DNS cache using the command dscacheutil -flushcache.

dscacheutil -flushcache

# Displays a message indicating that the computer name has been set and then retrieves and echoes the current computer name using the scutil --get ComputerName command.

echo "Computer name has been set..."
echo "<result>`scutil --get ComputerName`</result>"

# The bash script exits with a status code of 0, indicating successful completion without errors.

exit 0