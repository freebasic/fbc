extern "c++"
enum Fl_Event
	FL_NO_EVENT		= 0
	FL_PUSH			= 1
	FL_RELEASE		= 2
	FL_ENTER		= 3
	FL_LEAVE		= 4
	FL_DRAG			= 5
	FL_FOCUS		= 6
	FL_UNFOCUS		= 7
	FL_KEYDOWN		= 8
	FL_KEYBOARD		= 8
	FL_KEYUP		= 9
	FL_CLOSE		= 10
	FL_MOVE			= 11
	FL_SHORTCUT		= 12
	FL_DEACTIVATE		= 13
	FL_ACTIVATE		= 14
	FL_HIDE			= 15
	FL_SHOW			= 16
	FL_PASTE		= 17
	FL_SELECTIONCLEAR	= 18
	FL_MOUSEWHEEL		= 19
	FL_DND_ENTER		= 20
	FL_DND_DRAG		= 21
	FL_DND_LEAVE		= 22
	FL_DND_RELEASE		= 23
	FL_SCREEN_CONFIGURATION_CHANGED = 24
	FL_FULLSCREEN         = 25
	FL_ZOOM_GESTURE	= 26
end enum

enum Fl_When
	FL_WHEN_NEVER		= 0
	FL_WHEN_CHANGED		= 1
	FL_WHEN_NOT_CHANGED	= 2
	FL_WHEN_RELEASE		= 4
	FL_WHEN_RELEASE_ALWAYS	= 6
	FL_WHEN_ENTER_KEY	= 8
	FL_WHEN_ENTER_KEY_ALWAYS=10
	FL_WHEN_ENTER_KEY_CHANGED=11
end enum

#define _FL_Button	&hfee8
#define _FL_BackSpace	&hff08
#define _FL_Tab		&hff09
#define _FL_Iso_Key	&hff0c
#define _FL_Enter	&hff0d
#define _FL_Pause	&hff13
#define _FL_Scroll_Lock	&hff14
#define _FL_Escape	&hff1b
#define _FL_Kana         &hff2e
#define _FL_Eisu         &hff2f
#define _FL_Yen          &hff30
#define _FL_JIS_Underscore &hff31
#define _FL_Home	&hff50
#define _FL_Left	&hff51
#define _FL_Up		&hff52
#define _FL_Right	&hff53
#define _FL_Down	&hff54
#define _FL_Page_Up	&hff55
#define _FL_Page_Down	&hff56
#define _FL_End		&hff57
#define _FL_Print	&hff61
#define _FL_Insert	&hff63
#define _FL_Menu	&hff67
#define _FL_Help	&hff68
#define _FL_Num_Lock	&hff7f
#define _FL_KP		&hff80
#define _FL_KP_Enter	&hff8d
#define _FL_KP_Last	&hffbd
#define _FL_F		&hffbd
#define _FL_F_Last	&hffe0
#define _FL_Shift_L	&hffe1
#define _FL_Shift_R	&hffe2
#define _FL_Control_L	&hffe3
#define _FL_Control_R	&hffe4
#define _FL_Caps_Lock	&hffe5
#define _FL_Meta_L	&hffe7
#define _FL_Meta_R	&hffe8
#define _FL_Alt_L	&hffe9
#define _FL_Alt_R	&hffea
#define _FL_Delete	&hffff

#define _FL_Volume_Down  &hEF11
#define _FL_Volume_Mute  &hEF12
#define _FL_Volume_Up    &hEF13
#define _FL_Media_Play   &hEF14
#define _FL_Media_Stop   &hEF15
#define _FL_Media_Prev   &hEF16
#define _FL_Media_Next   &hEF17
#define _FL_Home_Page    &hEF18
#define _FL_Mail         &hEF19
#define _FL_Search       &hEF1B
#define _FL_Back         &hEF26
#define _FL_Forward      &hEF27
#define _FL_Stop         &hEF28
#define _FL_Refresh      &hEF29
#define _FL_Sleep        &hEF2F
#define _FL_Favorites    &hEF30

