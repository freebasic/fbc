''''''''''''''''''''''''''''''''''''''/
' Name:        defs.h
' Purpose:     Declarations/definitions common to all wx source files
' Author:      Julian Smart and others
' Modified by:
' Created:     01/02/97
' RCS-ID:      $Id$
' Copyright:   (c)
' Licence:     wxWindows licence
''''''''''''''''''''''''''''''''''''''/
'ported to fb by dumbledore, aka the unknown qb programmer :P

#ifndef _WX_DEFS_H_
#define _WX_DEFS_H_

#ifndef TRUE
   #define TRUE 1
#endif

#ifndef FALSE
   #define FALSE 0
#endif

' symbolic constant used by all Find()-like functions returning positive
' integer on success as failure indicator
#define wxNOT_FOUND       (-1)

' ----------------------------------------------------------------------------
' OS mnemonics -- Identify the running OS (useful for Windows)
' ----------------------------------------------------------------------------

' Not all platforms are currently available or supported
enum platform
    wxUNKNOWN_PLATFORM
    wxCURSES                 ' Text-only CURSES
    wxXVIEW_X                ' Sun's XView OpenLOOK toolkit
    wxMOTIF_X                ' OSF Motif 1.x.x
    wxCOSE_X                 ' OSF Common Desktop Environment
    wxNEXTSTEP               ' NeXTStep
    wxMAC                    ' Apple Mac OS 8/9/X with Mac paths
    wxMAC_DARWIN             ' Apple Mac OS X with Unix paths
    wxBEOS                   ' BeOS
    wxGTK                    ' GTK on X
    wxGTK_WIN32              ' GTK on Win32
    wxGTK_OS2                ' GTK on OS/2
    wxGTK_BEOS               ' GTK on BeOS
    wxGEOS                   ' GEOS
    wxOS2_PM                 ' OS/2 Workplace
    wxWINDOWS                ' Windows or WfW
    wxMICROWINDOWS           ' MicroWindows
    wxPENWINDOWS             ' Windows for Pen Computing
    wxWINDOWS_NT             ' Windows NT
    wxWIN32S                 ' Windows 32S API
    wxWIN95                  ' Windows 95
    wxWIN386                 ' Watcom 32-bit supervisor modus
    wxMGL_UNIX               ' MGL with direct hardware access
    wxMGL_X                  ' MGL on X
    wxMGL_WIN32              ' MGL on Win32
    wxMGL_OS2                ' MGL on OS/2
    wxMGL_DOS                ' MGL on MS-DOS
    wxWINDOWS_OS2            ' Native OS/2 PM
    wxUNIX                   ' wxBase under Unix
    wxX11                     ' Plain X11 and Universal widgets
end enum

' ----------------------------------------------------------------------------
' Geometric flags
' ----------------------------------------------------------------------------

enum wxGeometryCentre
    wxCENTRE                  = &h0001
    wxCENTER                  = wxCENTRE
end enum

' centering into frame rather than screen (obsolete)
#define wxCENTER_FRAME          &h0000
' centre on screen rather than parent
#define wxCENTRE_ON_SCREEN      &h0002
#define wxCENTER_ON_SCREEN      wxCENTRE_ON_SCREEN

enum wxOrientation
    wxHORIZONTAL              = &h0004
    wxVERTICAL                = &h0008

    wxBOTH                    = (wxVERTICAL or wxHORIZONTAL)
end enum

enum wxDirection
    wxLEFT                    = &h0010
    wxRIGHT                   = &h0020
    wxUP                      = &h0040
    wxDOWN                    = &h0080

    wxTOP                     = wxUP
    wxBOTTOM                  = wxDOWN

    wxNORTH                   = wxUP
    wxSOUTH                   = wxDOWN
    wxWEST                    = wxLEFT
    wxEAST                    = wxRIGHT

    wxALL                     = (wxUP or wxDOWN or wxRIGHT or wxLEFT)
end enum

enum wxAlignment
    wxALIGN_NOT               = &h0000
    wxALIGN_CENTER_HORIZONTAL = &h0100
    wxALIGN_CENTRE_HORIZONTAL = wxALIGN_CENTER_HORIZONTAL
    wxALIGN_LEFT              = wxALIGN_NOT
    wxALIGN_TOP               = wxALIGN_NOT
    wxALIGN_RIGHT             = &h0200
    wxALIGN_BOTTOM            = &h0400
    wxALIGN_CENTER_VERTICAL   = &h0800
    wxALIGN_CENTRE_VERTICAL   = wxALIGN_CENTER_VERTICAL

    wxALIGN_CENTER            = (wxALIGN_CENTER_HORIZONTAL or wxALIGN_CENTER_VERTICAL)
    wxALIGN_CENTRE            = wxALIGN_CENTER

    ' a mask to extract alignment from the combination of flags
    wxALIGN_MASK              = &h0f00
end enum

enum wxStretch
    wxSTRETCH_NOT             = &h0000
    wxSHRINK                  = &h1000
    wxGROW                    = &h2000
    wxEXPAND                  = wxGROW
    wxSHAPED                  = &h4000
    wxADJUST_MINSIZE          = &h8000
    wxTILE                    = &hc000
end enum

' border flags: the values are chosen for backwards compatibility
enum wxBorder_enum
    ' this is different from wxBORDER_NONE as by default the controls do have
    ' border
    wxBORDER_DEFAULT = 0

    wxBORDER_NONE   = &h00200000
    wxBORDER_STATIC = &h01000000
    wxBORDER_SIMPLE = &h02000000
    wxBORDER_RAISED = &h04000000
    wxBORDER_SUNKEN = &h08000000
    wxBORDER_DOUBLE = &h10000000

    ' a mask to extract border style from the combination of flags
    wxBORDER_MASK   = &h1f200000
end enum

' ----------------------------------------------------------------------------
' Window style flags
' ----------------------------------------------------------------------------

'
' Values are chosen so they can be or'ed in a bit list.
' Some styles are used across more than one group,
' so the values mustn't clash with others in the group.
' Otherwise, numbers can be reused across groups.
'
' From version 1.66:
' Window (cross-group) styles now take up the first half
' of the flag, and control-specific styles the
' second half.
'
'

'
' Window (Frame/dialog/subwindow/panel item) style flags
'
#define wxVSCROLL               &h80000000
#define wxHSCROLL               &h40000000
#define wxCAPTION               &h20000000

' New styles (border styles are now in their own enum)
#define wxDOUBLE_BORDER         wxBORDER_DOUBLE
#define wxSUNKEN_BORDER         wxBORDER_SUNKEN
#define wxRAISED_BORDER         wxBORDER_RAISED
#define wxBORDER                wxBORDER_SIMPLE
#define wxSIMPLE_BORDER         wxBORDER_SIMPLE
#define wxSTATIC_BORDER         wxBORDER_STATIC
#define wxNO_BORDER             wxBORDER_NONE

' Override CTL3D etc. control colour processing to allow own background
' colour.
' Override CTL3D or native 3D styles for children
#define wxNO_3D                 &h00800000

' OBSOLETE - use wxNO_3D instead
#define wxUSER_COLOURS          wxNO_3D

' wxALWAYS_SHOW_SB: instead of hiding the scrollbar when it is not needed,
' disable it - but still show (see also wxLB_ALWAYS_SB style)
'
' NB: as this style is only supported by wxUniversal so far as it doesn't use
'     wxUSER_COLOURS/wxNO_3D, we reuse the same style value
#define wxALWAYS_SHOW_SB        &h00800000

' Clip children when painting, which reduces flicker in e.g. frames and
' splitter windows, but can't be used in a panel where a static box must be
' 'transparent' (panel paints the background for it)
#define wxCLIP_CHILDREN         &h00400000

' Note we're reusing the wxCAPTION style because we won't need captions
' for subwindows/controls
#define wxCLIP_SIBLINGS         &h20000000

#define wxTRANSPARENT_WINDOW    &h00100000

' Add this style to a panel to get tab traversal working outside of dialogs
' (on by default for wxPanel, wxDialog, wxScrolledWindow)
#define wxTAB_TRAVERSAL         &h00080000

' Add this style if the control wants to get all keyboard messages (under
' Windows, it won't normally get the dialog navigation key events)
#define wxWANTS_CHARS           &h00040000

' Make window retained (mostly Motif, I think) -- obsolete (VZ)?
#define wxRETAINED              &h00020000
#define wxBACKINGSTORE          wxRETAINED

' set this flag to create a special popup window: it will be always shown on
' top of other windows, will capture the mouse and will be dismissed when the
' mouse is clicked outside of it or if it loses focus in any other way
#define wxPOPUP_WINDOW          &h00020000

' don't invalidate the whole window (resulting in a PAINT event) when the
' window is resized (currently, makes sense for wxMSW only)
#define wxNO_FULL_REPAINT_ON_RESIZE &h00010000

'
' Extra window style flags (use wxWS_EX prefix to make it clear that they
' should be passed to wxWindow::SetExtraStyle(), not SetWindowStyle())
'

' by default, TransferDataTo/FromWindow() only work on direct children of the
' window (compatible behaviour), set this flag to make them recursively
' descend into all subwindows
#define wxWS_EX_VALIDATE_RECURSIVELY    &h00000001

' wxCommandEvents and the objects of the derived classes are forwarded to the
' parent window and so on recursively by default. Using this flag for the
' given window allows to block this propagation at this window, i.e. prevent
' the events from being propagated further upwards. The dialogs have this
' flag on by default.
#define wxWS_EX_BLOCK_EVENTS            &h00000002

' don't use this window as an implicit parent for the other windows: this must
' be used with transient windows as otherwise there is the risk of creating a
' dialog/frame with this window as a parent which would lead to a crash if the
' parent is destroyed before the child
#define wxWS_EX_TRANSIENT               &h00000004

' Use this style to add a context-sensitive help to the window (currently for
' Win32 only and it doesn't work if wxMINIMIZE_BOX or wxMAXIMIZE_BOX are used)
#define wxFRAME_EX_CONTEXTHELP  &h00000004
#define wxDIALOG_EX_CONTEXTHELP &h00000004

'
' wxFrame/wxDialog style flags
'
#define wxSTAY_ON_TOP           &h8000
#define wxICONIZE               &h4000
#define wxMINIMIZE              wxICONIZE
#define wxMAXIMIZE              &h2000
                                        ' free flag value: &h1000
#define wxSYSTEM_MENU           &h0800
#define wxMINIMIZE_BOX          &h0400
#define wxMAXIMIZE_BOX          &h0200
#define wxTINY_CAPTION_HORIZ    &h0100
#define wxTINY_CAPTION_VERT     &h0080
#define wxRESIZE_BORDER         &h0040

#define wxDIALOG_NO_PARENT      &h0001
                                        ' Don't make owned by apps top window
#define wxFRAME_NO_TASKBAR      &h0002
                                        ' No taskbar button (MSW only)
#define wxFRAME_TOOL_WINDOW     &h0004
                                        ' No taskbar button, no system menu
#define wxFRAME_FLOAT_ON_PARENT &h0008
                                        ' Always above its parent
#define wxFRAME_SHAPED          &h0010
                                        ' Create a window that is able to be shaped

' deprecated versions defined for compatibility reasons
#define wxRESIZE_BOX            wxMAXIMIZE_BOX
#define wxTHICK_FRAME           wxRESIZE_BORDER

' obsolete styles, unused any more
#define wxDIALOG_MODAL          &h0020
                                        ' free flag value &h0020
#define wxDIALOG_MODELESS       &h0000

'
' MDI parent frame style flags
' Can overlap with some of the above.
'

#define wxFRAME_NO_WINDOW_MENU  &h0100

#if WXWIN_COMPATIBILITY
#define wxDEFAULT_FRAME wxDEFAULT_FRAME_STYLE
#endif

#define wxDEFAULT_FRAME_STYLE (wxSYSTEM_MENU or wxRESIZE_BORDER or wxMINIMIZE_BOX or wxMAXIMIZE_BOX or wxCAPTION or wxCLIP_CHILDREN)

#if defined(__FB_WIN32__)
#   define wxDEFAULT_DIALOG_STYLE  (wxSYSTEM_MENU or wxCAPTION)
#else
'  Under Unix, the dialogs don't have a system menu. Specifying wxSYSTEM_MENU
'  here will make a close button appear.
#   define wxDEFAULT_DIALOG_STYLE  wxCAPTION
#endif

'
' wxExtDialog style flags
'
#define wxED_CLIENT_MARGIN      &h0004
#define wxED_BUTTONS_BOTTOM     &h0000
                                        ' has no effect
#define wxED_BUTTONS_RIGHT      &h0002
#define wxED_STATIC_LINE        &h0001

#if defined(__FB_WIN32__)
#   define wxEXT_DIALOG_STYLE  (wxDEFAULT_DIALOG_STYLEorwxED_CLIENT_MARGIN)
#else
#   define wxEXT_DIALOG_STYLE  (wxDEFAULT_DIALOG_STYLEorwxED_CLIENT_MARGINorwxED_STATIC_LINE)
#endif

'
' wxMenuBar style flags
'
' use native docking
#define wxMB_DOCKABLE       &h0001

'
' wxMenu style flags
'
#define wxMENU_TEAROFF      &h0001

'
' Apply to all panel items
'
#define wxCOLOURED          &h0800
#define wxFIXED_LENGTH      &h0400

