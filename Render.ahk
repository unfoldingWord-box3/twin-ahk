#Requires AutoHotkey v2+

; Render.ahk is an AHK script that manages 2 or more windows applications.
; It is currently sensitive to location of render installation

; Routing table     ; support 3 main hotkeys Win-A, Win-K, and Win-S
#n::runNotepad()    ; open notepad as a test
#+n::raiseNotepad() ; raise notepad to top of stack

#r::runRender()     ; run render app
#+r::raiseRender()  ; raise render to top of stack

#w::runWell()       ; navigate to bible well
#+w::raiseWell()    ; raise bible well to top of window stack

#a::runAll()        ; do runNotepadn, runWell and runRender
#k::closeAll()      ; kill bible well and render
#s::runSwitch()     ;

; Legend #=Win, +=Shift, ^=Ctrl, !=Alt

SetTitleMatchMode 3 ; 1-begins with, 2-contains, 3-exact match
global raiseWhich := 0
global gutter := A_ScreenWidth / 4

makeGui()

return

; ------- TBD ---------- 
;  AVTT
;  installed bible well
;+ make .25 bible well
;  github repo
;
; something like the following might support arbitrary apps to me managed
; on say a 4x4 grid 
;   1.1  1.2  1.3  1.4
;   2.1  2.2  2.3  2.4
;   3.1  3.2  3.3  3.4
;   4.1  4.2  4.3  4.4
;
; workspaceAhk.ini
;   [render]
;     path=C:\Users\bruce\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Hosanna\Render.appref-ms
;     window=Render
;     size=1.4-4.4
;   [notepad]
;     path=notepad.exe
;     window=Untitled - Notepad
;     size=1.2-4.4
;   [well]
;     path=chrome.exe --kiosk https://app.well.bible --new-window
;     window=Bible Well - Google Chrome
;     size=1.2-4.4
;
;Legend path=How to start, window=how to raise, size=coordinates for shape

makeGui() { ; TBD add a button to top right corner to close all and switch
  myGui := Gui()
  myGui.Opt( "+AlwaysOnTop -Caption +Owner" )
  
  myGuiCtrl1 := myGui.addButton( "","Start" )
  myGuiCtrl1.Opt( "x0 y10 w50 h20"  )
  myGuiCtrl1.OnEvent( "Click", runAll ) 

  myGuiCtrl2 := myGui.addButton( "","Stop" )
  myGuiCtrl2.Opt( "x50 y10 w50 h20"  )
  myGuiCtrl2.OnEvent( "Click", closeAll ) 
  
  myGuiCtrl3 := myGui.addButton( "", "Switch" )
  myGuiCtrl3.Opt( "x100 y10 w50 h20" )
  myGuiCtrl3.OnEvent( "Click", runSwitch ) 
  
  myGui.Show
  myGui.Move( A_ScreenWidth * .96, 5, 60, 95 )
}

slowSend( txt ) {
  SendInput txt
  sleep 200
}

runNotepad() {
  Run "notepad.exe"
  global gutter
  
  if WinWait(     "Untitled - Notepad", , 5 ) {
    WinActivate   
    WinWaitActive 
    WinMove gutter + 22, 0, A_ScreenWidth - gutter - 22, A_ScreenHeight
  }
}

runRender() {
  Run "C:\Users\bruce\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Hosanna\Render.appref-ms"
}

runWell() {
  global gutter
  Run "chrome.exe --kiosk https://app.well.bible --new-window "

  if WinWait( "Bible Well - Google Chrome", , 10 ) {
;    slowSend "^l`t{Enter}"            ; TBD install/open PWA
;   slowSend "`t"
;   slowSend "{enter}"
;    sleep 1000
;   slowSend "`t"
;    slowSend "{Enter}"
;    sleep 1000
;    WinActivate "Bible Well"
;    sleep 2000
    WinMove 0, 0,  gutter, A_ScreenHeight
  }
} 

raiseRender() {
  winActivate "Render"
  global raiseWhich := 2
}

raiseNotepad() {
  WinActivate "Untitled - Notepad"
  global raiseWhich := 1
}

raiseWell() {
  WinActivate "Bible Well - Google Chrome"
  global raiseWhich := 0
}

runAll( * ) {
  runNotepad()
  runRender()
  runWell()
}

closeAll( * ) {
  try {
    ProcessClose "Render.MainApplication.exe"
  }
  
  try {  ; as web tab
    WinActivate "Bible Well - Google Chrome"
    Send "^w"
  }

  try {  ; as web app
    WinActivate "app.well.bible"
    Send "^w"
  }
  
  try {
    ProcessClose "notepad.exe"
  }
}

runSwitch( * ) {
  global raiseWhich
  
  switch raiseWhich {
    case 0: raiseWell()
    case 1: raiseNotepad()
    case 2: raiseRender()
  }
  
  raiseWhich += 1
  
  if raiseWhich > 2 {
    raiseWhich := 0
  }
}