#define _FL_LEFT_MOUSE	1
#define _FL_MIDDLE_MOUSE	2
#define _FL_RIGHT_MOUSE	3

#define __FL_SHIFT	&h00010000
#define __FL_CAPS_LOCK	&h00020000
#define __FL_CTRL	&h00040000
#define __FL_ALT	&h00080000
#define __FL_NUM_LOCK	&h00100000

#define __FL_META	&h00400000

#define __FL_SCROLL_LOCK	&h00800000

#define __FL_BUTTON1	&h01000000
#define __FL_BUTTON2	&h02000000
#define __FL_BUTTON3	&h04000000
#define __FL_BUTTONS	&h7f000000
#define __FL_BUTTON(n)	(&h00800000 shl (n))

#define __FL_KEY_MASK &h0000ffff

#ifdef __FB_APPLE__
#  define __FL_COMMAND	__FL_META
#  define __FL_CONTROL 	__FL_CTRL
#else
#  define __FL_COMMAND	__FL_CTRL
#  define __FL_CONTROL	__FL_META
#endif




enum Fl_Boxtype
	FL_NO_BOX = 0
	FL_FLAT_BOX
	FL_UP_BOX
	FL_DOWN_BOX
	FL_UP_FRAME
	FL_DOWN_FRAME
	FL_THIN_UP_BOX
	FL_THIN_DOWN_BOX
	FL_THIN_UP_FRAME
	FL_THIN_DOWN_FRAME
	FL_ENGRAVED_BOX
	FL_EMBOSSED_BOX
	FL_ENGRAVED_FRAME
	FL_EMBOSSED_FRAME
	FL_BORDER_BOX
	_FL_SHADOW_BOX
	FL_BORDER_FRAME
	_FL_SHADOW_FRAME
	_FL_ROUNDED_BOX
	_FL_RSHADOW_BOX
	_FL_ROUNDED_FRAME
	_FL_RFLAT_BOX
	_FL_ROUND_UP_BOX
	_FL_ROUND_DOWN_BOX
	_FL_DIAMOND_UP_BOX
	_FL_DIAMOND_DOWN_BOX
	_FL_OVAL_BOX
	_FL_OSHADOW_BOX
	_FL_OVAL_FRAME
	_FL_OFLAT_BOX
	_FL_PLASTIC_UP_BOX
	_FL_PLASTIC_DOWN_BOX
	_FL_PLASTIC_UP_FRAME
	_FL_PLASTIC_DOWN_FRAME
	_FL_PLASTIC_THIN_UP_BOX
	_FL_PLASTIC_THIN_DOWN_BOX
	_FL_PLASTIC_ROUND_UP_BOX
	_FL_PLASTIC_ROUND_DOWN_BOX
	_FL_GTK_UP_BOX
	_FL_GTK_DOWN_BOX
	_FL_GTK_UP_FRAME
	_FL_GTK_DOWN_FRAME
	_FL_GTK_THIN_UP_BOX
	_FL_GTK_THIN_DOWN_BOX
	_FL_GTK_THIN_UP_FRAME
	_FL_GTK_THIN_DOWN_FRAME
	_FL_GTK_ROUND_UP_BOX
	_FL_GTK_ROUND_DOWN_BOX
	_FL_GLEAM_UP_BOX
	_FL_GLEAM_DOWN_BOX
	_FL_GLEAM_UP_FRAME
	_FL_GLEAM_DOWN_FRAME
	_FL_GLEAM_THIN_UP_BOX
	_FL_GLEAM_THIN_DOWN_BOX
	_FL_GLEAM_ROUND_UP_BOX
	_FL_GLEAM_ROUND_DOWN_BOX
	FL_FREE_BOXTYPE
end enum

