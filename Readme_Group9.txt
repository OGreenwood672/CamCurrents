# How to run the app:

Before attempting to run the app, you must first ensure you have these installed and enabled in your preferred source code editor:
- Dart Extension for your code editor
- Flutter (https://flutter.dev/)
    -> Please refer to their documentation for further details about installation and setup for your preferred devices.
- Flutter Extension for your code editor

We suggest using Visual Studio Code as your source code editor.

## Android Emulator:
Please refer to this documentation under "Configure your target Android device" -> "Virtual Device":
https://docs.flutter.dev/get-started/install/windows/mobile?tab=vscode

## Android Devices:
1. Make sure you have enabled Developer options on your device.
    -> This is done by finding "Build number" in the Settings app under "About Phone" (-> "Software Information") and clicking on it 7 times.
    -> A "Developer options" setting should now appear under "About Phone".
2. Make sure you also have "USB Debugging" enabled in the "Developer Options" section.
3. Open this project in a code editor on a laptop/PC.
4. Plug in your phone into the computer with a USB cable.
    -> A popup will appear on your phone asking if you want to allow USB debugging. Click "yes".
5. Refer to https://docs.flutter.dev/get-started/test-drive to run the application.

## Apple (iOS) Devices (requires Apple ID or sign up for a "Developer Account"):
1. Make sure XCode has been set up on your device.
    -> Further details about how to do so here: https://help.apple.com/xcode/mac/current/#/dev60b6fbbc7
2. Open XCode, then open "Preferences > Accounts". Sign in with your Apple ID or Developer ID.
3. "Manage Certificates" > click on the "+" sign and select "iOS Development".
4. Plug your device into your machine. Find your device in the drop down (Window > Organizer).
5. Below the Team pop-up menu, click Fix Issue.
6. In XCode, click the Run button.


# Libraries:
- 'flutter/material.dart'
- 'async'
- 'convert'
- 'http/http.dart'
- 'intl/intl.dart'