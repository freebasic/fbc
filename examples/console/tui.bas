'' Text user interface example

namespace tui

type window
	declare constructor _
		( _
			new_x as integer = 1, new_y as integer = 1, _
			new_w as integer = 20, new_h as integer = 5, _
			new_title as string = "" _
		)
	declare destructor( )
	declare sub show( )

	'' Title property
	declare property title as string
	declare property title( new_title as string )

	'' Position properties
	declare property x as integer
	declare property x( new_x as integer )
	declare property y as integer
	declare property y( new_y as integer )

private:
	declare sub redraw( )
	declare sub remove( )
	declare sub drawtitle( )

	dim as string mytitle
	dim as integer posx, posy, sizew, sizeh
end type

constructor window _
	( _
		new_x as integer, new_y as integer, _
		new_w as integer, new_h as integer, _
		new_title as string _
	)

	this.posx = new_x
	this.posy = new_y
	this.sizew = new_w
	this.sizeh = new_h
	this.mytitle = new_title

	if( len( this.mytitle ) = 0 ) then
		this.mytitle = "untitled"
	end if

end constructor

destructor window( )
	color 7, 0
	cls
end destructor

property window.title( ) as string
	return this.mytitle
end property

property window.title( new_title as string )
	this.mytitle = new_title
	this.drawtitle( )
end property

property window.x( ) as integer
	return this.posx
end property

property window.x( new_x as integer )
	this.remove( )
	this.posx = new_x
	this.redraw( )
end property

property window.y( ) as integer
	return this.posy
end property

property window.y( new_y as integer )
	this.remove( )
	this.posy = new_y
	this.redraw( )
end property

sub window.show( )
	this.redraw( )
end sub

sub window.drawtitle( )
	locate this.posy, this.posx
	color 15, 1
	print space( this.sizew );
	locate this.posy, this.posx + (this.sizew \ 2) - (len( this.mytitle ) \ 2)
	print this.mytitle;
end sub

sub window.remove( )
	color 0, 0
	var spaces = space( this.sizew )
	for i as integer = this.posy to this.posy + this.sizeh - 1
		locate i, this.posx
		print spaces;
	next
end sub

sub window.redraw( )
	this.drawtitle( )
	color 8, 7
	var spaces = space( this.sizew )
	for i as integer = this.posy + 1 to this.posy + this.sizeh - 1
		locate i, this.posx
		print spaces;
	next
end sub

end namespace

	dim win as tui.window = tui.window( 3, 5, 50, 15 )

	win.show( )
	sleep 500

	win.title = "Window 1"
	sleep 250
	win.x = win.x + 10
	sleep 250

	win.title = "Window 2"
	sleep 250
	win.y = win.y - 2
	sleep 250

	locate 25, 1
	color 7, 0
	print "Press any key...";

	sleep