declare function fl_define_FL_ROUND_UP_BOX() as Fl_Boxtype
#define FL_ROUND_UP_BOX fl_define_FL_ROUND_UP_BOX()
#define FL_ROUND_DOWN_BOX (Fl_Boxtype)(fl_define_FL_ROUND_UP_BOX()+1)
declare function fl_define_FL_SHADOW_BOX() as Fl_Boxtype
#define FL_SHADOW_BOX fl_define_FL_SHADOW_BOX()
#define FL_SHADOW_FRAME (Fl_Boxtype)(fl_define_FL_SHADOW_BOX()+2)
declare function fl_define_FL_ROUNDED_BOX() as Fl_Boxtype
#define FL_ROUNDED_BOX fl_define_FL_ROUNDED_BOX()
#define FL_ROUNDED_FRAME (Fl_Boxtype)(fl_define_FL_ROUNDED_BOX()+2)
declare function fl_define_FL_RFLAT_BOX() as Fl_Boxtype
#define FL_RFLAT_BOX fl_define_FL_RFLAT_BOX()
declare function fl_define_FL_RSHADOW_BOX() as Fl_Boxtype
#define FL_RSHADOW_BOX fl_define_FL_RSHADOW_BOX()
declare function fl_define_FL_DIAMOND_BOX() as Fl_Boxtype
#define FL_DIAMOND_UP_BOX fl_define_FL_DIAMOND_BOX()
#define FL_DIAMOND_DOWN_BOX (Fl_Boxtype)(fl_define_FL_DIAMOND_BOX()+1)
declare function fl_define_FL_OVAL_BOX() as Fl_Boxtype
#define FL_OVAL_BOX fl_define_FL_OVAL_BOX()
#define FL_OSHADOW_BOX (Fl_Boxtype)(fl_define_FL_OVAL_BOX()+1)
#define FL_OVAL_FRAME (Fl_Boxtype)(fl_define_FL_OVAL_BOX()+2)
#define FL_OFLAT_BOX (Fl_Boxtype)(fl_define_FL_OVAL_BOX()+3)

declare function fl_define_FL_PLASTIC_UP_BOX() as Fl_Boxtype
#define FL_PLASTIC_UP_BOX fl_define_FL_PLASTIC_UP_BOX()
#define FL_PLASTIC_DOWN_BOX (Fl_Boxtype)(fl_define_FL_PLASTIC_UP_BOX()+1)
#define FL_PLASTIC_UP_FRAME (Fl_Boxtype)(fl_define_FL_PLASTIC_UP_BOX()+2)
#define FL_PLASTIC_DOWN_FRAME (Fl_Boxtype)(fl_define_FL_PLASTIC_UP_BOX()+3)
#define FL_PLASTIC_THIN_UP_BOX (Fl_Boxtype)(fl_define_FL_PLASTIC_UP_BOX()+4)
#define FL_PLASTIC_THIN_DOWN_BOX (Fl_Boxtype)(fl_define_FL_PLASTIC_UP_BOX()+5)
#define FL_PLASTIC_ROUND_UP_BOX (Fl_Boxtype)(fl_define_FL_PLASTIC_UP_BOX()+6)
#define FL_PLASTIC_ROUND_DOWN_BOX (Fl_Boxtype)(fl_define_FL_PLASTIC_UP_BOX()+7)

declare function fl_define_FL_GTK_UP_BOX() as Fl_Boxtype
#define FL_GTK_UP_BOX fl_define_FL_GTK_UP_BOX()
#define FL_GTK_DOWN_BOX (Fl_Boxtype)(fl_define_FL_GTK_UP_BOX()+1)
#define FL_GTK_UP_FRAME (Fl_Boxtype)(fl_define_FL_GTK_UP_BOX()+2)
#define FL_GTK_DOWN_FRAME (Fl_Boxtype)(fl_define_FL_GTK_UP_BOX()+3)
#define FL_GTK_THIN_UP_BOX (Fl_Boxtype)(fl_define_FL_GTK_UP_BOX()+4)
#define FL_GTK_THIN_DOWN_BOX (Fl_Boxtype)(fl_define_FL_GTK_UP_BOX()+5)
#define FL_GTK_THIN_UP_FRAME (Fl_Boxtype)(fl_define_FL_GTK_UP_BOX()+6)
#define FL_GTK_THIN_DOWN_FRAME (Fl_Boxtype)(fl_define_FL_GTK_UP_BOX()+7)
#define FL_GTK_ROUND_UP_BOX (Fl_Boxtype)(fl_define_FL_GTK_UP_BOX()+8)
#define FL_GTK_ROUND_DOWN_BOX (Fl_Boxtype)(fl_define_FL_GTK_UP_BOX()+9)