'
' Styles for wxListBox
'
#define wxLB_SORT           &h0010
#define wxLB_SINGLE         &h0020
#define wxLB_MULTIPLE       &h0040
#define wxLB_EXTENDED       &h0080
' wxLB_OWNERDRAW is Windows-only
#define wxLB_OWNERDRAW      &h0100
#define wxLB_NEEDED_SB      &h0200
#define wxLB_ALWAYS_SB      &h0400
#define wxLB_HSCROLL        wxHSCROLL
' always show an entire number of rows
#define wxLB_INT_HEIGHT     &h0800

' deprecated synonyms
#define wxPROCESS_ENTER     &h0400
                                    ' wxTE_PROCESS_ENTER
#define wxPASSWORD          &h0800
                                    ' wxTE_PASSWORD

'
' wxComboBox style flags
'
#define wxCB_SIMPLE         &h0004
#define wxCB_SORT           &h0008
#define wxCB_READONLY       &h0010
#define wxCB_DROPDOWN       &h0020

'
' wxRadioBox style flags
'
' should we number the items from left to right or from top to bottom in a 2d
' radiobox?
#define wxRA_LEFTTORIGHT    &h0001
#define wxRA_TOPTOBOTTOM    &h0002

' New, more intuitive names to specify majorDim argument
#define wxRA_SPECIFY_COLS   wxHORIZONTAL
#define wxRA_SPECIFY_ROWS   wxVERTICAL

' Old names for compatibility
#define wxRA_HORIZONTAL     wxHORIZONTAL
#define wxRA_VERTICAL       wxVERTICAL

'
' wxRadioButton style flag
'
#define wxRB_GROUP          &h0004
#define wxRB_SINGLE         &h0008

'
' wxGauge flags
'
#define wxGA_HORIZONTAL      wxHORIZONTAL
#define wxGA_VERTICAL        wxVERTICAL
#define wxGA_PROGRESSBAR     &h0010
' Windows only
#define wxGA_SMOOTH          &h0020

'
' wxSlider flags
'
#define wxSL_HORIZONTAL      wxHORIZONTAL
                                          ' 4
#define wxSL_VERTICAL        wxVERTICAL
                                          ' 8
' The next one is obsolete - use scroll events instead
#define wxSL_NOTIFY_DRAG     &h0000
#define wxSL_TICKS           &h0010
#define wxSL_AUTOTICKS       wxSL_TICKS
                                        ' we don't support manual ticks
#define wxSL_LABELS          &h0020
#define wxSL_LEFT            &h0040
#define wxSL_TOP             &h0080
#define wxSL_RIGHT           &h0100
#define wxSL_BOTTOM          &h0200
#define wxSL_BOTH            &h0400
#define wxSL_SELRANGE        &h0800

'
' wxScrollBar flags
'
#define wxSB_HORIZONTAL      wxHORIZONTAL
#define wxSB_VERTICAL        wxVERTICAL

'
' wxSpinButton flags.
' Note that a wxSpinCtrl is sometimes defined as
' a wxTextCtrl, and so the flags must be different
' from wxTextCtrl's.
'
#define wxSP_HORIZONTAL       wxHORIZONTAL
                                           ' 4
#define wxSP_VERTICAL         wxVERTICAL
                                           ' 8
#define wxSP_ARROW_KEYS       &h1000
#define wxSP_WRAP             &h2000

'
' wxSplitterWindow flags
'
#define wxSP_NOBORDER         &h0000
#define wxSP_NOSASH           &h0010
#define wxSP_BORDER           &h0020
#define wxSP_PERMIT_UNSPLIT   &h0040
#define wxSP_LIVE_UPDATE      &h0080
#define wxSP_3DSASH           &h0100
#define wxSP_3DBORDER         &h0200
#define wxSP_FULLSASH         &h0400
#define wxSP_3D               (wxSP_3DBORDER or wxSP_3DSASH)
#define wxSP_SASH_AQUA        &h0800

'
' wxNotebook flags
'
#define wxNB_FIXEDWIDTH       &h0010
#define wxNB_TOP              &h0000
                                        ' default
#define wxNB_LEFT             &h0020
#define wxNB_RIGHT            &h0040
#define wxNB_BOTTOM           &h0080
#define wxNB_MULTILINE        &h0100

'
' wxTabCtrl flags
'
#define wxTC_RIGHTJUSTIFY     &h0010
#define wxTC_FIXEDWIDTH       &h0020
#define wxTC_TOP              &h0000
                                        ' default
#define wxTC_LEFT             &h0020
#define wxTC_RIGHT            &h0040
#define wxTC_BOTTOM           &h0080
#define wxTC_MULTILINE        wxNB_MULTILINE
#define wxTC_OWNERDRAW        &h0200

' wxToolBar style flags
#define wxTB_HORIZONTAL     wxHORIZONTAL
                                            ' == &h0004
#define wxTB_VERTICAL       wxVERTICAL
                                            ' == &h0008
#define wxTB_3DBUTTONS      &h0010
#define wxTB_FLAT           &h0020
                                            ' supported only under Win98+/GTK
#define wxTB_DOCKABLE       &h0040
                                            ' use native docking under GTK
#define wxTB_NOICONS        &h0080
                                            ' don't show the icons
#define wxTB_TEXT           &h0100
                                            ' show the text
#define wxTB_NODIVIDER      &h0200
                                            ' don't show the divider (Windows)
#define wxTB_NOALIGN        &h0400
                                            ' no automatic alignment (Windows)

'
' wxStatusBar95 flags
'
#define wxST_SIZEGRIP         &h0010

'
' wxStaticText flags
'
#define wxST_NO_AUTORESIZE    &h0001

'
' wxStaticBitmap flags
'
#define wxBI_EXPAND           wxEXPAND

'
' wxStaticLine flags
'
#define wxLI_HORIZONTAL         wxHORIZONTAL
#define wxLI_VERTICAL           wxVERTICAL

'
' wxProgressDialog flags
'
#define wxPD_CAN_ABORT          &h0001
#define wxPD_APP_MODAL          &h0002
#define wxPD_AUTO_HIDE          &h0004
#define wxPD_ELAPSED_TIME       &h0008
#define wxPD_ESTIMATED_TIME     &h0010
' wxGA_SMOOTH = &h0020 may also be used with wxProgressDialog
' NO!!! This is wxDIALOG_MODAL and will cause the progress dialog to
' be modal. No progress will then be made at all.
#define wxPD_REMAINING_TIME     &h0040

'
' wxDirDialog styles
'

#define wxDD_NEW_DIR_BUTTON     &h0080

'
' extended dialog specifiers. these values are stored in a different
' flag and thus do not overlap with other style flags. note that these
' values do not correspond to the return values of the dialogs (for
' those values, look at the wxID_XXX defines).
'

' wxCENTRE already defined as  &h00000001
#define wxYES                   &h00000002
#define wxOK                    &h00000004
#define wxNO                    &h00000008
#define wxYES_NO                (wxYES or wxNO)
#define wxCANCEL                &h00000010

#define wxYES_DEFAULT           &h00000000
                                              ' has no effect (default)
#define wxNO_DEFAULT            &h00000080

#define wxICON_EXCLAMATION      &h00000100
#define wxICON_HAND             &h00000200
#define wxICON_WARNING          wxICON_EXCLAMATION
#define wxICON_ERROR            wxICON_HAND
#define wxICON_QUESTION         &h00000400
#define wxICON_INFORMATION      &h00000800
#define wxICON_STOP             wxICON_HAND
#define wxICON_ASTERISK         wxICON_INFORMATION
#define wxICON_MASK             (&h00000100 or &h00000200 or &h00000400 or &h00000800)

#define  wxFORWARD              &h00001000
#define  wxBACKWARD             &h00002000
#define  wxRESET                &h00004000
#define  wxHELP                 &h00008000
#define  wxMORE                 &h00010000
#define  wxSETUP                &h00020000

' ----------------------------------------------------------------------------
' standard IDs
' ----------------------------------------------------------------------------

' any id: means that we don't care about the id, whether when installing an
' event handler or when creating a new window
enum ids0
    wxID_ANY = -1
end enum

' id for a separator line in the menu (invalid for normal item)
enum ids1
    wxID_SEPARATOR = -1
end enum

' Standard menu IDs
enum menu_ids
    wxID_LOWEST = 4999

    wxID_OPEN
    wxID_CLOSE
    wxID_NEW
    wxID_SAVE
    wxID_SAVEAS
    wxID_REVERT
    wxID_EXIT
    wxID_UNDO
    wxID_REDO
    wxID_HELP
    wxID_PRINT
    wxID_PRINT_SETUP
    wxID_PREVIEW
    wxID_ABOUT
    wxID_HELP_CONTENTS
    wxID_HELP_COMMANDS
    wxID_HELP_PROCEDURES
    wxID_HELP_CONTEXT
    wxID_CLOSE_ALL

    wxID_CUT = 5030
    wxID_COPY
    wxID_PASTE
    wxID_CLEAR
    wxID_FIND
    wxID_DUPLICATE
    wxID_SELECTALL

    wxID_FILE1 = 5050
    wxID_FILE2
    wxID_FILE3
    wxID_FILE4
    wxID_FILE5
    wxID_FILE6
    wxID_FILE7
    wxID_FILE8
    wxID_FILE9

    ' Standard button IDs
    wxID_OK = 5100
    wxID_CANCEL
    wxID_APPLY
    wxID_YES
    wxID_NO
    wxID_STATIC
    wxID_FORWARD
    wxID_BACKWARD
    wxID_DEFAULT
    wxID_MORE
    wxID_SETUP
    wxID_RESET
    wxID_CONTEXT_HELP
    wxID_YESTOALL
    wxID_NOTOALL
    wxID_ABORT
    wxID_RETRY
    wxID_IGNORE

    ' System menu IDs (used by wxUniv):
    wxID_SYSTEM_MENU = 5200
    wxID_CLOSE_FRAME
    wxID_MOVE_FRAME
    wxID_RESIZE_FRAME
    wxID_MAXIMIZE_FRAME
    wxID_ICONIZE_FRAME
    wxID_RESTORE_FRAME

    ' IDs used by generic file dialog (13 consecutive starting from this value)
    wxID_FILEDLGG = 5900

    wxID_HIGHEST = 5999
end enum

' ----------------------------------------------------------------------------
' other constants
' ----------------------------------------------------------------------------

' menu and toolbar item kinds
enum wxItemKind
    wxITEM_SEPARATOR = -1
    wxITEM_NORMAL
    wxITEM_CHECK
    wxITEM_RADIO
    wxITEM_MAX
end enum

' hit test results
enum wxHitTest
    wxHT_NOWHERE

    ' scrollbar
    wxHT_SCROLLBAR_FIRST = wxHT_NOWHERE
    wxHT_SCROLLBAR_ARROW_LINE_1    ' left or upper arrow to scroll by line
    wxHT_SCROLLBAR_ARROW_LINE_2    ' right or down
    wxHT_SCROLLBAR_ARROW_PAGE_1    ' left or upper arrow to scroll by page
    wxHT_SCROLLBAR_ARROW_PAGE_2    ' right or down
    wxHT_SCROLLBAR_THUMB           ' on the thumb
    wxHT_SCROLLBAR_BAR_1           ' bar to the left/above the thumb
    wxHT_SCROLLBAR_BAR_2           ' bar to the right/below the thumb
    wxHT_SCROLLBAR_LAST

    ' window
    wxHT_WINDOW_OUTSIDE            ' not in this window at all
    wxHT_WINDOW_INSIDE             ' in the client area
    wxHT_WINDOW_VERT_SCROLLBAR     ' on the vertical scrollbar
    wxHT_WINDOW_HORZ_SCROLLBAR     ' on the horizontal scrollbar
    wxHT_WINDOW_CORNER             ' on the corner between 2 scrollbars

    wxHT_MAX
end enum

' ----------------------------------------------------------------------------
' Possible SetSize flags
' ----------------------------------------------------------------------------

' Use internally-calculated width if -1
#define wxSIZE_AUTO_WIDTH       &h0001
' Use internally-calculated height if -1
#define wxSIZE_AUTO_HEIGHT      &h0002
' Use internally-calculated width and height if each is -1
#define wxSIZE_AUTO             (wxSIZE_AUTO_WIDTHorwxSIZE_AUTO_HEIGHT)
' Ignore missing (-1) dimensions (use existing).
' For readability only: test for wxSIZE_AUTO_WIDTH/HEIGHT in code.
#define wxSIZE_USE_EXISTING     &h0000
' Allow -1 as a valid position
#define wxSIZE_ALLOW_MINUS_ONE  &h0004
' Don't do parent client adjustments (for implementation only)
#define wxSIZE_NO_ADJUSTMENTS   &h0008

' ----------------------------------------------------------------------------
' GDI descriptions
' ----------------------------------------------------------------------------

