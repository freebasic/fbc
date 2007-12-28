''
''
'' japi -- java application programming interface
''		   (header translated with help of SWIG FB wrapper)
''
'' NOTICE: This file is part of the FreeBASIC Compiler package and can't
''         be included in other distributions without authorization.
''
''
#ifndef __japi_bi__
#define __japi_bi__

#inclib "japi"

#ifdef __FB_WIN32__
#inclib "coldname"
#inclib "wsock32"
#endif

#define J_TRUE 1
#define J_FALSE 0
#define J_LEFT 0
#define J_CENTER 1
#define J_RIGHT 2
#define J_TOP 3
#define J_BOTTOM 4
#define J_TOPLEFT 5
#define J_TOPRIGHT 6
#define J_BOTTOMLEFT 7
#define J_BOTTOMRIGHT 8
#define J_DEFAULT_CURSOR 0
#define J_CROSSHAIR_CURSOR 1
#define J_TEXT_CURSOR 2
#define J_WAIT_CURSOR 3
#define J_SW_RESIZE_CURSOR 4
#define J_SE_RESIZE_CURSOR 5
#define J_NW_RESIZE_CURSOR 6
#define J_NE_RESIZE_CURSOR 7
#define J_N_RESIZE_CURSOR 8
#define J_S_RESIZE_CURSOR 9
#define J_W_RESIZE_CURSOR 10
#define J_E_RESIZE_CURSOR 11
#define J_HAND_CURSOR 12
#define J_MOVE_CURSOR 13
#define J_HORIZONTAL 0
#define J_VERTICAL 1
#define J_PLAIN 0
#define J_BOLD 1
#define J_ITALIC 2
#define J_COURIER 1
#define J_HELVETIA 2
#define J_TIMES 3
#define J_DIALOGIN 4
#define J_DIALOGOUT 5
#define J_BLACK 0
#define J_WHITE 1
#define J_RED 2
#define J_GREEN 3
#define J_BLUE 4
#define J_CYAN 5
#define J_MAGENTA 6
#define J_YELLOW 7
#define J_ORANGE 8
#define J_GREEN_YELLOW 9
#define J_GREEN_CYAN 10
#define J_BLUE_CYAN 11
#define J_BLUE_MAGENTA 12
#define J_RED_MAGENTA 13
#define J_DARK_GRAY 14
#define J_LIGHT_GRAY 15
#define J_GRAY 16
#define J_NONE 0
#define J_LINEDOWN 1
#define J_LINEUP 2
#define J_AREADOWN 3
#define J_AREAUP 4
#define J_MOVED 0
#define J_DRAGGED 1
#define J_PRESSED 2
#define J_RELEASED 3
#define J_ENTERERD 4
#define J_EXITED 5
#define J_DOUBLECLICK 6
#define J_RESIZED 1
#define J_HIDDEN 2
#define J_SHOWN 3
#define J_ACTIVATED 0
#define J_DEACTIVATED 1
#define J_OPENED 2
#define J_CLOSED 3
#define J_ICONIFIED 4
#define J_DEICONIFIED 5
#define J_CLOSING 6
#define J_GIF 0
#define J_JPG 1
#define J_PPM 2
#define J_BMP 3
#define J_ROUND 0
#define J_RECT 1
#define J_RANDMAX 2147483647

