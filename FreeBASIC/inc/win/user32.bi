#ifndef USER32_BI
#define USER32_BI
'---------
'USER32.BI
'---------
'
'This header defines every obtainable user32 Function and related data types and structures.

'VERSION: 1.08

'Changelog:
'  1.08: NMHDR moved back, comdlg must include this header
'  1.07: STRING types changed to BYTE PTR for structs fields and function results (v1ctor)
'  1.06: Added new stuff for listboxes, scrollbars, and static controls.
'  1.05: Added function constants for the combobox control.
'  1.04: NMHDR moved into winbase.bi for future compatibility with comdlg32.bi.
'  1.03: new button style constants. Added the HELPINFO Type. Transmigrated to WINBASE.BI for simplicity by fsw's request.
'        Moved type SECURITY_ATTRIBUTES into WINBASE.BI.
'  1.02: Rewrote the preprocessor directives so they'd actually WORK. :) Removed unneeded constants.
'  1.01: uses 0.08's new preprocessor to include win32constants.bi and win32types.bi, this makes shared constants and
'        types across multiple API inclusions a breeze :)

'$include once: "win\winbase.bi"

'----------------------
'| REQUIRED CONSTANTS |
'----------------------

' NOTE: All Message Numbers below &H0400 are RESERVED.

' Window Messages
const WM_NULL    = &H0
const WM_CREATE  = &H1
const WM_DESTROY = &H2
const WM_MOVE    = &H3
const WM_SIZE    = &H5

const WM_ACTIVATE = &H6
'
' WM_ACTIVATE state values

const WA_INACTIVE    = 0
const WA_ACTIVE      = 1
const WA_CLICKACTIVE = 2

const WM_SETFOCUS             = &H7
const WM_KILLFOCUS            = &H8
const WM_ENABLE               = &HA
const WM_SETREDRAW            = &HB
const WM_SETTEXT              = &HC
const WM_GETTEXT              = &HD
const WM_GETTEXTLENGTH        = &HE
const WM_PAINT                = &HF
const WM_CLOSE                = &H10
const WM_QUERYENDSESSION      = &H11
const WM_QUIT                 = &H12
const WM_QUERYOPEN            = &H13
const WM_ERASEBKGND           = &H14
const WM_SYSCOLORCHANGE       = &H15
const WM_ENDSESSION           = &H16
const WM_SHOWWINDOW           = &H18
const WM_WININICHANGE         = &H1A
const WM_SETTINGCHANGE        = WM_WININICHANGE
const WM_DEVMODECHANGE        = &H1B
const WM_ACTIVATEAPP          = &H1C
const WM_FONTCHANGE           = &H1D
const WM_TIMECHANGE           = &H1E
const WM_CANCELMODE           = &H1F
const WM_SETCURSOR            = &H20
const WM_MOUSEACTIVATE        = &H21
const WM_CHILDACTIVATE        = &H22
const WM_QUEUESYNC            = &H23
const WM_GETMINMAXINFO        = &H24
const WM_PAINTICON            = &H26
const WM_ICONERASEBKGND       = &H27
const WM_NEXTDLGCTL           = &H28
const WM_SPOOLERSTATUS        = &H2A
const WM_DRAWITEM             = &H2B
const WM_MEASUREITEM          = &H2C
const WM_DELETEITEM           = &H2D
const WM_VKEYTOITEM           = &H2E
const WM_CHARTOITEM           = &H2F
const WM_SETFONT              = &H30
const WM_GETFONT              = &H31
const WM_SETHOTKEY            = &H32
const WM_GETHOTKEY            = &H33
const WM_QUERYDRAGICON        = &H37
const WM_COMPAREITEM          = &H39
const WM_GETOBJECT            = &H3D
const WM_COMPACTING           = &H41
const WM_OTHERWINDOWCREATED   = &H42  ' no Integerer suported
const WM_OTHERWINDOWDESTROYED = &H43  ' no Integerer suported
const WM_COMMNOTIFY           = &H44  ' no Integerer suported
const WM_WINDOWPOSCHANGING    = &H46
const WM_WINDOWPOSCHANGED     = &H47
const WM_POWER                = &H48

' notifications passed in low word of lParam on WM_COMMNOTIFY messages
const CN_RECEIVE  = &H1
const CN_TRANSMIT = &H2
const CN_EVENT    = &H4

' wParam for const WM_POWER window message and DRV_POWER driver notification
const PWR_OK             = 1
const PWR_FAIL           = -1
const PWR_SUSPENDREQUEST = 1
const PWR_SUSPENDRESUME  = 2
const PWR_CRITICALRESUME = 3

const WM_COPYDATA                   = &H4A
const WM_CANCELJOURNAL              = &H4B
const WM_NOTIFY                     = &H4E
const WM_INPUTLANGUAGECHANGEREQUEST = &H50
const WM_INPUTLANGCHANGEREQUEST     = &H50
const WM_INPUTLANGUAGECHANGE        = &H51
const WM_INPUTLANGCHANGE            = &H51
const WM_TCARD                      = &H52
const WM_HELP                       = &H53
const WM_USERCHANGED                = &H54
const WM_NOTIFYFORMAT               = &H55

const WM_CONTEXTMENU      = &H07B
const WM_STYLECHANGING    = &H07C
const WM_STYLECHANGED     = &H07D
const WM_DISPLAYCHANGE    = &H07E

const WM_GETICON          = &H07F
const WM_SETICON          = &H080
const WM_NCCREATE         = &H081
const WM_NCDESTROY        = &H082
const WM_NCCALCSIZE       = &H083
const WM_NCHITTEST        = &H084
const WM_NCPAINT          = &H085
const WM_NCACTIVATE       = &H086
const WM_GETDLGCODE       = &H087
const WM_SYNCPAINT        = &H088
const WM_NCMOUSEMOVE      = &H0A0
const WM_NCLBUTTONDOWN    = &H0A1
const WM_NCLBUTTONUP      = &H0A2
const WM_NCLBUTTONDBLCLK  = &H0A3
const WM_NCRBUTTONDOWN    = &H0A4
const WM_NCRBUTTONUP      = &H0A5
const WM_NCRBUTTONDBLCLK  = &H0A6
const WM_NCMBUTTONDOWN    = &H0A7
const WM_NCMBUTTONUP      = &H0A8
const WM_NCMBUTTONDBLCLK  = &H0A9
const WM_NCXBUTTONDOWN    = &H0AB
const WM_NCXBUTTONUP      = &H0AC
const WM_NCXBUTTONDBLCLK  = &H0AD
const WM_INPUT            = &H0FF
const WM_KEYFIRST         = &H100
const WM_KEYDOWN          = &H100
const WM_KEYUP            = &H101
const WM_CHAR             = &H102
const WM_DEADCHAR         = &H103
const WM_SYSKEYDOWN       = &H104
const WM_SYSKEYUP         = &H105
const WM_SYSCHAR          = &H106
const WM_SYSDEADCHAR      = &H107
const WM_UNICHAR          = &H0109
const WM_KEYLAST          = &H0109
const UNICODE_NOCHAR      = &H0FFFF
const WM_INITDIALOG       = &H110
const WM_COMMAND          = &H111
const WM_SYSCOMMAND       = &H112
const WM_TIMER            = &H113
const WM_HSCROLL          = &H114
const WM_VSCROLL          = &H115
const WM_INITMENU         = &H116
const WM_INITMENUPOPUP    = &H117
const WM_MENUSELECT       = &H11F
const WM_MENUCHAR         = &H120
const WM_ENTERIDLE        = &H121
const WM_MENURBUTTONUP    = &H0122
const WM_MENUDRAG         = &H0123
const WM_MENUGETOBJECT    = &H0124
const WM_UNINITMENUPOPUP  = &H0125
const WM_MENUCOMMAND      = &H0126
const WM_CHANGEUISTATE    = &H0127
const WM_UPDATEUISTATE    = &H0128
const WM_QUERYUISTATE     = &H0129
const WM_CTLCOLORMSGBOX   = &H132
const WM_CTLCOLOREDIT     = &H133
const WM_CTLCOLORLISTBOX  = &H134
const WM_CTLCOLORBTN      = &H135
const WM_CTLCOLORDLG      = &H136
const WM_CTLCOLORSCROLLBAR= &H137
const WM_CTLCOLORSTATIC   = &H138
const WM_MOUSEFIRST       = &H200
const WM_MOUSEMOVE        = &H200
const WM_LBUTTONDOWN      = &H201
const WM_LBUTTONUP        = &H202
const WM_LBUTTONDBLCLK    = &H203
const WM_RBUTTONDOWN      = &H204
const WM_RBUTTONUP        = &H205
const WM_RBUTTONDBLCLK    = &H206
const WM_MBUTTONDOWN      = &H207
const WM_MBUTTONUP        = &H208
const WM_MBUTTONDBLCLK    = &H209
const WM_MOUSEWHEEL       = &H20A
const WM_XBUTTONDOWN      = &H20B
const WM_XBUTTONUP        = &H20C
const WM_XBUTTONDBLCLK    = &H20D
const WM_MOUSELAST        = &H20D
const WM_PARENTNOTIFY     = &H210
const WM_ENTERMENULOOP    = &H211
const WM_EXITMENULOOP     = &H212

const WM_SIZING           = &H214
const WM_CAPTURECHANGED   = &H215
const WM_MOVING           = &H216

const WM_POWERBROADCAST   = &H218
const WM_DEVICECHANGE     = &H219
const WM_MDICREATE        = &H220
const WM_MDIDESTROY       = &H221
const WM_MDIACTIVATE      = &H222
const WM_MDIRESTORE       = &H223
const WM_MDINEXT          = &H224
const WM_MDIMAXIMIZE      = &H225
const WM_MDITILE          = &H226
const WM_MDICASCADE       = &H227
const WM_MDIICONARRANGE   = &H228
const WM_MDIGETACTIVE     = &H229
const WM_MDISETMENU       = &H230
const WM_ENTERSIZEMOVE    = &H231
const WM_EXITSIZEMOVE     = &H232
const WM_DROPFILES        = &H233
const WM_MDIREFRESHMENU   = &H234

const WM_MOUSEHOVER        = &H2A1
const WM_MOUSELEAVE        = &H2A3
const WM_WTSSESSION_CHANGE = &H02B1
const WM_TABLET_FIRST      = &H02c0
const WM_TABLET_LAST       = &H02df

const WM_CUT              = &H300
const WM_COPY             = &H301
const WM_PASTE            = &H302
const WM_CLEAR            = &H303
const WM_UNDO             = &H304
const WM_USER 			  = 1024
const WM_RENDERFORMAT     = &H305
const WM_RENDERALLFORMATS = &H306
const WM_DESTROYCLIPBOARD = &H307
const WM_DRAWCLIPBOARD    = &H308
const WM_PAINTCLIPBOARD   = &H309
const WM_VSCROLLCLIPBOARD = &H30A
const WM_SIZECLIPBOARD    = &H30B
const WM_ASKCBFORMATNAME  = &H30C
const WM_CHANGECBCHAIN    = &H30D
const WM_HSCROLLCLIPBOARD = &H30E
const WM_QUERYNEWPALETTE  = &H30F
const WM_PALETTEISCHANGING= &H310
const WM_PALETTECHANGED   = &H311
const WM_HOTKEY           = &H312
const WM_PRINT            = &H317
const WM_PRINTCLIENT      = &H318
const WM_APPCOMMAND       = &H319
const WM_THEMECHANGED     = &H31A

const WM_HANDHELDFIRST    = &H0358
const WM_HANDHELDLAST     = &H035F
const WM_AFXFIRST         = &H0360
const WM_AFXLAST          = &H037F

const WM_PENWINFIRST      = &H380
const WM_PENWINLAST       = &H38F

const WM_APP              = &H08000

' DrawText() Format Flags
const DT_TOP                  = &H0
const DT_LEFT                 = &H0
const DT_CENTER               = &H1
const DT_RIGHT                = &H2
const DT_VCENTER              = &H4
const DT_BOTTOM               = &H8
const DT_WORDBREAK            = &H10
const DT_SINGLELINE           = &H20
const DT_EXPANDTABS           = &H40
const DT_TABSTOP              = &H80
const DT_NOCLIP               = &H100
const DT_EXTERNALLEADING      = &H200
const DT_CALCRECT             = &H400
const DT_NOPREFIX             = &H800
const DT_INTERNAL             = &H1000
const DT_EDITCONTROL          = &H00002000
const DT_PATH_ELLIPSIS        = &H00004000
const DT_END_ELLIPSIS         = &H00008000
const DT_MODIFYSTRING         = &H00010000
const DT_RTLREADING           = &H00020000
const DT_WORD_ELLIPSIS        = &H00040000
const DT_NOFULLWIDTHCHARBREAK = &H00080000
const DT_HIDEPREFIX           = &H00100000
const DT_PREFIXONLY           = &H00200000

' Monolithic state-drawing routine
' Image type
const DST_COMPLEX    = &H00000000
const DST_TEXT       = &H00000001
const DST_PREFIXTEXT = &H00000002
const DST_ICON       = &H00000003
const DST_BITMAP     = &H00000004

' State type
const DSS_NORMAL     = &H00000000
const DSS_UNION      = &H00000010  ' Gray String appearance
const DSS_DISABLED   = &H00000020
const DSS_MONO       = &H00000080
const DSS_HIDEPREFIX = &H00000200
const DSS_PREFIXONLY = &H00000400
const DSS_RIGHT      = &H00008000

const DCX_WINDOW          = &H1&
const DCX_CACHE           = &H2&
const DCX_NORESETATTRS    = &H4&
const DCX_CLIPCHILDREN    = &H8&
const DCX_CLIPSIBLINGS    = &H10&
const DCX_PARENTCLIP      = &H20&

const DCX_EXCLUDERGN      = &H40&
const DCX_INTERSECTRGN    = &H80&

const DCX_EXCLUDEUPDATE   = &H100&
const DCX_INTERSECTUPDATE = &H200&

const DCX_LOCKWINDOWUPDATE= &H400&

const DCX_NORECOMPUTE     = &H100000
const DCX_VALIDATE        = &H200000

const RDW_INVALIDATE      = &H1
const RDW_INTERNALPAINT   = &H2
const RDW_ERASE           = &H4

const RDW_VALIDATE        = &H8
const RDW_NOINTERNALPAINT = &H10
const RDW_NOERASE         = &H20

const RDW_NOCHILDREN      = &H40
const RDW_ALLCHILDREN     = &H80

const RDW_UPDATENOW       = &H100
const RDW_ERASENOW        = &H200

const RDW_FRAME           = &H400
const RDW_NOFRAME         = &H800

const SW_SCROLLCHILDREN = &H0001
const SW_INVALIDATE     = &H0002
const SW_ERASE          = &H0004
const SW_SMOOTHSCROLL   = &H0010

' ShowWindow() Commands
Const SW_HIDE = 0
Const SW_SHOWNORMAL = 1
Const SW_NORMAL = 1
Const SW_SHOWMINIMIZED = 2
Const SW_SHOWMAXIMIZED = 3
Const SW_MAXIMIZE = 3
Const SW_SHOWNOACTIVATE = 4
Const SW_SHOW = 5
Const SW_MINIMIZE = 6
Const SW_SHOWMINNOACTIVE = 7
Const SW_SHOWNA = 8
Const SW_RESTORE = 9
Const SW_SHOWDEFAULT = 10
Const SW_MAX = 10

' EnableScrollBar() flags
const ESB_ENABLE_BOTH   = &H0
const ESB_DISABLE_BOTH  = &H3

const ESB_DISABLE_LEFT  = &H1
const ESB_DISABLE_RIGHT = &H2

const ESB_DISABLE_UP    = &H1
const ESB_DISABLE_DOWN  = &H2

const ESB_DISABLE_LTUP  = ESB_DISABLE_LEFT
const ESB_DISABLE_RTDN  = ESB_DISABLE_RIGHT