enum gdi_desc
    ' Text font families
    wxDEFAULT    = 70
    wxDECORATIVE
    wxROMAN
    wxSCRIPT
    wxSWISS
    wxMODERN
    wxTELETYPE  ' @@@@'

    ' Proportional or Fixed width fonts (not yet used)
    wxVARIABLE   = 80
    wxFIXED

    wxNORMAL     = 90
    wxLIGHT
    wxBOLD
    ' Also wxNORMAL for normal (non-italic text)
    wxITALIC
    wxSLANT

    ' Pen styles
    wxSOLID      =   100
    wxDOT
    wxLONG_DASH
    wxSHORT_DASH
    wxDOT_DASH
    wxUSER_DASH

    wxTRANSPARENT

    ' Brush & Pen Stippling. Note that a stippled pen cannot be dashed!!
    ' Note also that stippling a Pen IS meaningfull, because a Line is
    wxSTIPPLE_MASK_OPAQUE 'mask is used for blitting monochrome using text fore and back ground colors
    wxSTIPPLE_MASK        'mask is used for masking areas in the stipple bitmap (TO DO)
    ' drawn with a Pen, and without any Brush -- and it can be stippled.
    wxSTIPPLE =          110
    wxBDIAGONAL_HATCH
    wxCROSSDIAG_HATCH
    wxFDIAGONAL_HATCH
    wxCROSS_HATCH
    wxHORIZONTAL_HATCH
    wxVERTICAL_HATCH

    wxJOIN_BEVEL =     120
    wxJOIN_MITER
    wxJOIN_ROUND

    wxCAP_ROUND =      130
    wxCAP_PROJECTING
    wxCAP_BUTT
end enum

'''' VZ: why doesn't it start with "wx"? FIXME
'''#define IS_HATCH(s)    ((s)>=wxBDIAGONAL_HATCH && (s)<=wxVERTICAL_HATCH)

' Logical ops
enum form_ops_t
  wxCLEAR
  wxROP_BLACK = wxCLEAR
  wxBLIT_BLACKNESS = wxCLEAR        ' 0
  
  wxXOR
  wxROP_XORPEN = wxXOR
  wxBLIT_SRCINVERT = wxXOR          ' src XOR dst
  
  wxINVERT
  wxROP_NOT = wxINVERT
  wxBLIT_DSTINVERT = wxINVERT       ' NOT dst
  
  wxOR_REVERSE
  wxROP_MERGEPENNOT = wxOR_REVERSE
  wxBLIT_00DD0228 = wxOR_REVERSE    ' src OR (NOT dst)
  
  wxAND_REVERSE
  wxROP_MASKPENNOT = wxAND_REVERSE
  wxBLIT_SRCERASE = wxAND_REVERSE   ' src AND (NOT dst)
  
  wxCOPY
  wxROP_COPYPEN = wxCOPY
  wxBLIT_SRCCOPY = wxCOPY           ' src
  
  wxAND
  wxROP_MASKPEN = wxAND
  wxBLIT_SRCAND = wxAND             ' src AND dst
  
  wxAND_INVERT
  wxROP_MASKNOTPEN = wxAND_INVERT
  wxBLIT_00220326 = wxAND_INVERT    ' (NOT src) AND dst
  
  wxNO_OP
  wxROP_NOP = wxNO_OP
  wxBLIT_00AA0029 = wxNO_OP         ' dst
  
  wxNOR
  wxROP_NOTMERGEPEN = wxNOR
  wxBLIT_NOTSRCERASE = wxNOR        ' (NOT src) AND (NOT dst)
  
  wxEQUIV
  wxROP_NOTXORPEN = wxEQUIV
  wxBLIT_00990066 = wxEQUIV         ' (NOT src) XOR dst
  
  wxSRC_INVERT
  wxROP_NOTCOPYPEN = wxSRC_INVERT
  wxBLIT_NOTSCRCOPY = wxSRC_INVERT  ' (NOT src)
  
  wxOR_INVERT
  wxROP_MERGENOTPEN = wxOR_INVERT
  wxBLIT_MERGEPAINT = wxOR_INVERT   ' (NOT src) OR dst
  
  wxNAND
  wxROP_NOTMASKPEN = wxNAND
  wxBLIT_007700E6 = wxNAND          ' (NOT src) OR (NOT dst)
  
  wxOR
  wxROP_MERGEPEN = wxOR
  wxBLIT_SRCPAINT = wxOR            ' src OR dst
  
  wxSET
  wxROP_WHITE = wxSET
  wxBLIT_WHITENESS = wxSET           ' 1
end enum

' Flood styles
enum floodstyles
    wxFLOOD_SURFACE = 1
    wxFLOOD_BORDER
end enum

' Polygon filling mode
enum polyfill
    wxODDEVEN_RULE = 1
    wxWINDING_RULE
end enum

' ToolPanel in wxFrame (VZ: unused?)
enum toolpanel
    wxTOOL_TOP = 1
    wxTOOL_BOTTOM
    wxTOOL_LEFT
    wxTOOL_RIGHT
end enum

' the values of the format constants should be the same as correspondign
' CF_XXX constants in Windows API
enum wxDataFormatId
    wxDF_INVALID =          0
    wxDF_TEXT =             1  ' CF_TEXT'
    wxDF_BITMAP =           2  ' CF_BITMAP'
    wxDF_METAFILE =         3  ' CF_METAFILEPICT'
    wxDF_SYLK =             4
    wxDF_DIF =              5
    wxDF_TIFF =             6
    wxDF_OEMTEXT =          7  ' CF_OEMTEXT'
    wxDF_DIB =              8  ' CF_DIB'
    wxDF_PALETTE =          9
    wxDF_PENDATA =          10
    wxDF_RIFF =             11
    wxDF_WAVE =             12
    wxDF_UNICODETEXT =      13
    wxDF_ENHMETAFILE =      14
    wxDF_FILENAME =         15 ' CF_HDROP'
    wxDF_LOCALE =           16
    wxDF_PRIVATE =          20
    wxDF_HTML =             30 ' Note: does not correspond to CF_ constant'
    wxDF_MAX
end enum

' Virtual keycodes
enum wxKeyCode
    WXK_BACK    =    8
    WXK_TAB     =    9
    WXK_RETURN  =    13
    WXK_ESCAPE  =    27
    WXK_SPACE   =    32
    WXK_DELETE  =    127

    WXK_START   = 300
    WXK_LBUTTON
    WXK_RBUTTON
    WXK_CANCEL
    WXK_MBUTTON
    WXK_CLEAR
    WXK_SHIFT
    WXK_ALT
    WXK_CONTROL
    WXK_MENU
    WXK_PAUSE
    WXK_CAPITAL
    WXK_PRIOR  ' Page up
    WXK_NEXT   ' Page down
    WXK_END
    WXK_HOME
    WXK_LEFT
    WXK_UP
    WXK_RIGHT
    WXK_DOWN
    WXK_SELECT
    WXK_PRINT
    WXK_EXECUTE
    WXK_SNAPSHOT
    WXK_INSERT
    WXK_HELP
    WXK_NUMPAD0
    WXK_NUMPAD1
    WXK_NUMPAD2
    WXK_NUMPAD3
    WXK_NUMPAD4
    WXK_NUMPAD5
    WXK_NUMPAD6
    WXK_NUMPAD7
    WXK_NUMPAD8
    WXK_NUMPAD9
    WXK_MULTIPLY
    WXK_ADD
    WXK_SEPARATOR
    WXK_SUBTRACT
    WXK_DECIMAL
    WXK_DIVIDE
    WXK_F1
    WXK_F2
    WXK_F3
    WXK_F4
    WXK_F5
    WXK_F6
    WXK_F7
    WXK_F8
    WXK_F9
    WXK_F10
    WXK_F11
    WXK_F12
    WXK_F13
    WXK_F14
    WXK_F15
    WXK_F16
    WXK_F17
    WXK_F18
    WXK_F19
    WXK_F20
    WXK_F21
    WXK_F22
    WXK_F23
    WXK_F24
    WXK_NUMLOCK
    WXK_SCROLL
    WXK_PAGEUP
    WXK_PAGEDOWN

    WXK_NUMPAD_SPACE
    WXK_NUMPAD_TAB
    WXK_NUMPAD_ENTER
    WXK_NUMPAD_F1
    WXK_NUMPAD_F2
    WXK_NUMPAD_F3
    WXK_NUMPAD_F4
    WXK_NUMPAD_HOME
    WXK_NUMPAD_LEFT
    WXK_NUMPAD_UP
    WXK_NUMPAD_RIGHT
    WXK_NUMPAD_DOWN
    WXK_NUMPAD_PRIOR
    WXK_NUMPAD_PAGEUP
    WXK_NUMPAD_NEXT
    WXK_NUMPAD_PAGEDOWN
    WXK_NUMPAD_END
    WXK_NUMPAD_BEGIN
    WXK_NUMPAD_INSERT
    WXK_NUMPAD_DELETE
    WXK_NUMPAD_EQUAL
    WXK_NUMPAD_MULTIPLY
    WXK_NUMPAD_ADD
    WXK_NUMPAD_SEPARATOR
    WXK_NUMPAD_SUBTRACT
    WXK_NUMPAD_DECIMAL
    WXK_NUMPAD_DIVIDE
end enum

' Mapping modes (same values as used by Windows, don't change)
enum mapping_modes
    wxMM_TEXT = 1
    wxMM_LOMETRIC
    wxMM_HIMETRIC
    wxMM_LOENGLISH
    wxMM_HIENGLISH
    wxMM_TWIPS
    wxMM_ISOTROPIC
    wxMM_ANISOTROPIC
    wxMM_POINTS
    wxMM_METRIC
end enum

' Shortcut for easier dialog-unit-to-pixel conversion'
#define wxDLG_UNIT(parent, pt) parent->ConvertDialogToPixels(pt)

' Paper types'
enum wxPaperSize
    wxPAPER_NONE               ' Use specific dimensions
    wxPAPER_LETTER             ' Letter, 8 1/2 by 11 inches
    wxPAPER_LEGAL              ' Legal, 8 1/2 by 14 inches
    wxPAPER_A4                 ' A4 Sheet, 210 by 297 millimeters
    wxPAPER_CSHEET             ' C Sheet, 17 by 22 inches
    wxPAPER_DSHEET             ' D Sheet, 22 by 34 inches
    wxPAPER_ESHEET             ' E Sheet, 34 by 44 inches
    wxPAPER_LETTERSMALL        ' Letter Small, 8 1/2 by 11 inches
    wxPAPER_TABLOID            ' Tabloid, 11 by 17 inches
    wxPAPER_LEDGER             ' Ledger, 17 by 11 inches
    wxPAPER_STATEMENT          ' Statement, 5 1/2 by 8 1/2 inches
    wxPAPER_EXECUTIVE          ' Executive, 7 1/4 by 10 1/2 inches
    wxPAPER_A3                 ' A3 sheet, 297 by 420 millimeters
    wxPAPER_A4SMALL            ' A4 small sheet, 210 by 297 millimeters
    wxPAPER_A5                 ' A5 sheet, 148 by 210 millimeters
    wxPAPER_B4                 ' B4 sheet, 250 by 354 millimeters
    wxPAPER_B5                 ' B5 sheet, 182-by-257-millimeter paper
    wxPAPER_FOLIO              ' Folio, 8-1/2-by-13-inch paper
    wxPAPER_QUARTO             ' Quarto, 215-by-275-millimeter paper
    wxPAPER_10x14              ' 10-by-14-inch sheet
    wxPAPER_11X17              ' 11-by-17-inch sheet
    wxPAPER_NOTE               ' Note, 8 1/2 by 11 inches
    wxPAPER_ENV_9              ' #9 Envelope, 3 7/8 by 8 7/8 inches
    wxPAPER_ENV_10             ' #10 Envelope, 4 1/8 by 9 1/2 inches
    wxPAPER_ENV_11             ' #11 Envelope, 4 1/2 by 10 3/8 inches
    wxPAPER_ENV_12             ' #12 Envelope, 4 3/4 by 11 inches
    wxPAPER_ENV_14             ' #14 Envelope, 5 by 11 1/2 inches
    wxPAPER_ENV_DL             ' DL Envelope, 110 by 220 millimeters
    wxPAPER_ENV_C5             ' C5 Envelope, 162 by 229 millimeters
    wxPAPER_ENV_C3             ' C3 Envelope, 324 by 458 millimeters
    wxPAPER_ENV_C4             ' C4 Envelope, 229 by 324 millimeters
    wxPAPER_ENV_C6             ' C6 Envelope, 114 by 162 millimeters
    wxPAPER_ENV_C65            ' C65 Envelope, 114 by 229 millimeters
    wxPAPER_ENV_B4             ' B4 Envelope, 250 by 353 millimeters
    wxPAPER_ENV_B5             ' B5 Envelope, 176 by 250 millimeters
    wxPAPER_ENV_B6             ' B6 Envelope, 176 by 125 millimeters
    wxPAPER_ENV_ITALY          ' Italy Envelope, 110 by 230 millimeters
    wxPAPER_ENV_MONARCH        ' Monarch Envelope, 3 7/8 by 7 1/2 inches
    wxPAPER_ENV_PERSONAL       ' 6 3/4 Envelope, 3 5/8 by 6 1/2 inches
    wxPAPER_FANFOLD_US         ' US Std Fanfold, 14 7/8 by 11 inches
    wxPAPER_FANFOLD_STD_GERMAN ' German Std Fanfold, 8 1/2 by 12 inches
    wxPAPER_FANFOLD_LGL_GERMAN ' German Legal Fanfold, 8 1/2 by 13 inches

    wxPAPER_ISO_B4             ' B4 (ISO) 250 x 353 mm
    wxPAPER_JAPANESE_POSTCARD  ' Japanese Postcard 100 x 148 mm
    wxPAPER_9X11               ' 9 x 11 in
    wxPAPER_10x11              ' 10 x 11 in
    wxPAPER_15X11              ' 15 x 11 in
    wxPAPER_ENV_INVITE         ' Envelope Invite 220 x 220 mm
    wxPAPER_LETTER_EXTRA       ' Letter Extra 9 \275 x 12 in
    wxPAPER_LEGAL_EXTRA        ' Legal Extra 9 \275 x 15 in
    wxPAPER_TABLOID_EXTRA      ' Tabloid Extra 11.69 x 18 in
    wxPAPER_A4_EXTRA           ' A4 Extra 9.27 x 12.69 in
    wxPAPER_LETTER_TRANSVERSE  ' Letter Transverse 8 \275 x 11 in
    wxPAPER_A4_TRANSVERSE      ' A4 Transverse 210 x 297 mm
    wxPAPER_LETTER_EXTRA_TRANSVERSE ' Letter Extra Transverse 9\275 x 12 in
    wxPAPER_A_PLUS             ' SuperA/SuperA/A4 227 x 356 mm
    wxPAPER_B_PLUS             ' SuperB/SuperB/A3 305 x 487 mm
    wxPAPER_LETTER_PLUS        ' Letter Plus 8.5 x 12.69 in
    wxPAPER_A4_PLUS            ' A4 Plus 210 x 330 mm
    wxPAPER_A5_TRANSVERSE      ' A5 Transverse 148 x 210 mm
    wxPAPER_B5_TRANSVERSE      ' B5 (JIS) Transverse 182 x 257 mm
    wxPAPER_A3_EXTRA           ' A3 Extra 322 x 445 mm
    wxPAPER_A5_EXTRA           ' A5 Extra 174 x 235 mm
    wxPAPER_B5_EXTRA           ' B5 (ISO) Extra 201 x 276 mm
    wxPAPER_A2                 ' A2 420 x 594 mm
    wxPAPER_A3_TRANSVERSE      ' A3 Transverse 297 x 420 mm
    wxPAPER_A3_EXTRA_TRANSVERSE ' A3 Extra Transverse 322 x 445 mm
