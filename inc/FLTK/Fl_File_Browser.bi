#include once "Fl_Browser.bi"
#include once "Fl_File_Icon.bi"
#include once "filename.bi"

extern "c++"
type Fl_File_Browser extends Fl_Browser field=4
private:
	filetype_ as long
	directory_ as const zstring ptr
	iconsize_ as ubyte
	pattern_ as const zstring ptr

	declare const function full_height() as long
	declare const function item_height(as any ptr) as long
	declare const function item_width(as any ptr) as long
	declare const sub item_draw(as any ptr, as long, as long, as long, as long)
	declare const function incr_height() as long

protected:
	declare constructor (byref b as const Fl_File_Browser)
	declare operator let (byref b as const Fl_File_Browser)
public:
	enum
		FILES
		DIRECTORIES
	end enum

	declare constructor(as long, as long, as long, as long, as const zstring ptr=0)

	declare const function iconsize() as ubyte
	declare sub iconsize(s as ubyte)
	declare sub filter(pattern as const zstring ptr)
	declare const function filter() as const zstring ptr
	declare function load(directory as const zstring ptr, sort as Fl_File_Sort_F = @fl_numericsort) as long
	declare const function textsize() as Fl_Fontsize
	declare sub textsize(s as Fl_Fontsize)
	declare const function filetype() as long
	declare sub filetype(t as long)

end type
end extern

private function Fl_File_Browser.incr_height() as long
	return (item_height(0))
end function

private function Fl_File_Browser.iconsize() as ubyte
	return (iconsize_)
end function

private sub Fl_File_Browser.iconsize(s as ubyte)
	iconsize_ = s: redraw()
end sub

private function Fl_File_Browser.filter() as const zstring ptr
	return (pattern_)
end function

private function Fl_File_Browser.textsize() as Fl_Fontsize 
	return base.textsize()
end function

private sub Fl_File_Browser.textsize(s as Fl_Fontsize)
	base.textsize(s): iconsize_ = cast(ubyte, 3 * s / 2)
end sub

private function Fl_File_Browser.filetype() as long
	return (filetype_)
end function

private sub Fl_File_Browser.filetype(t as long)
	filetype_ = t
end sub