' MessageBox() Flags
const MB_OK                        = &H00000000&
const MB_OKCANCEL                  = &H00000001&
const MB_ABORTRETRYIGNORE          = &H00000002&
const MB_YESNOCANCEL               = &H00000003&
const MB_YESNO                     = &H00000004&
const MB_RETRYCANCEL               = &H00000005&
const MB_CANCELTRYCONTINUE         = &H00000006&

const MB_ICONHAND                  = &H00000010&
const MB_ICONQUESTION              = &H00000020&
const MB_ICONEXCLAMATION           = &H00000030&
const MB_ICONASTERISK              = &H00000040&

const MB_USERICON                  = &H00000080&
const MB_ICONWARNING               = MB_ICONEXCLAMATION
const MB_ICONERROR                 = MB_ICONHAND

const MB_ICONINFORMATION           = MB_ICONASTERISK
const MB_ICONSTOP                  = MB_ICONHAND

const MB_DEFBUTTON1                = &H00000000&
const MB_DEFBUTTON2                = &H00000100&
const MB_DEFBUTTON3                = &H00000200&
const MB_DEFBUTTON4                = &H00000300&

const MB_APPLMODAL                 = &H00000000&
const MB_SYSTEMMODAL               = &H00001000&
const MB_TASKMODAL                 = &H00002000&
const MB_HELP                      = &H00004000&  ' Help Button

const MB_NOFOCUS                   = &H00008000&
const MB_SETFOREGROUND             = &H00010000&
const MB_DEFAULT_DESKTOP_ONLY      = &H00020000&

const MB_TOPMOST                   = &H00040000&
const MB_RIGHT                     = &H00080000&
const MB_RTLREADING                = &H00100000&

const MB_SERVICE_NOTIFICATION      = &H00200000&
const MB_SERVICE_NOTIFICATION_NT3X = &H00040000&

const MB_TYPEMASK                  = &H0000000F&
const MB_ICONMASK                  = &H000000F0&
const MB_DEFMASK                   = &H00000F00&
const MB_MODEMASK                  = &H00003000&
const MB_MISCMASK                  = &H0000C000&

' Window Styles
Const WS_OVERLAPPED = &H0&
Const WS_POPUP        = &H80000000
Const WS_CHILD        = &H40000000
Const WS_MINIMIZE     = &H20000000
Const WS_VISIBLE      = &H10000000
Const WS_DISABLED     = &H8000000
Const WS_CLIPSIBLINGS = &H4000000
Const WS_CLIPCHILDREN = &H2000000
Const WS_MAXIMIZE     = &H1000000
Const WS_CAPTION      = &HC00000                  '  WS_BORDER Or WS_DLGFRAME
Const WS_BORDER       = &H800000
Const WS_DLGFRAME     = &H400000
Const WS_VSCROLL      = &H200000
Const WS_HSCROLL      = &H100000
Const WS_SYSMENU      = &H80000
Const WS_THICKFRAME   = &H40000
Const WS_GROUP        = &H20000
Const WS_TABSTOP      = &H10000

Const WS_MINIMIZEBOX = &H20000
Const WS_MAXIMIZEBOX = &H10000

Const WS_TILED            = WS_OVERLAPPED
Const WS_ICONIC           = WS_MINIMIZE
Const WS_SIZEBOX          = WS_THICKFRAME
Const WS_OVERLAPPEDWINDOW = (WS_OVERLAPPED Or WS_CAPTION Or WS_SYSMENU Or WS_THICKFRAME Or WS_MINIMIZEBOX Or WS_MAXIMIZEBOX)
Const WS_TILEDWINDOW      = WS_OVERLAPPEDWINDOW

' Common Window Styles
Const WS_POPUPWINDOW = (WS_POPUP Or WS_BORDER Or WS_SYSMENU)
Const WS_CHILDWINDOW = (WS_CHILD)

' Extended Window Styles
Const WS_EX_ACCEPTFILES     = &H10&
Const WS_EX_APPWINDOW       = &H40000&
Const WS_EX_CLIENTEDGE      = &H200&
Const WS_EX_CONTEXTHELP     = &H400&
Const WS_EX_CONTROLPARENT   = &H10000&
Const WS_EX_DLGMODALFRAME   = &H1&
Const WS_EX_LAYERED         = &H80000
Const WS_EX_LAYOUTRTL       = &H400000&
Const WS_EX_LEFT            = &H0&
Const WS_EX_LEFTSCROLLBAR   = &H4000&
Const WS_EX_LTRREADING      = &H0&
Const WS_EX_MDICHILD        = &H40&
Const WS_EX_NOACTIVATE      = &H8000000&
Const WS_EX_NOINHERITLAYOUT = &H100000&
Const WS_EX_NOPARENTNOTIFY  = &H4&
Const WS_EX_RIGHT           = &H1000&
Const WS_EX_RIGHTSCROLLBAR  = &H0&
Const WS_EX_RTLREADING      = &H2000&
Const WS_EX_STATICEDGE      = &H20000&
Const WS_EX_TOOLWINDOW      = &H80&
Const WS_EX_TOPMOST         = &H8&
Const WS_EX_TRANSPARENT     = &H20&
Const WS_EX_WINDOWEDGE      = &H100&

Const WS_EX_OVERLAPPEDWINDOW = (WS_EX_WINDOWEDGE Or WS_EX_CLIENTEDGE)
Const WS_EX_PALETTEWINDOW    = (WS_EX_WINDOWEDGE Or WS_EX_TOOLWINDOW Or WS_EX_TOPMOST)

' Class styles
Const CS_VREDRAW         = &H1
Const CS_HREDRAW         = &H2
Const CS_KEYCVTWINDOW    = &H4
Const CS_DBLCLKS         = &H8
Const CS_OWNDC           = &H20
Const CS_CLASSDC         = &H40
Const CS_PARENTDC        = &H80
Const CS_NOKEYCVT        = &H100
Const CS_NOCLOSE         = &H200
Const CS_SAVEBITS        = &H800
Const CS_BYTEALIGNCLIENT = &H1000
Const CS_BYTEALIGNWINDOW = &H2000
Const CS_PUBLICCLASS     = &H4000

' Standard Icon IDs
Const IDI_APPLICATION = 32512&
Const IDI_HAND        = 32513&
Const IDI_QUESTION    = 32514&
Const IDI_EXCLAMATION = 32515&
Const IDI_ASTERISK    = 32516&

' Dialog Box Command IDs
Const IDOK       = 1
Const IDCANCEL   = 2
Const IDABORT    = 3
Const IDRETRY    = 4
Const IDIGNORE   = 5
Const IDYES      = 6
Const IDNO       = 7
Const IDTRY      = &HA
Const IDCONTINUE = &HB

' Standard Cursor IDs
Const IDC_ARROW       = 32512&
Const IDC_IBEAM       = 32513&
Const IDC_WAIT        = 32514&
Const IDC_CROSS       = 32515&
Const IDC_UPARROW     = 32516&
Const IDC_SIZE        = 32640&
Const IDC_ICON        = 32641&
Const IDC_SIZENWSE    = 32642&
Const IDC_SIZENESW    = 32643&
Const IDC_SIZEWE      = 32644&
Const IDC_SIZENS      = 32645&
Const IDC_SIZEALL     = 32646&
Const IDC_NO          = 32648&
Const IDC_APPSTARTING = 32650&

Const CW_USEDEFAULT = &H80000000
Const HWND_DESKTOP  = 0

' PeekMessage() Options
Const PM_NOREMOVE = &H0
Const PM_REMOVE   = &H1
Const PM_NOYIELD  = &H2

' keyboard constants
Const VK_LBUTTON = &H1
Const VK_RBUTTON = &H2
Const VK_CANCEL = &H3
Const VK_MBUTTON = &H4
Const VK_BACK = &H8
Const VK_TAB = &H9
Const VK_CLEAR = &HC
Const VK_RETURN = &HD
Const VK_SHIFT = &H10
Const VK_CONTROL = &H11
Const VK_MENU = &H12
Const VK_PAUSE = &H13
Const VK_CAPITAL = &H14
Const VK_ESCAPE = &H1B
Const VK_SPACE = &H20
Const VK_PRIOR = &H21
Const VK_NEXT = &H22
Const VK_END = &H23
Const VK_HOME = &H24
Const VK_LEFT = &H25
Const VK_UP = &H26
Const VK_RIGHT = &H27
Const VK_DOWN = &H28
Const VK_SELECT = &H29
Const VK_PRINT = &H2A
Const VK_EXECUTE = &H2B
Const VK_SNAPSHOT = &H2C
Const VK_INSERT = &H2D
Const VK_DELETE = &H2E
Const VK_HELP = &H2F
Const VK_0 = &H30
Const VK_1 = &H31
Const VK_2 = &H32
Const VK_3 = &H33
Const VK_4 = &H34
Const VK_5 = &H35
Const VK_6 = &H36
Const VK_7 = &H37
Const VK_8 = &H38
Const VK_9 = &H39
Const VK_A = &H41
Const VK_B = &H42
Const VK_C = &H43
Const VK_D = &H44
Const VK_E = &H45
Const VK_F = &H46
Const VK_G = &H47
Const VK_H = &H48
Const VK_I = &H49
Const VK_J = &H4A
Const VK_K = &H4B
Const VK_L = &H4C
Const VK_M = &H4D
Const VK_N = &H4E
Const VK_O = &H4F
Const VK_P = &H50
Const VK_Q = &H51
Const VK_R = &H52
Const VK_S = &H53
Const VK_T = &H54
Const VK_U = &H55
Const VK_V = &H56
Const VK_W = &H57
Const VK_X = &H58
Const VK_Y = &H59
Const VK_Z = &H5A
Const VK_STARTKEY = &H5B
Const VK_CONTEXTKEY = &H5D
Const VK_NUMPAD0 = &H60
Const VK_NUMPAD1 = &H61
Const VK_NUMPAD2 = &H62
Const VK_NUMPAD3 = &H63
Const VK_NUMPAD4 = &H64
Const VK_NUMPAD5 = &H65
Const VK_NUMPAD6 = &H66
Const VK_NUMPAD7 = &H67
Const VK_NUMPAD8 = &H68
Const VK_NUMPAD9 = &H69
Const VK_MULTIPLY = &H6A
Const VK_ADD = &H6B
Const VK_SEPARATOR = &H6C
Const VK_SUBTRACT = &H6D
Const VK_DECIMAL = &H6E
Const VK_DIVIDE = &H6F
Const VK_F1 = &H70
Const VK_F2 = &H71
Const VK_F3 = &H72
Const VK_F4 = &H73
Const VK_F5 = &H74
Const VK_F6 = &H75
Const VK_F7 = &H76
Const VK_F8 = &H77
Const VK_F9 = &H78
Const VK_F10 = &H79
Const VK_F11 = &H7A
Const VK_F12 = &H7B
Const VK_F13 = &H7C
Const VK_F14 = &H7D
Const VK_F15 = &H7E
Const VK_F16 = &H7F
Const VK_F17 = &H80
Const VK_F18 = &H81
Const VK_F19 = &H82
Const VK_F20 = &H83
Const VK_F21 = &H84
Const VK_F22 = &H85
Const VK_F23 = &H86
Const VK_F24 = &H87
Const VK_NUMLOCK = &H90
Const VK_OEM_SCROLL = &H91
Const VK_OEM_1 = &HBA
Const VK_OEM_PLUS = &HBB
Const VK_OEM_COMMA = &HBC
Const VK_OEM_MINUS = &HBD
Const VK_OEM_PERIOD = &HBE
Const VK_OEM_2 = &HBF
Const VK_OEM_3 = &HC0
Const VK_OEM_4 = &HDB
Const VK_OEM_5 = &HDC
Const VK_OEM_6 = &HDD
Const VK_OEM_7 = &HDE
Const VK_OEM_8 = &HDF
Const VK_ICO_F17 = &HE0
Const VK_ICO_F18 = &HE1
Const VK_OEM102 = &HE2
Const VK_ICO_HELP = &HE3
Const VK_ICO_00 = &HE4
Const VK_ICO_CLEAR = &HE6
Const VK_OEM_RESET = &HE9
Const VK_OEM_JUMP = &HEA
Const VK_OEM_PA1 = &HEB
Const VK_OEM_PA2 = &HEC
Const VK_OEM_PA3 = &HED
Const VK_OEM_WSCTRL = &HEE
Const VK_OEM_CUSEL = &HEF
Const VK_OEM_ATTN = &HF0
Const VK_OEM_FINNISH = &HF1
Const VK_OEM_COPY = &HF2
Const VK_OEM_AUTO = &HF3
Const VK_OEM_ENLW = &HF4
Const VK_OEM_BACKTAB = &HF5
Const VK_ATTN = &HF6
Const VK_CRSEL = &HF7
Const VK_EXSEL = &HF8
Const VK_EREOF = &HF9
Const VK_PLAY = &HFA
Const VK_ZOOM = &HFB
Const VK_NONAME = &HFC
Const VK_PA1 = &HFD
Const VK_OEM_CLEAR = &HFE
Const KEYEVENTF_EXTENDEDKEY = &H1
Const KEYEVENTF_KEYUP = &H2

' button construction constants
Const BS_3STATE          = &H5&
Const BS_AUTO3STATE      = &H6&
Const BS_AUTOCHECKBOX    = &H3&
Const BS_AUTORADIOBUTTON = &H9&
Const BS_CHECKBOX        = &H2&
Const BS_DEFPUSHBUTTON   = &H1&
Const BS_GROUPBOX        = &H7&
Const BS_LEFTTEXT        = &H20&
Const BS_OWNERDRAW       = &HB&
Const BS_PUSHBUTTON      = &H0&
Const BS_RADIOBUTTON     = &H4&
Const BS_USERBUTTON      = &H8&

'button additional styles
Const BS_BITMAP      = &H80&
Const BS_BOTTOM      = &H800&
Const BS_CENTER      = &H300&
Const BS_FLAT        = &H8000&
Const BS_LEFT        = &H100&
Const BS_MULTILINE   = &H2000&
Const BS_NOTIFY      = &H4000&
Const BS_PUSHLIKE    = &H1000&
Const BS_RIGHT       = &H200&
Const BS_RIGHTBUTTON = BS_LEFTTEXT
Const BS_TEXT        = &H0&
Const BS_TOP         = &H400&
Const BS_VCENTER     = &HC00&

'button notifications
Const BN_CLICKED       = 0
Const BN_PAINT         = 1
Const BN_HILITE        = 2
Const BN_UNHILITE      = 3
Const BN_DISABLE       = 4
Const BN_DOUBLECLICKED = 5
Const BN_SETFOCUS      = 6
Const BN_KILLFOCUS     = 7
Const BN_PUSHED        = BN_HILITE
Const BN_UNPUSHED      = BN_UNHILITE
Const BN_DBLCLK        = BN_DOUBLECLICKED

'button command messages
Const BM_GETCHECK = &HF0
Const BM_GETSTATE = &HF2
Const BM_SETCHECK = &HF1
Const BM_SETSTATE = &HF3
Const BM_SETSTYLE = &HF4
Const BM_CLICK    = &HF5
Const BM_GETIMAGE = &HF6
Const BM_SETIMAGE = &HF7

Const FLASHW_STOP      = 0
Const FLASHW_CAPTION   = 1
Const FLASHW_TRAY      = 2
Const FLASHW_ALL       = (FLASHW_CAPTION Or FLASHW_TRAY)
Const FLASHW_TIMER     = 4
Const FLASHW_TIMERNOFG = &HC

Const GWL_HINSTANCE  = (-6)
Const SWP_NOSIZE     = &H1
Const SWP_NOZORDER   = &H4
Const SWP_NOACTIVATE = &H10
Const HCBT_ACTIVATE  = 5
Const WH_CBT         = 5

'combobox construction constants
Const CBS_AUTOHSCROLL       = &H40&
Const CBS_DISABLENOSCROLL   = &H800&
Const CBS_DROPDOWN          = &H2&
Const CBS_DROPDOWNLIST      = &H3&
Const CBS_HASSTRINGS        = &H200&
Const CBS_NOINTEGRALHEIGHT  = &H400&
Const CBS_OEMCONVERT        = &H80&
Const CBS_OWNERDRAWFIXED    = &H10&
Const CBS_OWNERDRAWVARIABLE = &H20&
Const CBS_SIMPLE            = &H1&
Const CBS_SORT              = &H100&