end enum

' Printing orientation'
#ifndef wxPORTRAIT
#define wxPORTRAIT      1
#define wxLANDSCAPE     2
#endif

' Duplex printing modes
'

enum wxDuplexMode
    wxDUPLEX_SIMPLEX ' Non-duplex
    wxDUPLEX_HORIZONTAL
    wxDUPLEX_VERTICAL
end enum

' Print quality.
'

#define wxPRINT_QUALITY_HIGH    -1
#define wxPRINT_QUALITY_MEDIUM  -2
#define wxPRINT_QUALITY_LOW     -3
#define wxPRINT_QUALITY_DRAFT   -4

' Print mode (currently PostScript only)
'

enum wxPrintMode
    wxPRINT_MODE_NONE =    0
    wxPRINT_MODE_PREVIEW = 1   ' Preview in external application
    wxPRINT_MODE_FILE =    2   ' Print to file
    wxPRINT_MODE_PRINTER = 3    ' Send to printer
end enum

' ----------------------------------------------------------------------------
' miscellaneous
' ----------------------------------------------------------------------------

' define this macro if font handling is done using the X font names
#ifndef __FB_WIN32__
    #define _WX_X_FONTLIKE
#endif

' macro to specify "All Files" on different platforms
#ifdef __FB_WIN32__
#   define wxALL_FILES_PATTERN   wxT("*.*")
#   define wxALL_FILES           gettext_noop("All files (*.*)or*.*")
#else
#   define wxALL_FILES_PATTERN   wxT("*")
#   define wxALL_FILES           gettext_noop("All files (*)or*")
#endif






' ----------------------------------------------------------------------------
' wxTextCtrl style flags
' ----------------------------------------------------------------------------

' the flag bits &h0001, and &h0004 are free but should be used only for the
' things which don't make sense for a text control used by wxTextEntryDialog
' because they would otherwise conflict with wxOK, wxCANCEL, wxCENTRE

#define wxTE_NO_VSCROLL     &h0002
#define wxTE_AUTO_SCROLL    &h0008

#define wxTE_READONLY       &h0010
#define wxTE_MULTILINE      &h0020
#define wxTE_PROCESS_TAB    &h0040

' alignment flags
#define wxTE_LEFT           &h0000                    
                                                      ' &h0000
#define wxTE_CENTER         wxALIGN_CENTER_HORIZONTAL 
                                                      ' &h0100
#define wxTE_RIGHT          wxALIGN_RIGHT             
                                                      ' &h0200
#define wxTE_CENTRE         wxTE_CENTER

' this style means to use RICHEDIT control and does something only under wxMSW
' and Win32 and is silently ignored under all other platforms
#define wxTE_RICH           &h0080

#define wxTE_PROCESS_ENTER  &h0400
#define wxTE_PASSWORD       &h0800

' automatically detect the URLs and generate the events when mouse is
' moved/clicked over an URL
'
' this is for Win32 richedit controls only so far
#define wxTE_AUTO_URL       &h1000

' by default, the Windows text control doesn't show the selection when it
' doesn't have focus - use this style to force it to always show it
#define wxTE_NOHIDESEL      &h2000

' use wxHSCROLL to not wrap text at all, wxTE_LINEWRAP to wrap it at any
' position and wxTE_WORDWRAP to wrap at words boundary
#define wxTE_DONTWRAP       wxHSCROLL
#define wxTE_LINEWRAP       &h4000
#define wxTE_WORDWRAP       &h0000  
                                       ' it's just == !wxHSCROLL

' force using RichEdit version 2.0 or 3.0 instead of 1.0 (default) for
' wxTE_RICH controls - can be used together with or instead of wxTE_RICH
#define wxTE_RICH2          &h8000





' ---------------------------------------------------------------------------
' constants
' ---------------------------------------------------------------------------

' Bitmap flags
enum wxBitmapType
    wxBITMAP_TYPE_INVALID          ' should be == 0 for compatibility!
    wxBITMAP_TYPE_BMP
    wxBITMAP_TYPE_BMP_RESOURCE
    wxBITMAP_TYPE_RESOURCE = wxBITMAP_TYPE_BMP_RESOURCE
    wxBITMAP_TYPE_ICO
    wxBITMAP_TYPE_ICO_RESOURCE
    wxBITMAP_TYPE_CUR
    wxBITMAP_TYPE_CUR_RESOURCE
    wxBITMAP_TYPE_XBM
    wxBITMAP_TYPE_XBM_DATA
    wxBITMAP_TYPE_XPM
    wxBITMAP_TYPE_XPM_DATA
    wxBITMAP_TYPE_TIF
    wxBITMAP_TYPE_TIF_RESOURCE
    wxBITMAP_TYPE_GIF
    wxBITMAP_TYPE_GIF_RESOURCE
    wxBITMAP_TYPE_PNG
    wxBITMAP_TYPE_PNG_RESOURCE
    wxBITMAP_TYPE_JPEG
    wxBITMAP_TYPE_JPEG_RESOURCE
    wxBITMAP_TYPE_PNM
    wxBITMAP_TYPE_PNM_RESOURCE
    wxBITMAP_TYPE_PCX
    wxBITMAP_TYPE_PCX_RESOURCE
    wxBITMAP_TYPE_PICT
    wxBITMAP_TYPE_PICT_RESOURCE
    wxBITMAP_TYPE_ICON
    wxBITMAP_TYPE_ICON_RESOURCE
    wxBITMAP_TYPE_ANI
    wxBITMAP_TYPE_IFF
    wxBITMAP_TYPE_MACCURSOR
    wxBITMAP_TYPE_MACCURSOR_RESOURCE
    wxBITMAP_TYPE_ANY = 50
end enum

' Standard cursors
enum wxStockCursor
    wxCURSOR_NONE          ' should be 0
    wxCURSOR_ARROW
    wxCURSOR_RIGHT_ARROW
    wxCURSOR_BULLSEYE
    wxCURSOR_CHAR
    wxCURSOR_CROSS
    wxCURSOR_HAND
    wxCURSOR_IBEAM
    wxCURSOR_LEFT_BUTTON
    wxCURSOR_MAGNIFIER
    wxCURSOR_MIDDLE_BUTTON
    wxCURSOR_NO_ENTRY
    wxCURSOR_PAINT_BRUSH
    wxCURSOR_PENCIL
    wxCURSOR_POINT_LEFT
    wxCURSOR_POINT_RIGHT
    wxCURSOR_QUESTION_ARROW
    wxCURSOR_RIGHT_BUTTON
    wxCURSOR_SIZENESW
    wxCURSOR_SIZENS
    wxCURSOR_SIZENWSE
    wxCURSOR_SIZEWE
    wxCURSOR_SIZING
    wxCURSOR_SPRAYCAN
    wxCURSOR_WAIT
    wxCURSOR_WATCH
    wxCURSOR_BLANK
#ifndef __FB_WIN32__
    wxCURSOR_DEFAULT ' standard X11 cursor
#endif
#ifndef __FB_WIN32__
    ' Not yet implemented for Windows
    wxCURSOR_CROSS_REVERSE
    wxCURSOR_DOUBLE_ARROW
    wxCURSOR_BASED_ARROW_UP
    wxCURSOR_BASED_ARROW_DOWN
#endif ' X11

    wxCURSOR_ARROWWAIT

    wxCURSOR_MAX
end enum

#ifdef __FB_WIN32__
    #define wxCURSOR_DEFAULT wxCURSOR_ARROW
#endif

'splash screen flags
#define wxSPLASH_CENTRE_ON_PARENT   &h01
#define wxSPLASH_CENTRE_ON_SCREEN   &h02
#define wxSPLASH_NO_CENTRE          &h00
#define wxSPLASH_TIMEOUT            &h04
#define wxSPLASH_NO_TIMEOUT         &h00


' font encodings
enum wxFontEncoding
    wxFONTENCODING_SYSTEM = -1     ' system default
    wxFONTENCODING_DEFAULT         ' current default encoding

    ' ISO8859 standard defines a number of single-byte charsets
    wxFONTENCODING_ISO8859_1       ' West European (Latin1)
    wxFONTENCODING_ISO8859_2       ' Central and East European (Latin2)
    wxFONTENCODING_ISO8859_3       ' Esperanto (Latin3)
    wxFONTENCODING_ISO8859_4       ' Baltic (old) (Latin4)
    wxFONTENCODING_ISO8859_5       ' Cyrillic
    wxFONTENCODING_ISO8859_6       ' Arabic
    wxFONTENCODING_ISO8859_7       ' Greek
    wxFONTENCODING_ISO8859_8       ' Hebrew
    wxFONTENCODING_ISO8859_9       ' Turkish (Latin5)
    wxFONTENCODING_ISO8859_10      ' Variation of Latin4 (Latin6)
    wxFONTENCODING_ISO8859_11      ' Thai
    wxFONTENCODING_ISO8859_12      ' doesn't exist currently, but put it
                                    ' here anyhow to make all ISO8859
                                    ' consecutive numbers
    wxFONTENCODING_ISO8859_13      ' Baltic (Latin7)
    wxFONTENCODING_ISO8859_14      ' Latin8
    wxFONTENCODING_ISO8859_15      ' Latin9 (a.k.a. Latin0, includes euro)
    wxFONTENCODING_ISO8859_MAX

    ' Cyrillic charset soup (see http:'czyborra.com/charsets/cyrillic.html)
    wxFONTENCODING_KOI8            ' we don't support any of KOI8 variants
    wxFONTENCODING_ALTERNATIVE     ' same as MS-DOS CP866
    wxFONTENCODING_BULGARIAN       ' used under Linux in Bulgaria

    ' what would we do without Microsoft? They have their own encodings
        ' for DOS
    wxFONTENCODING_CP437           ' original MS-DOS codepage
    wxFONTENCODING_CP850           ' CP437 merged with Latin1
    wxFONTENCODING_CP852           ' CP437 merged with Latin2
    wxFONTENCODING_CP855           ' another cyrillic encoding
    wxFONTENCODING_CP866           ' and another one
        ' and for Windows
    wxFONTENCODING_CP874           ' WinThai
    wxFONTENCODING_CP932           ' Japanese (shift-JIS)
    wxFONTENCODING_CP936           ' Chinese simplified (GB)
    wxFONTENCODING_CP949           ' Korean (Hangul charset)
    wxFONTENCODING_CP950           ' Chinese (traditional - Big5)
    wxFONTENCODING_CP1250          ' WinLatin2
    wxFONTENCODING_CP1251          ' WinCyrillic
    wxFONTENCODING_CP1252          ' WinLatin1
    wxFONTENCODING_CP1253          ' WinGreek (8859-7)
    wxFONTENCODING_CP1254          ' WinTurkish
    wxFONTENCODING_CP1255          ' WinHebrew
    wxFONTENCODING_CP1256          ' WinArabic
    wxFONTENCODING_CP1257          ' WinBaltic (same as Latin 7)
    wxFONTENCODING_CP12_MAX

    wxFONTENCODING_UTF7            ' UTF-7 Unicode encoding
    wxFONTENCODING_UTF8            ' UTF-8 Unicode encoding

    ' Far Eastern encodings
        ' Chinese
    wxFONTENCODING_GB2312 = wxFONTENCODING_CP936 ' Simplified Chinese
    wxFONTENCODING_BIG5 = wxFONTENCODING_CP950   ' Traditional Chinese

        ' Japanese (see http:'zsigri.tripod.com/fontboard/cjk/jis.html)
    wxFONTENCODING_SHIFT_JIS = wxFONTENCODING_CP932  ' Shift JIS
    wxFONTENCODING_EUC_JP = wxFONTENCODING_UTF8 + 1  ' Extended Unix Codepage for Japanese

    wxFONTENCODING_UNICODE         ' Unicode - currently used only by
                                   ' wxEncodingConverter class

    wxFONTENCODING_MAX
