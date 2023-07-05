#include once "Fl_Input_.bi"

extern "c++"
type Fl_Input extends Fl_Input_ 
private:
	declare constructor (byref b as const Fl_Input)
	declare operator let (byref b as const Fl_Input)


	declare function handle_key() as long
	declare function shift_position(p as long) as long
	declare function shift_up_down_position(p as long) as long
	declare sub handle_mouse(keepmark as long=0)

	declare function kf_lines_up(repeat_num as long) as long
	declare function kf_lines_down(repeat_num as long) as long
	declare function kf_page_up() as long
	declare function kf_page_down() as long
	declare function kf_insert_toggle() as long
	declare function kf_delete_word_right() as long
	declare function kf_delete_word_left() as long
	declare function kf_delete_sol() as long
	declare function kf_delete_eol() as long
	declare function kf_delete_char_right() as long
	declare function kf_delete_char_left() as long
	declare function kf_move_sol() as long
	declare function kf_move_eol() as long
	declare function kf_clear_eol() as long
	declare function kf_move_char_left() as long
	declare function kf_move_char_right() as long
	declare function kf_move_word_left() as long
	declare function kf_move_word_right() as long
	declare function kf_move_up_and_sol() as long
	declare function kf_move_down_and_eol() as long
	declare function kf_top() as long
	declare function kf_bottom() as long
	declare function kf_select_all() as long
	declare function kf_undo() as long
	declare function kf_redo() as long
	declare function kf_copy() as long
	declare function kf_paste() as long
	declare function kf_copy_cut() as long
protected:
	declare sub draw()
public:
	'declare constructor()
	declare function handle(as long) as long
	declare constructor(as long,as long,as long,as long,as const zstring ptr = 0)

end type
end extern
