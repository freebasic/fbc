#include once "Fl_Text_Display.bi"


extern "c++"

type Fl_Text_Editor extends Fl_Text_Display
protected:
	declare constructor (byref b as const Fl_Text_Editor)
	declare operator let (byref b as const Fl_Text_Editor)

public:
	type Key_Func as function(key as long, editor as Fl_Text_Editor ptr) as long

	type Key_Binding 
	      key as long
	      state as long
	      function_ as Key_Func
	      next_ as Key_Binding ptr
	end type

	declare constructor(x as long, y as long, w as long, h as long, title as const zstring ptr=0)
	declare destructor()
	declare virtual function handle(as long) as long

	declare sub insert_mode(b as long)
	declare function insert_mode() as long

	declare sub tab_nav(b as long)
	declare const function tab_nav() as long

	declare static function kf_default(c as long, e as Fl_Text_Editor ptr) as long
	declare static function kf_ignore(c as long, e as Fl_Text_Editor ptr) as long
	declare static function kf_backspace(c as long, e as Fl_Text_Editor ptr) as long
	declare static function kf_enter(c as long, e as Fl_Text_Editor ptr) as long
	declare static function kf_move(c as long, e as Fl_Text_Editor ptr) as long
	declare static function kf_shift_move(c as long, e as Fl_Text_Editor ptr) as long
	declare static function kf_ctrl_move(c as long, e as Fl_Text_Editor ptr) as long
	declare static function kf_c_s_move(c as long, e as Fl_Text_Editor ptr) as long
	declare static function kf_meta_move(c as long, e as Fl_Text_Editor ptr) as long
	declare static function kf_m_s_move(c as long, e as Fl_Text_Editor ptr) as long
	declare static function kf_home(c as long, e as Fl_Text_Editor ptr) as long
	declare static function kf_end(c as long, e as Fl_Text_Editor ptr) as long
	declare static function kf_left(c as long, e as Fl_Text_Editor ptr) as long
	declare static function kf_up(c as long, e as Fl_Text_Editor ptr) as long
	declare static function kf_right(c as long, e as Fl_Text_Editor ptr) as long
	declare static function kf_down(c as long, e as Fl_Text_Editor ptr) as long
	declare static function kf_page_up(c as long, e as Fl_Text_Editor ptr) as long
	declare static function kf_page_down(c as long, e as Fl_Text_Editor ptr) as long
	declare static function kf_insert(c as long, e as Fl_Text_Editor ptr) as long
	declare static function kf_delete(c as long, e as Fl_Text_Editor ptr) as long
	declare static function kf_copy(c as long, e as Fl_Text_Editor ptr) as long
	declare static function kf_cut(c as long, e as Fl_Text_Editor ptr) as long
	declare static function kf_paste(c as long, e as Fl_Text_Editor ptr) as long
	declare static function kf_select_all(c as long, e as Fl_Text_Editor ptr) as long
	declare static function kf_undo(c as long, e as Fl_Text_Editor ptr) as long


protected:
	declare function handle_key() as long
	declare sub maybe_do_callback()

	insert_mode_ as long
	key_bindings as Fl_Text_Editor.Key_Binding ptr

	static global_key_bindings as Fl_Text_Editor.Key_Binding ptr
	default_key_function_ as Fl_Text_Editor.Key_Func
end type

end extern

private destructor Fl_Text_Editor()
	'remove_all_key_bindings()
end destructor

private sub Fl_Text_Editor.insert_mode(b as long) 
	insert_mode_=b
end sub

private function Fl_Text_Editor.insert_mode() as long
	return insert_mode_
end function

