; NSIS Script for the FreeBASIC Windows Installer
;
; This template contains a few ;;;<something>;;; parts that will be filled in
; by makescript.
; Paths are relative to the root FreeBASIC directory.

!define FB_VERSION "0.22.0"

!include "MUI2.nsh"

!define URL_SITE "http://www.freebasic.net"
!define URL_WIKI "${URL_SITE}/wiki"
!define URL_FORUM "${URL_SITE}/forum"
!define URL_SOURCEFORGE "http://www.sourceforge.net/projects/fbc"

; "FreeBASIC Shell Here" Explorer context menu extension
!define REGKEY_FBHERE         "Software\Classes\Directory\shell\FreeBASIC"
!define REGKEY_FBHERE_COMMAND "Software\Classes\Directory\shell\FreeBASIC\command"

!define REGKEY_APP    "Software\Microsoft\Windows\CurrentVersion\App Paths\fbc.exe"
!define REGKEY_UNINST "Software\Microsoft\Windows\CurrentVersion\Uninstall\FreeBASIC"

SetCompressor /SOLID lzma
Name "FreeBASIC ${FB_VERSION}"
OutFile "..\FreeBASIC-${FB_VERSION}-win32.exe"
InstallDir "C:\FreeBASIC"
InstallDirRegKey HKLM "${REGKEY_APP}" ""
ShowInstDetails show
ShowUnInstDetails show

!define MUI_ABORTWARNING
!define MUI_ICON   "fblogo.ico"
!define MUI_UNICON "fblogo.ico"
!define MUI_HEADERIMAGE
!define MUI_HEADERIMAGE_BITMAP         "src\contrib\installer\fblogo-header.bmp"
!define MUI_WELCOMEFINISHPAGE_BITMAP   "src\contrib\installer\fblogo-welcome.bmp"
!define MUI_UNWELCOMEFINISHPAGE_BITMAP "src\contrib\installer\fblogo-welcome.bmp"

; Language setting will be stored in registry, for the uninstaller to read out
!define MUI_LANGDLL_REGISTRY_ROOT "HKLM"
!define MUI_LANGDLL_REGISTRY_KEY "${REGKEY_UNINST}"
!define MUI_LANGDLL_REGISTRY_VALUENAME "NSIS:Language"

; Installer pages --------------------------------------------------------------

; Welcome
!insertmacro MUI_PAGE_WELCOME

; License
!insertmacro MUI_PAGE_LICENSE "docs\gpl.txt"

; Components page
!insertmacro MUI_PAGE_COMPONENTS

; Installation directory
!insertmacro MUI_PAGE_DIRECTORY

; Startmenu directory
var FB_STARTMENU
!define MUI_STARTMENUPAGE_NODISABLE
!define MUI_STARTMENUPAGE_DEFAULTFOLDER "FreeBASIC"
!define MUI_STARTMENUPAGE_REGISTRY_ROOT "HKLM"
!define MUI_STARTMENUPAGE_REGISTRY_KEY "${REGKEY_UNINST}"
!define MUI_STARTMENUPAGE_REGISTRY_VALUENAME "NSIS:StartMenuDir"
!insertmacro MUI_PAGE_STARTMENU Application $FB_STARTMENU

; Installation progress bar
!insertmacro MUI_PAGE_INSTFILES

; Finish page
!insertmacro MUI_PAGE_FINISH

; Uninstaller pages ------------------------------------------------------------

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES
!insertmacro MUI_UNPAGE_FINISH

; ------------------------------------------------------------------------------

; Language files
!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "German"

LangString TEXT_REMOVEPREV ${LANG_ENGLISH} "Before installing FreeBASIC ${FB_VERSION}, your previous FreeBASIC installation will be removed. Do you want to continue?"
LangString TEXT_REMOVEPREV ${LANG_GERMAN}  "Vor der Installation von FreeBASIC ${FB_VERSION} wird zunächst die vorherige FreeBASIC-Installation entfernt. Möchten Sie fortfahren?"

LangString TEXT_WEBSITE ${LANG_ENGLISH} "Website"
LangString TEXT_WEBSITE ${LANG_GERMAN}  "Webseite"

LangString TEXT_WIKI ${LANG_ENGLISH} "Online manual"
LangString TEXT_WIKI ${LANG_GERMAN}  "Online Referenz (Englisch)"

LangString TEXT_FORUM ${LANG_ENGLISH} "Forum"
LangString TEXT_FORUM ${LANG_GERMAN}  "Forum (Englisch)"