declare function fl_define_FL_GLEAM_UP_BOX() as Fl_Boxtype
#define FL_GLEAM_UP_BOX fl_define_FL_GLEAM_UP_BOX()
#define FL_GLEAM_DOWN_BOX (Fl_Boxtype)(fl_define_FL_GLEAM_UP_BOX()+1)
#define FL_GLEAM_UP_FRAME (Fl_Boxtype)(fl_define_FL_GLEAM_UP_BOX()+2)
#define FL_GLEAM_DOWN_FRAME (Fl_Boxtype)(fl_define_FL_GLEAM_UP_BOX()+3)
#define FL_GLEAM_THIN_UP_BOX (Fl_Boxtype)(fl_define_FL_GLEAM_UP_BOX()+4)
#define FL_GLEAM_THIN_DOWN_BOX (Fl_Boxtype)(fl_define_FL_GLEAM_UP_BOX()+5)
#define FL_GLEAM_ROUND_UP_BOX (Fl_Boxtype)(fl_define_FL_GLEAM_UP_BOX()+6)
#define FL_GLEAM_ROUND_DOWN_BOX (Fl_Boxtype)(fl_define_FL_GLEAM_UP_BOX()+7)

private function fl_box(b as Fl_Boxtype) as  Fl_Boxtype
	return cast(Fl_Boxtype, iif(b<FL_UP_BOX orelse b mod 4>1,b,b-2))
end function

private function fl_down(b as Fl_Boxtype) as Fl_Boxtype
	return cast(Fl_Boxtype,iif(b<FL_UP_BOX, b, b or 1))
end function

private function fl_frame_(b as Fl_Boxtype) as Fl_Boxtype
	return cast(Fl_Boxtype, iif(b mod 4<2,b,b+2))
end function

#define _FL_FRAME FL_ENGRAVED_FRAME
#define FL_FRAME_BOX FL_ENGRAVED_BOX
#define FL_CIRCLE_BOX FL_ROUND_DOWN_BOX
#define FL_DIAMOND_BOX FL_DIAMOND_DOWN_BOX

enum Fl_Labeltype
	FL_NORMAL_LABEL	= 0
	FL_NO_LABEL
	_FL_SHADOW_LABEL
	_FL_ENGRAVED_LABEL
	_FL_EMBOSSED_LABEL
	_FL_MULTI_LABEL
	_FL_ICON_LABEL
	_FL_IMAGE_LABEL

	FL_FREE_LABELTYPE
end enum

#define FL_SYMBOL_LABEL FL_NORMAL_LABEL
declare function fl_define_FL_SHADOW_LABEL() as Fl_Labeltype
#define FL_SHADOW_LABEL fl_define_FL_SHADOW_LABEL()
declare function fl_define_FL_ENGRAVED_LABEL() as Fl_Labeltype
#define FL_ENGRAVED_LABEL fl_define_FL_ENGRAVED_LABEL()
declare function fl_define_FL_EMBOSSED_LABEL() as Fl_Labeltype
#define FL_EMBOSSED_LABEL fl_define_FL_EMBOSSED_LABEL()

type Fl_Align as unsigned long

