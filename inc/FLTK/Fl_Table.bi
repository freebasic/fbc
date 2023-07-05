#include once "Fl.bi"
#include once "Fl_Group.bi"
#include once "Fl_Scroll.bi"
#include once "Fl_Box.bi"
#include once "Fl_Scrollbar.bi"


extern "c++"

type Fl_Table extends Fl_Group 
	enum TableContext
		CONTEXT_NONE       = 0
		CONTEXT_STARTPAGE  = &H01
		CONTEXT_ENDPAGE    = &H02
		CONTEXT_ROW_HEADER = &H04
		CONTEXT_COL_HEADER = &H08
		CONTEXT_CELL       = &H10
		CONTEXT_TABLE      = &H20
		CONTEXT_RC_RESIZE  = &H40
	end enum
private:
	as long _rows, _cols
	_row_header_w as long
	_col_header_h as long
	_row_position as long
	_col_position as long
  
	_row_header as ubyte
	_col_header as ubyte
	_row_resize as ubyte
	_col_resize as ubyte
	_row_resize_min as ubyte
	_col_resize_min as ubyte
  
	_redraw_toprow as long
	_redraw_botrow as long
	_redraw_leftcol as long
	_redraw_rightcol as long
	_row_header_color as Fl_Color
	_col_header_color as Fl_Color
  
	auto_drag as long
	_selecting as long

	type IntVector
	private:
		arr as long ptr
		_size as unsigned long
		'declare sub init() 
		declare sub copy(newarr as long ptr, newsize as unsigned long)
	public:
		declare constructor
		declare destructor
		declare constructor (byref o as IntVector)
		declare operator let (byref o as IntVector)
		declare operator [] (x as long) as long
		declare function size() as unsigned long
		declare sub size(count as unsigned long)
		declare function pop_back() as long
		declare sub push_back(val_ as long)
		declare function back() as long
	end type

	_colwidths as IntVector
	_rowheights as IntVector
  
	_last_cursor as Fl_Cursor

	_callback_context as TableContext
	as long _callback_row, _callback_col
  
	_resizing_col as long
	_resizing_row as long
	_dragging_x as long
	_dragging_y as long
	_last_row as long
  
	declare sub _redraw_cell(context as TableContext, R as long, C as long)
  
	declare sub _start_auto_drag()
	declare sub _stop_auto_drag()
	declare sub _auto_drag_cb()
	declare static sub _auto_drag_cb2(d as any ptr)
protected:
	declare constructor (byref b as const Fl_Table)
	declare operator let (byref b as const Fl_Table)

	enum ResizeFlag
		RESIZE_NONE      = 0
		RESIZE_COL_LEFT  = 1
		RESIZE_COL_RIGHT = 2
		RESIZE_ROW_ABOVE = 3
		RESIZE_ROW_BELOW = 4
	end enum
  
	as long table_w, table_h
	as long toprow, botrow, leftcol, rightcol
  
	as long current_row, current_col
	as long select_row, select_col
  
	toprow_scrollpos as long
	leftcol_scrollpos as long
  
	as long tix, tiy, tiw, tih
	as long tox, toy, tow, toh
	as long wix, wiy, wiw, wih
  
	table as Fl_Scroll ptr
	vscrollbar as Fl_Scrollbar ptr
	hscrollbar as Fl_Scrollbar ptr

	declare function handle(e as long) as long
  
	declare sub recalc_dimensions()
	declare sub table_resized()
	declare sub table_scrolled()
	declare sub get_bounds(context as TableContext, byref X as long, byref Y as long, byref W as long, byref H as long)
	declare sub change_cursor(newcursor as Fl_Cursor)
	declare function cursor2rowcol(byref R as long, byref C as long, byref resizeflag as ResizeFlag) as TableContext
	declare function find_cell(context as TableContext, R as long, C as long, byref X as long, byref Y as long, byref W as long, byref H as long) as long
	declare function row_col_clamp(context as TableContext, byref R as long, byref C as long) as long

	declare virtual sub draw_cell(context as TableContext, R as long=0, C as long=0, X as long=0, Y as long=0, W as long=0, H as long=0)
  
	declare function row_scroll_position(row as long) as integer
	declare function col_scroll_position(col as long) as integer
  
	declare function is_fltk_container() as long
  
	declare static sub scroll_cb(as Fl_Widget ptr, as any ptr)
  
	declare sub damage_zone(r1 as long, c1 as long, r2 as long, c2 as long, r3 as long = 0, c3 as long = 0)
  
	declare sub redraw_range(topRow as long, botRow as long, leftCol as long, rightCol as long)