end enum

' ----------------------------------------------------------------------------
' font constants
' ----------------------------------------------------------------------------

' standard font families: these may be used only for the font creation, it
' doesn't make sense to query an existing font for its font family as,
' especially if the font had been created from a native font description, it
' may be unknown
enum wxFontFamily
    wxFONTFAMILY_DEFAULT = wxDEFAULT
    wxFONTFAMILY_DECORATIVE = wxDECORATIVE
    wxFONTFAMILY_ROMAN = wxROMAN
    wxFONTFAMILY_SCRIPT = wxSCRIPT
    wxFONTFAMILY_SWISS = wxSWISS
    wxFONTFAMILY_MODERN = wxMODERN
    wxFONTFAMILY_TELETYPE = wxTELETYPE
    wxFONTFAMILY_MAX
    wxFONTFAMILY_UNKNOWN = wxFONTFAMILY_MAX
end enum

' font styles
enum wxFontStyle
    wxFONTSTYLE_NORMAL = wxNORMAL
    wxFONTSTYLE_ITALIC = wxITALIC
    wxFONTSTYLE_SLANT = wxSLANT
    wxFONTSTYLE_MAX
end enum

' font weights
enum wxFontWeight
    wxFONTWEIGHT_NORMAL = wxNORMAL
    wxFONTWEIGHT_LIGHT = wxLIGHT
    wxFONTWEIGHT_BOLD = wxBOLD
    wxFONTWEIGHT_MAX
end enum

'flags for wxstyledtextctrl
'----------------------------------------------------------------------

' Should a wxPopupWindow be used for the call tips and autocomplete windows?
#ifndef wxSTC_USE_POPUP
#define wxSTC_USE_POPUP 1
#endif

'----------------------------------------------------------------------
' BEGIN generated section.  The following code is automatically generated
'       by gen_iface.py.  Do not edit this file.  Edit stc.h.in instead
'       and regenerate

#define wxSTC_INVALID_POSITION -1

' Define start of Scintilla messages to be greater than all edit (EM_*) messages
' as many EM_ messages can be used although that use is deprecated.
#define wxSTC_START 2000
#define wxSTC_OPTIONAL_START 3000
#define wxSTC_LEXER_START 4000
#define wxSTC_WS_INVISIBLE 0
#define wxSTC_WS_VISIBLEALWAYS 1
#define wxSTC_WS_VISIBLEAFTERINDENT 2
#define wxSTC_EOL_CRLF 0
#define wxSTC_EOL_CR 1
#define wxSTC_EOL_LF 2

' The SC_CP_UTF8 value can be used to enter Unicode mode.
' This is the same value as CP_UTF8 in Windows
#define wxSTC_CP_UTF8 65001

' The SC_CP_DBCS value can be used to indicate a DBCS mode for GTK+.
#define wxSTC_CP_DBCS 1
#define wxSTC_MARKER_MAX 31
#define wxSTC_MARK_CIRCLE 0
#define wxSTC_MARK_ROUNDRECT 1
#define wxSTC_MARK_ARROW 2
#define wxSTC_MARK_SMALLRECT 3
#define wxSTC_MARK_SHORTARROW 4
#define wxSTC_MARK_EMPTY 5
#define wxSTC_MARK_ARROWDOWN 6
#define wxSTC_MARK_MINUS 7
#define wxSTC_MARK_PLUS 8

' Shapes used for outlining column.
#define wxSTC_MARK_VLINE 9
#define wxSTC_MARK_LCORNER 10
#define wxSTC_MARK_TCORNER 11
#define wxSTC_MARK_BOXPLUS 12
#define wxSTC_MARK_BOXPLUSCONNECTED 13
#define wxSTC_MARK_BOXMINUS 14
#define wxSTC_MARK_BOXMINUSCONNECTED 15
#define wxSTC_MARK_LCORNERCURVE 16
#define wxSTC_MARK_TCORNERCURVE 17
#define wxSTC_MARK_CIRCLEPLUS 18
#define wxSTC_MARK_CIRCLEPLUSCONNECTED 19
#define wxSTC_MARK_CIRCLEMINUS 20
#define wxSTC_MARK_CIRCLEMINUSCONNECTED 21

' Invisible mark that only sets the line background color.
#define wxSTC_MARK_BACKGROUND 22
#define wxSTC_MARK_DOTDOTDOT 23
#define wxSTC_MARK_ARROWS 24
#define wxSTC_MARK_PIXMAP 25
#define wxSTC_MARK_CHARACTER 10000

' Markers used for outlining column.
#define wxSTC_MARKNUM_FOLDEREND 25
#define wxSTC_MARKNUM_FOLDEROPENMID 26
#define wxSTC_MARKNUM_FOLDERMIDTAIL 27
#define wxSTC_MARKNUM_FOLDERTAIL 28
#define wxSTC_MARKNUM_FOLDERSUB 29
#define wxSTC_MARKNUM_FOLDER 30
#define wxSTC_MARKNUM_FOLDEROPEN 31
#define wxSTC_MASK_FOLDERS &hFE000000
#define wxSTC_MARGIN_SYMBOL 0
#define wxSTC_MARGIN_NUMBER 1

' Styles in range 32..37 are predefined for parts of the UI and are not used as normal styles.
' Styles 38 and 39 are for future use.
#define wxSTC_STYLE_DEFAULT 32
#define wxSTC_STYLE_LINENUMBER 33
#define wxSTC_STYLE_BRACELIGHT 34
#define wxSTC_STYLE_BRACEBAD 35
#define wxSTC_STYLE_CONTROLCHAR 36
#define wxSTC_STYLE_INDENTGUIDE 37
#define wxSTC_STYLE_LASTPREDEFINED 39
#define wxSTC_STYLE_MAX 127

' Character set identifiers are used in StyleSetCharacterSet.
' The values are the same as the Windows *_CHARSET values.
#define wxSTC_CHARSET_ANSI 0
#define wxSTC_CHARSET_DEFAULT 1
#define wxSTC_CHARSET_BALTIC 186
#define wxSTC_CHARSET_CHINESEBIG5 136
#define wxSTC_CHARSET_EASTEUROPE 238
#define wxSTC_CHARSET_GB2312 134
#define wxSTC_CHARSET_GREEK 161
#define wxSTC_CHARSET_HANGUL 129
#define wxSTC_CHARSET_MAC 77
#define wxSTC_CHARSET_OEM 255
#define wxSTC_CHARSET_RUSSIAN 204
#define wxSTC_CHARSET_SHIFTJIS 128
#define wxSTC_CHARSET_SYMBOL 2
#define wxSTC_CHARSET_TURKISH 162
#define wxSTC_CHARSET_JOHAB 130
#define wxSTC_CHARSET_HEBREW 177
#define wxSTC_CHARSET_ARABIC 178
#define wxSTC_CHARSET_VIETNAMESE 163
#define wxSTC_CHARSET_THAI 222
#define wxSTC_CASE_MIXED 0
#define wxSTC_CASE_UPPER 1
#define wxSTC_CASE_LOWER 2
#define wxSTC_INDIC_MAX 7
#define wxSTC_INDIC_PLAIN 0
#define wxSTC_INDIC_SQUIGGLE 1
#define wxSTC_INDIC_TT 2
#define wxSTC_INDIC_DIAGONAL 3
#define wxSTC_INDIC_STRIKE 4
#define wxSTC_INDIC_HIDDEN 5
#define wxSTC_INDIC0_MASK &h20
#define wxSTC_INDIC1_MASK &h40
#define wxSTC_INDIC2_MASK &h80
#define wxSTC_INDICS_MASK &hE0

' PrintColourMode - use same colours as screen.
#define wxSTC_PRINT_NORMAL 0

' PrintColourMode - invert the light value of each style for printing.
#define wxSTC_PRINT_INVERTLIGHT 1

' PrintColourMode - force black text on white background for printing.
#define wxSTC_PRINT_BLACKONWHITE 2

' PrintColourMode - text stays coloured, but all background is forced to be white for printing.
#define wxSTC_PRINT_COLOURONWHITE 3

' PrintColourMode - only the default-background is forced to be white for printing.
#define wxSTC_PRINT_COLOURONWHITEDEFAULTBG 4
#define wxSTC_FIND_WHOLEWORD 2
#define wxSTC_FIND_MATCHCASE 4
#define wxSTC_FIND_WORDSTART &h00100000
#define wxSTC_FIND_REGEXP &h00200000
#define wxSTC_FIND_POSIX &h00400000
#define wxSTC_FOLDLEVELBASE &h400
#define wxSTC_FOLDLEVELWHITEFLAG &h1000
#define wxSTC_FOLDLEVELHEADERFLAG &h2000
#define wxSTC_FOLDLEVELBOXHEADERFLAG &h4000
#define wxSTC_FOLDLEVELBOXFOOTERFLAG &h8000
#define wxSTC_FOLDLEVELCONTRACTED &h10000
#define wxSTC_FOLDLEVELUNINDENT &h20000
#define wxSTC_FOLDLEVELNUMBERMASK &h0FFF
#define wxSTC_FOLDFLAG_LINEBEFORE_EXPANDED &h0002
#define wxSTC_FOLDFLAG_LINEBEFORE_CONTRACTED &h0004
#define wxSTC_FOLDFLAG_LINEAFTER_EXPANDED &h0008
#define wxSTC_FOLDFLAG_LINEAFTER_CONTRACTED &h0010
#define wxSTC_FOLDFLAG_LEVELNUMBERS &h0040
#define wxSTC_FOLDFLAG_BOX &h0001
#define wxSTC_TIME_FOREVER 10000000
#define wxSTC_WRAP_NONE 0
#define wxSTC_WRAP_WORD 1
#define wxSTC_CACHE_NONE 0
#define wxSTC_CACHE_CARET 1
#define wxSTC_CACHE_PAGE 2
#define wxSTC_CACHE_DOCUMENT 3
#define wxSTC_EDGE_NONE 0
#define wxSTC_EDGE_LINE 1
#define wxSTC_EDGE_BACKGROUND 2
#define wxSTC_CURSORNORMAL -1
#define wxSTC_CURSORWAIT 4

' Constants for use with SetVisiblePolicy, similar to SetCaretPolicy.
#define wxSTC_VISIBLE_SLOP &h01
#define wxSTC_VISIBLE_STRICT &h04

' Caret policy, used by SetXCaretPolicy and SetYCaretPolicy.
' If CARET_SLOP is set, we can define a slop value: caretSlop.
' This value defines an unwanted zone (UZ) where the caret is... unwanted.
' This zone is defined as a number of pixels near the vertical margins,
' and as a number of lines near the horizontal margins.
' By keeping the caret away from the edges, it is seen within its context,
' so it is likely that the identifier that the caret is on can be completely seen,
' and that the current line is seen with some of the lines following it which are
' often dependent on that line.
#define wxSTC_CARET_SLOP &h01

' If CARET_STRICT is set, the policy is enforced... strictly.
' The caret is centred on the display if slop is not set,
' and cannot go in the UZ if slop is set.
#define wxSTC_CARET_STRICT &h04

' If CARET_JUMPS is set, the display is moved more energetically
' so the caret can move in the same direction longer before the policy is applied again.
#define wxSTC_CARET_JUMPS &h10

' If CARET_EVEN is not set, instead of having symmetrical UZs,
' the left and bottom UZs are extended up to right and top UZs respectively.
' This way, we favour the displaying of useful information: the begining of lines,
' where most code reside, and the lines after the caret, eg. the body of a function.
#define wxSTC_CARET_EVEN &h08

' Maximum value of keywordSet parameter of SetKeyWords.
#define wxSTC_KEYWORDSET_MAX 8

' Notifications
' Type of modification and the action which caused the modification.
' These are defined as a bit mask to make it easy to specify which notifications are wanted.
' One bit is set from each of SC_MOD_* and SC_PERFORMED_*.
#define wxSTC_MOD_INSERTTEXT &h1
#define wxSTC_MOD_DELETETEXT &h2
#define wxSTC_MOD_CHANGESTYLE &h4
#define wxSTC_MOD_CHANGEFOLD &h8
#define wxSTC_PERFORMED_USER &h10
#define wxSTC_PERFORMED_UNDO &h20
#define wxSTC_PERFORMED_REDO &h40
#define wxSTC_LASTSTEPINUNDOREDO &h100
#define wxSTC_MOD_CHANGEMARKER &h200
#define wxSTC_MOD_BEFOREINSERT &h400
#define wxSTC_MOD_BEFOREDELETE &h800
#define wxSTC_MODEVENTMASKALL &hF77

