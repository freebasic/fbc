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

declare function j_start cdecl alias "j_start" () as integer
declare function j_connect cdecl alias "j_connect" (byval as zstring ptr) as integer
declare sub j_setport cdecl alias "j_setport" (byval as integer)
declare sub j_setdebug cdecl alias "j_setdebug" (byval as integer)
declare function j_frame cdecl alias "j_frame" (byval as zstring ptr) as integer
declare function j_button cdecl alias "j_button" (byval as integer, byval as zstring ptr) as integer
declare function j_graphicbutton cdecl alias "j_graphicbutton" (byval as integer, byval as zstring ptr) as integer
declare function j_checkbox cdecl alias "j_checkbox" (byval as integer, byval as zstring ptr) as integer
declare function j_label cdecl alias "j_label" (byval as integer, byval as zstring ptr) as integer
declare function j_graphiclabel cdecl alias "j_graphiclabel" (byval as integer, byval as zstring ptr) as integer
declare function j_canvas cdecl alias "j_canvas" (byval as integer, byval as integer, byval as integer) as integer
declare function j_panel cdecl alias "j_panel" (byval as integer) as integer
declare function j_borderpanel cdecl alias "j_borderpanel" (byval as integer, byval as integer) as integer
declare function j_radiogroup cdecl alias "j_radiogroup" (byval as integer) as integer
declare function j_radiobutton cdecl alias "j_radiobutton" (byval as integer, byval as zstring ptr) as integer
declare function j_list cdecl alias "j_list" (byval as integer, byval as integer) as integer
declare function j_choice cdecl alias "j_choice" (byval as integer) as integer
declare function j_dialog cdecl alias "j_dialog" (byval as integer, byval as zstring ptr) as integer
declare function j_window cdecl alias "j_window" (byval as integer) as integer
declare function j_popupmenu cdecl alias "j_popupmenu" (byval as integer, byval as zstring ptr) as integer
declare function j_scrollpane cdecl alias "j_scrollpane" (byval as integer) as integer
declare function j_hscrollbar cdecl alias "j_hscrollbar" (byval as integer) as integer
declare function j_vscrollbar cdecl alias "j_vscrollbar" (byval as integer) as integer
declare function j_line cdecl alias "j_line" (byval as integer, byval as integer, byval as integer, byval as integer) as integer
declare function j_printer cdecl alias "j_printer" (byval as integer) as integer
declare function j_image cdecl alias "j_image" (byval as integer, byval as integer) as integer
declare function j_filedialog cdecl alias "j_filedialog" (byval as integer, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr) as zstring ptr
declare function j_fileselect cdecl alias "j_fileselect" (byval as integer, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr) as zstring ptr
declare function j_messagebox cdecl alias "j_messagebox" (byval as integer, byval as zstring ptr, byval as zstring ptr) as integer
declare function j_alertbox cdecl alias "j_alertbox" (byval as integer, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr) as integer
declare function j_choicebox2 cdecl alias "j_choicebox2" (byval as integer, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr) as integer
declare function j_choicebox3 cdecl alias "j_choicebox3" (byval as integer, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr, byval as zstring ptr) as integer
declare function j_progressbar cdecl alias "j_progressbar" (byval as integer, byval as integer) as integer
declare function j_led cdecl alias "j_led" (byval as integer, byval as integer, byval as integer) as integer
declare function j_sevensegment cdecl alias "j_sevensegment" (byval as integer, byval as integer) as integer
declare function j_meter cdecl alias "j_meter" (byval as integer, byval as zstring ptr) as integer
declare sub j_additem cdecl alias "j_additem" (byval as integer, byval as zstring ptr)
declare function j_textfield cdecl alias "j_textfield" (byval as integer, byval as integer) as integer
declare function j_textarea cdecl alias "j_textarea" (byval as integer, byval as integer, byval as integer) as integer
declare function j_menubar cdecl alias "j_menubar" (byval as integer) as integer
declare function j_menu cdecl alias "j_menu" (byval as integer, byval as zstring ptr) as integer
declare function j_helpmenu cdecl alias "j_helpmenu" (byval as integer, byval as zstring ptr) as integer
declare function j_menuitem cdecl alias "j_menuitem" (byval as integer, byval as zstring ptr) as integer
declare function j_checkmenuitem cdecl alias "j_checkmenuitem" (byval as integer, byval as zstring ptr) as integer
declare sub j_pack cdecl alias "j_pack" (byval as integer)
declare sub j_print cdecl alias "j_print" (byval as integer)
declare sub j_playsoundfile cdecl alias "j_playsoundfile" (byval as zstring ptr)
declare sub j_play cdecl alias "j_play" (byval as integer)
declare function j_sound cdecl alias "j_sound" (byval as zstring ptr) as integer
declare sub j_setfont cdecl alias "j_setfont" (byval as integer, byval as integer, byval as integer, byval as integer)
declare sub j_setfontname cdecl alias "j_setfontname" (byval as integer, byval as integer)
declare sub j_setfontsize cdecl alias "j_setfontsize" (byval as integer, byval as integer)
declare sub j_setfontstyle cdecl alias "j_setfontstyle" (byval as integer, byval as integer)
declare sub j_seperator cdecl alias "j_seperator" (byval as integer)
declare sub j_disable cdecl alias "j_disable" (byval as integer)
declare sub j_enable cdecl alias "j_enable" (byval as integer)
declare function j_getstate cdecl alias "j_getstate" (byval as integer) as integer
declare function j_getrows cdecl alias "j_getrows" (byval as integer) as integer
declare function j_getcolumns cdecl alias "j_getcolumns" (byval as integer) as integer
declare function j_getselect cdecl alias "j_getselect" (byval as integer) as integer
declare function j_isselect cdecl alias "j_isselect" (byval as integer, byval as integer) as integer
declare function j_isvisible cdecl alias "j_isvisible" (byval as integer) as integer
declare function j_isparent cdecl alias "j_isparent" (byval as integer, byval as integer) as integer
declare function j_isresizable cdecl alias "j_isresizable" (byval as integer) as integer
declare sub j_select cdecl alias "j_select" (byval as integer, byval as integer)
declare sub j_deselect cdecl alias "j_deselect" (byval as integer, byval as integer)
declare sub j_multiplemode cdecl alias "j_multiplemode" (byval as integer, byval as integer)
declare sub j_insert cdecl alias "j_insert" (byval as integer, byval as integer, byval as zstring ptr)
declare sub j_remove cdecl alias "j_remove" (byval as integer, byval as integer)
declare sub j_removeitem cdecl alias "j_removeitem" (byval as integer, byval as zstring ptr)
declare sub j_removeall cdecl alias "j_removeall" (byval as integer)
declare sub j_setstate cdecl alias "j_setstate" (byval as integer, byval as integer)
declare sub j_setrows cdecl alias "j_setrows" (byval as integer, byval as integer)
declare sub j_setcolumns cdecl alias "j_setcolumns" (byval as integer, byval as integer)
declare sub j_seticon cdecl alias "j_seticon" (byval as integer, byval as integer)
declare sub j_setimage cdecl alias "j_setimage" (byval as integer, byval as integer)
declare sub j_setvalue cdecl alias "j_setvalue" (byval as integer, byval as integer)
declare sub j_setradiogroup cdecl alias "j_setradiogroup" (byval as integer, byval as integer)
declare sub j_setunitinc cdecl alias "j_setunitinc" (byval as integer, byval as integer)
declare sub j_setblockinc cdecl alias "j_setblockinc" (byval as integer, byval as integer)
declare sub j_setmin cdecl alias "j_setmin" (byval as integer, byval as integer)
declare sub j_setmax cdecl alias "j_setmax" (byval as integer, byval as integer)
declare sub j_setdanger cdecl alias "j_setdanger" (byval as integer, byval as integer)
declare sub j_setslidesize cdecl alias "j_setslidesize" (byval as integer, byval as integer)
declare sub j_setcursor cdecl alias "j_setcursor" (byval as integer, byval as integer)
declare sub j_setresizable cdecl alias "j_setresizable" (byval as integer, byval as integer)
declare function j_getlength cdecl alias "j_getlength" (byval as integer) as integer
declare function j_getvalue cdecl alias "j_getvalue" (byval as integer) as integer
declare function j_getdanger cdecl alias "j_getdanger" (byval as integer) as integer
declare function j_getscreenheight cdecl alias "j_getscreenheight" () as integer
declare function j_getscreenwidth cdecl alias "j_getscreenwidth" () as integer
declare function j_getheight cdecl alias "j_getheight" (byval as integer) as integer
declare function j_getwidth cdecl alias "j_getwidth" (byval as integer) as integer
declare function j_getinsets cdecl alias "j_getinsets" (byval as integer, byval as integer) as integer
declare function j_getlayoutid cdecl alias "j_getlayoutid" (byval as integer) as integer
declare function j_getinheight cdecl alias "j_getinheight" (byval as integer) as integer
declare function j_getinwidth cdecl alias "j_getinwidth" (byval as integer) as integer
declare function j_gettext cdecl alias "j_gettext" (byval as integer, byval as zstring ptr) as zstring ptr
declare function j_getitem cdecl alias "j_getitem" (byval as integer, byval as integer, byval as zstring ptr) as zstring ptr
declare function j_getitemcount cdecl alias "j_getitemcount" (byval as integer) as integer
declare sub j_delete cdecl alias "j_delete" (byval as integer, byval as integer, byval as integer)
declare sub j_replacetext cdecl alias "j_replacetext" (byval as integer, byval as zstring ptr, byval as integer, byval as integer)
declare sub j_appendtext cdecl alias "j_appendtext" (byval as integer, byval as zstring ptr)
declare sub j_inserttext cdecl alias "j_inserttext" (byval as integer, byval as zstring ptr, byval as integer)
declare sub j_settext cdecl alias "j_settext" (byval as integer, byval as zstring ptr)
declare sub j_selectall cdecl alias "j_selectall" (byval as integer)
declare sub j_selecttext cdecl alias "j_selecttext" (byval as integer, byval as integer, byval as integer)
declare function j_getselstart cdecl alias "j_getselstart" (byval as integer) as integer
declare function j_getselend cdecl alias "j_getselend" (byval as integer) as integer
declare function j_getseltext cdecl alias "j_getseltext" (byval as integer, byval as zstring ptr) as zstring ptr
declare function j_getcurpos cdecl alias "j_getcurpos" (byval as integer) as integer
declare sub j_setcurpos cdecl alias "j_setcurpos" (byval as integer, byval as integer)
declare sub j_setechochar cdecl alias "j_setechochar" (byval as integer, byval as byte)
declare sub j_seteditable cdecl alias "j_seteditable" (byval as integer, byval as integer)
declare sub j_setshortcut cdecl alias "j_setshortcut" (byval as integer, byval as byte)
declare sub j_quit cdecl alias "j_quit" ()
declare sub j_kill cdecl alias "j_kill" ()
declare sub j_setsize cdecl alias "j_setsize" (byval as integer, byval as integer, byval as integer)
declare function j_getaction cdecl alias "j_getaction" () as integer
declare function j_nextaction cdecl alias "j_nextaction" () as integer
declare sub j_show cdecl alias "j_show" (byval as integer)
declare sub j_showpopup cdecl alias "j_showpopup" (byval as integer, byval as integer, byval as integer)
declare sub j_add cdecl alias "j_add" (byval as integer, byval as integer)
declare sub j_release cdecl alias "j_release" (byval as integer)
declare sub j_releaseall cdecl alias "j_releaseall" (byval as integer)
declare sub j_hide cdecl alias "j_hide" (byval as integer)
declare sub j_dispose cdecl alias "j_dispose" (byval as integer)
declare sub j_setpos cdecl alias "j_setpos" (byval as integer, byval as integer, byval as integer)
declare function j_getviewportheight cdecl alias "j_getviewportheight" (byval as integer) as integer
declare function j_getviewportwidth cdecl alias "j_getviewportwidth" (byval as integer) as integer
declare function j_getxpos cdecl alias "j_getxpos" (byval as integer) as integer
declare function j_getypos cdecl alias "j_getypos" (byval as integer) as integer
declare sub j_getpos cdecl alias "j_getpos" (byval as integer, byval as integer ptr, byval as integer ptr)
declare function j_getparentid cdecl alias "j_getparentid" (byval as integer) as integer
declare sub j_setfocus cdecl alias "j_setfocus" (byval as integer)
declare function j_hasfocus cdecl alias "j_hasfocus" (byval as integer) as integer
declare function j_getstringwidth cdecl alias "j_getstringwidth" (byval as integer, byval as zstring ptr) as integer
declare function j_getfontheight cdecl alias "j_getfontheight" (byval as integer) as integer
declare function j_getfontascent cdecl alias "j_getfontascent" (byval as integer) as integer
declare function j_keylistener cdecl alias "j_keylistener" (byval as integer) as integer
declare function j_getkeycode cdecl alias "j_getkeycode" (byval as integer) as integer
declare function j_getkeychar cdecl alias "j_getkeychar" (byval as integer) as integer
declare function j_mouselistener cdecl alias "j_mouselistener" (byval as integer, byval as integer) as integer
declare function j_getmousex cdecl alias "j_getmousex" (byval as integer) as integer
declare function j_getmousey cdecl alias "j_getmousey" (byval as integer) as integer
declare sub j_getmousepos cdecl alias "j_getmousepos" (byval as integer, byval as integer ptr, byval as integer ptr)
declare function j_getmousebutton cdecl alias "j_getmousebutton" (byval as integer) as integer
declare function j_focuslistener cdecl alias "j_focuslistener" (byval as integer) as integer
declare function j_componentlistener cdecl alias "j_componentlistener" (byval as integer, byval as integer) as integer
declare function j_windowlistener cdecl alias "j_windowlistener" (byval as integer, byval as integer) as integer
declare sub j_setflowlayout cdecl alias "j_setflowlayout" (byval as integer, byval as integer)
declare sub j_setborderlayout cdecl alias "j_setborderlayout" (byval as integer)
declare sub j_setgridlayout cdecl alias "j_setgridlayout" (byval as integer, byval as integer, byval as integer)
declare sub j_setfixlayout cdecl alias "j_setfixlayout" (byval as integer)
declare sub j_setnolayout cdecl alias "j_setnolayout" (byval as integer)
declare sub j_setborderpos cdecl alias "j_setborderpos" (byval as integer, byval as integer)
declare sub j_sethgap cdecl alias "j_sethgap" (byval as integer, byval as integer)
declare sub j_setvgap cdecl alias "j_setvgap" (byval as integer, byval as integer)
declare sub j_setinsets cdecl alias "j_setinsets" (byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
declare sub j_setalign cdecl alias "j_setalign" (byval as integer, byval as integer)
declare sub j_setflowfill cdecl alias "j_setflowfill" (byval as integer, byval as integer)
declare sub j_translate cdecl alias "j_translate" (byval as integer, byval as integer, byval as integer)
declare sub j_cliprect cdecl alias "j_cliprect" (byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
declare sub j_drawrect cdecl alias "j_drawrect" (byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
declare sub j_fillrect cdecl alias "j_fillrect" (byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
declare sub j_drawroundrect cdecl alias "j_drawroundrect" (byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
declare sub j_fillroundrect cdecl alias "j_fillroundrect" (byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
declare sub j_drawoval cdecl alias "j_drawoval" (byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
declare sub j_filloval cdecl alias "j_filloval" (byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
declare sub j_drawcircle cdecl alias "j_drawcircle" (byval as integer, byval as integer, byval as integer, byval as integer)
declare sub j_fillcircle cdecl alias "j_fillcircle" (byval as integer, byval as integer, byval as integer, byval as integer)
declare sub j_drawarc cdecl alias "j_drawarc" (byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
declare sub j_fillarc cdecl alias "j_fillarc" (byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
declare sub j_drawline cdecl alias "j_drawline" (byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
declare sub j_drawpolyline cdecl alias "j_drawpolyline" (byval as integer, byval as integer, byval as integer ptr, byval as integer ptr)
declare sub j_drawpolygon cdecl alias "j_drawpolygon" (byval as integer, byval as integer, byval as integer ptr, byval as integer ptr)
declare sub j_fillpolygon cdecl alias "j_fillpolygon" (byval as integer, byval as integer, byval as integer ptr, byval as integer ptr)
declare sub j_drawpixel cdecl alias "j_drawpixel" (byval as integer, byval as integer, byval as integer)
declare sub j_drawstring cdecl alias "j_drawstring" (byval as integer, byval as integer, byval as integer, byval as zstring ptr)
declare sub j_setxor cdecl alias "j_setxor" (byval as integer, byval as integer)
declare function j_getimage cdecl alias "j_getimage" (byval as integer) as integer
declare sub j_getimagesource cdecl alias "j_getimagesource" (byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer ptr, byval as integer ptr, byval as integer ptr)
declare sub j_drawimagesource cdecl alias "j_drawimagesource" (byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer ptr, byval as integer ptr, byval as integer ptr)
declare function j_getscaledimage cdecl alias "j_getscaledimage" (byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer) as integer
declare sub j_drawimage cdecl alias "j_drawimage" (byval as integer, byval as integer, byval as integer, byval as integer)
declare sub j_drawscaledimage cdecl alias "j_drawscaledimage" (byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer, byval as integer)
declare sub j_setcolor cdecl alias "j_setcolor" (byval as integer, byval as integer, byval as integer, byval as integer)
declare sub j_setcolorbg cdecl alias "j_setcolorbg" (byval as integer, byval as integer, byval as integer, byval as integer)
declare sub j_setnamedcolor cdecl alias "j_setnamedcolor" (byval as integer, byval as integer)
declare sub j_setnamedcolorbg cdecl alias "j_setnamedcolorbg" (byval as integer, byval as integer)
declare function j_loadimage cdecl alias "j_loadimage" (byval as zstring ptr) as integer
declare function j_saveimage cdecl alias "j_saveimage" (byval as integer, byval as zstring ptr, byval as integer) as integer
declare sub j_sync cdecl alias "j_sync" ()
declare sub j_beep cdecl alias "j_beep" ()
declare function j_random cdecl alias "j_random" () as integer
declare sub j_sleep cdecl alias "j_sleep" (byval as integer)

#endif
