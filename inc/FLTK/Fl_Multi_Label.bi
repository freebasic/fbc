extern "c++"
type Fl_Widget_ as Fl_Widget
type Fl_Menu_Item_ as Fl_Menu_Item

type Fl_Multi_Label
	labela as const zstring ptr
	labelb as const zstring ptr
	typea as ubyte
	typeb as ubyte

	declare sub label(as Fl_Widget_ ptr)
	declare sub label(as Fl_Menu_Item_ ptr)
end type
end extern

