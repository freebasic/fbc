; NSIS Script for the FreeBASIC Windows Installer
;
; This template contains a few ;;;<something>;;; parts that will be filled in
; by makescript.
; Paths are relative to the root FreeBASIC directory.

SetCompressor /SOLID lzma
OutFile "..\FreeBASIC-;;;FBVERSION;;;-win32.exe"
Name "FreeBASIC ;;;FBVERSION;;;"

!include "MUI2.nsh"

; URL used for a startmenu shortcut
!define URL_WIKI "http://www.freebasic.net/wiki"

; We write some entries to this place, so FB appears in Windows' Software list.
!define REGKEY_UNINST "Software\Microsoft\Windows\CurrentVersion\Uninstall\FreeBASIC"

!define MULTIUSER_EXECUTIONLEVEL Highest
!define MULTIUSER_MUI
!define MULTIUSER_INSTALLMODE_INSTDIR "FreeBASIC"
;!define MULTIUSER_INSTALLMODE_COMMANDLINE
;!define MULTIUSER_INSTALLMODE_DEFAULT_REGISTRY_KEY "${REGKEY_UNINST}"
;!define MULTIUSER_INSTALLMODE_DEFAULT_REGISTRY_VALUENAME "InstallMode"
;!define MULTIUSER_INSTALLMODE_INSTDIR_REGISTRY_KEY "${REGKEY_UNINST}"
;!define MULTIUSER_INSTALLMODE_INSTDIR_REGISTRY_VALUENAME "InstDir"
!include "MultiUser.nsh"

!define MUI_ABORTWARNING
!define MUI_ICON                       "fblogo.ico"
!define MUI_UNICON                     "fblogo.ico"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP         "..\fblogo-header.bmp"
!define MUI_STARTMENUPAGE_NODISABLE
!define MUI_STARTMENUPAGE_DEFAULTFOLDER "FreeBASIC"
!define MUI_STARTMENUPAGE_REGISTRY_ROOT SHCTX
!define MUI_STARTMENUPAGE_REGISTRY_KEY "${REGKEY_UNINST}"
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "NSIS:StartMenuDir"

; Installer pages --------------------------------------------------------------

var FB_STARTMENU
ShowInstDetails show

;!insertmacro MULTIUSER_PAGE_INSTALLMODE
; This page would allow Admins to choose whether to make an AllUsers or just a
; CurrentUser install. Without this choice we depend on MultiUser's defaults,
; which are: Admins can only install for AllUsers, while normal users can only
; install as CurrentUser.
; But how to pass this information to the uninstaller? The uninstaller needs to
; know whether to use HKLM or HKCU, in order to read out (and delete) our
; ${REGKEY_UNINST}, which tells it where the startmenu entries were placed.
; MultiUser does have a check for that in the uninstaller; it checks whether
; the MULTIUSER_INSTALLMODE_DEFAULT_REGISTRY_KEY key exists in HKCU but not
; HKLM, or in HKLM but not HKCU. Then it can set the proper mode. But if the
; key exists in both hives (with two installations), it can't know.
; The only way to solve this would be to store this information in a file in
; the installation directory, or to avoid installing startmenu and registry
; entries.

!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_STARTMENU Application $FB_STARTMENU
!insertmacro MUI_PAGE_INSTFILES

; Uninstaller pages ------------------------------------------------------------

ShowUnInstDetails show

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

; ------------------------------------------------------------------------------

!insertmacro MUI_LANGUAGE "English"

Function .onInit
  !insertmacro MULTIUSER_INIT
FunctionEnd

Section Install
    SetOverwrite on
    SetOutPath $INSTDIR

    ; makescript will put all files to install here
    ;;;INSTALL;;;

    SetOutPath $INSTDIR
    File "open-console.exe"
    File "fblogo.ico"
    WriteIniStr "$INSTDIR\wiki.url" "InternetShortcut" "URL" "${URL_WIKI}"

    ; Startmenu
    !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
    CreateDirectory "$SMPROGRAMS\$FB_STARTMENU"
    CreateShortCut "$SMPROGRAMS\$FB_STARTMENU\Online wiki.lnk"  "$INSTDIR\wiki.url"         "" "$INSTDIR\fblogo.ico"
    CreateShortCut "$SMPROGRAMS\$FB_STARTMENU\Open console.lnk" "$INSTDIR\open-console.exe" "" "$INSTDIR\fblogo.ico"
    !insertmacro MUI_STARTMENU_WRITE_END

    ; Uninstaller
    WriteUninstaller "$INSTDIR\uninstall.exe"
    WriteRegStr SHCTX "${REGKEY_UNINST}" "DisplayName"     "$(^Name)"
    WriteRegStr SHCTX "${REGKEY_UNINST}" "UninstallString" "$INSTDIR\uninstall.exe"
    WriteRegStr SHCTX "${REGKEY_UNINST}" "DisplayIcon"     "$INSTDIR\fblogo.ico"
    WriteRegStr SHCTX "${REGKEY_UNINST}" "DisplayVersion"  ";;;FBVERSION;;;"
    WriteRegStr SHCTX "${REGKEY_UNINST}" "URLInfoAbout"    "${URL_WIKI}"
    WriteRegStr SHCTX "${REGKEY_UNINST}" "Publisher"       "${URL_WIKI}"
SectionEnd

Function un.onInit
  !insertmacro MULTIUSER_UNINIT
FunctionEnd

Section Uninstall
    ; makescript will put all files to remove here
    ;;;UNINSTALL;;;

    Delete "$INSTDIR\fblogo.ico"
    Delete "$INSTDIR\open-console.exe"
    Delete "$INSTDIR\wiki.url"

    !insertmacro MUI_STARTMENU_GETFOLDER Application $FB_STARTMENU
    Delete "$SMPROGRAMS\$FB_STARTMENU\Open console.lnk"
    Delete "$SMPROGRAMS\$FB_STARTMENU\Online wiki.lnk"
    RMDir  "$SMPROGRAMS\$FB_STARTMENU"

    DeleteRegKey SHCTX "${REGKEY_UNINST}"
    Delete "$INSTDIR\uninstall.exe"

    RMDir "$INSTDIR"
SectionEnd
