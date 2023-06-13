#include once "Fl.bi"
#include once "Fl_Double_Window.bi"
#include once "Fl_Group.bi"
#include once "Fl_Choice.bi"
#include once "Fl_Menu_Button.bi"
#include once "Fl_Button.bi"
'#include once "Fl_Preferences.bi"
#include once "Fl_Tile.bi"
#include once "Fl_File_Browser.bi"
#include once "Fl_Box.bi"
#include once "Fl_Check_Button.bi"
#include once "Fl_File_Input.bi"
#include once "Fl_Return_Button.bi"
#include once "fl_ask.bi"

extern "c++"
type Fl_Preferences_ as Fl_Preferences

type Fl_File_Chooser
public:
	enum
		SINGLE_ = 0
		MULTI = 1
		CREATE = 2
		DIRECTORY = 4
	end enum
private:
	static prefs as Fl_Preferences_ ptr
	callback_ as sub(as Fl_File_Chooser ptr, as any ptr)
	data_ as any ptr
	directory_ as zstring*FL_PATH_MAX
	pattern_ as zstring*FL_PATH_MAX 
	preview_text_ as zstring*2048
	type__ as long
	declare sub favoritesButtonCB()
	declare sub favoritesCB(w as Fl_Widget ptr)
	declare sub fileListCB() 
	declare sub fileNameCB() 
	declare sub newdir()
	declare static sub previewCB(fc as Fl_File_Chooser ptr)
	declare sub showChoiceCB()
	declare sub update_favorites()
	declare sub update_preview()
public:
	declare constructor(d as const zstring ptr, p as const zstring ptr, t as long, title as const zstring ptr)
private:
	window_ as Fl_Double_Window ptr
	declare static sub cb_window(as Fl_Double_Window ptr, as any ptr)
	showChoice as Fl_Choice ptr
	declare static sub cb_showChoice(as Fl_Choice ptr, as any ptr)
	favoritesButton as Fl_Menu_Button ptr
	declare static sub cb_favoritesButton(as Fl_Menu_Button ptr, as any ptr)
public:
	newButton as Fl_Button ptr
private:
	declare static sub cb_newButton(as Fl_Button ptr, as any ptr)
	declare static sub cb_(as Fl_Tile ptr, as any ptr)
	fileList as Fl_File_Browser ptr
	declare static sub cb_fileList(as Fl_File_Browser ptr, as any ptr)
	previewBox as Fl_Box ptr
public:
	previewButton as Fl_Check_Button ptr
private:
	declare static sub cb_previewButton(as Fl_Check_Button ptr, as any ptr)
public:
	showHiddenButton as Fl_Check_Button ptr
private:
	declare static sub cb_showHiddenButton(as Fl_Check_Button ptr, as any ptr)
	fileName as Fl_File_Input ptr
	declare static sub cb_fileName(as Fl_File_Input ptr, as any ptr)
	okButton as Fl_Return_Button ptr
	declare static sub cb_okButton(as Fl_Return_Button ptr, as any ptr)
	cancelButton as Fl_Button ptr
	declare static sub cb_cancelButton(as Fl_Button ptr, as any ptr)
	favWindow as Fl_Double_Window ptr
	favList as Fl_File_Browser ptr
	declare static sub cb_favList(as Fl_File_Browser ptr, as any ptr)
	favUpButton as Fl_Button ptr
	declare static sub cb_favUpButton(as Fl_Button ptr, as any ptr)
	favDeleteButton as Fl_Button ptr
	declare static sub cb_favDeleteButton(as Fl_Button ptr, as any ptr)
	favDownButton as Fl_Button ptr
	declare static sub cb_favDownButton(as Fl_Button ptr, as any ptr)
	favCancelButton as Fl_Button ptr
	declare static sub cb_favCancelButton(as Fl_Button ptr, as any ptr)
	favOkButton as Fl_Return_Button ptr
	declare static sub cb_favOkButton(as Fl_Return_Button ptr, as any ptr)
public:
	declare destructor()
	declare sub callback(cb as sub(as Fl_File_Chooser ptr, as any ptr), d as any ptr = 0)
	declare sub color( c as Fl_Color)
	declare function color() as Fl_Color
	declare function count() as long
	declare sub directory__ alias "directory" (d as const zstring ptr)
	declare function directory__ alias "directory" () as zstring ptr
	declare sub filter(p as const zstring ptr)
	declare function filter() as const zstring ptr
	declare function filter_value() as long
	declare sub filter_value(f as long)
	declare sub hide()
	declare sub iconsize(s as ubyte)
	declare function iconsize() as ubyte
	declare sub label(l as const zstring ptr)
	declare function label() as const zstring ptr
	declare sub ok_label(l as const zstring ptr)
	declare function ok_label() as const zstring ptr
	declare sub preview(e as long)
	declare const function preview() as long
private:
	declare sub showHidden(e as long)
	declare sub remove_hidden_files()
public:
	declare sub rescan()
	declare sub rescan_keep_filename()
	declare sub show()
	declare function shown() as long
	declare sub textcolor(c as Fl_Color)
	declare function textcolor() as Fl_Color
	declare sub textfont(f as Fl_Font)
	declare function textfont() as Fl_Font
	declare sub textsize(s as Fl_Fontsize)
	declare function textsize() as Fl_Fontsize
	declare sub type_ alias "type"(t as long)
	declare function type_ alias "type"() as long
	declare const function user_data() as any ptr
	declare sub user_data(d as any ptr)
	declare function value(f as long=1) as const zstring ptr
	declare sub value(filename as const zstring ptr)
	declare function visible() as long

	static add_favorites_label as const zstring ptr
	static all_files_label as const zstring ptr
	static custom_filter_label as const zstring ptr
	static existing_file_label as const zstring ptr
	static favorites_label as const zstring ptr
	static filename_label as const zstring ptr
	static filesystems_label as const zstring ptr
	static manage_favorites_label as const zstring ptr
	static new_directory_label as const zstring ptr
	static new_directory_tooltip as const zstring ptr
	static preview_label as const zstring ptr
	static save_label as const zstring ptr
	static show_label as const zstring ptr
	static hidden_label as const zstring ptr
	static sort as Fl_File_Sort_F ptr
private:
	ext_group as Fl_Widget ptr
public:
	declare function add_extra(gr as Fl_Widget ptr) as Fl_Widget ptr

end type

declare function fl_dir_chooser(message as const zstring ptr, fname as const zstring ptr, relative as long=0) as zstring ptr
declare function fl_file_chooser_ alias "fl_file_chooser" (message as const zstring ptr,pat as const zstring ptr, fname as const zstring ptr, relative as long=0) as zstring ptr
declare sub fl_file_chooser_callback(cb as sub(as const zstring ptr))
declare sub fl_file_chooser_ok_label(l as const zstring ptr)
end extern

private function Fl_File_Chooser.preview() as long
	return previewButton->value()
end function