public:
	declare constructor(X as long, Y as long, W as long, H as long, l as const zstring ptr=0)
	declare destructor

	declare virtual sub clear()

	declare sub table_box(val_ as Fl_Boxtype)
	declare function table_box() as Fl_Boxtype

	declare virtual sub rows(val_ as long)
	declare function rows() as long
	declare virtual sub cols(val_ as long)
	declare function cols() as long

	declare sub visible_cells(byref r1 as long, byref r2 as long, byref c1 as long, byref c2 as long) 
	declare function is_interactive_resize() as long
	declare function row_resize() as long
	declare sub row_resize(flag as long)
	declare function col_resize() as long
	declare sub col_resize(flag as long)
	declare function col_resize_min() as long
	declare sub col_resize_min(val_ as long)
	declare function row_resize_min() as long
	declare sub row_resize_min(val_ as long)
	declare function row_header() as long
	declare sub row_header(flag as long)
	declare function col_header() as long
	declare sub col_header(flag as long)
	declare sub col_header_height(height as long)
	declare function col_header_height() as long
	declare sub row_header_width(width_ as long)
	declare function row_header_width() as long
	declare sub row_header_color(val_ as Fl_Color)
	declare function row_header_color() as Fl_Color
	declare sub col_header_color(val_ as Fl_Color)
	declare function col_header_color() as Fl_Color
	declare sub row_height(row as long, height as long)
	declare function row_height(row as long) as long
	declare sub col_width(col as long, width_ as long)
	declare function col_width(col as long) as long
	declare sub row_height_all(height as long)
	declare sub col_width_all(width_ as long)
	declare sub row_position(row as long)
	declare sub col_position(col as long)
	declare function row_position() as long
	declare function col_position() as long
	declare sub top_row(row as long)
	declare function top_row() as long

	declare function is_selected(r as long, c as long) as long
	declare sub get_selection(byref row_top as long, byref col_left  as long, byref row_bot as long, byref col_right as long)
	declare sub set_selection(row_top as long, col_left as long, row_bot as long, col_right as long)
	declare function move_cursor(R as long, C as long, shiftselect as long) as long
	declare function move_cursor(R as long, C as long) as long

	declare sub resize(X as long, Y as long, W as long, H as long)
	declare sub draw()

	declare sub init_sizes()
	declare sub add(byref wgt as Fl_Widget)
	declare sub add(wgt as Fl_Widget ptr)
	declare sub insert(byref wgt as Fl_Widget, n as long)
	declare sub insert(byref wgt as Fl_Widget, w2 as Fl_Widget ptr)
	declare sub remove(byref wgt as Fl_Widget)
	declare sub begin()
	declare sub end_()

	declare function array() as Fl_Widget ptr const ptr
	declare const function child(n as long) as Fl_Widget ptr 
	declare const function children() as long
	declare const function find(wgt as const Fl_Widget ptr) as long
	declare const function find(byref wgt as const Fl_Widget) as long

	declare function callback_row() as long
	declare function callback_col() as long
	declare function callback_context() as TableContext

	declare sub do_callback(context as TableContext, row as long, col as long)

end type

end extern

private function Fl_Table.is_fltk_container() as long
	return( base.children() > 3 )
end function

private sub Fl_Table.redraw_range(topRow as long, botRow as long, leftCol as long, rightCol as long)
	if  _redraw_toprow = -1 then
		_redraw_toprow = topRow
		_redraw_botrow = botRow
		_redraw_leftcol = leftCol
		_redraw_rightcol = rightCol
	else
		if topRow < _redraw_toprow then _redraw_toprow = topRow
		if botRow > _redraw_botrow then _redraw_botrow = botRow
		if leftCol < _redraw_leftcol then _redraw_leftcol = leftCol
		if rightCol > _redraw_rightcol then _redraw_rightcol = rightCol
	end if    

	damage(FL_DAMAGE_CHILD)
end sub

private sub Fl_Table.clear()
	rows(0): cols(0): table->clear()
end sub

private sub Fl_Table.table_box(val_ as Fl_Boxtype)
	table->box(val_)
	table_resized()
end sub

private function Fl_Table.table_box() as Fl_Boxtype
	return table->box()
end function

private function Fl_Table.rows() as long
	return _rows
end function

private function Fl_Table.cols() as long
	return _cols
end function

private sub Fl_Table.visible_cells(byref r1 as long, byref r2 as long, byref c1 as long, byref c2 as long) 
	r1 = toprow
	r2 = botrow
	c1 = leftcol
	c2 = rightcol
end sub

private function Fl_Table.is_interactive_resize() as long
	return(_resizing_row <> -1 orelse _resizing_col <> -1)
end function

private function Fl_Table.row_resize() as long
	return _row_resize
end function

private sub Fl_Table.row_resize(flag as long)
	_row_resize=flag
end sub

private function Fl_Table.col_resize() as long
	return _col_resize
end function

private sub Fl_Table.col_resize(flag as long)
	_col_resize=flag
end sub

private function Fl_Table.col_resize_min() as long
	return _col_resize_min
end function

private sub Fl_Table.col_resize_min(val_ as long)
	_col_resize_min = iif( val_ < 1 , 1 , val_)
end sub

private function Fl_Table.row_resize_min() as long
	return _row_resize_min
end function

private sub Fl_Table.row_resize_min(val_ as long)
	_row_resize_min = iif( val_ < 1 , 1 , val_)
end sub

private function Fl_Table.row_header() as long
	return _row_header
end function

private sub Fl_Table.row_header(flag as long)
	_row_header=flag
	table_resized()
	redraw()
end sub

