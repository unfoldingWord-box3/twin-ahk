# twin-ahk
Auto Hot Key script POC to manage windows on a screen

## POC Rationale
I was asked to develop a Proof-of-Concept (POC) for controlling multiple apps in a single visual context 

The requirements were expressed as:
  2 apps occupying a screen tiled in a specific fashion
  Simple controls to start and stop the apps
  No interaction between apps is required
  The initial apps were Render an installed app and Bible Well which is a Progressive Web App (PWA)
  MS Windows only environment as Render is windows only
  Complete POC in 2 weeks
  
My initial thinking was to place multiple apps into browser iframes to manage their relative positions.
I have had substantial success using iframes on previous projects.

I constructed web searches like
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

  3. Asynchronous Pluggable Prodocol (URI Scheme) to connect to Windows app 
       After research, this seemed too complicated to be portable. Uses magic registry entries
  1. Remote Desktop to connect to Windows app 
       Researched this till I found that I have little control over remote desktop window.
  6. spawn apps service to connect to Windows app - spawnapps2.wordpress.com
       Reviews indicated that this service is difficult to configure
  5. 0data.fr service to connect to Windows app - at 0data.fr 20 euros/mo 
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

I stumbled onto AutoHotKey (AHK). This is an old product but is used to control apps in a way similar to selenium or jest.
It has deep contol of starting, controlling, stopping and positioning windows with a javascript like scripting language. 
with traditional hotkeys (window control) and hotstrings (string replacement).

AHK scripts can be compiled and dropped on a desktop as a single icon to enable hotkeys to control a collection of apps
The current POC uses 3 keys to start, cycle and stop 3 different apps.

The project was a success in an elapsed time of 2 weeks.

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
This script uses the 32bit autohotkey version 2. It is incompatible with any pre 2.0 versions
