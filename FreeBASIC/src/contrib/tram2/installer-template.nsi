; NSIS Script for the FreeBASIC Windows Installer
;
; This template contains a few ;;;<something>;;; parts that are filled in by
; tram2.
;
; Paths are relative to the root FreeBASIC directory.

!include "MUI2.nsh"

!define FB_VERSION ;;;VERSION;;;
!define FB_SITE "http://www.freebasic.net"

!define REGKEY_APP    "Software\Microsoft\Windows\CurrentVersion\App Paths\fbc.exe"
!define REGKEY_UNINST "Software\Microsoft\Windows\CurrentVersion\Uninstall\FreeBASIC"

SetCompressor /SOLID lzma
Name "FreeBASIC ${FB_VERSION}"
OutFile ;;;SETUP_EXE_NAME;;;
InstallDir "C:\FreeBASIC"
InstallDirRegKey HKLM "${REGKEY_APP}" ""
ShowInstDetails show
ShowUnInstDetails show

!define MUI_ABORTWARNING
!define MUI_ICON   "fblogo.ico"
!define MUI_UNICON "fblogo.ico"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP         "src\contrib\w32_inst\fblogo_header.bmp"
!define MUI_WELCOMEFINISHPAGE_BITMAP   "src\contrib\w32_inst\fblogo_welcome.bmp"
!define MUI_UNWELCOMEFINISHPAGE_BITMAP "src\contrib\w32_inst\fblogo_welcome.bmp"

; Language Selection Dialog Settings
!define MUI_LANGDLL_REGISTRY_ROOT "HKLM"
!define MUI_LANGDLL_REGISTRY_KEY "${REGKEY_UNINST}"
!define MUI_LANGDLL_REGISTRY_VALUENAME "NSIS:Language"

; Installer pages --------------------------------------------------------------

!insertmacro MUI_PAGE_WELCOME

!insertmacro MUI_PAGE_LICENSE "docs\gpl.txt"

!insertmacro MUI_PAGE_DIRECTORY

var FB_STARTMENU
!define MUI_STARTMENUPAGE_NODISABLE
!define MUI_STARTMENUPAGE_DEFAULTFOLDER "FreeBASIC"
!define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKLM"
!define MUI_STARTMENUPAGE_REGISTRY_KEY "${REGKEY_UNINST}"
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "NSIS:StartMenuDir"
!insertmacro MUI_PAGE_STARTMENU Application $FB_STARTMENU

!insertmacro MUI_PAGE_INSTFILES

!insertmacro MUI_PAGE_FINISH

; Uninstaller pages ------------------------------------------------------------

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

; ------------------------------------------------------------------------------

; Language files
!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "German"
!insertmacro MUI_LANGUAGE "PortugueseBR"

LangString TEXT_REMOVEPREV ${LANG_ENGLISH} "Before installing FreeBASIC ${FB_VERSION}, your previous FreeBASIC installation will be removed. Do you want to continue?"
LangString TEXT_REMOVEPREV ${LANG_GERMAN} "Vor der Installation von FreeBASIC ${FB_VERSION} wird zunächst die vorherige FreeBASIC-Installation entfernt. Möchten Sie fortfahren?"
LangString TEXT_REMOVEPREV ${LANG_PORTUGUESEBR} "Before installing FreeBASIC ${FB_VERSION}, your previous FreeBASIC installation will be removed.  Do you want to continue?"

; ------------------------------------------------------------------------------

Function .onInit
    !insertmacro MUI_LANGDLL_DISPLAY

    ReadRegStr $R0 HKLM "${REGKEY_UNINST}" "UninstallString"
    StrCmp $R0 "" done

    MessageBox MB_OKCANCEL|MB_ICONINFORMATION $(TEXT_REMOVEPREV) IDOK uninst
    Abort

uninst:
    ClearErrors
    Exec $R0

done:
FunctionEnd

Section Install
    SetOverwrite try

    SetOutPath $INSTDIR

    ;;;INSTALL;;;

    SetOutPath $INSTDIR

    ; Shortcuts
    WriteIniStr "$INSTDIR\FreeBASIC-forum.url" "InternetShortcut" "URL" "${FB_SITE}/forum"
    WriteIniStr "$INSTDIR\FreeBASIC-wiki.url"  "InternetShortcut" "URL" "${FB_SITE}/wiki"

    ; Startmenu shortcuts
    !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
    CreateDirectory "$SMPROGRAMS\$FB_STARTMENU"
    CreateShortCut "$SMPROGRAMS\$FB_STARTMENU\FreeBASIC-forum.lnk" "$INSTDIR\FreeBASIC-forum.url" "" "$INSTDIR\fblogo.ico"
    CreateShortCut "$SMPROGRAMS\$FB_STARTMENU\FreeBASIC-wiki.lnk"  "$INSTDIR\FreeBASIC-wiki.url"  "" "$INSTDIR\fblogo.ico"
    CreateShortCut "$SMPROGRAMS\$FB_STARTMENU\Uninstall.lnk"       "$INSTDIR\uninstall.exe"
    !insertmacro MUI_STARTMENU_WRITE_END

    ; Uninstaller
    WriteUninstaller "$INSTDIR\uninstall.exe"
    WriteRegStr HKLM "${REGKEY_APP}"    ""                "$INSTDIR\fbc.exe"
    WriteRegStr HKLM "${REGKEY_UNINST}" "DisplayName"     "$(^Name)"
    WriteRegStr HKLM "${REGKEY_UNINST}" "UninstallString" "$INSTDIR\uninstall.exe"
    WriteRegStr HKLM "${REGKEY_UNINST}" "DisplayIcon"     "$INSTDIR\fblogo.ico"
    WriteRegStr HKLM "${REGKEY_UNINST}" "DisplayVersion"  "${FB_VERSION}"
    WriteRegStr HKLM "${REGKEY_UNINST}" "URLInfoAbout"    "${FB_SITE}"
    WriteRegStr HKLM "${REGKEY_UNINST}" "Publisher"       "${FB_SITE}"
SectionEnd

Section Uninstall
    !insertmacro MUI_STARTMENU_GETFOLDER "Application" $FB_STARTMENU

    Delete "$SMPROGRAMS\$FB_STARTMENU\FreeBASIC-forum.lnk"
    Delete "$SMPROGRAMS\$FB_STARTMENU\FreeBASIC-wiki.lnk"
    Delete "$SMPROGRAMS\$FB_STARTMENU\Uninstall.lnk"
    RMDir  "$SMPROGRAMS\$FB_STARTMENU"

    ;;;UNINSTALL;;;

    Delete "$INSTDIR\FreeBASIC-forum.url"
    Delete "$INSTDIR\FreeBASIC-wiki.url"
    Delete "$INSTDIR\uninstall.exe"

    RMDir "$INSTDIR"

    DeleteRegKey HKLM "${REGKEY_UNINST}"
    DeleteRegKey HKLM "${REGKEY_APP}"
    SetAutoClose true
SectionEnd