LangString TEXT_SOURCEFORGE ${LANG_ENGLISH} "Project page on SourceForge"
LangString TEXT_SOURCEFORGE ${LANG_GERMAN}  "Projektseite auf SourceForge"

LangString TEXT_UNINSTALL ${LANG_ENGLISH} "Uninstall"
LangString TEXT_UNINSTALL ${LANG_GERMAN}  "Deinstallieren"

LangString TEXT_STARTSHELL ${LANG_ENGLISH} "Open FreeBASIC shell"
LangString TEXT_STARTSHELL ${LANG_GERMAN}  "FreeBASIC Konsole öffnen"

LangString TEXT_SECTION_FBC ${LANG_ENGLISH} "FreeBASIC Compiler"
LangString TEXT_SECTION_FBC ${LANG_GERMAN}  "FreeBASIC Konsole öffnen"

LangString TEXT_SECTIONDESC_FBC ${LANG_ENGLISH} "Compiler and libraries"
LangString TEXT_SECTIONDESC_FBC ${LANG_GERMAN}  "Compiler und Bibliotheken"

LangString TEXT_SECTION_FBHERE ${LANG_ENGLISH} "Explorer context menu extension"
LangString TEXT_SECTION_FBHERE ${LANG_GERMAN}  "Explorer Kontextmenü Erweiterung"

LangString TEXT_SECTIONDESC_FBHERE ${LANG_ENGLISH} "Adds a $\"FreeBASIC Shell Here$\" command to the right-click context menu of folders in Explorer."
LangString TEXT_SECTIONDESC_FBHERE ${LANG_GERMAN}  "Fügt dem Rechtsklick-Menü von Ordnern im Explorer einen $\"FreeBASIC Konsole hier öffnen$\" Befehl hinzu."

LangString TEXT_FBHERE ${LANG_ENGLISH} "Open FreeBASIC shell here"
LangString TEXT_FBHERE ${LANG_GERMAN}  "FreeBASIC Konsole hier öffnen"

; ------------------------------------------------------------------------------

Function removeOldInstallation
    ; Try to find the old installation via registry
    ReadRegStr $R0 HKLM "${REGKEY_UNINST}" "UninstallString"
    StrCmp $R0 "" done

    MessageBox MB_OKCANCEL|MB_ICONINFORMATION $(TEXT_REMOVEPREV) IDOK uninst

    ; Canceled...
    Abort

    ; Invoke the old uninstaller
uninst:
    ClearErrors
    Exec $R0

done:
FunctionEnd

Function .onInit
    ; Language selection dialog
    !insertmacro MUI_LANGDLL_DISPLAY

    Call removeOldInstallation
FunctionEnd

Section $(TEXT_SECTION_FBC) SECTION_FBC
    SectionIn RO
    SetOverwrite try

    SetOutPath $INSTDIR

    ; makescript will put all files to install here
    ;;;INSTALL;;;

    SetOutPath $INSTDIR

    File "start-shell.exe"

    ; .url's for Startmenu shortcuts
    WriteIniStr "$INSTDIR\site.url"        "InternetShortcut" "URL" "${URL_SITE}"
    WriteIniStr "$INSTDIR\wiki.url"        "InternetShortcut" "URL" "${URL_WIKI}"
    WriteIniStr "$INSTDIR\forum.url"       "InternetShortcut" "URL" "${URL_FORUM}"
    WriteIniStr "$INSTDIR\sourceforge.url" "InternetShortcut" "URL" "${URL_SOURCEFORGE}"

    ; Startmenu shortcuts
    !insertmacro MUI_STARTMENU_WRITE_BEGIN Application
    CreateShortCut "$DESKTOP\$(TEXT_STARTSHELL).lnk"                   "$INSTDIR\start-shell.exe" "" "$INSTDIR\fblogo.ico"
    CreateDirectory "$SMPROGRAMS\$FB_STARTMENU"
    CreateShortCut "$SMPROGRAMS\$FB_STARTMENU\$(TEXT_WEBSITE).lnk"     "$INSTDIR\site.url"        "" "$INSTDIR\fblogo.ico"
    CreateShortCut "$SMPROGRAMS\$FB_STARTMENU\$(TEXT_WIKI).lnk"        "$INSTDIR\wiki.url"        "" "$INSTDIR\fblogo.ico"
    CreateShortCut "$SMPROGRAMS\$FB_STARTMENU\$(TEXT_FORUM).lnk"       "$INSTDIR\forum.url"       "" "$INSTDIR\fblogo.ico"
    CreateShortCut "$SMPROGRAMS\$FB_STARTMENU\$(TEXT_SOURCEFORGE).lnk" "$INSTDIR\sourceforge.url" "" "$INSTDIR\fblogo.ico"
    CreateShortCut "$SMPROGRAMS\$FB_STARTMENU\$(TEXT_UNINSTALL).lnk"   "$INSTDIR\uninstall.exe"
    CreateShortCut "$SMPROGRAMS\$FB_STARTMENU\$(TEXT_STARTSHELL).lnk"  "$INSTDIR\start-shell.exe" "" "$INSTDIR\fblogo.ico"
    !insertmacro MUI_STARTMENU_WRITE_END