extern "c"
declare function j_start () as integer
declare function j_connect (byval as zstring ptr) as integer
declare sub j_setport (byval as integer)
declare sub j_setdebug (byval as integer)
declare function j_frame (byval as zstring ptr) as integer
declare function j_button (byval as integer, byval as zstring ptr) as integer
declare function j_graphicbutton (byval as integer, byval as zstring ptr) as integer
declare function j_checkbox (byval as integer, byval as zstring ptr) as integer
declare function j_label (byval as integer, byval as zstring ptr) as integer
declare function j_graphiclabel (byval as integer, byval as zstring ptr) as integer
declare function j_canvas (byval as integer, byval as integer, byval as integer) as integer
declare function j_panel (byval as integer) as integer
declare function j_borderpanel (byval as integer, byval as integer) as integer
declare function j_radiogroup (byval as integer) as integer
declare function j_radiobutton (byval as integer, byval as zstring ptr) as integer
declare function j_list (byval as integer, byval as integer) as integer
declare function j_choice (byval as integer) as integer
declare function j_dialog (byval as integer, byval as zstring ptr) as integer
declare function j_window (byval as integer) as integer
declare function j_popupmenu (byval as integer, byval as zstring ptr) as integer
declare function j_scrollpane (byval as integer) as integer
declare function j_hscrollbar (byval as integer) as integer
declare function j_vscrollbar (byval as integer) as integer
declare function j_line (byval as integer, byval as integer, byval as integer, byval as integer) as integer
declare function j_printer (byval as integer) as integer
declare function j_image (byval as integer, byval as integer) as integer
declare function j_filedialog (byval as integer, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr) as zstring ptr
declare function j_fileselect (byval as integer, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr) as zstring ptr
declare function j_messagebox (byval as integer, byval as zstring ptr, byval as zstring ptr) as integer
declare function j_alertbox (byval as integer, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr) as integer
declare function j_choicebox2 (byval as integer, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr) as integer
declare function j_choicebox3 (byval as integer, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr) as integer
declare function j_progressbar (byval as integer, byval as integer) as integer
declare function j_led (byval as integer, byval as integer, byval as integer) as integer
declare function j_sevensegment (byval as integer, byval as integer) as integer
declare function j_meter (byval as integer, byval as zstring ptr) as integer
declare sub j_additem (byval as integer, byval as zstring ptr)
declare function j_textfield (byval as integer, byval as integer) as integer
declare function j_textarea (byval as integer, byval as integer, byval as integer) as integer
declare function j_menubar (byval as integer) as integer
declare function j_menu (byval as integer, byval as zstring ptr) as integer
declare function j_helpmenu (byval as integer, byval as zstring ptr) as integer
declare function j_menuitem (byval as integer, byval as zstring ptr) as integer
declare function j_checkmenuitem (byval as integer, byval as zstring ptr) as integer
declare sub j_pack (byval as integer)
declare sub j_print (byval as integer)
declare sub j_playsoundfile (byval as zstring ptr)
declare sub j_play (byval as integer)
declare function j_sound (byval as zstring ptr) as integer
declare sub j_setfont (byval as integer, byval as integer, byval as integer, byval as integer)
declare sub j_setfontname (byval as integer, byval as integer)
declare sub j_setfontsize (byval as integer, byval as integer)
declare sub j_setfontstyle (byval as integer, byval as integer)
declare sub j_seperator (byval as integer)
declare sub j_disable (byval as integer)
declare sub j_enable (byval as integer)
declare function j_getstate (byval as integer) as integer
declare function j_getrows (byval as integer) as integer
declare function j_getcolumns (byval as integer) as integer
declare function j_getselect (byval as integer) as integer
declare function j_isselect (byval as integer, byval as integer) as integer
declare function j_isvisible (byval as integer) as integer
declare function j_isparent (byval as integer, byval as integer) as integer
declare function j_isresizable (byval as integer) as integer
declare sub j_select (byval as integer, byval as integer)
declare sub j_deselect (byval as integer, byval as integer)
declare sub j_multiplemode (byval as integer, byval as integer)
declare sub j_insert (byval as integer, byval as integer, byval as zstring ptr)
declare sub j_remove (byval as integer, byval as integer)
declare sub j_removeitem (byval as integer, byval as zstring ptr)
declare sub j_removeall (byval as integer)
declare sub j_setstate (byval as integer, byval as integer)
declare sub j_setrows (byval as integer, byval as integer)
declare sub j_setcolumns (byval as integer, byval as integer)
declare sub j_seticon (byval as integer, byval as integer)
declare sub j_setimage (byval as integer, byval as integer)
declare sub j_setvalue (byval as integer, byval as integer)
declare sub j_setradiogroup (byval as integer, byval as integer)
declare sub j_setunitinc (byval as integer, byval as integer)
declare sub j_setblockinc (byval as integer, byval as integer)
declare sub j_setmin (byval as integer, byval as integer)
declare sub j_setmax (byval as integer, byval as integer)
declare sub j_setdanger (byval as integer, byval as integer)
declare sub j_setslidesize (byval as integer, byval as integer)
declare sub j_setcursor (byval as integer, byval as integer)
declare sub j_setresizable (byval as integer, byval as integer)
declare function j_getlength (byval as integer) as integer
declare function j_getvalue (byval as integer) as integer
declare function j_getdanger (byval as integer) as integer
declare function j_getscreenheight () as integer
declare function j_getscreenwidth () as integer
declare function j_getheight (byval as integer) as integer
declare function j_getwidth (byval as integer) as integer
declare function j_getinsets (byval as integer, byval as integer) as integer
declare function j_getlayoutid (byval as integer) as integer
declare function j_getinheight (byval as integer) as integer
declare function j_getinwidth (byval as integer) as integer
declare function j_gettext (byval as integer, byval as zstring ptr) as zstring ptr
declare function j_getitem (byval as integer, byval as integer, byval as zstring ptr) as zstring ptr
declare function j_getitemcount (byval as integer) as integer
declare sub j_delete (byval as integer, byval as integer, byval as integer)
declare sub j_replacetext (byval as integer, byval as zstring ptr, byval as integer, byval as integer)
declare sub j_appendtext (byval as integer, byval as zstring ptr)
declare sub j_inserttext (byval as integer, byval as zstring ptr, byval as integer)
declare sub j_settext (byval as integer, byval as zstring ptr)
declare sub j_selectall (byval as integer)
declare sub j_selecttext (byval as integer, byval as integer, byval as integer)
declare function j_getselstart (byval as integer) as integer
declare function j_getselend (byval as integer) as integer
declare function j_getseltext (byval as integer, byval as zstring ptr) as zstring ptr
declare function j_getcurpos (byval as integer) as integer
declare sub j_setcurpos (byval as integer, byval as integer)
declare sub j_setechochar (byval as integer, byval as byte)
declare sub j_seteditable (byval as integer, byval as integer)
declare sub j_setshortcut (byval as integer, byval as byte)
declare sub j_quit ()
declare sub j_kill ()
declare sub j_setsize (byval as integer, byval as integer, byval as integer)
declare function j_getaction () as integer
declare function j_nextaction () as integer
declare sub j_show (byval as integer)
declare sub j_showpopup (byval as integer, byval as integer, byval as integer)
declare sub j_add (byval as integer, byval as integer)
declare sub j_release (byval as integer)
declare sub j_releaseall (byval as integer)
declare sub j_hide (byval as integer)
declare sub j_dispose (byval as integer)
declare sub j_setpos (byval as integer, byval as integer, byval as integer)
declare function j_getviewportheight (byval as integer) as integer
declare function j_getviewportwidth (byval as integer) as integer
declare function j_getxpos (byval as integer) as integer
declare function j_getypos (byval as integer) as integer
declare sub j_getpos (byval as integer, byval as integer ptr, byval as integer ptr)
declare function j_getparentid (byval as integer) as integer
declare sub j_setfocus (byval as integer)
declare function j_hasfocus (byval as integer) as integer
declare function j_getstringwidth (byval as integer, byval as zstring ptr) as integer
declare function j_getfontheight (byval as integer) as integer
declare function j_getfontascent (byval as integer) as integer
declare function j_keylistener (byval as integer) as integer
declare function j_getkeycode (byval as integer) as integer
declare function j_getkeychar (byval as integer) as integer
declare function j_mouselistener (byval as integer, byval as integer) as integer
declare function j_getmousex (byval as integer) as integer
declare function j_getmousey (byval as integer) as integer
declare sub j_getmousepos (byval as integer, byval as integer ptr, byval as integer ptr)
declare function j_getmousebutton (byval as integer) as integer
declare function j_focuslistener (byval as integer) as integer
declare function j_componentlistener (byval as integer, byval as integer) as integer
declare function j_windowlistener (byval as integer, byval as integer) as integer
declare sub j_setflowlayout (byval as integer, byval as integer)
declare sub j_setborderlayout (byval as integer)
declare sub j_setgridlayout (byval as integer, byval as integer, byval as integer)
declare sub j_setfixlayout (byval as integer)
declare sub j_setnolayout (byval as integer)
declare sub j_setborderpos (byval as integer, byval as integer)
declare sub j_sethgap (byval as integer, byval as integer)
declare sub j_setvgap (byval as integer, byval as integer)
declare sub j_setinsets (byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
declare sub j_setalign (byval as integer, byval as integer)
declare sub j_setflowfill (byval as integer, byval as integer)
declare sub j_translate (byval as integer, byval as integer, byval as integer)
declare sub j_cliprect (byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
declare sub j_drawrect (byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
declare sub j_fillrect (byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
declare sub j_drawroundrect (byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
declare sub j_fillroundrect (byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
declare sub j_drawoval (byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
declare sub j_filloval (byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
declare sub j_drawcircle (byval as integer, byval as integer, byval as integer, byval as integer)
declare sub j_fillcircle (byval as integer, byval as integer, byval as integer, byval as integer)
declare sub j_drawarc (byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
declare sub j_fillarc (byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
declare sub j_drawline (byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
declare sub j_drawpolyline (byval as integer, byval as integer, byval as integer ptr, byval as integer ptr)
declare sub j_drawpolygon (byval as integer, byval as integer, byval as integer ptr, byval as integer ptr)
declare sub j_fillpolygon (byval as integer, byval as integer, byval as integer ptr, byval as integer ptr)
declare sub j_drawpixel (byval as integer, byval as integer, byval as integer)
declare sub j_drawstring (byval as integer, byval as integer, byval as integer, byval as zstring ptr)
declare sub j_setxor (byval as integer, byval as integer)
declare function j_getimage (byval as integer) as integer
declare sub j_getimagesource (byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer ptr, byval as integer ptr, byval as integer ptr)
declare sub j_drawimagesource (byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer ptr, byval as integer ptr, byval as integer ptr)
declare function j_getscaledimage (byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer) as integer
declare sub j_drawimage (byval as integer, byval as integer, byval as integer, byval as integer)
declare sub j_drawscaledimage (byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
declare sub j_setcolor (byval as integer, byval as integer, byval as integer, byval as integer)
declare sub j_setcolorbg (byval as integer, byval as integer, byval as integer, byval as integer)
declare sub j_setnamedcolor (byval as integer, byval as integer)
declare sub j_setnamedcolorbg (byval as integer, byval as integer)
declare function j_loadimage (byval as zstring ptr) as integer
declare function j_saveimage (byval as integer, byval as zstring ptr, byval as integer) as integer
declare sub j_sync ()
declare sub j_beep ()
declare function j_random () as integer
declare sub j_sleep (byval as integer)
end extern

#endif