private function Fl_Table.col_header() as long
	return _col_header
end function

private sub Fl_Table.col_header(flag as long)
	_col_header=flag
	table_resized()
	redraw()
end sub

private sub Fl_Table.col_header_height(height as long)
	_col_header_h=height
	table_resized()
	redraw()
end sub

private function Fl_Table.col_header_height() as long
	return _col_header_h
end function

private sub Fl_Table.row_header_width(width_ as long)
	_row_header_w=width_
	table_resized()
	redraw()
end sub

private function Fl_Table.row_header_width() as long
	return _row_header_w
end function

private sub Fl_Table.row_header_color(val_ as Fl_Color)
	_row_header_color=val_
	redraw()
end sub

private function Fl_Table.row_header_color() as Fl_Color
	return _row_header_color
end function

private sub Fl_Table.col_header_color(val_ as Fl_Color)
	_col_header_color=val_
	redraw()
end sub

private function Fl_Table.col_header_color() as Fl_Color
	return _col_header_color
end function

private function Fl_Table.row_height(row as long) as long
	return iif(row<0 or row>=_rowheights.size(), 0 , _rowheights[row])
end function

private function Fl_Table.col_width(col as long) as long
	return iif(col<0 or col>=_colwidths.size(), 0 , _colwidths[col])
end function

private sub Fl_Table.row_height_all(height as long)
	for r as long=0 to rows()-1
		row_height(r, height)
	next
end sub

private sub Fl_Table.col_width_all(width_ as long)
	for c as long=0 to cols()-1
		col_width(c, width)
	next
end sub

private function Fl_Table.row_position() as long
	return _row_position
end function

private function Fl_Table.col_position() as long
	return _col_position
end function

private sub Fl_Table.top_row(row as long)
	row_position(row)
end sub

private function Fl_Table.top_row() as long
	return row_position()
end function

private sub Fl_Table.init_sizes()
	table->init_sizes()
	table->redraw()
end sub

private sub Fl_Table.add(byref wgt as Fl_Widget)
	table->add(wgt)
	if  table->children() > 2 then
		table->show()
	else 
		table->hide()
	end if

end sub

private sub Fl_Table.add(wgt as Fl_Widget ptr)
	add *wgt
end sub

private sub Fl_Table.insert(byref wgt as Fl_Widget, n as long)
	table->insert(wgt,n)
end sub

private sub Fl_Table.insert(byref wgt as Fl_Widget, w2 as Fl_Widget ptr)
	table->insert(wgt, w2)
end sub

private sub Fl_Table.remove(byref wgt as Fl_Widget)
	table->remove(wgt)
end sub

private sub Fl_Table.begin()
	table->begin()
end sub

private sub Fl_Table.end_()
	table->end_()
	if table->children() > 2 then
		table->show()
	else
		table->hide()
	end if
	Fl_Group.current(base.parent())
end sub

private function Fl_Table.array() as Fl_Widget ptr const ptr
	return table->array()
end function

private function Fl_Table.child(n as long) as Fl_Widget ptr 
	return table->child(n)
end function

private function Fl_Table.children() as long
	return table->children()-2
end function

private function Fl_Table.find(wgt as const Fl_Widget ptr) as long
	return table->find(wgt)
end function

private function Fl_Table.find(byref wgt as const Fl_Widget) as long
	return table->find(wgt)
end function

private function Fl_Table.callback_row() as long
	return _callback_row
end function

private function Fl_Table.callback_col() as long
	return _callback_col
end function

private function Fl_Table.callback_context() as TableContext
	return _callback_context
end function

private sub Fl_Table.do_callback(context as TableContext, row as long, col as long)
	_callback_context = context
	_callback_row = row
	_callback_col = col
	base.base.do_callback()
end sub

private sub Fl_Table.IntVector.copy(newarr as long ptr, newsize as unsigned long)
	size(newsize)
	for i as integer=1 to newsize
		arr[i]=newarr[i]
	next
end sub

private constructor Fl_Table.IntVector
	arr=0:_size=0
end constructor

private destructor Fl_Table.IntVector
	if  arr<>0 then deallocate(arr): arr = 0
end destructor

private constructor Fl_Table.IntVector (byref o as IntVector)
	arr=0:_size=0
	copy(o.arr, o._size)
end constructor

private operator Fl_Table.IntVector.let (byref o as IntVector)
	arr=0:_size=0
	copy(o.arr, o._size)
end operator

private operator Fl_Table.IntVector.[] (x as long) as long
	return(arr[x])
end operator

private function Fl_Table.IntVector.size() as unsigned long
	return _size
end function

private sub Fl_Table.IntVector.size(count as unsigned long)
	if count <> _size then
		arr = reallocate(arr, count * sizeof(long))
		_size = count
	end if
end sub

private function Fl_Table.IntVector.pop_back() as long
	dim as long tmp = arr[_size-1]: _size-=1: return(tmp)
end function

private sub Fl_Table.IntVector.push_back(val_ as long)
	dim as unsigned long x = _size: size(_size+1): arr[x] = val_
end sub

private function Fl_Table.IntVector.back() as long
	return(arr[_size-1])
end function
