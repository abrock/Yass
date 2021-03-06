Name "Yass"

!define VERSION "1.8.0"

OutFile ".\release\yass-installer-${VERSION}.exe"
SetCompressor lzma
XPStyle on
InstallColors /windows
Icon .\resources\icons\yass-multi-icon.ico
UninstallIcon .\resources\icons\yass-multi-icon.ico
InstallDir "$PROGRAMFILES\Yass Along ${VERSION}"
RequestExecutionLevel admin
LicenseData .\License.txt
Page license
Page components
Page directory

Section "Add context menu item to text files"
  SetOutPath "$INSTDIR"
  WriteRegStr HKCR "Directory\shell\yass" "" "Edit with Yass"
  WriteRegStr HKCR "Directory\shell\yass\command" "" '"$INSTDIR\yass.exe" "%1"'
  WriteRegStr HKCR "txtfile\shell\yass" "" "Edit with Yass"
  WriteRegStr HKCR "txtfile\shell\yass\command" "" '"$INSTDIR\yass.exe" "%1"'
SectionEnd

Section "Add context menu item to MIDI/Kar files"
  SetOutPath "$INSTDIR"

  ReadRegStr $R0 HKCR ".mid" ""
  StrCmp $R0 "" NoDefaultMid DefaultMid
NoDefaultMid:
  WriteRegStr HKCR ".mid\shell\yass" "" "Convert with Yass"
  WriteRegStr HKCR ".mid\shell\yass\command" "" '"$INSTDIR\yass.exe" "%1"'
  Goto EndMid
DefaultMid:
  WriteRegStr HKCR "$R0\shell\yass" "" "Convert with Yass"
  WriteRegStr HKCR "$R0\shell\yass\command" "" '"$INSTDIR\yass.exe" "%1"'
EndMid:

  ReadRegStr $R0 HKCR ".midi" ""
  StrCmp $R0 "" NoDefaultMidi DefaultMidi
NoDefaultMidi:
  WriteRegStr HKCR ".midi\shell\yass" "" "Convert with Yass"
  WriteRegStr HKCR ".midi\shell\yass\command" "" '"$INSTDIR\yass.exe" "%1"'
  Goto EndMidi
DefaultMidi:
  WriteRegStr HKCR "$R0\shell\yass" "" "Convert with Yass"
  WriteRegStr HKCR "$R0\shell\yass\command" "" '"$INSTDIR\yass.exe" "%1"'
EndMidi:

  ReadRegStr $R0 HKCR ".kar" ""
  StrCmp $R0 "" NoDefaultKar DefaultKar
NoDefaultKar:
  WriteRegStr HKCR ".kar\shell\yass" "" "Convert with Yass"
  WriteRegStr HKCR ".kar\shell\yass\command" "" '"$INSTDIR\yass.exe" "%1"'
  Goto EndKar
DefaultKar:
  WriteRegStr HKCR "$R0\shell\yass" "" "Convert with Yass"
  WriteRegStr HKCR "$R0\shell\yass\command" "" '"$INSTDIR\yass.exe" "%1"'
EndKar:

SectionEnd

Section "Add context menu item to directories"
  SetOutPath "$INSTDIR"
  WriteRegStr HKCR "Directory\shell\yass" "" "Edit with Yass"
  WriteRegStr HKCR "Directory\shell\yass\command" "" '"$INSTDIR\yass.exe" "%1"'
SectionEnd

Section "Create shortcuts on desktop"
  SetOutPath $INSTDIR
  CreateShortCut "$DESKTOP\Yass Editor.lnk" "$OUTDIR\yass.exe" "-lib" 
# "$INSTDIR\yass-edit.ico"
#  CreateShortCut "$DESKTOP\Yass Player.lnk" "$OUTDIR\yass.exe" "-play"
SectionEnd

Page instfiles
Section
  SetShellVarContext all
  SetOutPath $INSTDIR
  File ".\release\yass.exe"
  File ".\lib\fobs4jmf.dll"
#  File ".\lib\jinput-raw.dll"
#  File ".\lib\jinput-dx8.dll"
#  File ".\src\icons\yass-edit.ico"
  File ".\lib\Yass Along 1.0.1.pref"
  WriteRegStr HKLM "SOFTWARE\Yass Along" "installdir" "$INSTDIR"

  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Yass Along ${VERSION}" "DisplayName" "Yass Along ${VERSION}"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Yass Along ${VERSION}" "UninstallString" "$INSTDIR\uninstall.exe"

  WriteUninstaller $INSTDIR\uninstall.exe

  StrCpy $R1 $R0 1
  StrCmp $R1 ">" skip
	CreateDirectory "$SMPROGRAMS\Yass Along ${VERSION}"
#	CreateShortCut "$SMPROGRAMS\Yass Along ${VERSION}\Yass Player.lnk" "$INSTDIR\yass.exe" "-play"
	CreateShortCut "$SMPROGRAMS\Yass Along ${VERSION}\Yass Editor.lnk" "$INSTDIR\yass.exe" "-lib" 
# "$INSTDIR\yass-edit.ico"
	CreateShortCut "$SMPROGRAMS\Yass Along ${VERSION}\Yass Converter.lnk" "$INSTDIR\yass.exe" "-convert"
	CreateShortCut "$SMPROGRAMS\Yass Along ${VERSION}\Uninstall Yass Along.lnk" "$INSTDIR\uninstall.exe"
  skip:
SectionEnd

UninstallText "Thank you for using Yass."

Section "Uninstall"
  SetShellVarContext all

  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\Yass Along ${VERSION}" 

  DeleteRegKey HKCR "Directory\shell\yass\command"
  DeleteRegKey HKCR "Directory\shell\yass"
  DeleteRegKey HKCR "txtfile\shell\yass\command"
  DeleteRegKey HKCR "txtfile\shell\yass"

  ReadRegStr $R0 HKCR ".mid" ""
  DeleteRegKey HKCR "$R0\shell\yass\command"
  DeleteRegKey HKCR "$R0\shell\yass"
  DeleteRegKey HKCR ".mid\shell\yass\command"
  DeleteRegKey HKCR ".mid\shell\yass"

  ReadRegStr $R0 HKCR ".midi" ""
  DeleteRegKey HKCR "$R0\shell\yass\command"
  DeleteRegKey HKCR "$R0\shell\yass"
  DeleteRegKey HKCR ".midi\shell\yass\command"
  DeleteRegKey HKCR ".midi\shell\yass"

  ReadRegStr $R0 HKCR ".kar" ""
  DeleteRegKey HKCR "$R0\shell\yass\command"
  DeleteRegKey HKCR "$R0\shell\yass"
  DeleteRegKey HKCR ".kar\shell\yass\command"
  DeleteRegKey HKCR ".kar\shell\yass"


  delete "$DESKTOP\Yass Editor.lnk"
#  delete "$DESKTOP\Yass Player.lnk"
#  delete "$SMPROGRAMS\Yass Along ${VERSION}\Yass Player.lnk"
  delete "$SMPROGRAMS\Yass Along ${VERSION}\Yass Editor.lnk"
  delete "$SMPROGRAMS\Yass Along ${VERSION}\Yass Converter.lnk"
  delete "$SMPROGRAMS\Yass Along ${VERSION}\Uninstall Yass.lnk"
  rmdir "$SMPROGRAMS\Yass Along ${VERSION}"
  delete $INSTDIR\uninstall.exe 
  delete $INSTDIR\yass.exe
  rmdir /r "$INSTDIR"
sectionEnd