'combobox functions
Const CB_ADDSTRING             = &H143&
Const CB_DELETESTRING          = &H144&
Const CB_DIR                   = &H145&
Const CB_FINDSTRING            = &H14C&
Const CB_FINDSTRINGEXACT       = &H158&
Const CB_GETCOMBOBOXINFO       = &H164&
Const CB_GETCOUNT              = &H146&
Const CB_GETCURSEL             = &H147&
Const CB_GETDROPPEDCONTROLRECT = &H152&
Const CB_GETDROPPEDSTATE       = &H157&
Const CB_GETDROPPEDWIDTH       = &H15f&
Const CB_GETEDITSEL            = &H140&
Const CB_GETEXTENDEDUI         = &H156&
Const CB_GETHORIZONTALEXTENT   = &H15d&
Const CB_GETITEMDATA           = &H150&
Const CB_GETITEMHEIGHT         = &H154&
Const CB_GETLBTEXT             = &H148&
Const CB_GETLBTEXTLEN          = &H149&
Const CB_GETLOCALE             = &H15A&
Const CB_GETTOPINDEX           = &H15b&
Const CB_INITSTORAGE           = &H161&
Const CB_INSERTSTRING          = &H14A&
Const CB_LIMITTEXT             = &H141&
Const CB_RESETCONTENT          = &H14B&
Const CB_SELECTSTRING          = &H14D&
Const CB_SETCURSEL             = &H14E&
Const CB_SETDROPPEDWIDTH       = &H160&
Const CB_SETEDITSEL            = &H142&
Const CB_SETEXTENDEDUI         = &H155&
Const CB_SETHORIZONTALEXTENT   = &H15e&
Const CB_SETITEMDATA           = &H151&
Const CB_SETITEMHEIGHT         = &H153&
Const CB_SETLOCALE             = &H159&
Const CB_SETTOPINDEX           = &H15c&
Const CB_SHOWDROPDOWN          = &H14F&

'editbox/richeditbox construction constants
Const ES_AUTOHSCROLL = &H80&
Const ES_AUTOVSCROLL = &H40&
Const ES_CENTER      = &H1&
Const ES_LEFT        = &H0&
Const ES_LOWERCASE   = &H10&
Const ES_MULTILINE   = &H4&
Const ES_NOHIDESEL   = &H100&
Const ES_OEMCONVERT  = &H400&
Const ES_PASSWORD    = &H20&
Const ES_READONLY    = &H800&
Const ES_RIGHT       = &H2&
Const ES_UPPERCASE   = &H8&
Const ES_WANTRETURN  = &H1000&

'listbox construction constants
Const LBS_DISABLENOSCROLL   = &H1000&
Const LBS_EXTENDEDSEL       = &H800&
Const LBS_HASSTRINGS        = &H40&
Const LBS_MULTICOLUMN       = &H200&
Const LBS_MULTIPLESEL       = &H8&
Const LBS_NODATA            = &H2000&
Const LBS_NOINTEGRALHEIGHT  = &H100&
Const LBS_NOREDRAW          = &H4&
Const LBS_NOTIFY            = &H1&
Const LBS_OWNERDRAWFIXED    = &H10&
Const LBS_OWNERDRAWVARIABLE = &H20&
Const LBS_SORT              = &H2&
Const LBS_STANDARD          = (LBS_NOTIFY Or LBS_SORT Or WS_VSCROLL Or WS_BORDER)
Const LBS_USETABSTOPS       = &H80&
Const LBS_WANTKEYBOARDINPUT = &H400&

'scrollbar construction constants
Const SBS_BOTTOMALIGN             = &H4&
Const SBS_HORZ                    = &H0&
Const SBS_LEFTALIGN               = &H2&
Const SBS_RIGHTALIGN              = &H4&
Const SBS_SIZEBOX                 = &H8&
Const SBS_SIZEBOXBOTTOMRIGHTALIGN = &H4&
Const SBS_SIZEBOXTOPLEFTALIGN     = &H2&
Const SBS_TOPALIGN                = &H2&
Const SBS_VERT                    = &H1&

'constants for AlignRects
Const CUDR_NORMAL             = &H0
Const CUDR_NOSNAPTOGRID       = &H1
Const CUDR_NORESOLVEPOSITIONS = &H2
Const CUDR_NOCLOSEGAPS        = &H4
Const CUDR_NEGATIVECOORDS     = &H8
Const CUDR_NOPRIMARY          = &H10

'uFileType's for DlgDirList
Const DDL_ARCHIVE   = &H20&
Const DDL_DIRECTORY = &H10&
Const DDL_DRIVES    = &H4000&
Const DDL_EXCLUSIVE = &H8000&
Const DDL_HIDDEN    = &H2&
Const DDL_POSTMSGS  = &H2000&
Const DDL_READONLY  = &H1&
Const DDL_READWRITE = &H0&
Const DDL_SYSTEM    = &H4&

'listbox messages
Const LB_ADDFILE             = &H196&
Const LB_ADDSTRING           = &H180&
Const LB_DELETESTRING        = &H182&
Const LB_DIR                 = &H18D&
Const LB_FINDSTRING          = &H18F&
Const LB_FINDSTRINGEXACT     = &H1A2&
Const LB_GETANCHORINDEX      = &H19D&
Const LB_GETCARETINDEX       = &H19F&
Const LB_GETCOUNT            = &H18B&
Const LB_GETCURSEL           = &H188&
Const LB_GETHORIZONTALEXTENT = &H193&
Const LB_GETITEMDATA         = &H199&
Const LB_GETITEMHEIGHT       = &H1A1&
Const LB_GETITEMRECT         = &H198&
Const LB_GETLOCALE           = &H1A6&
Const LB_GETSEL              = &H187&
Const LB_GETSELCOUNT         = &H190&
Const LB_GETSELITEMS         = &H191&
Const LB_GETTEXT             = &H189&
Const LB_GETTEXTLEN          = &H18A&
Const LB_GETTOPINDEX         = &H18E&
Const LB_INITSTORAGE         = &H1A8&
Const LB_INSERTSTRING        = &H181&
Const LB_ITEMFROMPOINT       = &H1A9&
Const LB_RESETCONTENT        = &H184&
Const LB_SELECTSTRING        = &H18C&
Const LB_SELITEMRANGE        = &H19B&
Const LB_SELITEMRANGEEX      = &H183&
Const LB_SETANCHORINDEX      = &H19C&
Const LB_SETCARETINDEX       = &H19E&
Const LB_SETCOLUMNWIDTH      = &H195&
Const LB_SETCOUNT            = &H1A7&
Const LB_SETCURSEL           = &H186&
Const LB_SETHORIZONTALEXTENT = &H194&
Const LB_SETITEMDATA         = &H19A&
Const LB_SETITEMHEIGHT       = &H1A0&
Const LB_SETLOCALE           = &H1A5&
Const LB_SETSEL              = &H185&
Const LB_SETTABSTOPS         = &H192&
Const LB_SETTOPINDEX         = &H197&

'listbox notifications
Const LBN_DBLCLK    = 2&
Const LBN_ERRSPACE  = -2&
Const LBN_KILLFOCUS = 5&
Const LBN_SELCANCEL = 3&
Const LBN_SELCHANGE = 1&
Const LBN_SETFOCUS  = 4&

'static control messages
Const STM_GETICON  = &H171&
Const STM_GETIMAGE = &H173&
Const STM_SETICON  = &H170&
Const STM_SETIMAGE = &H172&

'static control notifications
Const STN_CLICKED = 0&
Const STN_DBLCLK  = 1&
Const STN_DISABLE = 3&
Const STN_ENABLE  = 2&

'static control styles
Const SS_BITMAP          = &HE&
Const SS_BLACKFRAME      = &H7&
Const SS_BLACKRECT       = &H4&
Const SS_CENTER          = &H1&
Const SS_CENTERIMAGE     = &H200&
Const SS_ENDELLIPSIS     = &H4000&
Const SS_ENHMETAFILE     = &HF&
Const SS_ETCHEDFRAME     = &H12&
Const SS_ETCHEDHORZ      = &H10&
Const SS_ETCHEDVERT      = &H11&
Const SS_GRAYFRAME       = &H8&
Const SS_GRAYRECT        = &H5&
Const SS_ICON            = &H3&
Const SS_LEFT            = &H0&
Const SS_LEFTNOWORDWRAP  = &HC&
Const SS_NOPREFIX        = &H80
Const SS_NOTIFY          = &H100&
Const SS_PATHELLIPSIS    = &H8000&
Const SS_REALSIZECONTROL = &H40&
Const SS_REALSIZEIMAGE   = &H800&
Const SS_RIGHT           = &H2&
Const SS_RIGHTJUST       = &H400&
Const SS_SIMPLE          = &HB&
Const SS_SUNKEN          = &H1000&
Const SS_TYPEMASK        = &H1F&
Const SS_WHITEFRAME      = &H9&
Const SS_WHITERECT       = &H6&
Const SS_WORDELLIPSIS    = &HC000&

Const SS_USERITEM        = &HA&

'constants for GetScrollRange/SetScrollRange
Const SB_CTL  = 2&
Const SB_HORZ = 0&
Const SB_VERT = 1&

'consts for GetScrollInfo/SetScrollInfo
Const SIF_RANGE           = &H1&
Const SIF_PAGE            = &H2&
Const SIF_POS             = &H4&
Const SIF_TRACKPOS        = &H10&
Const SIF_DISABLENOSCROLL = &H8&
Const SIF_ALL             = (SIF_RANGE Or SIF_PAGE Or SIF_POS Or SIF_TRACKPOS)

'consts for the wparam of WM_HSCROLL and WM_VSCROLL
Const SB_LINEUP        = 0&
Const SB_LINEDOWN      = 1&
Const SB_LINELEFT      = 0&
Const SB_LINERIGHT     = 1&
Const SB_PAGEUP        = 2&
Const SB_PAGEDOWN      = 3&
Const SB_PAGELEFT      = 2&
Const SB_PAGERIGHT     = 3&
Const SB_THUMBPOSITION = 4&
Const SB_THUMBTRACK    = 5&
Const SB_ENDSCROLL     = 8&

'menu constants
Const MF_BYCOMMAND = &H0&
Const MF_BYPOSITION = &H400&

'consts for AppendMenu/InsertMenu
Const MF_BITMAP = &H4&
Const MF_CHECKED = &H8&
Const MF_DISABLED = &H2&
Const MF_ENABLED = &H0&
Const MF_GRAYED = &H1&
Const MF_MENUBARBREAK = &H20&
Const MF_MENUBREAK = &H40&
Const MF_OWNERDRAW = &H100&
Const MF_POPUP = &H10&
Const MF_SEPARATOR = &H800&
Const MF_STRING = &H0&
Const MF_UNCHECKED = &H0&

'not quite sure where these are used...
Const MF_DEFAULT = &H1000&
Const MF_HILITE = &H80&
Const MF_UNHILITE = &H0&

'some api calls use these flags instead...note that they are not all the same as the above
Const MFS_CHECKED As Long = MF_CHECKED
Const MFS_DEFAULT As Long = MF_DEFAULT
Const MFS_GRAYED = &H3&
Const MFS_DISABLED As Long = MFS_GRAYED
Const MFS_ENABLED As Long = MF_ENABLED
Const MFS_HILITE As Long = MF_HILITE
Const MFS_UNCHECKED As Long = MF_UNCHECKED
Const MFS_UNHILITE As Long = MF_UNHILITE

'constants for TrackPopupMenu/TrackPopupMenuEx
'for horizontal popup menus
Const TPM_CENTERALIGN = &H4&
Const TPM_LEFTALIGN = &H0&
Const TPM_RIGHTALIGN = &H8&

'for vertical popup menus
Const TPM_BOTTOMALIGN = &H20&
Const TPM_TOPALIGN = &H0&
Const TPM_VCENTERALIGN = &H10&

'for parentless popup menus
Const TPM_NONOTIFY = &H80&
Const TPM_RETURNCMD = &H100&

'to determine which mouse buttons can click a menu item
Const TPM_LEFTBUTTON = &H0& 'only left button
Const TPM_RIGHTBUTTON = &H2& 'either button

'win98 and above only: popup menu animation method
Const TPM_HORNEGANIMATION = &H800&
Const TPM_HORPOSANIMATION = &H400&
Const TPM_NOANIMATION = &H4000&
Const TPM_VERNEGANIMATION = &H2000&
Const TPM_VERPOSANIMATION = &H1000&

'TrackPopupMenuEx only
'win98 and above only: for displaying menus when another menu is already displayed...for context menus within menus
'  To use these, use TPM_RECURSE with TPM_HORIZONTAL or TPM_VERTICAL
Const TPM_RECURSE = &H1&
Const TPM_HORIZONTAL = &H0&
Const TPM_VERTICAL = &H40&

const MFT_BITMAP = 4
const MFT_MENUBARBREAK = 32
const MFT_MENUBREAK = 64
const MFT_OWNERDRAW = 256
const MFT_RADIOCHECK = 512
const MFT_RIGHTJUSTIFY = &h4000
const MFT_SEPARATOR = &h800
const MFT_RIGHTORDER = &h2000
const MFT_STRING = 0

'------------------
'| REQUIRED TYPES |
'------------------

Type NMHDR
  hwndFrom As Integer
  idFrom   As UInteger
  code     As UInteger
End Type


Type PAINTSTRUCT
  hDC                  As UInteger
  fErase               As Integer
  rcPaint              As RECT
  fRestore             As Integer
  fIncUpdate           As Integer
  rgbReserved(0 to 31) As Byte
End Type

Type MSG
  hwnd    As Integer
  message As Integer
  wParam  As Integer
  lParam  As Integer
  time    As Integer
  pt      As POINTAPI
End Type

Type WNDCLASS
  style         As Integer
  lpfnwndproc   As Integer
  cbClsextra    As Integer
  cbWndExtra    As Integer
  hInstance     As Integer
  hIcon         As Integer
  hCursor       As Integer
  hbrBackground As Integer
  lpszMenuName  As byte Ptr
  lpszClassName As byte Ptr
End Type

Type WNDCLASSEX
  cbSize        As Integer
  style         As Integer
  lpfnWndProc   As Integer
  cbClsExtra    As Integer
  cbWndExtra    As Integer
  hInstance     As Integer
  hIcon         As Integer
  hCursor       As Integer
  hbrBackground As Integer
  lpszMenuName  As byte ptr
  lpszClassName As byte ptr
  hIconSm       As Integer
End Type

'scrollbar types
Type SCROLLINFO
  cbSize    As Integer
  fMask     As Integer
  nMin      As Integer
  nMax      As Integer
  nPage     As Integer
  nPos      As Integer
  nTrackPos As Integer
End Type

Type SCROLLBARINFO Field = 1
  cbSize          As Integer
  rcScrollBar     As RECT
  dxyLineButton   As Integer
  xyThumbTop      As Integer
  xyThumbBottom   As Integer
  reserved        As Integer
  rgstate(0 To 5) As Integer
End Type

'button types
Type BUTTON_IMAGELIST Field = 1
'  HIMAGELIST himl ' not sure about this one...
  margin As RECT
  uAlign As UInteger
End Type

Type NMBCHOTITEM Field = 1
  hdr     As NMHDR
  dwFlags As Integer
End Type

Type ACCEL Field = 1
  fVirt As Byte 
  key   As Short
  cmd   As Short
End Type

Type DLGTEMPLATE Field = 1
  style           As Integer
  dwExtendedStyle As Integer
  cdit            As Short
  x               As Short
  y               As Short
  cx              As Short
  cy              As Short
End Type

Type ICONINFO
  fIcon    As Integer
  xHotspot As Integer
  yHotspot As Integer
  hbmMask  As Integer
  hbmColor As Integer
End Type