const FL_ALIGN_CENTER = 0
const FL_ALIGN_TOP = 1
const FL_ALIGN_BOTTOM = 2
const FL_ALIGN_LEFT = 4
const FL_ALIGN_RIGHT = 8
const FL_ALIGN_INSIDE = 16
const FL_ALIGN_TEXT_OVER_IMAGE	= &h0020
const FL_ALIGN_IMAGE_OVER_TEXT	= &h0000
const FL_ALIGN_CLIP		= 64
const FL_ALIGN_WRAP		= 128
const FL_ALIGN_IMAGE_NEXT_TO_TEXT = &h0100
const FL_ALIGN_TEXT_NEXT_TO_IMAGE = &h0120
const FL_ALIGN_IMAGE_BACKDROP  = &h0200
const FL_ALIGN_TOP_LEFT	= FL_ALIGN_TOP or FL_ALIGN_LEFT
const FL_ALIGN_TOP_RIGHT	= FL_ALIGN_TOP or FL_ALIGN_RIGHT
const FL_ALIGN_BOTTOM_LEFT	= FL_ALIGN_BOTTOM or FL_ALIGN_LEFT
const FL_ALIGN_BOTTOM_RIGHT	= FL_ALIGN_BOTTOM or FL_ALIGN_RIGHT
const FL_ALIGN_LEFT_TOP	= &h0007
const FL_ALIGN_RIGHT_TOP	= &h000b
const FL_ALIGN_LEFT_BOTTOM	= &h000d
const FL_ALIGN_RIGHT_BOTTOM	= &h000e
const FL_ALIGN_NOWRAP		= 0
const FL_ALIGN_POSITION_MASK   = &h000f
const FL_ALIGN_IMAGE_MASK      = &h0320

type Fl_Font as long
const as Fl_Font FL_HELVETICA              = 0
const as Fl_Font FL_HELVETICA_BOLD         = 1
const as Fl_Font FL_HELVETICA_ITALIC       = 2
const as Fl_Font FL_HELVETICA_BOLD_ITALIC  = 3
const as Fl_Font FL_COURIER                = 4
const as Fl_Font FL_COURIER_BOLD           = 5
const as Fl_Font FL_COURIER_ITALIC         = 6
const as Fl_Font FL_COURIER_BOLD_ITALIC    = 7
const as Fl_Font FL_TIMES                  = 8
const as Fl_Font FL_TIMES_BOLD             = 9
const as Fl_Font FL_TIMES_ITALIC           = 10
const as Fl_Font FL_TIMES_BOLD_ITALIC      = 11
const as Fl_Font FL_SYMBOL                 = 12
const as Fl_Font FL_SCREEN                 = 13
const as Fl_Font FL_SCREEN_BOLD            = 14
const as Fl_Font FL_ZAPF_DINGBATS          = 15

const as Fl_Font FL_FREE_FONT              = 16
const as Fl_Font FL_BOLD                   = 1
const as Fl_Font FL_ITALIC                 = 2
const as Fl_Font FL_BOLD_ITALIC            = 3

type Fl_Fontsize as long

extern "c"
extern FL_NORMAL_SIZE as Fl_Fontsize
end extern

type Fl_Color as unsigned long
const as Fl_Color FL_FOREGROUND_COLOR  = 0
const as Fl_Color FL_BACKGROUND2_COLOR = 7
const as Fl_Color FL_INACTIVE_COLOR    = 8
const as Fl_Color FL_SELECTION_COLOR   = 15

const as Fl_Color FL_GRAY0   = 32
const as Fl_Color FL_DARK3   = 39
const as Fl_Color FL_DARK2   = 45
const as Fl_Color FL_DARK1   = 47
const as Fl_Color FL_BACKGROUND_COLOR  = 49
const as Fl_Color FL_LIGHT1  = 50
const as Fl_Color FL_LIGHT2  = 52
const as Fl_Color FL_LIGHT3  = 54
const as Fl_Color FL_BLACK   = 56
const as Fl_Color FL_RED     = 88
const as Fl_Color FL_GREEN   = 63
const as Fl_Color FL_YELLOW  = 95
const as Fl_Color FL_BLUE    = 216
const as Fl_Color FL_MAGENTA = 248
const as Fl_Color FL_CYAN    = 223
const as Fl_Color FL_DARK_RED = 72

const as Fl_Color FL_DARK_GREEN    = 60
const as Fl_Color FL_DARK_YELLOW   = 76
const as Fl_Color FL_DARK_BLUE     = 136
const as Fl_Color FL_DARK_MAGENTA  = 152
const as Fl_Color FL_DARK_CYAN     = 140