' Symbolic key codes and modifier flags.
' ASCII and other printable characters below 256.
' Extended keys above 300.
#define wxSTC_KEY_DOWN 300
#define wxSTC_KEY_UP 301
#define wxSTC_KEY_LEFT 302
#define wxSTC_KEY_RIGHT 303
#define wxSTC_KEY_HOME 304
#define wxSTC_KEY_END 305
#define wxSTC_KEY_PRIOR 306
#define wxSTC_KEY_NEXT 307
#define wxSTC_KEY_DELETE 308
#define wxSTC_KEY_INSERT 309
#define wxSTC_KEY_ESCAPE 7
#define wxSTC_KEY_BACK 8
#define wxSTC_KEY_TAB 9
#define wxSTC_KEY_RETURN 13
#define wxSTC_KEY_ADD 310
#define wxSTC_KEY_SUBTRACT 311
#define wxSTC_KEY_DIVIDE 312
#define wxSTC_SCMOD_SHIFT 1
#define wxSTC_SCMOD_CTRL 2
#define wxSTC_SCMOD_ALT 4

' For SciLexer.h
#define wxSTC_LEX_CONTAINER 0
#define wxSTC_LEX_NULL 1
#define wxSTC_LEX_PYTHON 2
#define wxSTC_LEX_CPP 3
#define wxSTC_LEX_HTML 4
#define wxSTC_LEX_XML 5
#define wxSTC_LEX_PERL 6
#define wxSTC_LEX_SQL 7
#define wxSTC_LEX_VB 8
#define wxSTC_LEX_PROPERTIES 9
#define wxSTC_LEX_ERRORLIST 10
#define wxSTC_LEX_MAKEFILE 11
#define wxSTC_LEX_BATCH 12
#define wxSTC_LEX_XCODE 13
#define wxSTC_LEX_LATEX 14
#define wxSTC_LEX_LUA 15
#define wxSTC_LEX_DIFF 16
#define wxSTC_LEX_CONF 17
#define wxSTC_LEX_PASCAL 18
#define wxSTC_LEX_AVE 19
#define wxSTC_LEX_ADA 20
#define wxSTC_LEX_LISP 21
#define wxSTC_LEX_RUBY 22
#define wxSTC_LEX_EIFFEL 23
#define wxSTC_LEX_EIFFELKW 24
#define wxSTC_LEX_TCL 25
#define wxSTC_LEX_NNCRONTAB 26
#define wxSTC_LEX_BULLANT 27
#define wxSTC_LEX_VBSCRIPT 28
#define wxSTC_LEX_ASP 29
#define wxSTC_LEX_PHP 30
#define wxSTC_LEX_BAAN 31
#define wxSTC_LEX_MATLAB 32
#define wxSTC_LEX_SCRIPTOL 33
#define wxSTC_LEX_ASM 34
#define wxSTC_LEX_CPPNOCASE 35
#define wxSTC_LEX_FORTRAN 36
#define wxSTC_LEX_F77 37
#define wxSTC_LEX_CSS 38
#define wxSTC_LEX_POV 39
#define wxSTC_LEX_LOUT 40
#define wxSTC_LEX_ESCRIPT 41
#define wxSTC_LEX_PS 42
#define wxSTC_LEX_NSIS 43
#define wxSTC_LEX_MMIXAL 44

' When a lexer specifies its language as SCLEX_AUTOMATIC it receives a
' value assigned in sequence from SCLEX_AUTOMATIC+1.
#define wxSTC_LEX_AUTOMATIC 1000

' Lexical states for SCLEX_PYTHON
#define wxSTC_P_DEFAULT 0
#define wxSTC_P_COMMENTLINE 1
#define wxSTC_P_NUMBER 2
#define wxSTC_P_STRING 3
#define wxSTC_P_CHARACTER 4
#define wxSTC_P_WORD 5
#define wxSTC_P_TRIPLE 6
#define wxSTC_P_TRIPLEDOUBLE 7
#define wxSTC_P_CLASSNAME 8
#define wxSTC_P_DEFNAME 9
#define wxSTC_P_OPERATOR 10
#define wxSTC_P_IDENTIFIER 11
#define wxSTC_P_COMMENTBLOCK 12
#define wxSTC_P_STRINGEOL 13

' Lexical states for SCLEX_CPP
#define wxSTC_C_DEFAULT 0
#define wxSTC_C_COMMENT 1
#define wxSTC_C_COMMENTLINE 2
#define wxSTC_C_COMMENTDOC 3
#define wxSTC_C_NUMBER 4
#define wxSTC_C_WORD 5
#define wxSTC_C_STRING 6
#define wxSTC_C_CHARACTER 7
#define wxSTC_C_UUID 8
#define wxSTC_C_PREPROCESSOR 9
#define wxSTC_C_OPERATOR 10
#define wxSTC_C_IDENTIFIER 11
#define wxSTC_C_STRINGEOL 12
#define wxSTC_C_VERBATIM 13
#define wxSTC_C_REGEX 14
#define wxSTC_C_COMMENTLINEDOC 15
#define wxSTC_C_WORD2 16
#define wxSTC_C_COMMENTDOCKEYWORD 17
#define wxSTC_C_COMMENTDOCKEYWORDERROR 18
#define wxSTC_C_GLOBALCLASS 19

' Lexical states for SCLEX_HTML, SCLEX_XML
#define wxSTC_H_DEFAULT 0
#define wxSTC_H_TAG 1
#define wxSTC_H_TAGUNKNOWN 2
#define wxSTC_H_ATTRIBUTE 3
#define wxSTC_H_ATTRIBUTEUNKNOWN 4
#define wxSTC_H_NUMBER 5
#define wxSTC_H_DOUBLESTRING 6
#define wxSTC_H_SINGLESTRING 7
#define wxSTC_H_OTHER 8
#define wxSTC_H_COMMENT 9
#define wxSTC_H_ENTITY 10

' XML and ASP
#define wxSTC_H_TAGEND 11
#define wxSTC_H_XMLSTART 12
#define wxSTC_H_XMLEND 13
#define wxSTC_H_SCRIPT 14
#define wxSTC_H_ASP 15
#define wxSTC_H_ASPAT 16
#define wxSTC_H_CDATA 17
#define wxSTC_H_QUESTION 18

' More HTML
#define wxSTC_H_VALUE 19

' X-Code
#define wxSTC_H_XCCOMMENT 20

' SGML
#define wxSTC_H_SGML_DEFAULT 21
#define wxSTC_H_SGML_COMMAND 22
#define wxSTC_H_SGML_1ST_PARAM 23
#define wxSTC_H_SGML_DOUBLESTRING 24
#define wxSTC_H_SGML_SIMPLESTRING 25
#define wxSTC_H_SGML_ERROR 26
#define wxSTC_H_SGML_SPECIAL 27
#define wxSTC_H_SGML_ENTITY 28
#define wxSTC_H_SGML_COMMENT 29
#define wxSTC_H_SGML_1ST_PARAM_COMMENT 30
#define wxSTC_H_SGML_BLOCK_DEFAULT 31

' Embedded Javascript
#define wxSTC_HJ_START 40
#define wxSTC_HJ_DEFAULT 41
#define wxSTC_HJ_COMMENT 42
#define wxSTC_HJ_COMMENTLINE 43
#define wxSTC_HJ_COMMENTDOC 44
#define wxSTC_HJ_NUMBER 45
#define wxSTC_HJ_WORD 46
#define wxSTC_HJ_KEYWORD 47
#define wxSTC_HJ_DOUBLESTRING 48
#define wxSTC_HJ_SINGLESTRING 49
#define wxSTC_HJ_SYMBOLS 50
#define wxSTC_HJ_STRINGEOL 51
#define wxSTC_HJ_REGEX 52

' ASP Javascript
#define wxSTC_HJA_START 55
#define wxSTC_HJA_DEFAULT 56
#define wxSTC_HJA_COMMENT 57
#define wxSTC_HJA_COMMENTLINE 58
#define wxSTC_HJA_COMMENTDOC 59
#define wxSTC_HJA_NUMBER 60
#define wxSTC_HJA_WORD 61
#define wxSTC_HJA_KEYWORD 62
#define wxSTC_HJA_DOUBLESTRING 63
#define wxSTC_HJA_SINGLESTRING 64
#define wxSTC_HJA_SYMBOLS 65
#define wxSTC_HJA_STRINGEOL 66
#define wxSTC_HJA_REGEX 67

' Embedded VBScript
#define wxSTC_HB_START 70
#define wxSTC_HB_DEFAULT 71
#define wxSTC_HB_COMMENTLINE 72
#define wxSTC_HB_NUMBER 73
#define wxSTC_HB_WORD 74
#define wxSTC_HB_STRING 75
#define wxSTC_HB_IDENTIFIER 76
#define wxSTC_HB_STRINGEOL 77

' ASP VBScript
#define wxSTC_HBA_START 80
#define wxSTC_HBA_DEFAULT 81
#define wxSTC_HBA_COMMENTLINE 82
#define wxSTC_HBA_NUMBER 83
#define wxSTC_HBA_WORD 84
#define wxSTC_HBA_STRING 85
#define wxSTC_HBA_IDENTIFIER 86
#define wxSTC_HBA_STRINGEOL 87

' Embedded Python
#define wxSTC_HP_START 90
#define wxSTC_HP_DEFAULT 91
#define wxSTC_HP_COMMENTLINE 92
#define wxSTC_HP_NUMBER 93
#define wxSTC_HP_STRING 94
#define wxSTC_HP_CHARACTER 95
#define wxSTC_HP_WORD 96
#define wxSTC_HP_TRIPLE 97
#define wxSTC_HP_TRIPLEDOUBLE 98
#define wxSTC_HP_CLASSNAME 99
#define wxSTC_HP_DEFNAME 100
#define wxSTC_HP_OPERATOR 101
#define wxSTC_HP_IDENTIFIER 102

' ASP Python
#define wxSTC_HPA_START 105
#define wxSTC_HPA_DEFAULT 106
#define wxSTC_HPA_COMMENTLINE 107
#define wxSTC_HPA_NUMBER 108
#define wxSTC_HPA_STRING 109
#define wxSTC_HPA_CHARACTER 110
#define wxSTC_HPA_WORD 111
#define wxSTC_HPA_TRIPLE 112
#define wxSTC_HPA_TRIPLEDOUBLE 113
#define wxSTC_HPA_CLASSNAME 114
#define wxSTC_HPA_DEFNAME 115
#define wxSTC_HPA_OPERATOR 116
#define wxSTC_HPA_IDENTIFIER 117

' PHP
#define wxSTC_HPHP_DEFAULT 118
#define wxSTC_HPHP_HSTRING 119
#define wxSTC_HPHP_SIMPLESTRING 120
#define wxSTC_HPHP_WORD 121
#define wxSTC_HPHP_NUMBER 122
#define wxSTC_HPHP_VARIABLE 123
#define wxSTC_HPHP_COMMENT 124
#define wxSTC_HPHP_COMMENTLINE 125
#define wxSTC_HPHP_HSTRING_VARIABLE 126
#define wxSTC_HPHP_OPERATOR 127

' Lexical states for SCLEX_PERL
#define wxSTC_PL_DEFAULT 0
#define wxSTC_PL_ERROR 1
#define wxSTC_PL_COMMENTLINE 2
#define wxSTC_PL_POD 3
#define wxSTC_PL_NUMBER 4
#define wxSTC_PL_WORD 5
#define wxSTC_PL_STRING 6
#define wxSTC_PL_CHARACTER 7
#define wxSTC_PL_PUNCTUATION 8
#define wxSTC_PL_PREPROCESSOR 9
#define wxSTC_PL_OPERATOR 10
#define wxSTC_PL_IDENTIFIER 11
#define wxSTC_PL_SCALAR 12
#define wxSTC_PL_ARRAY 13
#define wxSTC_PL_HASH 14
#define wxSTC_PL_SYMBOLTABLE 15
#define wxSTC_PL_REGEX 17
#define wxSTC_PL_REGSUBST 18
#define wxSTC_PL_LONGQUOTE 19
#define wxSTC_PL_BACKTICKS 20
#define wxSTC_PL_DATASECTION 21
#define wxSTC_PL_HERE_DELIM 22
#define wxSTC_PL_HERE_Q 23
#define wxSTC_PL_HERE_QQ 24
#define wxSTC_PL_HERE_QX 25
#define wxSTC_PL_STRING_Q 26
#define wxSTC_PL_STRING_QQ 27
#define wxSTC_PL_STRING_QX 28
#define wxSTC_PL_STRING_QR 29
#define wxSTC_PL_STRING_QW 30

' Lexical states for SCLEX_VB, SCLEX_VBSCRIPT
#define wxSTC_B_DEFAULT 0
#define wxSTC_B_COMMENT 1
#define wxSTC_B_NUMBER 2
#define wxSTC_B_KEYWORD 3
#define wxSTC_B_STRING 4
#define wxSTC_B_PREPROCESSOR 5
#define wxSTC_B_OPERATOR 6
#define wxSTC_B_IDENTIFIER 7
#define wxSTC_B_DATE 8