SectionEnd

Section $(TEXT_SECTION_FBHERE) SECTION_FBHERE
    ; Registry entries for "FreeBASIC Shell Here" in context menu
    WriteRegStr HKLM "${REGKEY_FBHERE}" "" "$(TEXT_FBHERE)"
    WriteRegStr HKLM "${REGKEY_FBHERE_COMMAND}" "" '"$INSTDIR\start-shell.exe" "%1"'
SectionEnd

Section -Post
    ; Create uninstaller
    WriteUninstaller "$INSTDIR\uninstall.exe"
    WriteRegStr HKLM "${REGKEY_APP}"    ""                "$INSTDIR\fbc.exe"
    WriteRegStr HKLM "${REGKEY_UNINST}" "DisplayName"     "$(^Name)"
    WriteRegStr HKLM "${REGKEY_UNINST}" "UninstallString" "$INSTDIR\uninstall.exe"
    WriteRegStr HKLM "${REGKEY_UNINST}" "DisplayIcon"     "$INSTDIR\fblogo.ico"
    WriteRegStr HKLM "${REGKEY_UNINST}" "DisplayVersion"  "${FB_VERSION}"
    WriteRegStr HKLM "${REGKEY_UNINST}" "URLInfoAbout"    "${URL_SITE}"
    WriteRegStr HKLM "${REGKEY_UNINST}" "Publisher"       "${URL_SITE}"
SectionEnd

; Section descriptions
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SECTION_FBC} "$(TEXT_SECTIONDESC_FBC)"
    !insertmacro MUI_DESCRIPTION_TEXT ${SECTION_FBHERE} "$(TEXT_SECTIONDESC_FBHERE)"
!insertmacro MUI_FUNCTION_DESCRIPTION_END

; Let the uninstaller retrieve the language used during installation.
; This is needed, because the (file)names of our startmenu shortcuts depend on
; the language setting.
Function un.onInit
    !insertmacro MUI_UNGETLANGUAGE
FunctionEnd

Section Uninstall

    ; makescript will put all files to remove here
    ;;;UNINSTALL;;;

    Delete "$INSTDIR\start-shell.exe"

    Delete "$INSTDIR\sourceforge.url"
    Delete "$INSTDIR\forum.url"
    Delete "$INSTDIR\wiki.url"
    Delete "$INSTDIR\site.url"

    Delete "$INSTDIR\uninstall.exe"

    RMDir "$INSTDIR"

    !insertmacro MUI_STARTMENU_GETFOLDER Application $FB_STARTMENU

    Delete "$SMPROGRAMS\$FB_STARTMENU\$(TEXT_STARTSHELL).lnk"
    Delete "$SMPROGRAMS\$FB_STARTMENU\$(TEXT_UNINSTALL).lnk"
    Delete "$SMPROGRAMS\$FB_STARTMENU\$(TEXT_SOURCEFORGE).lnk"
    Delete "$SMPROGRAMS\$FB_STARTMENU\$(TEXT_FORUM).lnk"
    Delete "$SMPROGRAMS\$FB_STARTMENU\$(TEXT_WIKI).lnk"
    Delete "$SMPROGRAMS\$FB_STARTMENU\$(TEXT_WEBSITE).lnk"
    RMDir  "$SMPROGRAMS\$FB_STARTMENU"
    Delete "$DESKTOP\$(TEXT_STARTSHELL).lnk"

    DeleteRegKey HKLM "${REGKEY_UNINST}"
    DeleteRegKey HKLM "${REGKEY_APP}"

    ; TODO FIXME: should only delete this if it was added during installation
    DeleteRegKey HKLM "${REGKEY_FBHERE_COMMAND}"
    DeleteRegKey HKLM "${REGKEY_FBHERE}"

    SetAutoClose true
SectionEnd
