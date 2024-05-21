# twin-ahk
Auto Hot Key script POC to manage windows on a screen

## POC Rationale
I was asked to develop a Proof-of-Concept (POC) for controlling multiple apps within a single visual context 

The requirements were expressed as:
  2 apps occupying a screen tiled in a specific fashion
  Simple controls to start and stop the apps
  No interaction between apps is required
  The initial apps were Render, an installed app, and Bible Well which is a Progressive Web App (PWA)
  MS Windows only environment as Render is windows only
  Complete POC in 2 weeks
  
My initial thinking was to place multiple apps into browser iframes to manage their relative positions.
I have had substantial success using iframes on previous projects.

I constructed browser searches like
  browser control of installed app
  windows app in iframe
  
I came up with an initial list of candidate frameworks in order of discovery
  1. Remote Desktop to connect to Windows app 
  2. guacamole-apache server to connect to Windows app 
  3. Asynchronous Pluggable Protocol (URI Scheme) to connect to Windows app 
  4. Recompile app into LLVM bytecode using emscripten to run in browser
  5. 0data.fr service to connect to Windows app 
  6. spawn apps service to connect to Windows app 
  7. boxedwine to emulate windows to connect to Windows app 
  8. vscode to integrate bible well and render 
  
Since time was of the essence I ordered these according to how I would attempt to use them based on 
what I considered to be the difficulty of integration.

  3. Asynchronous Pluggable Protocol (URI Scheme) to connect to Windows app 
       After research, this seemed too complicated to be portable. Uses "magic" registry entries.
  1. Remote Desktop to connect to Windows app 
       Researched this till I found that I have little control over remote desktop window.
  6. spawn apps service to connect to Windows app - spawnapps2.wordpress.com
       Reviews indicated that this service is difficult to configure
  5. 0data.fr service to connect to Windows app - at 0data.fr 20 euros/mo
       At first this seemed like the fastest to implement candidate, however,
       This service seems to have disappeared. Could not make contact with anyone or sign up for service.
       Google maps shows their Houston office available for lease
  7. boxedwine to emulate windows to connect to Windows app 
       Could not build from source. Installable image was suited only for very old games
       Star Trek 1992 works great.
  2. guacamole-apache server to connect to Windows app 
       Open source RDP/VNC equivalent that would take too long to configure
  4. Recompile app into LLVM bytecode using emscripten to run in browser - Requires access to source. 
       Code not available
  8. vscode to integrate bible well and render
       Recent projects told me this would not be a small effort  

If managing windows in a browser is not going to work then how do I control the apps independently?

Searching for strings like 
  controlling windows applications 

I stumbled onto AutoHotKey (AHK). This is an old product but is used to control apps in a way similar to selenium.
It has deep contol of starting, controlling, stopping and positioning windows with a javascript like scripting language 
using traditional hotkeys (window control) and hotstrings (string replacement).

AHK scripts can be compiled and dropped on a desktop as a single icon to enable hotkeys to control a collection of apps
The current POC uses 3 keys to: start, cycle, and stop 3 different apps.

The 3 apps are Render, Notepad and Bible Well

## Challenges
1. Could control the installation of bible well as PWA but could not locate handle to reposition it. So this code is commented out
2. Added ugly control at top right corner of display as illustration of how one might create control interface for AHK.
3. Render will currently not respond to window control except to start and stop.
4. The script is sensitive to the installed location of Render. My installation is not portable.

## Conclusions 
1. AHK is an elegant way to manage window automation.
2. It can read and write .ini files to manage its configuration
3. An experienced AHK script writer can employ tools to simplify the access to an app's embedded controls.
4. The project was a success in an elapsed time of 2 weeks.
5. To work with Render, Render will have to be "somewhat" responsive to resize events
6. Any number of app could be controlled by extending the current POC, however, making the apps configurable would allow a great interim solution for multiple apps interesting to a workflow.

## Instalation
To install this POC, drop the Render.exe file onto desktop
## Usage
To run the script,
1. Double click on "H" icon
2. Click one of:
 - WIN-A to start the 3 referenced apps
 - WIN-S to switch among the 3 in round robbin order
 - WIN-S to stop all three
3. Alternatively there is a prototype menu at the top right hand corner of the screen to accomplish the same tasks

## Screenshot
![twin-ahk](https://github.com/unfoldingWord-box3/twin-ahk/assets/4968713/183398d1-c4d9-40e4-a8f2-fbcf16d9467f)

## Dependencies
1. This script uses the 32bit autohotkey version 2. It is incompatible with any pre 2.0 versions. Download from: https://www.autohotkey.com/download/
2. The "Render_3.7.3.0_Installer.msi" version of Render is installed from [their website ](https://install.appcenter.ms/orgs/fcbh/apps/render-live-windows/distribution_groups/render%20global%20distribution)

## Development
The Render.ahk file can be directly edited by your favorite editor but should be stored in UTF-8 with BOM format
To recompile it;
1. download release "AutoHotkey_2.0.15_setup.exe" or greater from autohotkey.com
2. Double click on it to install
3. click on its installed Icon which looks like a Green Capital H.
4. Select compile
5. Enter or select path to source .ahk file
6. Enter or select path to exe file to be produced
7. Press Convert