' Lexical states for SCLEX_PROPERTIES
#define wxSTC_PROPS_DEFAULT 0
#define wxSTC_PROPS_COMMENT 1
#define wxSTC_PROPS_SECTION 2
#define wxSTC_PROPS_ASSIGNMENT 3
#define wxSTC_PROPS_DEFVAL 4

' Lexical states for SCLEX_LATEX
#define wxSTC_L_DEFAULT 0
#define wxSTC_L_COMMAND 1
#define wxSTC_L_TAG 2
#define wxSTC_L_MATH 3
#define wxSTC_L_COMMENT 4

' Lexical states for SCLEX_LUA
#define wxSTC_LUA_DEFAULT 0
#define wxSTC_LUA_COMMENT 1
#define wxSTC_LUA_COMMENTLINE 2
#define wxSTC_LUA_COMMENTDOC 3
#define wxSTC_LUA_NUMBER 4
#define wxSTC_LUA_WORD 5
#define wxSTC_LUA_STRING 6
#define wxSTC_LUA_CHARACTER 7
#define wxSTC_LUA_LITERALSTRING 8
#define wxSTC_LUA_PREPROCESSOR 9
#define wxSTC_LUA_OPERATOR 10
#define wxSTC_LUA_IDENTIFIER 11
#define wxSTC_LUA_STRINGEOL 12
#define wxSTC_LUA_WORD2 13
#define wxSTC_LUA_WORD3 14
#define wxSTC_LUA_WORD4 15
#define wxSTC_LUA_WORD5 16
#define wxSTC_LUA_WORD6 17
#define wxSTC_LUA_WORD7 18
#define wxSTC_LUA_WORD8 19

' Lexical states for SCLEX_ERRORLIST
#define wxSTC_ERR_DEFAULT 0
#define wxSTC_ERR_PYTHON 1
#define wxSTC_ERR_GCC 2
#define wxSTC_ERR_MS 3
#define wxSTC_ERR_CMD 4
#define wxSTC_ERR_BORLAND 5
#define wxSTC_ERR_PERL 6
#define wxSTC_ERR_NET 7
#define wxSTC_ERR_LUA 8
#define wxSTC_ERR_CTAG 9
#define wxSTC_ERR_DIFF_CHANGED 10
#define wxSTC_ERR_DIFF_ADDITION 11
#define wxSTC_ERR_DIFF_DELETION 12
#define wxSTC_ERR_DIFF_MESSAGE 13
#define wxSTC_ERR_PHP 14
#define wxSTC_ERR_ELF 15
#define wxSTC_ERR_IFC 16

' Lexical states for SCLEX_BATCH
#define wxSTC_BAT_DEFAULT 0
#define wxSTC_BAT_COMMENT 1
#define wxSTC_BAT_WORD 2
#define wxSTC_BAT_LABEL 3
#define wxSTC_BAT_HIDE 4
#define wxSTC_BAT_COMMAND 5
#define wxSTC_BAT_IDENTIFIER 6
#define wxSTC_BAT_OPERATOR 7

' Lexical states for SCLEX_MAKEFILE
#define wxSTC_MAKE_DEFAULT 0
#define wxSTC_MAKE_COMMENT 1
#define wxSTC_MAKE_PREPROCESSOR 2
#define wxSTC_MAKE_IDENTIFIER 3
#define wxSTC_MAKE_OPERATOR 4
#define wxSTC_MAKE_TARGET 5
#define wxSTC_MAKE_IDEOL 9

' Lexical states for SCLEX_DIFF
#define wxSTC_DIFF_DEFAULT 0
#define wxSTC_DIFF_COMMENT 1
#define wxSTC_DIFF_COMMAND 2
#define wxSTC_DIFF_HEADER 3
#define wxSTC_DIFF_POSITION 4
#define wxSTC_DIFF_DELETED 5
#define wxSTC_DIFF_ADDED 6

' Lexical states for SCLEX_CONF (Apache Configuration Files Lexer)
#define wxSTC_CONF_DEFAULT 0
#define wxSTC_CONF_COMMENT 1
#define wxSTC_CONF_NUMBER 2
#define wxSTC_CONF_IDENTIFIER 3
#define wxSTC_CONF_EXTENSION 4
#define wxSTC_CONF_PARAMETER 5
#define wxSTC_CONF_STRING 6
#define wxSTC_CONF_OPERATOR 7
#define wxSTC_CONF_IP 8
#define wxSTC_CONF_DIRECTIVE 9

' Lexical states for SCLEX_AVE, Avenue
#define wxSTC_AVE_DEFAULT 0
#define wxSTC_AVE_COMMENT 1
#define wxSTC_AVE_NUMBER 2
#define wxSTC_AVE_WORD 3
#define wxSTC_AVE_STRING 6
#define wxSTC_AVE_ENUM 7
#define wxSTC_AVE_STRINGEOL 8
#define wxSTC_AVE_IDENTIFIER 9
#define wxSTC_AVE_OPERATOR 10
#define wxSTC_AVE_WORD1 11
#define wxSTC_AVE_WORD2 12
#define wxSTC_AVE_WORD3 13
#define wxSTC_AVE_WORD4 14
#define wxSTC_AVE_WORD5 15
#define wxSTC_AVE_WORD6 16

' Lexical states for SCLEX_ADA
#define wxSTC_ADA_DEFAULT 0
#define wxSTC_ADA_WORD 1
#define wxSTC_ADA_IDENTIFIER 2
#define wxSTC_ADA_NUMBER 3
#define wxSTC_ADA_DELIMITER 4
#define wxSTC_ADA_CHARACTER 5
#define wxSTC_ADA_CHARACTEREOL 6
#define wxSTC_ADA_STRING 7
#define wxSTC_ADA_STRINGEOL 8
#define wxSTC_ADA_LABEL 9
#define wxSTC_ADA_COMMENTLINE 10
#define wxSTC_ADA_ILLEGAL 11

' Lexical states for SCLEX_BAAN
#define wxSTC_BAAN_DEFAULT 0
#define wxSTC_BAAN_COMMENT 1
#define wxSTC_BAAN_COMMENTDOC 2
#define wxSTC_BAAN_NUMBER 3
#define wxSTC_BAAN_WORD 4
#define wxSTC_BAAN_STRING 5
#define wxSTC_BAAN_PREPROCESSOR 6
#define wxSTC_BAAN_OPERATOR 7
#define wxSTC_BAAN_IDENTIFIER 8
#define wxSTC_BAAN_STRINGEOL 9
#define wxSTC_BAAN_WORD2 10

' Lexical states for SCLEX_LISP
#define wxSTC_LISP_DEFAULT 0
#define wxSTC_LISP_COMMENT 1
#define wxSTC_LISP_NUMBER 2
#define wxSTC_LISP_KEYWORD 3
#define wxSTC_LISP_STRING 6
#define wxSTC_LISP_STRINGEOL 8
#define wxSTC_LISP_IDENTIFIER 9
#define wxSTC_LISP_OPERATOR 10

' Lexical states for SCLEX_EIFFEL and SCLEX_EIFFELKW
#define wxSTC_EIFFEL_DEFAULT 0
#define wxSTC_EIFFEL_COMMENTLINE 1
#define wxSTC_EIFFEL_NUMBER 2
#define wxSTC_EIFFEL_WORD 3
#define wxSTC_EIFFEL_STRING 4
#define wxSTC_EIFFEL_CHARACTER 5
#define wxSTC_EIFFEL_OPERATOR 6
#define wxSTC_EIFFEL_IDENTIFIER 7
#define wxSTC_EIFFEL_STRINGEOL 8

' Lexical states for SCLEX_NNCRONTAB (nnCron crontab Lexer)
#define wxSTC_NNCRONTAB_DEFAULT 0
#define wxSTC_NNCRONTAB_COMMENT 1
#define wxSTC_NNCRONTAB_TASK 2
#define wxSTC_NNCRONTAB_SECTION 3
#define wxSTC_NNCRONTAB_KEYWORD 4
#define wxSTC_NNCRONTAB_MODIFIER 5
#define wxSTC_NNCRONTAB_ASTERISK 6
#define wxSTC_NNCRONTAB_NUMBER 7
#define wxSTC_NNCRONTAB_STRING 8
#define wxSTC_NNCRONTAB_ENVIRONMENT 9
#define wxSTC_NNCRONTAB_IDENTIFIER 10

' Lexical states for SCLEX_MATLAB
#define wxSTC_MATLAB_DEFAULT 0
#define wxSTC_MATLAB_COMMENT 1
#define wxSTC_MATLAB_COMMAND 2
#define wxSTC_MATLAB_NUMBER 3
#define wxSTC_MATLAB_KEYWORD 4
#define wxSTC_MATLAB_STRING 5
#define wxSTC_MATLAB_OPERATOR 6
#define wxSTC_MATLAB_IDENTIFIER 7

' Lexical states for SCLEX_SCRIPTOL
#define wxSTC_SCRIPTOL_DEFAULT 0
#define wxSTC_SCRIPTOL_COMMENT 1
#define wxSTC_SCRIPTOL_COMMENTLINE 2
#define wxSTC_SCRIPTOL_COMMENTDOC 3
#define wxSTC_SCRIPTOL_NUMBER 4
#define wxSTC_SCRIPTOL_WORD 5
#define wxSTC_SCRIPTOL_STRING 6
#define wxSTC_SCRIPTOL_CHARACTER 7
#define wxSTC_SCRIPTOL_UUID 8
#define wxSTC_SCRIPTOL_PREPROCESSOR 9
#define wxSTC_SCRIPTOL_OPERATOR 10
#define wxSTC_SCRIPTOL_IDENTIFIER 11
#define wxSTC_SCRIPTOL_STRINGEOL 12
#define wxSTC_SCRIPTOL_VERBATIM 13
#define wxSTC_SCRIPTOL_REGEX 14
#define wxSTC_SCRIPTOL_COMMENTLINEDOC 15
#define wxSTC_SCRIPTOL_WORD2 16
#define wxSTC_SCRIPTOL_COMMENTDOCKEYWORD 17
#define wxSTC_SCRIPTOL_COMMENTDOCKEYWORDERROR 18
#define wxSTC_SCRIPTOL_COMMENTBASIC 19

' Lexical states for SCLEX_ASM
#define wxSTC_ASM_DEFAULT 0
#define wxSTC_ASM_COMMENT 1
#define wxSTC_ASM_NUMBER 2
#define wxSTC_ASM_STRING 3
#define wxSTC_ASM_OPERATOR 4
#define wxSTC_ASM_IDENTIFIER 5
#define wxSTC_ASM_CPUINSTRUCTION 6
#define wxSTC_ASM_MATHINSTRUCTION 7
#define wxSTC_ASM_REGISTER 8
#define wxSTC_ASM_DIRECTIVE 9
#define wxSTC_ASM_DIRECTIVEOPERAND 10

' Lexical states for SCLEX_FORTRAN
#define wxSTC_F_DEFAULT 0
#define wxSTC_F_COMMENT 1
#define wxSTC_F_NUMBER 2
#define wxSTC_F_STRING1 3
#define wxSTC_F_STRING2 4
#define wxSTC_F_STRINGEOL 5
#define wxSTC_F_OPERATOR 6
#define wxSTC_F_IDENTIFIER 7
#define wxSTC_F_WORD 8
#define wxSTC_F_WORD2 9
#define wxSTC_F_WORD3 10
#define wxSTC_F_PREPROCESSOR 11
#define wxSTC_F_OPERATOR2 12
#define wxSTC_F_LABEL 13
#define wxSTC_F_CONTINUATION 14

' Lexical states for SCLEX_CSS
#define wxSTC_CSS_DEFAULT 0
#define wxSTC_CSS_TAG 1
#define wxSTC_CSS_CLASS 2
#define wxSTC_CSS_PSEUDOCLASS 3
#define wxSTC_CSS_UNKNOWN_PSEUDOCLASS 4
#define wxSTC_CSS_OPERATOR 5
#define wxSTC_CSS_IDENTIFIER 6
#define wxSTC_CSS_UNKNOWN_IDENTIFIER 7
#define wxSTC_CSS_VALUE 8
#define wxSTC_CSS_COMMENT 9
#define wxSTC_CSS_ID 10
#define wxSTC_CSS_IMPORTANT 11
#define wxSTC_CSS_DIRECTIVE 12
#define wxSTC_CSS_DOUBLESTRING 13
#define wxSTC_CSS_SINGLESTRING 14

' Lexical states for SCLEX_POV
#define wxSTC_POV_DEFAULT 0
#define wxSTC_POV_COMMENT 1
#define wxSTC_POV_COMMENTLINE 2
#define wxSTC_POV_NUMBER 3
#define wxSTC_POV_OPERATOR 4
#define wxSTC_POV_IDENTIFIER 5
#define wxSTC_POV_STRING 6
#define wxSTC_POV_STRINGEOL 7
#define wxSTC_POV_DIRECTIVE 8
#define wxSTC_POV_BADDIRECTIVE 9
#define wxSTC_POV_WORD2 10
#define wxSTC_POV_WORD3 11
#define wxSTC_POV_WORD4 12
#define wxSTC_POV_WORD5 13
#define wxSTC_POV_WORD6 14
#define wxSTC_POV_WORD7 15
#define wxSTC_POV_WORD8 16

