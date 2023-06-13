#include once "Enumerations.bi"

type Fl_Widget_ as Fl_Widget

enum Fl_Beep_
	FL_BEEP_DEFAULT = 0
	FL_BEEP_MESSAGE
	FL_BEEP_ERROR
	FL_BEEP_QUESTION
	FL_BEEP_PASSWORD
	FL_BEEP_NOTIFICATION
end enum

extern "c++"
declare sub fl_beep(t as long = FL_BEEP_DEFAULT)
declare sub fl_message(char as const zstring ptr,...)
declare sub fl_alert(char as const zstring ptr,...)

declare function fl_ask(char as const zstring ptr,...) as long
declare function fl_choice_ alias "fl_choice" (q as const zstring ptr, b0 as const zstring ptr, b1 as const zstring ptr, b2  as const zstring ptr,...) as long
declare function _fl_input alias "fl_input" (label as const zstring ptr, deflt as const zstring ptr= 0, ...) as const zstring ptr
declare function fl_password(label as const zstring ptr, deflt as const zstring ptr= 0, ...) as const zstring ptr

declare function fl_message_icon() as Fl_Widget ptr
extern "c"
extern fl_message_font_ as Fl_Font
extern fl_message_size_ as Fl_Fontsize
end extern
declare sub fl_message_font(f as Fl_Font , s as Fl_Fontsize) 

declare sub fl_message_hotspot overload(enable as long)
declare function fl_message_hotspot overload () as long

declare sub fl_message_title(title as const zstring ptr)
declare sub fl_message_title_default(title as const zstring ptr)

extern "c"
extern fl_no as const zstring ptr
extern fl_yes as const zstring ptr
extern fl_ok as const zstring ptr
extern fl_cancel as const zstring ptr
extern fl_close_ alias "fl_close" as const zstring ptr
end extern

end extern


private sub fl_message_font(f as Fl_Font , s as Fl_Fontsize) 
	fl_message_font_ = f: fl_message_size_ = s
end sub