Type SECURITY_QUALITY_OF_SERVICE
  Length As Integer
  Impersonationlevel As Short
  ContextTrackingMode As Short
  EffectiveOnly As Integer
End Type

Type CONVCONTEXT
  cb         As Integer
  wFlags     As Integer
  wCountryID As Integer
  iCodePage  As Integer
  dwLangID   As Integer
  dwSecurity As Integer
  qos        As SECURITY_QUALITY_OF_SERVICE
End Type

Type PFLASHWINFO
  cbsize    As Integer
  hwnd      As Integer
  dwflags   As Integer
  uCount    As Integer
  dwTimeout As Integer
End Type

Type PALTTABINFO Field = 1
  cbSize    As Integer
  cItems    As Integer
  cColumns  As Integer
  cRows     As Integer
  iColFocus As Integer
  iRowFocus As Integer
  cxItem    As Integer
  cyItem    As Integer
  ptStart   As POINTAPI
End Type

Type CONVINFO Field = 1
  cb            As Integer
  hUser         As Integer
  hConvPartner  As Integer
  hszSvcPartner As Integer
  hszServiceReq As Integer
  hszTopic      As Integer
  hszItem       As Integer
  wFmt          As Integer
  wType         As Integer
  wStatus       As Integer
  wConvst       As Integer
  wLastError    As Integer
  hConvList     As Integer
  ConvCtxt      As CONVCONTEXT
  hwnd          As Integer
  hwndPartner   As Integer
End Type

Type CMENUINFO
  cbSize          As Integer
  fMask           As Integer
  dwStyle         As Integer
  cyMax           As Integer
  hbrBack         As Integer
  dwContextHelpID As Integer
  dwMenuData      As Integer
End Type

Type MENUITEMINFO
  cbSize        As Integer
  fMask         As Integer
  fType         As Integer
  fState        As Integer
  wID           As Integer
  hSubMenu      As Integer
  hbmpChecked   As Integer
  hbmpUnchecked As Integer
  dwItemData    As Integer
  dwTypeData    As byte ptr
  cch           As Integer
End Type 

Type MENUITEMTEMPLATE Field = 1
  mtOption As Short
  mtID As Short
  mtString As Byte
End Type

Type MENUITEMTEMPLATEHEADER Field = 1
  versionNumber As Short
  offset As Short
End Type

Type WINDOWPLACEMENT Field = 1
  Length           As Integer
  flags            As Integer
  showCmd          As Integer
  ptMinPosition    As POINTAPI
  ptMaxPosition    As POINTAPI
  rcNormalPosition As RECT
End Type

Type ACL Field = 1
  AclRevision As Byte
  Sbz1        As Byte
  AclSize     As Short
  AceCount    As Short
  Sbz2        As Short
End Type

Type SECURITY_DESCRIPTOR
  Revision As Byte
  Sbz1     As Byte
  Control  As Integer
  Owner    As Integer
  Group    As Integer
  Sacl     As ACL
  Dacl     As ACL
End Type

Type MSGBOXPARAMS
  cbSize             As Integer
  hwndOwner          As Integer
  hInstance          As Integer
  lpszText           As byte ptr
  lpszCaption        As byte ptr
  dwStyle            As Integer
  lpszIcon           As byte ptr
  dwContextHelpId    As Integer
  lpfnMsgBoxCallback As Integer
  dwLanguageId       As Integer
End Type 

Type DRAWTEXTPARAMS
  cbSize        As Integer
  iTabLength    As Integer
  iLeftMargin   As Integer
  iRightMargin  As Integer
  uiLengthDrawn As Integer
End Type

Type TPMPARAMS
  cbSize    As Integer
  rcExclude As RECT
End Type

Type PCOMBOBOXINFO
  cbSize      As Integer
  rcItem      As RECT
  rcButton    As RECT
  stateButton As Integer
  hwndCombo   As Integer
  hwndItem    As Integer
  hwndList    As Integer
End Type

Type PCURSORINFO
  cbSize      As Integer
  flags       As Integer
  hCursor     As Integer 'As HCURSOR???
  ptScreenPos As POINTAPI
End Type

Type PGUITHREADINFO
  cbSize        As Integer
  flags         As Integer
  hwndActive    As Integer
  hwndFocus     As Integer
  hwndCapture   As Integer
  hwndMenuOwner As Integer
  hwndMoveSize  As Integer
  hwndCaret     As Integer
  rcCaret       As RECT
End Type

'typedef struct tagMENUBARINFO
'{
'    DWORD cbSize;
'    RECT  rcBar;          // rect of bar, popup, item
'    HMENU hMenu;          // real menu handle of bar, popup
'    HWND  hwndMenu;       // hwnd of item submenu if one
'    BOOL  fBarFocused:1;  // bar, popup has the focus
'    BOOL  fFocused:1;     // item has the focus
'} MENUBARINFO, *PMENUBARINFO, *LPMENUBARINFO;

Type MONITORINFO
  cbSize    As Integer
  rcMonitor As RECT
  rcWork    As RECT
  dwFlags   As Integer
End Type

Type MOUSEMOVEPOINT
  x           As Integer
  y           As Integer
  time        As Integer
  dwExtraInfo As Integer
End Type

'typedef struct tagTITLEBARINFO
'{
'    DWORD cbSize;
'    RECT  rcTitleBar;
'    DWORD rgstate[CCHILDREN_TITLEBAR+1];
'} TITLEBARINFO, *PTITLEBARINFO, *LPTITLEBARINFO;

'typedef struct tagWINDOWINFO
'{
'    DWORD cbSize;
'    RECT  rcWindow;
'    RECT  rcClient;
'    DWORD dwStyle;
'    DWORD dwExStyle;
'    DWORD dwOtherStuff;
'    UINT  cxWindowBorders;
'    UINT  cyWindowBorders;
'    ATOM  atomWindowType;
'    WORD  wCreatorVersion;
'} WINDOWINFO, *PWINDOWINFO, *LPWINDOWINFO;

Type HELPINFO Field = 1
  cbSize       As Integer
  iContextType As Integer
  iCtrlId      As Integer
  hItemHandle  As Integer
  dwContextId  As Integer
  MousePos     As POINTAPI
End Type

'-----------------
'| API FUNCTIONS |
'-----------------