' Lexical states for SCLEX_LOUT
#define wxSTC_LOUT_DEFAULT 0
#define wxSTC_LOUT_COMMENT 1
#define wxSTC_LOUT_NUMBER 2
#define wxSTC_LOUT_WORD 3
#define wxSTC_LOUT_WORD2 4
#define wxSTC_LOUT_WORD3 5
#define wxSTC_LOUT_WORD4 6
#define wxSTC_LOUT_STRING 7
#define wxSTC_LOUT_OPERATOR 8
#define wxSTC_LOUT_IDENTIFIER 9
#define wxSTC_LOUT_STRINGEOL 10

' Lexical states for SCLEX_ESCRIPT
#define wxSTC_ESCRIPT_DEFAULT 0
#define wxSTC_ESCRIPT_COMMENT 1
#define wxSTC_ESCRIPT_COMMENTLINE 2
#define wxSTC_ESCRIPT_COMMENTDOC 3
#define wxSTC_ESCRIPT_NUMBER 4
#define wxSTC_ESCRIPT_WORD 5
#define wxSTC_ESCRIPT_STRING 6
#define wxSTC_ESCRIPT_OPERATOR 7
#define wxSTC_ESCRIPT_IDENTIFIER 8
#define wxSTC_ESCRIPT_BRACE 9
#define wxSTC_ESCRIPT_WORD2 10
#define wxSTC_ESCRIPT_WORD3 11

' Lexical states for SCLEX_PS
#define wxSTC_PS_DEFAULT 0
#define wxSTC_PS_COMMENT 1
#define wxSTC_PS_DSC_COMMENT 2
#define wxSTC_PS_DSC_VALUE 3
#define wxSTC_PS_NUMBER 4
#define wxSTC_PS_NAME 5
#define wxSTC_PS_KEYWORD 6
#define wxSTC_PS_LITERAL 7
#define wxSTC_PS_IMMEVAL 8
#define wxSTC_PS_PAREN_ARRAY 9
#define wxSTC_PS_PAREN_DICT 10
#define wxSTC_PS_PAREN_PROC 11
#define wxSTC_PS_TEXT 12
#define wxSTC_PS_HEXSTRING 13
#define wxSTC_PS_BASE85STRING 14
#define wxSTC_PS_BADSTRINGCHAR 15

' Lexical states for SCLEX_NSIS
#define wxSTC_NSIS_DEFAULT 0
#define wxSTC_NSIS_COMMENT 1
#define wxSTC_NSIS_STRINGDQ 2
#define wxSTC_NSIS_STRINGLQ 3
#define wxSTC_NSIS_STRINGRQ 4
#define wxSTC_NSIS_FUNCTION 5
#define wxSTC_NSIS_VARIABLE 6
#define wxSTC_NSIS_LABEL 7
#define wxSTC_NSIS_USERDEFINED 8
#define wxSTC_NSIS_SECTIONDEF 9
#define wxSTC_NSIS_SUBSECTIONDEF 10
#define wxSTC_NSIS_IFDEFINEDEF 11
#define wxSTC_NSIS_MACRODEF 12
#define wxSTC_NSIS_STRINGVAR 13

' Lexical states for SCLEX_MMIXAL
#define wxSTC_MMIXAL_LEADWS 0
#define wxSTC_MMIXAL_COMMENT 1
#define wxSTC_MMIXAL_LABEL 2
#define wxSTC_MMIXAL_OPCODE 3
#define wxSTC_MMIXAL_OPCODE_PRE 4
#define wxSTC_MMIXAL_OPCODE_VALID 5
#define wxSTC_MMIXAL_OPCODE_UNKNOWN 6
#define wxSTC_MMIXAL_OPCODE_POST 7
#define wxSTC_MMIXAL_OPERANDS 8
#define wxSTC_MMIXAL_NUMBER 9
#define wxSTC_MMIXAL_REF 10
#define wxSTC_MMIXAL_CHAR 11
#define wxSTC_MMIXAL_STRING 12
#define wxSTC_MMIXAL_REGISTER 13
#define wxSTC_MMIXAL_HEX 14
#define wxSTC_MMIXAL_OPERATOR 15
#define wxSTC_MMIXAL_SYMBOL 16
#define wxSTC_MMIXAL_INCLUDE 17


'-----------------------------------------
' Commands that can be bound to keystrokes


' Redoes the next action on the undo history.
#define wxSTC_CMD_REDO 2011

' Select all the text in the document.
#define wxSTC_CMD_SELECTALL 2013

' Undo one action in the undo history.
#define wxSTC_CMD_UNDO 2176

' Cut the selection to the clipboard.
#define wxSTC_CMD_CUT 2177

' Copy the selection to the clipboard.
#define wxSTC_CMD_COPY 2178

' Paste the contents of the clipboard into the document replacing the selection.
#define wxSTC_CMD_PASTE 2179

' Clear the selection.
#define wxSTC_CMD_CLEAR 2180

' Move caret down one line.
#define wxSTC_CMD_LINEDOWN 2300

' Move caret down one line extending selection to new caret position.
#define wxSTC_CMD_LINEDOWNEXTEND 2301

' Move caret up one line.
#define wxSTC_CMD_LINEUP 2302

' Move caret up one line extending selection to new caret position.
#define wxSTC_CMD_LINEUPEXTEND 2303

' Move caret left one character.
#define wxSTC_CMD_CHARLEFT 2304

' Move caret left one character extending selection to new caret position.
#define wxSTC_CMD_CHARLEFTEXTEND 2305

' Move caret right one character.
#define wxSTC_CMD_CHARRIGHT 2306

' Move caret right one character extending selection to new caret position.
#define wxSTC_CMD_CHARRIGHTEXTEND 2307

' Move caret left one word.
#define wxSTC_CMD_WORDLEFT 2308

' Move caret left one word extending selection to new caret position.
#define wxSTC_CMD_WORDLEFTEXTEND 2309

' Move caret right one word.
#define wxSTC_CMD_WORDRIGHT 2310

' Move caret right one word extending selection to new caret position.
#define wxSTC_CMD_WORDRIGHTEXTEND 2311

' Move caret to first position on line.
#define wxSTC_CMD_HOME 2312

' Move caret to first position on line extending selection to new caret position.
#define wxSTC_CMD_HOMEEXTEND 2313

' Move caret to last position on line.
#define wxSTC_CMD_LINEEND 2314

' Move caret to last position on line extending selection to new caret position.
#define wxSTC_CMD_LINEENDEXTEND 2315

' Move caret to first position in document.
#define wxSTC_CMD_DOCUMENTSTART 2316

' Move caret to first position in document extending selection to new caret position.
#define wxSTC_CMD_DOCUMENTSTARTEXTEND 2317

' Move caret to last position in document.
#define wxSTC_CMD_DOCUMENTEND 2318

' Move caret to last position in document extending selection to new caret position.
#define wxSTC_CMD_DOCUMENTENDEXTEND 2319

' Move caret one page up.
#define wxSTC_CMD_PAGEUP 2320

' Move caret one page up extending selection to new caret position.
#define wxSTC_CMD_PAGEUPEXTEND 2321

' Move caret one page down.
#define wxSTC_CMD_PAGEDOWN 2322

' Move caret one page down extending selection to new caret position.
#define wxSTC_CMD_PAGEDOWNEXTEND 2323

' Switch from insert to overtype mode or the reverse.
#define wxSTC_CMD_EDITTOGGLEOVERTYPE 2324

' Cancel any modes such as call tip or auto-completion list display.
#define wxSTC_CMD_CANCEL 2325

' Delete the selection or if no selection, the character before the caret.
#define wxSTC_CMD_DELETEBACK 2326

' If selection is empty or all on one line replace the selection with a tab character.
' If more than one line selected, indent the lines.
#define wxSTC_CMD_TAB 2327

' Dedent the selected lines.
#define wxSTC_CMD_BACKTAB 2328

' Insert a new line, may use a CRLF, CR or LF depending on EOL mode.
#define wxSTC_CMD_NEWLINE 2329

' Insert a Form Feed character.
#define wxSTC_CMD_FORMFEED 2330

' Move caret to before first visible character on line.
' If already there move to first character on line.
#define wxSTC_CMD_VCHOME 2331

' Like VCHome but extending selection to new caret position.
#define wxSTC_CMD_VCHOMEEXTEND 2332

' Magnify the displayed text by increasing the sizes by 1 point.
#define wxSTC_CMD_ZOOMIN 2333

' Make the displayed text smaller by decreasing the sizes by 1 point.
#define wxSTC_CMD_ZOOMOUT 2334

' Delete the word to the left of the caret.
#define wxSTC_CMD_DELWORDLEFT 2335

' Delete the word to the right of the caret.
#define wxSTC_CMD_DELWORDRIGHT 2336

' Cut the line containing the caret.
#define wxSTC_CMD_LINECUT 2337

' Delete the line containing the caret.
#define wxSTC_CMD_LINEDELETE 2338

' Switch the current line with the previous.
#define wxSTC_CMD_LINETRANSPOSE 2339

' Duplicate the current line.
#define wxSTC_CMD_LINEDUPLICATE 2404

' Transform the selection to lower case.
#define wxSTC_CMD_LOWERCASE 2340

' Transform the selection to upper case.
#define wxSTC_CMD_UPPERCASE 2341

' Scroll the document down, keeping the caret visible.
#define wxSTC_CMD_LINESCROLLDOWN 2342

' Scroll the document up, keeping the caret visible.
#define wxSTC_CMD_LINESCROLLUP 2343

' Delete the selection or if no selection, the character before the caret.
' Will not delete the character before at the start of a line.
#define wxSTC_CMD_DELETEBACKNOTLINE 2344

' Move caret to first position on display line.
#define wxSTC_CMD_HOMEDISPLAY 2345

' Move caret to first position on display line extending selection to
' new caret position.
#define wxSTC_CMD_HOMEDISPLAYEXTEND 2346

' Move caret to last position on display line.
#define wxSTC_CMD_LINEENDDISPLAY 2347

' Move caret to last position on display line extending selection to new
' caret position.
#define wxSTC_CMD_LINEENDDISPLAYEXTEND 2348

' These are like their namesakes Home(Extend)?, LineEnd(Extend)?, VCHome(Extend)?
' except they behave differently when word-wrap is enabled:
' They go first to the start / end of the display line, like (Home|LineEnd)Display
' The difference is that, the cursor is already at the point, it goes on to the start
' or end of the document line, as appropriate for (Home|LineEnd|VCHome)Extend.
#define wxSTC_CMD_HOMEWRAP 2349
#define wxSTC_CMD_HOMEWRAPEXTEND 2450
#define wxSTC_CMD_LINEENDWRAP 2451
#define wxSTC_CMD_LINEENDWRAPEXTEND 2452
#define wxSTC_CMD_VCHOMEWRAP 2453
#define wxSTC_CMD_VCHOMEWRAPEXTEND 2454

' Move to the previous change in capitalisation.
#define wxSTC_CMD_WORDPARTLEFT 2390

' Move to the previous change in capitalisation extending selection
' to new caret position.
#define wxSTC_CMD_WORDPARTLEFTEXTEND 2391

' Move to the change next in capitalisation.
#define wxSTC_CMD_WORDPARTRIGHT 2392

' Move to the next change in capitalisation extending selection
' to new caret position.
#define wxSTC_CMD_WORDPARTRIGHTEXTEND 2393

' Delete back from the current position to the start of the line.
#define wxSTC_CMD_DELLINELEFT 2395

' Delete forwards from the current position to the end of the line.
#define wxSTC_CMD_DELLINERIGHT 2396

' Move caret between paragraphs (delimited by empty lines)
#define wxSTC_CMD_PARADOWN 2413
#define wxSTC_CMD_PARADOWNEXTEND 2414
#define wxSTC_CMD_PARAUP 2415
#define wxSTC_CMD_PARAUPEXTEND 2416


' END of generated section
'----------------------------------------------------------------------

'wxfiledlg flags
enum file_dialog
    wxOPEN              = &h0001
    wxSAVE              = &h0002
    wxOVERWRITE_PROMPT  = &h0004
    wxHIDE_READONLY     = &h0008
    wxFILE_MUST_EXIST   = &h0010
    wxMULTIPLE          = &h0020
    wxCHANGE_DIR        = &h0040
end enum

' ----------------------------------------------------------------------------
' Flags for wxFindReplaceData.Flags
' ----------------------------------------------------------------------------

' flages used by wxFindDialogEvent::GetFlags()
enum wxFindReplaceFlags
    ' downward search/replace selected (otherwise - upwards)
    wxFR_DOWN       = 1
    ' whole word search/replace selected
    wxFR_WHOLEWORD  = 2
    ' case sensitive search/replace selected (otherwise - case insensitive)
    wxFR_MATCHCASE  = 4
end enum

' these flags can be specified in wxFindReplaceDialog ctor or Create()
enum wxFindReplaceDialogStyles
    ' replace dialog (otherwise find dialog)
    wxFR_REPLACEDIALOG = 1
    ' don't allow changing the search direction
    wxFR_NOUPDOWN      = 2
    ' don't allow case sensitive searching
    wxFR_NOMATCHCASE   = 4
    ' don't allow whole word searching
    wxFR_NOWHOLEWORD   = 8
end enum

enum wxXmlResourceFlags
    wxXRC_USE_LOCALE     = 1
    wxXRC_NO_SUBCLASSING = 2
end enum
