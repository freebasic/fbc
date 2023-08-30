#include once "Fl_Table.bi"

extern "c++"
type CharVector 
private:
	arr as byte ptr
	_size as long
	'declare sub init() 
	declare sub copy(newarr as byte ptr, newsize as long)
public:
	declare constructor
	declare destructor
	declare constructor (byref o as CharVector)
	declare operator let (byref o as CharVector)
	declare operator [] (x as long) as long
	declare function size() as long
	declare sub size(count as long)
	declare function pop_back() as long
	declare sub push_back(val_ as long)
	declare function back() as long
end type

private sub CharVector.copy(newarr as byte ptr, newsize as long)
	size(newsize)
	for i as integer=1 to newsize
		arr[i]=newarr[i]
	next
end sub

private constructor CharVector
	arr=0:_size=0
end constructor

private destructor CharVector
	if  arr<>0 then deallocate(arr): arr = 0
end destructor

private constructor CharVector (byref o as CharVector)
	arr=0:_size=0
	copy(o.arr, o._size)
end constructor

private operator CharVector.let (byref o as CharVector)
	arr=0:_size=0
	copy(o.arr, o._size)
end operator

private operator CharVector.[] (x as long) as long
	return(arr[x])
end operator

private function CharVector.size() as long
	return _size
end function

private sub CharVector.size(count as long)
	if count <> _size then
		arr = reallocate(arr, count * sizeof(byte))
		_size = count
	end if
end sub

private function CharVector.pop_back() as long
	dim as long tmp = arr[_size-1]: _size-=1: return(tmp)
end function

private sub CharVector.push_back(val_ as long)
	dim as unsigned long x = _size: size(_size+1): arr[x] = val_
end sub

private function CharVector.back() as long
	return(arr[_size-1])
end function

type Fl_Table_Row extends Fl_Table
	enum TableRowSelectMode
		SELECT_NONE
		SELECT_SINGLE
		SELECT_MULTI
	end enum
private:
	_rowselect as CharVector
	_dragging_select as long
	_last_row as long
	_last_y as long
	_last_push_x as long
	_last_push_y as long
  
	_selectmode as long'TableRowSelectMode

protected:
	declare constructor (byref b as const Fl_Table_Row)
	declare operator let (byref b as const Fl_Table_Row)

	declare function handle(event as long) as long
	declare function find_cell(context as TableContext, R as long, C as long, byref X as long, byref Y as long, byref W as long, byref H as long) as long
public:
	declare constructor(X as long, Y as long, W as long, H as long, l as const zstring ptr=0)
	declare destructor

	declare sub rows(val as long)
	declare function rows() as long
  
	declare sub type_ alias "type" (val_ as TableRowSelectMode)
	declare const function type_ () as TableRowSelectMode 
  
	declare function row_selected(row as long) as long
	declare function select_row(row as long, flag as long=1) as long
	declare sub select_all_rows(flag as long=1)
  
	declare sub clear()
end type

end extern

private function Fl_Table_Row.find_cell(context as TableContext, R as long, C as long, byref X as long, byref Y as long, byref W as long, byref H as long) as long
	return(base.find_cell(context, R, C, X, Y, W, H))
end function

private constructor Fl_Table_Row(X as long, Y as long, W as long, H as long, l as const zstring ptr=0)
	base(X,Y,W,H,l)
	_dragging_select = 0
	_last_row        = -1
	_last_y          = -1
	_last_push_x     = -1
	_last_push_y     = -1
	_selectmode      = SELECT_MULTI
end constructor

private destructor Fl_Table_Row
end destructor

private function Fl_Table_Row.rows() as long
	return base.rows()
end function

function Fl_Table_Row.type_  () as TableRowSelectMode
	return _selectmode
end function

private sub Fl_Table_Row.clear()
	rows(0): cols(0): base.clear()
end sub