Declare Function ActivateKeyboardLayout Lib "user32" (ByVal HKL As Integer, ByVal Flags As Integer) As Integer
Declare Function AdjustWindowRect Lib "user32" (ByRef lpRect As RECT, ByVal dwStyle As Integer, ByVal bMenu As Integer) As Integer
Declare Function AdjustWindowRectEx Lib "user32" (ByRef lpRect As RECT, ByVal dsStyle As Integer, ByVal bMenu As Integer, ByVal dwEsStyle As Integer) As Integer
Declare Function AlignRects Lib "user32" (arc As RECT, cCount As Integer, iPrimary As Integer, dwFlags As Integer) As Integer
Declare Function AnimateWindow Lib "user32" (ByVal hwnd As Integer, ByVal dwTime As Integer, ByVal dwFlags As Integer) As Integer
Declare Function AnyPopup Lib "user32" () As Integer
Declare Function AppendMenu Lib "user32" Alias "AppendMenuA" (ByVal hMenu As Integer, ByVal wFlags As Integer, ByVal wIDNewItem As Integer, lpNewItem As Any) As Integer
Declare Function ArrangeIconicWindows Lib "user32" (ByVal hwnd As Integer) As Integer
Declare Function AttachThreadInput Lib "user32" (ByVal idAttach As Integer, ByVal idAttachTo As Integer, ByVal fAttach As Integer) As Integer
Declare Function BeginDeferWindowPos Lib "user32" (ByVal nNumWindows As Integer) As Integer
Declare Function BeginPaint Lib "user32" Alias "BeginPaint" (ByVal hwnd As Integer, lpPaint As PAINTSTRUCT) As Integer
Declare Function BlockInput Lib "user32" (ByVal fBlockIt As Integer) As Integer
Declare Function BringWindowToTop Lib "user32" (ByVal hwnd As Integer) As Integer
Declare Function BroadcastSystemMessage Lib "user32" (ByVal dw As Integer, ByRef pdw As Integer, ByVal un As Integer, ByVal wParam As Integer, ByVal lParam As Integer) As Integer
Declare Function CallMsgFilter Lib "user32" Alias "CallMsgFilterA" (ByRef lpMsg As msg, ByVal ncode As Integer) As Integer
Declare Function CallNextHookEx Lib "user32" (ByVal hHook As Integer, ByVal ncode As Integer, ByVal wParam As Integer, lParam As Any) As Integer
Declare Function CallWindowProc Lib "user32" Alias "CallWindowProcA" (ByVal lpPrevWndFunc As Integer, ByVal hwnd As Integer, ByVal msg As Integer, ByVal wParam As Integer, ByVal lParam As Integer) As Integer
Declare Function CascadeWindows Lib "user32" (ByVal hWndParent As Integer, ByVal wHow As Integer, byref lpRect As RECT, ByVal cKids As Integer, ByRef lpkids As Integer) As Short
Declare Function ChangeClipboardChain Lib "user32" (ByVal hwnd As Integer, ByVal hWndNext As Integer) As Integer
Declare Function ChangeDisplaySettings Lib "user32" Alias "ChangeDisplaySettingsA" (ByRef lpDevMode As DEVMODE, ByVal dwFlags As Integer) As Integer
Declare Function ChangeDisplaySettingsEx Lib "user32" Alias "ChangeDisplaySettingsExA" (ByVal lpszDeviceName As String, ByRef lpDevMode As DEVMODE, ByVal hwnd As Integer, ByVal dwflags As Integer, ByRef lParam As Any) As Integer
Declare Function ChangeMenu Lib "user32" Alias "ChangeMenuA" (ByVal hMenu As Integer, ByVal cmd As Integer, ByVal lpszNewItem As String, ByVal cmdInsert As Integer, ByVal flags As Integer) As Integer
Declare Function CharLower Lib "user32" Alias "CharLowerA" (ByVal lpsz As String) As byte ptr
Declare Function CharLowerBuff Lib "user32" Alias "CharLowerBuffA" (ByVal lpsz As String, ByVal cchLength As Integer) As Integer
Declare Function CharNext Lib "user32" Alias "CharNextA" (ByVal lpsz As String) As byte ptr
Declare Function CharNextEx Lib "user32" Alias "CharNextExA" (ByVal CodePage As Short, ByVal lpCurrentChar As String, ByVal dwFlags As Integer) As Integer
Declare Function CharPrev Lib "user32" Alias "CharPrevA" (ByVal lpszStart As String, ByVal lpszCurrent As String) As byte ptr
Declare Function CharPrevEx Lib "user32" Alias "CharPrevExA" (ByVal CodePage As Short, ByVal lpStart As String, ByVal lpCurrentChar As String, ByVal dwFlags As Integer) As Integer
Declare Function CharToOem Lib "user32" Alias "CharToOemA" (ByVal lpszSrc As String, ByVal lpszDst As String) As Integer
Declare Function CharToOemBuff Lib "user32" Alias "CharToOemBuffA" (ByVal lpszSrc As String, ByVal lpszDst As String, ByVal cchDstLength As Integer) As Integer
Declare Function CharUpper Lib "user32" Alias "CharUpperA" (ByVal lpsz As String) As byte ptr
Declare Function CharUpperBuff Lib "user32" Alias "CharUpperBuffA" (ByVal lpsz As String, ByVal cchLength As Integer) As Integer
Declare Function CheckDlgButton Lib "user32" Alias "CheckDlgButtonA" (ByVal hDlg As Integer, ByVal nIDButton As Integer, ByVal wCheck As Integer) As Integer
Declare Function CheckMenuItem Lib "user32" (ByVal hMenu As Integer, ByVal wIDCheckItem As Integer, ByVal wCheck As Integer) As Integer
Declare Function CheckMenuRadioItem Lib "user32" (ByVal hMenu As Integer, ByVal un1 As Integer, ByVal un2 As Integer, ByVal un3 As Integer, ByVal un4 As Integer) As Integer
Declare Function CheckRadioButton Lib "user32" (ByVal hDlg As Integer, ByVal nIDFirstButton As Integer, ByVal nIDLastButton As Integer, ByVal nIDCheckButton As Integer) As Integer
Declare Function ChildWindowFromPoint Lib "user32" (ByVal hWndParent As Integer, Byref pt As POINTAPI) As Integer
Declare Function ChildWindowFromPointEx Lib "user32" (ByVal hWnd As Integer, Byref pt As POINTAPI, ByVal un As Integer) As Integer
Declare Function ClientToScreen Lib "user32" (ByVal hwnd As Integer, ByRef lpPoint As POINTAPI) As Integer
Declare Function ClipCursor Lib "user32" (ByRef lpRect As Any) As Integer
Declare Function CloseClipboard Lib "user32" () As Integer
Declare Function CloseDesktop Lib "user32" (ByVal hDesktop As Integer) As Integer
Declare Function CloseWindow Lib "user32" (ByVal hwnd As Integer) As Integer
Declare Function CloseWindowStation Lib "user32" (ByVal hWinSta As Integer) As Integer
Declare Function CopyAcceleratorTable Lib "user32" Alias "CopyAcceleratorTableA" (ByVal hAccelSrc As Integer, ByRef lpAccelDst As ACCEL, ByVal cAccelEntries As Integer) As Integer
Declare Function CopyCursor Lib "user32" (ByVal hcur As Integer) As Integer
Declare Function CopyIcon Lib "user32" (ByVal hIcon As Integer) As Integer
Declare Function CopyImage Lib "user32" (ByVal handle As Integer, ByVal un1 As Integer, ByVal n1 As Integer, ByVal n2 As Integer, ByVal un2 As Integer) As Integer
Declare Function CopyRect Lib "user32" (ByRef lpDestRect As RECT, ByRef lpSourceRect As RECT) As Integer
Declare Function CountClipboardFormats Lib "user32" () As Integer
Declare Function CreateAcceleratorTable Lib "user32" Alias "CreateAcceleratorTableA" (ByRef lpaccl As ACCEL, ByVal cEntries As Integer) As Integer
Declare Function CreateCaret Lib "user32" (ByVal hwnd As Integer, ByVal hBitmap As Integer, ByVal nWidth As Integer, ByVal nHeight As Integer) As Integer
Declare Function CreateCursor Lib "user32" (ByVal hInstance As Integer, ByVal nXhotspot As Integer, ByVal nYhotspot As Integer, ByVal nWidth As Integer, ByVal nHeight As Integer, ByRef lpANDbitPlane As Any, ByRef lpXORbitPlane As Any) As Integer
Declare Function CreateDesktop Lib "user32" Alias "CreateDesktopA" (ByVal lpszDesktop As String, ByVal lpszDevice As String, ByRef pDevmode As DEVMODE, ByVal dwFlags As Integer, ByVal dwDesiredAccess As Integer, ByRef lpsa As SECURITY_ATTRIBUTES) As Integer
Declare Function CreateDialogIndirectParam Lib "user32" Alias "CreateDialogIndirectParamA" (ByVal hInstance As Integer, ByRef lpTemplate As DLGTEMPLATE, ByVal hWndParent As Integer, ByVal lpDialogFunc As Integer, ByVal dwInitParam As Integer) As Integer
Declare Function CreateDialogParam Lib "user32" Alias "CreateDialogParamA" (ByVal hInstance As Integer, ByVal lpName As String, ByVal hWndParent As Integer, ByVal lpDialogFunc As Integer, ByVal lParamInit As Integer) As Integer
Declare Function CreateIcon Lib "user32" (ByVal hInstance As Integer, ByVal nWidth As Integer, ByVal nHeight As Integer, ByVal nPlanes As Byte, ByVal nBitsPixel As Byte, ByRef lpANDbits As Byte, ByRef lpXORbits As Byte) As Integer
Declare Function CreateIconFromResource Lib "user32" (ByRef presbits As Byte, ByVal dwResSize As Integer, ByVal fIcon As Integer, ByVal dwVer As Integer) As Integer
Declare Function CreateIconFromResourceEx Lib "user32" (ByVal presbits As String, ByVal dwResSize As Integer, ByVal fIcon As Integer, ByVal dwVer As Integer, ByVal cxDesired As Integer, ByVal cyDesired As Integer, ByVal Flags As Integer) As Integer
Declare Function CreateIconIndirect Lib "user32" (ByRef piconinfo As ICONINFO) As Integer
Declare Function CreateMDIWindow Lib "user32" Alias "CreateMDIWindowA" (ByVal lpClassName As String, ByVal lpWindowName As String, ByVal dwStyle As Integer, ByVal x As Integer, ByVal y As Integer, ByVal nWidth As Integer, ByVal nHeight As Integer, ByVal hWndParent As Integer, ByVal hInstance As Integer, ByVal lParam As Integer) As Integer
Declare Function CreateMenu Lib "user32" () As Integer
Declare Function CreatePopupMenu Lib "user32" () As Integer
Declare Function CreateWindowEx Lib "user32" Alias "CreateWindowExA" (ByVal dwExStyle As Integer, ByVal lpClassName As String, ByVal lpWindowName As String, ByVal dwStyle As Integer, ByVal x As Integer, ByVal y As Integer, ByVal nWidth As Integer, ByVal nHeight As Integer, ByVal hWndParent As Integer, ByVal hMenu As Integer, ByVal hInstance As Integer, lpParam as Any) As Integer
Declare Function CreateWindowStation Lib "user32" Alias "CreateWindowStationA" (ByVal lpwinsta As String, ByVal dwReserved As Integer, ByVal dwDesiredAccess As Integer, ByRef lpsa As SECURITY_ATTRIBUTES) As Integer
Declare Function DdeAbandonTransaction Lib "user32" (ByVal idInst As Integer, ByVal hConv As Integer, ByVal idTransaction As Integer) As Integer
Declare Function DdeAccessData Lib "user32" (ByVal hData As Integer, ByRef pcbDataSize As Integer) As Integer
Declare Function DdeAddData Lib "user32" (ByVal hData As Integer, ByRef pSrc As Byte, ByVal cb As Integer, ByVal cbOff As Integer) As Integer
Declare Function DdeClientTransaction Lib "user32" (ByRef pData As Byte, ByVal cbData As Integer, ByVal hConv As Integer, ByVal hszItem As Integer, ByVal wFmt As Integer, ByVal wType As Integer, ByVal dwTimeout As Integer, ByRef pdwResult As Integer) As Integer
Declare Function DdeCmpStringHandles Lib "user32" (ByVal hsz1 As Integer, ByVal hsz2 As Integer) As Integer
Declare Function DdeConnect Lib "user32" (ByVal idInst As Integer, ByVal hszService As Integer, ByVal hszTopic As Integer, ByRef pCC As CONVCONTEXT) As Integer
Declare Function DdeConnectList Lib "user32" (ByVal idInst As Integer, ByVal hszService As Integer, ByVal hszTopic As Integer, ByVal hConvList As Integer, ByRef pCC As CONVCONTEXT) As Integer
Declare Function DdeCreateDataHandle Lib "user32" (ByVal idInst As Integer, ByRef pSrc As Byte, ByVal cb As Integer, ByVal cbOff As Integer, ByVal hszItem As Integer, ByVal wFmt As Integer, ByVal afCmd As Integer) As Integer
Declare Function DdeCreateStringHandle Lib "user32" Alias "DdeCreateStringHandleA" (ByVal idInst As Integer, ByVal psz As String, ByVal iCodePage As Integer) As Integer
Declare Function DdeDisconnect Lib "user32" (ByVal hConv As Integer) As Integer
Declare Function DdeDisconnectList Lib "user32" (ByVal hConvList As Integer) As Integer
Declare Function DdeEnableCallback Lib "user32" (ByVal idInst As Integer, ByVal hConv As Integer, ByVal wCmd As Integer) As Integer
Declare Function DdeFreeDataHandle Lib "user32" (ByVal hData As Integer) As Integer
Declare Function DdeFreeStringHandle Lib "user32" (ByVal idInst As Integer, ByVal hsz As Integer) As Integer
Declare Function DdeGetData Lib "user32" (ByVal hData As Integer, ByRef pDst As Byte, ByVal cbMax As Integer, ByVal cbOff As Integer) As Integer
Declare Function DdeGetLastError Lib "user32" (ByVal idInst As Integer) As Integer
Declare Function DdeImpersonateClient Lib "user32" (ByVal hConv As Integer) As Integer
Declare Function DdeInitialize Lib "user32" Alias "DdeInitializeA" (ByRef pidInst As Integer, ByVal pfnCallback As Integer, ByVal afCmd As Integer, ByVal ulRes As Integer) As Short
Declare Function DdeKeepStringHandle Lib "user32" (ByVal idInst As Integer, ByVal hsz As Integer) As Integer
Declare Function DdeNameService Lib "user32" (ByVal idInst As Integer, ByVal hsz1 As Integer, ByVal hsz2 As Integer, ByVal afCmd As Integer) As Integer
Declare Function DdePostAdvise Lib "user32" (ByVal idInst As Integer, ByVal hszTopic As Integer, ByVal hszItem As Integer) As Integer
Declare Function DdeQueryConvInfo Lib "user32" (ByVal hConv As Integer, ByVal idTransaction As Integer, ByRef pConvInfo As CONVINFO) As Integer
Declare Function DdeQueryNextServer Lib "user32" (ByVal hConvList As Integer, ByVal hConvPrev As Integer) As Integer
Declare Function DdeQueryString Lib "user32" Alias "DdeQueryStringA" (ByVal idInst As Integer, ByVal hsz As Integer, ByVal psz As String, ByVal cchMax As Integer, ByVal iCodePage As Integer) As Integer
Declare Function DdeReconnect Lib "user32" (ByVal hConv As Integer) As Integer
Declare Function DdeSetQualityOfService Lib "user32" (ByVal hWndClient As Integer, ByRef pqosNew As SECURITY_QUALITY_OF_SERVICE, ByRef pqosPrev As SECURITY_QUALITY_OF_SERVICE) As Integer
Declare Function DdeSetUserHandle Lib "user32" (ByVal hConv As Integer, ByVal id As Integer, ByVal hUser As Integer) As Integer
Declare Function DdeUnaccessData Lib "user32" (ByVal hData As Integer) As Integer
Declare Function DdeUninitialize Lib "user32" (ByVal idInst As Integer) As Integer
Declare Function DefDlgProc Lib "user32" Alias "DefDlgProcA" (ByVal hDlg As Integer, ByVal wMsg As Integer, ByVal wParam As Integer, ByVal lParam As Integer) As Integer
Declare Function DefFrameProc Lib "user32" Alias "DefFrameProcA" (ByVal hwnd As Integer, ByVal hWndMDIClient As Integer, ByVal wMsg As Integer, ByVal wParam As Integer, ByVal lParam As Integer) As Integer
Declare Function DefMDIChildProc Lib "user32" Alias "DefMDIChildProcA" (ByVal hwnd As Integer, ByVal wMsg As Integer, ByVal wParam As Integer, ByVal lParam As Integer) As Integer
Declare Function DefWindowProc lib "user32" Alias "DefWindowProcA" (ByVal hwnd As Integer, ByVal wMsg As Integer, ByVal wParam As Integer, ByVal lParam As Integer) As Integer
Declare Function DeferWindowPos Lib "user32" (ByVal hWinPosInfo As Integer, ByVal hwnd As Integer, ByVal hWndInsertAfter As Integer, ByVal x As Integer, ByVal y As Integer, ByVal cx As Integer, ByVal cy As Integer, ByVal wFlags As Integer) As Integer
Declare Function DeleteMenu Lib "user32" (ByVal hMenu As Integer, ByVal nPosition As Integer, ByVal wFlags As Integer) As Integer
Declare Function DestroyAcceleratorTable Lib "user32" (ByVal haccel As Integer) As Integer
Declare Function DestroyCaret Lib "user32" () As Integer
Declare Function DestroyCursor Lib "user32" (ByVal hCursor As Integer) As Integer
Declare Function DestroyIcon Lib "user32" (ByVal hIcon As Integer) As Integer
Declare Function DestroyMenu Lib "user32" (ByVal hMenu As Integer) As Integer
Declare Function DestroyWindow Lib "user32" (ByVal hwnd As Integer) As Integer
Declare Function DialogBoxIndirectParam Lib "user32" Alias "DialogBoxIndirectParamA" (ByVal hInstance As Integer, ByRef hDialogTemplate As DLGTEMPLATE, ByVal hWndParent As Integer, ByVal lpDialogFunc As Integer, ByVal dwInitParam As Integer) As Integer
Declare Sub DialogBoxParam Lib "user32" Alias "DialogBoxParamA" (ByVal hInstance As Integer, ByVal lpTemplateName As String, ByVal hWndParent As Integer, ByVal lpDialogFunc As Integer, ByVal dwInitParam As Integer)
Declare Function DispatchMessage Lib "user32" Alias "DispatchMessageA" (lpMsg As MSG) As Integer
Declare Function DlgDirList Lib "user32" Alias "DlgDirListA" (ByVal hDlg As Integer, ByVal lpPathSpec As String, ByVal nIDListBox As Integer, ByVal nIDStaticPath As Integer, ByVal wFileType As Integer) As Integer
Declare Function DlgDirListComboBox Lib "user32" Alias "DlgDirListComboBoxA" (ByVal hDlg As Integer, ByVal lpPathSpec As String, ByVal nIDComboBox As Integer, ByVal nIDStaticPath As Integer, ByVal wFileType As Integer) As Integer
Declare Function DlgDirSelectComboBoxEx Lib "user32" Alias "DlgDirSelectComboBoxExA" (ByVal hWndDlg As Integer, ByVal lpszPath As String, ByVal cbPath As Integer, ByVal idComboBox As Integer) As Integer
Declare Function DlgDirSelectEx Lib "user32" Alias "DlgDirSelectExA" (ByVal hWndDlg As Integer, ByVal lpszPath As String, ByVal cbPath As Integer, ByVal idListBox As Integer) As Integer
Declare Function DragDetect Lib "user32" (ByVal hWnd As Integer, Byref pt As POINTAPI) As Integer
Declare Function DragObject Lib "user32" (ByVal hWnd1 As Integer, ByVal hWnd2 As Integer, ByVal un As Integer, ByVal dw As Integer, ByVal hCursor As Integer) As Integer
Declare Function DrawAnimatedRects Lib "user32" (ByVal hwnd As Integer, ByVal idAni As Integer, ByRef lprcFrom As RECT, ByRef lprcTo As RECT) As Integer
Declare Function DrawCaption Lib "user32" (ByVal hWnd As Integer, ByVal hDC As Integer, ByRef pcRect As Rect, ByVal un As Integer) As Integer
Declare Function DrawEdge Lib "user32" (ByVal hdc As Integer, ByRef qrc As RECT, ByVal edge As Integer, ByVal grfFlags As Integer) As Integer
Declare Function DrawFocusRect Lib "user32" (ByVal hdc As Integer, ByRef lpRect As RECT) As Integer
Declare Function DrawFrameControl Lib "user32" (ByVal hDC As Integer, ByRef lpRect As RECT, ByVal un1 As Integer, ByVal un2 As Integer) As Integer
Declare Function DrawIcon Lib "user32" (ByVal hdc As Integer, ByVal x As Integer, ByVal y As Integer, ByVal hIcon As Integer) As Integer
Declare Function DrawIconEx Lib "user32" (ByVal hdc As Integer, ByVal xLeft As Integer, ByVal yTop As Integer, ByVal hIcon As Integer, ByVal cxWidth As Integer, ByVal cyWidth As Integer, ByVal istepIfAniCur As Integer, ByVal hbrFlickerFreeDraw As Integer, ByVal diFlags As Integer) As Integer
Declare Function DrawMenuBar Lib "user32" (ByVal hwnd As Integer) As Integer
Declare Function DrawState Lib "user32" Alias "DrawStateA" (ByVal hDC As Integer, ByVal hBrush As Integer, ByVal lpDrawStateProc As Integer, ByVal lParam As Integer, ByVal wParam As Integer, ByVal n1 As Integer, ByVal n2 As Integer, ByVal n3 As Integer, ByVal n4 As Integer, ByVal un As Integer) As Integer
Declare Function DrawText Lib "user32" Alias "DrawTextA" (ByVal hdc As Integer, ByVal lpStr As String, ByVal nCount As Integer, lpRect As RECT, ByVal wFormat As Integer) As Integer
Declare Function DrawTextEx Lib "user32" Alias "DrawTextExA" (ByVal hDC As Integer, ByVal lpsz As String, ByVal n As Integer, ByRef lpRect As RECT, ByVal un As Integer, ByRef lpDrawTextParams As DRAWTEXTPARAMS) As Integer
Declare Function EmptyClipboard Lib "user32" () As Integer
Declare Function EnableMenuItem Lib "user32" (ByVal hMenu As Integer, ByVal wIDEnableItem As Integer, ByVal wEnable As Integer) As Integer
Declare Function EnableScrollBar Lib "user32" (ByVal hwnd As Integer, ByVal wSBflags As Integer, ByVal wArrows As Integer) As Integer
Declare Function EnableWindow Lib "user32" (ByVal hwnd As Integer, ByVal fEnable As Integer) As Integer
Declare Function EndDeferWindowPos Lib "user32" (ByVal hWinPosInfo As Integer) As Integer
Declare Function EndDialog Lib "user32" (ByVal hDlg As Integer, ByVal nResult As Integer) As Integer
Declare Function EndMenu Lib "user32" () As Integer
Declare Function EndPaint Lib "user32" Alias "EndPaint" (ByVal hwnd As Integer, lpPaint As PAINTSTRUCT) As Integer
Declare Function EnumChildWindows Lib "user32" (ByVal hWndParent As Integer, ByVal lpEnumFunc As Integer, ByVal lParam As Integer) As Integer
Declare Function EnumClipboardFormats Lib "user32" (ByVal wFormat As Integer) As Integer
Declare Function EnumDesktops Lib "user32" Alias "EnumDesktopsA" (ByVal hwinsta As Integer, ByVal lpEnumFunc As Integer, ByVal lParam As Integer) As Integer
Declare Function EnumDesktopWindows Lib "user32" (ByVal hDesktop As Integer, ByVal lpfn As Integer, ByVal lParam As Integer) As Integer
Declare Function EnumDisplaySettings Lib "user32" Alias "EnumDisplaySettingsA" (ByVal lpszDeviceName As String, ByVal iModeNum As Integer, ByRef lpDevMode As DEVMODE) As Integer
Declare Function EnumDisplaySettingsEx Lib "user32" (ByVal lpszDeviceName As String, ByVal iModeNum As Integer, ByRef lpDevMode As DEVMODE, ByVal dwFlags As Integer) As Integer
Declare Function EnumProps Lib "user32" Alias "EnumPropsA" (ByVal hWnd As Integer, ByVal lpEnumFunc As Integer) As Integer
Declare Function EnumPropsEx Lib "user32" Alias "EnumPropsExA" (ByVal hWnd As Integer, ByVal lpEnumFunc As Integer, ByVal lParam As Integer) As Integer
Declare Function EnumThreadWindows Lib "user32" (ByVal dwThreadId As Integer, ByVal lpfn As Integer, ByVal lParam As Integer) As Integer
Declare Function EnumWindows Lib "user32" (ByVal lpEnumFunc As Integer, ByVal lParam As Integer) As Integer
Declare Function EnumWindowStations Lib "user32" Alias "EnumWindowStationsA" (ByVal lpEnumFunc As Integer, ByVal lParam As Integer) As Integer
Declare Function EqualRect Lib "user32" (ByRef lpRect1 As RECT, ByRef lpRect2 As RECT) As Integer
Declare Function ExcludeUpdateRgn Lib "user32" (ByVal hdc As Integer, ByVal hwnd As Integer) As Integer
Declare Function ExitWindows Lib "user32" (ByVal dwReserved As Integer, ByVal uReturnCode As Integer) As Integer
Declare Function ExitWindowsEx Lib "user32" (ByVal uFlags As Integer, ByVal dwReserved As Integer) As Integer
Declare Function FillRect Lib "user32" (ByVal hdc As Integer, ByRef lpRect As RECT, ByVal hBrush As Integer) As Integer
Declare Function FindWindow Lib "user32" Alias "FindWindowA" (ByVal lpClassName As String, ByVal lpWindowName As String) As Integer
Declare Function FindWindowEx Lib "user32" Alias "FindWindowExA" (ByVal hWnd1 As Integer, ByVal hWnd2 As Integer, ByVal lpsz1 As String, ByVal lpsz2 As String) As Integer
Declare Function FlashWindow Lib "user32" (ByVal hwnd As Integer, ByVal bInvert As Integer) As Integer
Declare Function FlashWindowEx Lib "user32" (ByRef pfwi As PFLASHWINFO ) As Integer
Declare Function FrameRect Lib "user32" (ByVal hdc As Integer, ByRef lpRect As RECT, ByVal hBrush As Integer) As Integer
Declare Function FreeDDElParam Lib "user32" (ByVal msg As Integer, ByVal lParam As Integer) As Integer
Declare Function GetActiveWindow Lib "user32" Alias "GetActiveWindow" ( ) As Integer
Declare Function GetAltTabInfo Lib "user32" (ByVal hwnd As Integer, ByVal iItem As Integer, ByRef pati As PALTTABINFO, ByVal pszItemText As String, ByVal cchItemText As Integer) As Integer
Declare Function GetAncestor Lib "user32" (ByVal hwnd As Integer, ByVal gaFlags As Integer) As Integer
Declare Function GetAsyncKeyState Lib "user32" (ByVal vKey As Integer) As Short
Declare Function GetCapture Lib "user32" () As Integer
Declare Function GetCaretBlinkTime Lib "user32" () As Integer
Declare Function GetCaretPos Lib "user32" (ByRef lpPoint As POINTAPI) As Integer
Declare Function GetClassInfo Lib "user32" Alias "GetClassInfoA" (ByVal hInstance As Integer, ByVal lpClassName As String, ByRef lpWndClass As WNDCLASS) As Integer
Declare Function GetClassInfoEx Lib "user32" Alias "GetClassInfoExA" (ByVal hinstance As Integer, ByVal lpcstr As String, ByRef lpwndclassexa As WNDCLASSEX) As Integer
Declare Function GetClassLong Lib "user32" Alias "GetClassLongA" (ByVal hwnd As Integer, ByVal nIndex As Integer) As Integer
Declare Function GetClassName Lib "user32" Alias "GetClassNameA" (ByVal hwnd As Integer, ByVal lpClassName As String, ByVal nMaxCount As Integer) As Integer
Declare Function GetClassWord Lib "user32" (ByVal hwnd As Integer, ByVal nIndex As Integer) As Integer
Declare Function GetClientRect lib "user32" Alias "GetClientRect" (ByVal hwnd As Integer, lpRect as RECT) As Integer
Declare Function GetClipboardData Lib "user32" (ByVal wFormat As Integer) As Integer
Declare Function GetClipboardFormatName Lib "user32" Alias "GetClipboardFormatNameA" (ByVal wFormat As Integer, ByVal lpString As String, ByVal nMaxCount As Integer) As Integer
Declare Function GetClipboardOwner Lib "user32" () As Integer
Declare Function GetClipboardSequenceNumber Lib "user32" () As Integer
Declare Function GetClipboardViewer Lib "user32" () As Integer
Declare Function GetClipCursor Lib "user32" (ByRef lprc As RECT) As Integer
Declare Function GetComboBoxInfo Lib "user32" (ByVal hwndCombo As Integer, ByRef pcbi As PCOMBOBOXINFO) As Integer
Declare Function GetCursor Lib "user32" () As Integer
Declare Function GetCursorInfo Lib "user32" (ByRef pci As PCURSORINFO) As Integer
Declare Function GetCursorPos Lib "user32" (ByRef lpPoint As POINTAPI) As Integer
Declare Function GetDC Lib "user32" (ByVal hWnd As Integer) As Integer
Declare Function GetDCEx Lib "user32" (ByVal hwnd As Integer, ByVal hrgnclip As Integer, ByVal fdwOptions As Integer) As Integer
Declare Function GetDesktopWindow Lib "user32" () As Integer
Declare Function GetDialogBaseUnits Lib "user32" () As Integer
Declare Function GetDlgCtrlID Lib "user32" (ByVal hwnd As Integer) As Integer
Declare Function GetDlgItem Lib "user32" (ByVal hDlg As Integer, ByVal nIDDlgItem As Integer) As Integer
Declare Function GetDlgItemInt Lib "user32" (ByVal hDlg As Integer, ByVal nIDDlgItem As Integer, ByVal lpTranslated As Integer, ByVal bSigned As Integer) As Integer
Declare Function GetDlgItemText Lib "user32" Alias "GetDlgItemTextA" (ByVal hDlg As Integer, ByVal nIDDlgItem As Integer, ByVal lpString As String, ByVal nMaxCount As Integer) As Integer
Declare Function GetDoubleClickTime Lib "user32" () As Integer
Declare Function GetFocus Lib "user32" Alias "GetFocus" () As Integer
Declare Function GetForegroundWindow Lib "user32" () As Integer
Declare Function GetGuiResources Lib "user32" (ByVal hProcess As Integer, ByVal uiFlags As Integer) As Integer
Declare Function GetGUIThreadInfo Lib "user32" (ByVal idThread As Integer, ByRef pgui As PGUITHREADINFO) As Integer
Declare Function GetIconInfo Lib "user32" (ByVal hIcon As Integer, ByRef piconinfo As ICONINFO) As Integer
Declare Function GetInputState Lib "user32" () As Integer
Declare Function GetKBCodePage Lib "user32" () As Integer
Declare Function GetKeyboardLayout Lib "user32" (ByVal dwLayout As Integer) As Integer
Declare Function GetKeyboardLayoutList Lib "user32" (ByVal nBuff As Integer, ByRef lpList As Integer) As Integer
Declare Function GetKeyboardLayoutName Lib "user32" Alias "GetKeyboardLayoutNameA" (ByVal pwszKLID As String) As Integer
Declare Function GetKeyboardState Lib "user32" (ByRef pbKeyState As Byte) As Integer
Declare Function GetKeyboardType Lib "user32" (ByVal nTypeFlag As Integer) As Integer
Declare Function GetKeyNameText Lib "user32" Alias "GetKeyNameTextA" (ByVal lParam As Integer, ByVal lpBuffer As String, ByVal nSize As Integer) As Integer
Declare Function GetKeyState Lib "user32" (ByVal vKey As Integer) As Short
Declare Function GetLastActivePopup Lib "user32" (ByVal hwndOwnder As Integer) As Integer
Declare Function GetListBoxInfo Lib "user32" (ByVal hwnd As Integer) As Integer
Declare Function GetMenu Lib "user32" (ByVal hwnd As Integer) As Integer
Declare Function GetMenuCheckMarkDimensions Lib "user32" () As Integer
Declare Function GetMenuContextHelpId Lib "user32" (ByVal hMenu As Integer) As Integer
Declare Function GetMenuDefaultItem Lib "user32" (ByVal hMenu As Integer, ByVal fByPos As Integer, ByVal gmdiFlags As Integer) As Integer
Declare Function GetMenuInfo Lib "user32" (ByVal hmenu As Integer, ByRef LPMENUINFO As CMENUINFO) As Integer 'MENUINFO renamed to CMENUINFO
Declare Function GetMenuItemCount Lib "user32" (ByVal hMenu As Integer) As Integer
Declare Function GetMenuItemID Lib "user32" (ByVal hMenu As Integer, ByVal nPos As Integer) As Integer
Declare Function GetMenuItemInfo Lib "user32" Alias "GetMenuItemInfoA" (ByVal hMenu As Integer, ByVal un As Integer, ByVal b As Short, ByRef lpMenuItemInfo As MENUITEMINFO) As Integer
Declare Function GetMenuItemRect Lib "user32" (ByVal hWnd As Integer, ByVal hMenu As Integer, ByVal uItem As Integer,  ByRef lprcItem As RECT) As Integer
Declare Function GetMenuState Lib "user32" (ByVal hMenu As Integer, ByVal wID As Integer, ByVal wFlags As Integer) As Integer
Declare Function GetMenuString Lib "user32" Alias "GetMenuStringA" (ByVal hMenu As Integer, ByVal wIDItem As Integer, ByVal lpString As String, ByVal nMaxCount As Integer, ByVal wFlag As Integer) As Integer
Declare Function GetMessage lib "user32" Alias "GetMessageA" (lpMsg as MSG, ByVal hwnd As Integer, ByVal wMsgFilterMin As Integer, ByVal wMsgFilterMax As Integer) As Integer
Declare Function GetMessageExtraInfo Lib "user32" () As Integer
Declare Function GetMessagePos Lib "user32" () As Integer
Declare Function GetMessageTime Lib "user32" () As Integer
Declare Function GetMonitorInfo Lib "user32" Alias "GetMonitorInfoA" (ByRef hMonitor As Integer, ByRef lpmi As MONITORINFO) As Integer
Declare Function GetMouseMovePointsEx Lib "user32" (ByVal cbSize As Integer, ByRef lppt As MOUSEMOVEPOINT, ByRef lpptBuf As MOUSEMOVEPOINT, ByVal nBufPoints As Integer, ByVal resolution As Integer) As Integer
Declare Function GetNextDlgGroupItem Lib "user32" (ByVal hDlg As Integer, ByVal hCtl As Integer, ByVal bPrevious As Integer) As Integer
Declare Function GetNextDlgTabItem Lib "user32" (ByVal hDlg As Integer, ByVal hCtl As Integer, ByVal bPrevious As Integer) As Integer
Declare Function GetNextWindow Lib "user32" Alias "GetWindow" (ByVal hwnd As Integer, ByVal wFlag As Integer) As Integer
Declare Function GetOpenClipboardWindow Lib "user32" () As Integer
Declare Function GetParent Lib "user32" (ByVal hwnd As Integer) As Integer
Declare Function GetPriorityClipboardFormat Lib "user32" (ByRef lpPriorityList As Integer, ByVal nCount As Integer) As Integer
Declare Function GetProcessDefaultLayout Lib "user32" (ByRef pdwDefaultLayout As Integer) As Integer
Declare Function GetProcessWindowStation Lib "user32" () As Integer
Declare Function GetProp Lib "user32" Alias "GetPropA" (ByVal hwnd As Integer, ByVal lpString As String) As Integer
Declare Function GetQueueStatus Lib "user32" (ByVal fuFlags As Integer) As Integer
Declare Function GetScrollInfo Lib "user32" (ByVal hWnd As Integer, ByVal fnBar As Integer, ByRef lpScrollInfo As SCROLLINFO) As Integer
Declare Function GetScrollPos Lib "user32" (ByVal hwnd As Integer, ByVal nBar As Integer) As Integer
Declare Function GetScrollRange Lib "user32" (ByVal hwnd As Integer, ByVal nBar As Integer, ByRef lpMinPos As Integer, ByRef lpMaxPos As Integer) As Integer
Declare Function GetSubMenu Lib "user32" (ByVal hMenu As Integer, ByVal nPos As Integer) As Integer
Declare Function GetSysColor Lib "user32" (ByVal nIndex As Integer) As Integer
Declare Function GetSysColorBrush Lib "user32" (ByVal nIndex As Integer) As Integer
Declare Function GetSystemMenu Lib "user32" (ByVal hwnd As Integer, ByVal bRevert As Integer) As Integer
Declare Function GetSystemMetrics Lib "user32" (ByVal nIndex As Integer) As Integer
Declare Function GetTabbedTextExtent Lib "user32" Alias "GetTabbedTextExtentA" (ByVal hdc As Integer, ByVal lpString As String, ByVal nCount As Integer, ByVal nTabPositions As Integer, ByRef lpnTabStopPositions As Integer) As Integer
Declare Function GetThreadDesktop Lib "user32" (ByVal dwThread As Integer) As Integer
Declare Function GetTopWindow Lib "user32" (ByVal hwnd As Integer) As Integer
Declare Function GetUpdateRect Lib "user32" (ByVal hwnd As Integer, ByRef lpRect As RECT, ByVal bErase As Integer) As Integer
Declare Function GetUpdateRgn Lib "user32" (ByVal hwnd As Integer, ByVal hRgn As Integer, ByVal fErase As Integer) As Integer
Declare Function GetUserObjectSecurity Lib "user32" (ByVal hObj As Integer, ByRef pSIRequested As Integer, ByRef pSd As SECURITY_DESCRIPTOR, ByVal nLength As Integer, ByRef lpnLengthNeeded As Integer) As Integer
Declare Function GetWindow Lib "user32" (ByVal hwnd As Integer, ByVal wCmd As Integer) As Integer
Declare Function GetWindowContextHelpId Lib "user32" (ByVal hWnd As Integer) As Integer
Declare Function GetWindowDC Lib "user32" (ByVal hwnd As Integer) As Integer
Declare Function GetWindowLong Lib "user32" Alias "GetWindowLongA" (ByVal hWnd As Integer, ByVal nIndex As Integer) As Integer
Declare Function GetWindowModuleFileName Lib "user32" Alias "GetWindowModuleFileNameA" (ByVal hwnd As Integer, ByVal pszFileName As String, ByVal cchFileNameMax As Integer) As Integer
Declare Function GetWindowPlacement Lib "user32" (ByVal hwnd As Integer, ByRef lpwndpl As WINDOWPLACEMENT) As Integer
Declare Function GetWindowRect Lib "user32" (ByVal hWnd As Integer, lpRect As RECT) As Integer
Declare Function GetWindowRgn Lib "user32" (ByVal hWnd As Integer, ByVal hRgn As Integer) As Integer
Declare Function GetWindowText Lib "user32" Alias "GetWindowTextA" (ByVal hwnd As Integer, ByVal lpString As String, ByVal cch As Integer) As Integer
Declare Function GetWindowTextLength Lib "user32" Alias "GetWindowTextLengthA" (ByVal hwnd As Integer) As Integer
Declare Function GetWindowThreadProcessId Lib "user32" (ByVal hwnd As Integer, ByRef lpdwProcessId As Integer) As Integer
Declare Function GetWindowWord Lib "user32" (ByVal hwnd As Integer, ByVal nIndex As Integer) As Short
Declare Function GrayString Lib "user32" Alias "GrayStringA" (ByVal hDC As Integer, ByVal hBrush As Integer, ByVal lpOutputFunc As Integer, ByVal lpData As Integer, ByVal nCount As Integer, ByVal X As Integer, ByVal Y As Integer, ByVal nWidth As Integer, ByVal nHeight As Integer) As Integer
Declare Function HideCaret Lib "user32" (ByVal hwnd As Integer) As Integer
Declare Function HiliteMenuItem Lib "user32" (ByVal hwnd As Integer, ByVal hMenu As Integer, ByVal wIDHiliteItem As Integer, ByVal wHilite As Integer) As Integer
Declare Function ImpersonateDdeClientWindow Lib "user32" (ByVal hWndClient As Integer, ByVal hWndServer As Integer) As Integer
Declare Function InflateRect Lib "user32" (ByRef lpRect As RECT, ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function InSendMessage Lib "user32" () As Integer
Declare Function InSendMessageEx Lib "user32" (lpReserved As Any) As Integer
Declare Function InsertMenu Lib "user32" Alias "InsertMenuA" (ByVal hMenu As UInteger, ByVal nPosition As UInteger, ByVal wFlags As UInteger, ByVal wIDNewItem As UInteger, lpNewItem As Any) As Integer
Declare Function InsertMenuItem Lib "user32" Alias "InsertMenuItemA" (ByVal hMenu As Integer, ByVal un As Integer, ByVal bool As Short, ByRef lpcMenuItemInfo As MENUITEMINFO) As Integer
Declare Function IntersectRect Lib "user32" (ByRef lpDestRect As RECT, ByRef lpSrc1Rect As RECT, ByRef lpSrc2Rect As RECT) As Integer
Declare Function InvalidateRect Lib "user32" (ByVal hwnd As Integer, ByRef lpRect As RECT, ByVal bErase As Integer) As Integer
Declare Function InvalidateRgn Lib "user32" (ByVal hwnd As Integer, ByVal hRgn As Integer, ByVal bErase As Integer) As Integer
Declare Function InvertRect Lib "user32" (ByVal hdc As Integer, ByRef lpRect As RECT) As Integer
Declare Function IsCharAlpha Lib "user32" Alias "IsCharAlphaA" (ByVal cChar As Byte) As Integer
Declare Function IsCharAlphaNumeric Lib "user32" Alias "IsCharAlphaNumericA" (ByVal cChar As Byte) As Integer
Declare Function IsCharLower Lib "user32" Alias "IsCharLowerA" (ByVal cChar As Byte) As Integer
Declare Function IsCharUpper Lib "user32" Alias "IsCharUpperA" (ByVal cChar As Byte) As Integer
Declare Function IsChild Lib "user32" (ByVal hWndParent As Integer, ByVal hwnd As Integer) As Integer
Declare Function IsClipboardFormatAvailable Lib "user32" (ByVal wFormat As Integer) As Integer
Declare Function IsDialogMessage Lib "user32" Alias "IsDialogMessageA" (ByVal hDlg As Integer, ByRef lpMsg As MSG) As Integer
Declare Function IsDlgButtonChecked Lib "user32" (ByVal hDlg As Integer, ByVal nIDButton As Integer) As Integer
Declare Function IsIconic Lib "user32" (ByVal hwnd As Integer) As Integer
Declare Function IsMenu Lib "user32" (ByVal hMenu As Integer) As Integer
Declare Function IsRectEmpty Lib "user32" (ByRef lpRect As RECT) As Integer
Declare Function IsWindow Lib "user32" (ByVal hwnd As Integer) As Integer
Declare Function IsWindowEnabled Lib "user32" (ByVal hwnd As Integer) As Integer
Declare Function IsWindowUnicode Lib "user32" (ByVal hwnd As Integer) As Integer
Declare Function IsWindowVisible Lib "user32" (ByVal hwnd As Integer) As Integer
Declare Function IsZoomed Lib "user32" (ByVal hwnd As Integer) As Integer
Declare Function KillTimer Lib "user32" (ByVal hwnd As Integer, ByVal nIDEvent As Integer) As Integer
Declare Function LoadAccelerators Lib "user32" Alias "LoadAcceleratorsA" (ByVal hInstance As Integer, ByVal lpTableName As String) As Integer
Declare Function LoadBitmap Lib "user32" Alias "LoadBitmapA" (ByVal hInstance As Integer, ByVal lpBitmapName As String) As Integer
Declare Function LoadCursor Lib "user32" Alias "LoadCursorA" (ByVal hInstance As Integer, ByVal lpCursorName As String) As Integer
Declare Function LoadCursorFromFile Lib "user32" Alias "LoadCursorFromFileA" (ByVal lpFileName As String) As Integer
Declare Function LoadIcon Lib "user32" Alias "LoadIconA" (ByVal hInstance As Integer, ByVal lpIconName As String) As Integer
Declare Function LoadImage Lib "user32" Alias "LoadImageA" (ByVal hInst As Integer, ByVal lpsz As String, ByVal un1 As Integer, ByVal n1 As Integer, ByVal n2 As Integer, ByVal un2 As Integer) As Integer
Declare Function LoadKeyboardLayout Lib "user32" Alias "LoadKeyboardLayoutA" (ByVal pwszKLID As String, ByVal flags As Integer) As Integer
Declare Function LoadMenu Lib "user32" Alias "LoadMenuA" (ByVal hInstance As Integer, ByVal lpString As String) As Integer
Declare Function LoadMenuIndirect Lib "user32" Alias "LoadMenuIndirectA" (ByVal lpMenuTemplate As Integer) As Integer
Declare Function LoadString Lib "user32" Alias "LoadStringA" (ByVal hInstance As Integer, ByVal wID As Integer, ByVal lpBuffer As String, ByVal nBufferMax As Integer) As Integer
Declare Function LockWindowUpdate Lib "user32" (ByVal hwndLock As Integer) As Integer
Declare Function LookupIconIdFromDirectory Lib "user32" (ByRef presbits As Byte, ByVal fIcon As Short) As Integer
Declare Function LookupIconIdFromDirectoryEx Lib "user32" (ByRef presbits As Byte, ByVal fIcon As Short, ByVal cxDesired As Integer, ByVal cyDesired As Integer, ByVal Flags As Integer) As Integer
Declare Function MapDialogRect Lib "user32" (ByVal hDlg As Integer, ByRef lpRect As RECT) As Integer
Declare Function MapVirtualKey Lib "user32" Alias "MapVirtualKeyA" (ByVal wCode As Integer, ByVal wMapType As Integer) As Integer
Declare Function MapVirtualKeyEx Lib "user32" Alias "MapVirtualKeyExA" (ByVal uCode As Integer, ByVal uMapType As Integer, ByVal dwhkl As Integer) As Integer
Declare Function MenuItemFromPoint Lib "user32" (ByVal hWnd As Integer, ByVal hMenu As Integer, Byref ptScreen As POINTAPI) As Integer
Declare Function MessageBeep Lib "user32" (ByVal wType As Integer) As Integer
Declare Function MessageBox Lib "user32" Alias "MessageBoxA" (ByVal hwnd As Integer, ByVal lpText As String, ByVal lpCaption As String, ByVal wtype As Integer) As Integer
Declare Function MessageBoxEx Lib "user32" Alias "MessageBoxExA" (ByVal hwnd As Integer, ByVal lpText As String, ByVal lpCaption As String, ByVal uType As Integer, ByVal wLanguageId As Integer) As Integer
Declare Function MessageBoxIndirect Lib "user32" Alias "MessageBoxIndirectA" (ByRef lpMsgBoxParams As MSGBOXPARAMS) As Integer
Declare Sub MonitorFromPoint Lib "user32" (Byref pt As POINTAPI, ByVal dwFlags As Integer)
Declare Sub MonitorFromRect Lib "user32" (ByRef lprc As RECT, ByVal dwFlags As Integer)
Declare Sub MonitorFromWindow Lib "user32" (ByVal hwnd As Integer, ByVal dwFlags As Integer)
Declare Function MoveWindow Lib "user32" (ByVal hwnd As Integer, ByVal x As Integer, ByVal y As Integer, ByVal nWidth As Integer, ByVal nHeight As Integer, ByVal bRepaint As Integer) As Integer
Declare Function MsgWaitForMultipleObjects Lib "user32" (ByVal nCount As Integer, ByRef pHandles As Integer, ByVal fWaitAll As Integer, ByVal dwMilliseconds As Integer, ByVal dwWakeMask As Integer) As Integer
Declare Function MsgWaitForMultipleObjectsEx Lib "user32" (ByVal nCount As Integer, ByRef pHandles As Integer, ByVal dwMilliseconds As Integer, ByVal dwWakeMask As Integer, ByVal dwFlags As Integer) As Integer
Declare Sub NotifyWinEvent Lib "user32" (ByVal lEvent As Integer, ByVal hwnd As Integer, ByVal idObject As Integer, ByVal idChild As Integer)
Declare Function OemKeyScan Lib "user32" (ByVal wOemChar As Integer) As Integer
Declare Function OemToChar Lib "user32" Alias "OemToCharA" (ByVal lpszSrc As String, ByVal lpszDst As String) As Integer
Declare Function OemToCharBuff Lib "user32" Alias "OemToCharBuffA" (ByVal lpszSrc As String, ByVal lpszDst As String, ByVal cchDstLength As Integer) As Integer
Declare Function OffsetRect Lib "user32" (ByRef lpRect As RECT, ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function OpenClipboard Lib "user32" (ByVal hwnd As Integer) As Integer
Declare Function OpenDesktop Lib "user32" Alias "OpenDesktopA" (ByVal lpszDesktop As String, ByVal dwFlags As Integer, ByVal fInherit As Short, ByVal dwDesiredAccess As Integer) As Integer
Declare Function OpenIcon Lib "user32" (ByVal hwnd As Integer) As Integer
Declare Function PackDDElParam Lib "user32" (ByVal msg As Integer, ByVal uiLo As Integer, ByVal uiHi As Integer) As Integer
Declare Function PaintDesktop Lib "user32" (ByVal hdc As Integer) As Integer
Declare Function PeekMessage Lib "user32" Alias "PeekMessageA" (lpMsg As MSG, ByVal hwnd As Integer, ByVal wMsgFilterMin As Integer, ByVal wMsgFilterMax As Integer, ByVal wRemoveMsg As Integer) As Integer
Declare Function PostMessage Lib "user32" Alias "PostMessageA" (ByVal hwnd As Integer, ByVal wMsg As Integer, ByVal wParam As Integer, ByVal lParam As Integer) As Integer
Declare sub PostQuitMessage Lib "user32" Alias "PostQuitMessage" (ByVal nExitCode As Integer)
Declare Function PtInRect Lib "user32" (ByRef lpRect As RECT, ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function RealChildWindowFromPoint Lib "user32" (ByVal hwndParent As Integer, Byref ptParentClientCoords As POINTAPI) As Integer
Declare Function RealGetWindowClass Lib "user32" (ByVal hwnd As Integer, ByVal pszType As String, ByVal cchType As Integer) As Integer
Declare Function RedrawWindow Lib "user32" (ByVal hwnd As Integer, ByRef lprcUpdate As RECT, ByVal hrgnUpdate As Integer, ByVal fuRedraw As Integer) As Integer
Declare Function RegisterClass Lib "user32" Alias "RegisterClassA" (Class As WNDCLASS) As Integer
Declare Function RegisterClassEx Lib "user32" Alias "RegisterClassExA" (pcWndClassEx As WNDCLASSEX) As Integer
Declare Function RegisterClipboardFormat Lib "user32" Alias "RegisterClipboardFormatA" (ByVal lpString As String) As Integer
Declare Function RegisterHotKey Lib "user32" (ByVal hwnd As Integer, ByVal id As Integer, ByVal fsModifiers As Integer, ByVal vk As Integer) As Integer
Declare Function RegisterWindowMessage Lib "user32" Alias "RegisterWindowMessageA" (ByVal lpString As String) As Integer
Declare Function ReleaseCapture Lib "user32" () As Integer
Declare Function ReleaseDC Lib "user32" (ByVal hWnd As Integer, ByVal hDC As Integer) As Integer
Declare Function RemoveMenu Lib "user32" (ByVal hMenu As Integer, ByVal nPosition As Integer, ByVal wFlags As Integer) As Integer
Declare Function RemoveProp Lib "user32" Alias "RemovePropA" (ByVal hwnd As Integer, ByVal lpString As String) As Integer
Declare Function ReplyMessage Lib "user32" (ByVal lReply As Integer) As Integer
Declare Function ReuseDDElParam Lib "user32" (ByVal lParam As Integer, ByVal msgIn As Integer, ByVal msgOut As Integer, ByVal uiLo As Integer, ByVal uiHi As Integer) As Integer
Declare Function ScreenToClient Lib "user32" (ByVal hwnd As Integer, ByRef lpPoint As POINTAPI) As Integer
Declare Function ScrollDC Lib "user32" (ByVal hdc As Integer, ByVal dx As Integer, ByVal dy As Integer, ByRef lprcScroll As RECT, ByRef lprcClip As RECT, ByVal hrgnUpdate As Integer, ByRef lprcUpdate As RECT) As Integer
Declare Function ScrollWindow Lib "user32" (ByVal hWnd As Integer, ByVal XAmount As Integer, ByVal YAmount As Integer, ByRef lpRect As RECT, ByRef lpClipRect As RECT) As Integer
Declare Function ScrollWindowEx Lib "user32" (ByVal hwnd As Integer, ByVal dx As Integer, ByVal dy As Integer, ByRef lprcScroll As RECT, ByRef lprcClip As RECT, ByVal hrgnUpdate As Integer, ByRef lprcUpdate As RECT, ByVal fuScroll As Integer) As Integer
Declare Function SendDlgItemMessage Lib "user32" Alias "SendDlgItemMessageA" (ByVal hDlg As Integer, ByVal nIDDlgItem As Integer, ByVal wMsg As Integer, ByVal wParam As Integer, ByVal lParam As Integer) As Integer
Declare Function SendIMEMessageEx Lib "user32" Alias "SendIMEMessageExA" (ByVal hwnd As Integer, ByVal lparam As Integer) As Integer
Declare Function SendMessage Lib "user32" Alias "SendMessageA" (ByVal hwnd As Integer, ByVal wMsg As Integer, ByVal wParam As Integer, ByRef lParam As Any) As Integer
Declare Function SendMessageCallback Lib "user32" Alias "SendMessageCallbackA" (ByVal hwnd As Integer, ByVal msg As Integer, ByVal wParam As Integer, ByVal lParam As Integer, ByVal lpResultCallBack As Integer, ByVal dwData As Integer) As Integer
Declare Function SendMessageTimeout Lib "user32" Alias "SendMessageTimeoutA" (ByVal hwnd As Integer, ByVal msg As Integer, ByVal wParam As Integer, ByVal lParam As Integer, ByVal fuFlags As Integer, ByVal uTimeout As Integer, ByRef lpdwResult As Integer) As Integer
Declare Function SendNotifyMessage Lib "user32" Alias "SendNotifyMessageA" (ByVal hwnd As Integer, ByVal msg As Integer, ByVal wParam As Integer, ByVal lParam As Integer) As Integer
Declare Function SetActiveWindow Lib "user32" (ByVal hwnd As Integer) As Integer
Declare Function SetCapture Lib "user32" (ByVal hwnd As Integer) As Integer
Declare Function SetCaretBlinkTime Lib "user32" (ByVal wMSeconds As Integer) As Integer
Declare Function SetCaretPos Lib "user32" (ByVal x As Integer, ByVal y As Integer) As Integer
Declare Function SetClassLong Lib "user32" Alias "SetClassLongA" (ByVal hwnd As Integer, ByVal nIndex As Integer, ByVal dwNewLong As Integer) As Integer
Declare Function SetClassWord Lib "user32" (ByVal hwnd As Integer, ByVal nIndex As Integer, ByVal wNewWord As Integer) As Integer
Declare Function SetClipboardData Lib "user32" (ByVal wFormat As Integer, ByVal hMem As Integer) As Integer
Declare Function SetClipboardViewer Lib "user32" (ByVal hwnd As Integer) As Integer
Declare Function SetCursor Lib "user32" (ByVal hCursor As Integer) As Integer
Declare Function SetCursorPos Lib "user32" (ByVal x As Integer, ByVal y As Integer) As Integer
Declare Sub SetDebugErrorLevel Lib "user32" (ByVal dwLevel As Integer)
Declare Function SetDlgItemInt Lib "user32" (ByVal hDlg As Integer, ByVal nIDDlgItem As Integer, ByVal wValue As Integer, ByVal bSigned As Integer) As Integer
Declare Function SetDlgItemText Lib "user32" Alias "SetDlgItemTextA" (ByVal hDlg As Integer, ByVal nIDDlgItem As Integer, ByVal lpString As String) As Integer
Declare Function SetDoubleClickTime Lib "user32" (ByVal wCount As Integer) As Integer
Declare Function SetFocus Lib "user32" Alias "SetFocus" (ByVal hwnd As Integer) As Integer
Declare Function SetForegroundWindow Lib "user32" (ByVal hwnd As Integer) As Integer
Declare Function SetKeyboardState Lib "user32" (ByRef lppbKeyState As Byte) As Integer
Declare Sub SetLastErrorEx Lib "user32" (ByVal dwErrCode As Integer, ByVal dwType As Integer)
Declare Function SetMenu Lib "user32" (ByVal hwnd As Integer, ByVal hMenu As Integer) As Integer
Declare Function SetMenuContextHelpId Lib "user32" (ByVal hMenu As Integer, ByVal dw As Integer) As Integer
Declare Function SetMenuDefaultItem Lib "user32" (ByVal hMenu As Integer, ByVal uItem As Integer, ByVal fByPos As Integer) As Integer
Declare Function SetMenuInfo Lib "user32" (ByVal hmenu As Integer, ByRef LPCMENUINFO As CMENUINFO) As Integer
Declare Function SetMenuItemBitmaps Lib "user32" (ByVal hMenu As Integer, ByVal nPosition As Integer, ByVal wFlags As Integer, ByVal hBitmapUnchecked As Integer, ByVal hBitmapChecked As Integer) As Integer
Declare Function SetMenuItemInfo Lib "user32" Alias "SetMenuItemInfoA" (ByVal hMenu As Integer, ByVal un As Integer, ByVal bool As Short, ByRef lpcMenuItemInfo As MENUITEMINFO) As Integer
Declare Function SetMessageExtraInfo Lib "user32" (ByVal lParam As Integer) As Integer
Declare Function SetMessageQueue Lib "user32" (ByVal cMessagesMax As Integer) As Integer
Declare Function SetParent Lib "user32" (ByVal hWndChild As Integer, ByVal hWndNewParent As Integer) As Integer
Declare Function SetProcessDefaultLayout Lib "user32" (ByVal dwDefaultLayout As Integer) As Integer
Declare Function SetProcessWindowStation Lib "user32" (ByVal hWinSta As Integer) As Integer
Declare Function SetProp Lib "user32" Alias "SetPropA" (ByVal hwnd As Integer, ByVal lpString As String, ByVal hData As Integer) As Integer
Declare Function SetRect Lib "user32" (ByRef lpRect As RECT, ByVal X1 As Integer, ByVal Y1 As Integer, ByVal X2 As Integer, ByVal Y2 As Integer) As Integer
Declare Function SetRectEmpty Lib "user32" (ByRef lpRect As RECT) As Integer
Declare Function SetScrollInfo Lib "user32" (ByVal hWnd As Integer, ByVal n As Integer, ByRef lpcScrollInfo As SCROLLINFO, ByVal bool As Short) As Integer
Declare Function SetScrollPos Lib "user32" (ByVal hwnd As Integer, ByVal nBar As Integer, ByVal nPos As Integer, ByVal bRedraw As Integer) As Integer
Declare Function SetScrollRange Lib "user32" (ByVal hwnd As Integer, ByVal nBar As Integer, ByVal nMinPos As Integer, ByVal nMaxPos As Integer, ByVal bRedraw As Integer) As Integer
Declare Function SetSysColors Lib "user32" (ByVal nChanges As Integer, ByRef lpSysColor As Integer, ByRef lpColorValues As Integer) As Integer
Declare Function SetSystemCursor Lib "user32" (ByVal hcur As Integer, ByVal id As Integer) As Integer
Declare Function SetThreadDesktop Lib "user32" (ByVal hDesktop As Integer) As Integer
Declare Function SetTimer Lib "user32" (ByVal hWnd As Integer, ByVal nIDEvent As Integer, ByVal uElapse As Integer, ByVal lpTimerFunc As Integer) As Integer
Declare Function SetUserObjectInformation Lib "user32" Alias "SetUserObjectInformationA" (ByVal hObj As Integer, ByVal nIndex As Integer, ByRef pvInfo As Any, ByVal nLength As Integer) As Integer
Declare Function SetUserObjectSecurity Lib "user32" (ByVal hObj As Integer, ByRef pSIRequested As Integer, ByRef pSd As SECURITY_DESCRIPTOR) As Integer
Declare Function SetWindowContextHelpId Lib "user32" (ByVal hWnd As Integer, ByVal dw As Integer) As Integer
Declare Function SetWindowLong Lib "user32" Alias "SetWindowLongA" (ByVal hwnd As Integer, ByVal nIndex As Integer, ByVal dwNewLong As Integer) As Integer
Declare Function SetWindowPlacement Lib "user32" (ByVal hwnd As Integer, ByRef lpwndpl As WINDOWPLACEMENT) As Integer
Declare Function SetWindowPos Lib "user32" (ByVal hWnd As Integer, ByVal hWndInsertAfter As Integer, ByVal x As Integer, ByVal y As Integer, ByVal cx As Integer, ByVal cy As Integer, ByVal wFlags As Integer) As Integer
Declare Function SetWindowRgn Lib "user32" (ByVal hWnd As Integer, ByVal hRgn As Integer, ByVal bRedraw As Short) As Integer
Declare Function SetWindowText Lib "user32" Alias "SetWindowTextA" (ByVal hwnd As Integer, byVal lpText As String ) As Short
Declare Function SetWindowWord Lib "user32" (ByVal hwnd As Integer, ByVal nIndex As Integer, ByVal wNewWord As Integer) As Integer
Declare Function SetWindowsHook Lib "user32" Alias "SetWindowsHookA" (ByVal nFilterType As Integer, ByVal pfnFilterProc As Integer) As Integer
Declare Function SetWindowsHookEx Lib "user32" Alias "SetWindowsHookExA" (ByVal idHook As Integer, ByVal lpfn As Integer, ByVal hmod As Integer, ByVal dwThreadId As Integer) As Integer
Declare Function ShowCaret Lib "user32" (ByVal hwnd As Integer) As Integer
Declare Function ShowCursor Lib "user32" (ByVal bShow As Integer) As Integer
Declare Function ShowOwnedPopups Lib "user32" (ByVal hwnd As Integer, ByVal fShow As Integer) As Integer
Declare Function ShowScrollBar Lib "user32" (ByVal hwnd As Integer, ByVal wBar As Integer, ByVal bShow As Integer) As Integer
Declare Function ShowWindow lib "user32" Alias "ShowWindow" (ByVal hwnd As Integer, ByVal nCmdShow As Integer) As Integer
Declare Function ShowWindowAsync Lib "user32" (ByVal hWnd As Integer, ByVal nCmdShow As Integer) As Integer
Declare Function SubtractRect Lib "user32" (ByRef lprcDst As RECT, ByRef lprcSrc1 As RECT, ByRef lprcSrc2 As RECT) As Integer
Declare Function SwapMouseButton Lib "user32" (ByVal bSwap As Integer) As Integer
Declare Function SwitchDesktop Lib "user32" (ByVal hDesktop As Integer) As Integer
Declare Function SystemParametersInfo Lib "user32" Alias "SystemParametersInfoA" (ByVal uAction As Integer, ByVal uParam As Integer, ByRef lpvParam As Any, ByVal fuWinIni As Integer) As Integer
Declare Function TabbedTextOut Lib "user32" Alias "TabbedTextOutA" (ByVal hdc As Integer, ByVal x As Integer, ByVal y As Integer, ByVal lpString As String, ByVal nCount As Integer, ByVal nTabPositions As Integer, ByRef lpnTabStopPositions As Integer, ByVal nTabOrigin As Integer) As Integer
Declare Function TileWindows Lib "user32" (ByVal hwndParent As Integer, ByVal wHow As Integer, ByRef lpRect As RECT, ByVal cKids As Integer, ByRef lpKids As Integer) As Short
Declare Function ToAscii Lib "user32" (ByVal uVirtKey As Integer, ByVal uScanCode As Integer, ByRef lpbKeyState As Byte, ByRef lpwTransKey As Integer, ByVal fuState As Integer) As Integer
Declare Function ToAsciiEx Lib "user32" (ByVal uVirtKey As Integer, ByVal uScanCode As Integer, ByRef lpKeyState As Byte, ByRef lpChar As Short, ByVal uFlags As Integer, ByVal dwhkl As Integer) As Integer
Declare Function ToUnicode Lib "user32" (ByVal wVirtKey As Integer, ByVal wScanCode As Integer, ByRef lpKeyState As Byte, ByVal pwszBuff As String, ByVal cchBuff As Integer, ByVal wFlags As Integer) As Integer
Declare Function ToUnicodeEx Lib "user32" (ByVal wVirtKey As Integer, ByVal wScanCode As Integer, ByVal lpKeyState As String, ByVal pwszBuff As String, ByVal cchBuff As Integer, ByVal wFlags As Integer, ByVal dwhkl As Integer) As Integer
Declare Function TrackPopupMenu Lib "user32" (ByVal hMenu As Integer, ByVal wFlags As Integer, ByVal x As Integer, ByVal y As Integer, ByVal nReserved As Integer, ByVal hwnd As Integer, ByRef lprc As RECT) As Integer
Declare Function TrackPopupMenuEx Lib "user32" (ByVal hMenu As Integer, ByVal un As Integer, ByVal n1 As Integer, ByVal n2 As Integer, ByVal hWnd As Integer, ByRef lpTPMParams As TPMPARAMS) As Integer
Declare Function TranslateAccelerator Lib "user32" Alias "TranslateAcceleratorA" (ByVal hwnd As Integer, ByVal hAccTable As Integer, ByRef lpMsg As MSG) As Integer
Declare Function TranslateMDISysAccel Lib "user32" (ByVal hWndClient As Integer, ByRef lpMsg As MSG) As Integer
Declare Function TranslateMessage Lib "user32" Alias "TranslateMessage" (lpMsg As MSG) As Integer
Declare Function UnhookWinEvent Lib "user32" (ByRef hWinEventHook As Integer) As Integer
Declare Function UnhookWindowsHook Lib "user32" (ByVal nCode As Integer, ByVal pfnFilterProc As Integer) As Integer
Declare Function UnhookWindowsHookEx Lib "user32" (ByVal hHook As Integer) As Integer
Declare Function UnionRect Lib "user32" (ByRef lpDestRect As RECT, ByRef lpSrc1Rect As RECT, ByRef lpSrc2Rect As RECT) As Integer
Declare Function UnloadKeyboardLayout Lib "user32" (ByVal HKL As Integer) As Integer
Declare Function UnpackDDElParam Lib "user32" (ByVal msg As Integer, ByVal lParam As Integer, ByRef puiLo As Integer, ByRef puiHi As Integer) As Integer
Declare Function UnregisterClass Lib "user32" Alias "UnregisterClassA" (ByVal lpClassName As String, ByVal hInstance As Integer) As Integer
Declare Function UnregisterDeviceNotification Lib "user32" (ByRef Handle As Integer) As Integer
Declare Function UnregisterHotKey Lib "user32" (ByVal hwnd As Integer, ByVal id As Integer) As Integer
Declare Function UpdateWindow Lib "user32" Alias "UpdateWindow" (ByVal hwnd As Integer) As Integer
Declare Function ValidateRect Lib "user32" (ByVal hwnd As Integer, ByRef lpRect As RECT) As Integer
Declare Function ValidateRgn Lib "user32" (ByVal hwnd As Integer, ByVal hRgn As Integer) As Integer
Declare Function VkKeyScan Lib "user32" Alias "VkKeyScanA" (ByVal cChar As Byte) As Short
Declare Function VkKeyScanEx Lib "user32" Alias "VkKeyScanExA" (ByVal ch As Byte, ByVal dwhkl As Integer) As Short
Declare Function WaitForInputIdle Lib "user32" (ByVal hProcess As Integer, ByVal dwMilliseconds As Integer) As Integer
Declare Function WindowFromDC Lib "user32" (ByVal hdc As Integer) As Integer
Declare Function WindowFromPoint Lib "user32" (ByVal xPoint As Integer, ByVal yPoint As Integer) As Integer
Declare Function WinHelp Lib "user32" Alias "WinHelpA" (ByVal hwnd As Integer, ByVal lpHelpFile As String, ByVal wCommand As Integer, ByVal dwData As Integer) As Integer
Declare Function WINNLSEnableIME Lib "user32" (ByVal hwnd As Integer, ByVal bool As Integer) As Integer
Declare Function WINNLSGetEnableStatus Lib "user32" (ByVal hwnd As Integer) As Integer
Declare Function WINNLSGetIMEHotkey Lib "user32" (ByVal hwnd As Integer) As Integer
Declare Sub keybd_event Lib "user32" (ByVal bVk As Byte, ByVal bScan As Byte, ByVal dwFlags As Integer, ByVal dwExtraInfo As Integer)
Declare Sub mouse_event Lib "user32" (ByVal dwFlags As Integer, ByVal dx As Integer, ByVal dy As Integer, ByVal cButtons As Integer, ByVal dwExtraInfo As Integer)

'the following functions require advanced functionality, additional data types, or are missing their required types.
'Declare Function EnumDisplayDevices Lib "user32" Alias "EnumDisplayDevicesA" (ByVal lpDevice As String, ByVal iDevNum As Integer, ByRef lpDisplayDevice As PDISPLAY_DEVICEA, ByVal dwFlags As Integer) As Integer
'Declare Function EnumDisplayMonitors Lib "user32" (ByVal hdc As Integer, ByRef lprcClip As RECT, ByRef lpfnEnum As MONITORENUMPROC, ByVal dwData As Integer) As Integer
'Declare Function GetMenuBarInfo Lib "user32" (ByVal hwnd As Integer, ByVal idObject As Integer, ByVal idItem As Integer, ByRef pmbi As PMENUBARINFO) As Integer
'Declare Function GetScrollBarInfo Lib "user32" (ByVal hwnd As Integer, ByVal idObject As Integer, ByRef psbi As PSCROLLBARINFO) As Integer
'Declare Function GetTitleBarInfo Lib "user32" (ByVal hwnd As Integer, ByRef pti As PTITLEBARINFO) As Integer
'Declare Function GetUserObjectInformation Lib "user32" Alias "GetUserObjectInformationA" (ByVal hObj As Integer, ByVal nIndex As Integer, ByRef pvInfo As Any, ByVal nLength As Integer, ByRef lpnLengthNeeded As Integer) As Integer
'Declare Function GetWindowInfo Lib "user32" (ByVal hwnd As Integer, ByRef pwi As PWINDOWINFO) As Integer
'Declare Function IMPGetIME Lib "user32" Alias "IMPGetIMEA" (ByVal hwnd As Integer, ByRef LPIMEPROA As IMEPROA) As Integer
'Declare Function IMPQueryIME Lib "user32" Alias "IMPQueryIMEA" (ByRef LPIMEPROA As IMEPROA) As Integer
'Declare Function IMPSetIME Lib "user32" Alias "IMPSetIMEA" (ByVal hwnd As Integer, ByRef LPIMEPROA As IMEPROA) As Integer
'Declare Function MapWindowPoints Lib "user32" (ByVal hwndFrom As Integer, ByVal hwndTo As Integer, ByRef lppt As Any, ByVal cPoints As Integer) As Integer
'Declare Function ModifyMenu Lib "user32" Alias "ModifyMenuA" (ByVal hMenu As Integer, ByVal nPosition As Integer, ByVal wFlags As Integer, ByVal wIDNewItem As Integer, ByVal lpString As Any) As Integer
'Declare Function OpenInputDesktop Lib "user32" (ByVal dwFlags As Integer, ByVal fInherit As Boolean, ByVal dwDesiredAccess As Integer) As Integer
'Declare Function OpenWindowStation Lib "user32" Alias "OpenWindowStationA" (ByVal lpszWinSta As String, ByVal fInherit As Boolean, ByVal dwDesiredAccess As Integer) As Integer
'Declare Sub RegisterDeviceNotification Lib "user32" Alias "RegisterDeviceNotificationA" (ByVal hRecipient As Integer, ByRef NotificationFilter As Any, ByVal Flags As Integer)
'Declare Function SendInput Lib "user32" (ByVal cInputs As Integer, ByRef pInputs As INPUT, ByVal cbSize As Integer) As Integer
'Declare Sub SetWinEventHook Lib "user32" (ByVal eventMin As Integer, ByVal eventMax As Integer, ByVal hmodWinEventProc As Integer, ByRef pfnWinEventProc As WINEVENTPROC, ByVal idProcess As Integer, ByVal idThread As Integer, ByVal dwFlags As Integer)
'Declare Function TrackMouseEvent Lib "user32" (ByRef lpEventTrack As TRACKMOUSEEVENT) As Integer
#endif 'USER32_BI