const as Fl_Color FL_WHITE         = 255


#define FL_FREE_COLOR     cast(Fl_Color,16)
#define FL_NUM_FREE_COLOR 16
#define _FL_GRAY_RAMP      cast(Fl_Color,32)
#define FL_NUM_GRAY       24
#define FL_GRAY           FL_BACKGROUND_COLOR
#define _FL_COLOR_CUBE     cast(Fl_Color,56)
#define FL_NUM_RED        5
#define FL_NUM_GREEN      8
#define FL_NUM_BLUE       5

declare function fl_inactive(c as Fl_Color) as Fl_Color

declare function fl_contrast(fg as Fl_Color, bg as Fl_Color) as Fl_Color

declare function fl_color_average(c1 as Fl_Color, c2 as Fl_Color, weight as single) as Fl_Color

private function fl_lighter(c as Fl_Color) as Fl_Color
	return fl_color_average(c, FL_WHITE, .67f)
end function

private function fl_darker(c as Fl_Color) as Fl_Color
	return fl_color_average(c, FL_BLACK, .67f)
end function

private function fl_rgb_color overload (r as ubyte, g as ubyte, b as ubyte) as Fl_Color
	if r=0 andalso g=0 andalso b=0 then
		return FL_BLACK
	else
		return cast(Fl_Color,((((r shl 8) or g) shl 8) or b) shl 8)
	end if
end function

private function fl_rgb_color overload (g as ubyte) as Fl_Color
	if g=0 then
		return FL_BLACK
	else
		return cast(Fl_Color,((((g shl 8) or g) shl 8) or g) shl 8)
	end if
end function

private function fl_gray_ramp(i as long) as Fl_Color
	return cast(Fl_Color,i)+_FL_GRAY_RAMP
end function

private function fl_color_cube(r as long, g as long, b as long) as Fl_Color
	return cast(Fl_Color,(b*FL_NUM_RED + r) * FL_NUM_GREEN + g + _FL_COLOR_CUBE)
end function

enum Fl_Cursor 
	FL_CURSOR_DEFAULT    =  0
	FL_CURSOR_ARROW      = 35
	FL_CURSOR_CROSS      = 66
	FL_CURSOR_WAIT       = 76
	FL_CURSOR_INSERT     = 77
	FL_CURSOR_HAND       = 31
	FL_CURSOR_HELP       = 47
	FL_CURSOR_MOVE       = 27

	FL_CURSOR_NS         = 78
	FL_CURSOR_WE         = 79
	FL_CURSOR_NWSE       = 80
	FL_CURSOR_NESW       = 81
	FL_CURSOR_N          = 70
	FL_CURSOR_NE         = 69
	FL_CURSOR_E          = 49
	FL_CURSOR_SE         =  8
	FL_CURSOR_S          =  9
	FL_CURSOR_SW         =  7
	FL_CURSOR_W          = 36
	FL_CURSOR_NW         = 68

	FL_CURSOR_NONE       =255
end enum

enum
	FL_READ   = 1
	FL_WRITE  = 4
	FL_EXCEPT = 8
end enum

enum Fl_Mode  
	FL_RGB		= 0
	FL_INDEX	= 1
	FL_SINGLE	= 0
	FL_DOUBLE	= 2
	FL_ACCUM	= 4
	FL_ALPHA	= 8
	FL_DEPTH	= 16
	FL_STENCIL	= 32
	FL_RGB8		= 64
	FL_MULTISAMPLE= 128
	FL_STEREO     = 256
	FL_FAKE_SINGLE = 512
	FL_OPENGL3    = 1024
end enum

#define FL_IMAGE_WITH_ALPHA &h40000000

enum Fl_Damage 
	FL_DAMAGE_CHILD    = &h01
	FL_DAMAGE_EXPOSE   = &h02
	FL_DAMAGE_SCROLL   = &h04
	FL_DAMAGE_OVERLAY  = &h08
	FL_DAMAGE_USER1    = &h10
	FL_DAMAGE_USER2    = &h20
	FL_DAMAGE_ALL      = &h80
end enum






end extern
