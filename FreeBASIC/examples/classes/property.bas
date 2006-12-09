'' properties example

namespace tui

	type window
	
		'' public
		declare constructor ( _x as integer = 1, _y as integer = 1, _
							  _w as integer = 20, _h as integer = 5, _
							  _title as zstring ptr = 0 )
		declare destructor
		
		declare sub show
		
		'' title prop
		declare property title as string
		declare property title( new_title as string )

		'' pos prop
		declare property x as integer
		declare property x( new_x as integer )
		declare property y as integer
		declare property y( new_y as integer )
		
	private:
		declare sub redraw
		declare sub drawtitle
		
		dim as string p_title
		dim as integer p_x, p_y, p_w, p_h
		
	end type
	
	''
	constructor window( _x as integer, _y as integer, _
						_w as integer, _h as integer, _
						_title as zstring ptr )
		
		p_x = _x
		p_y = _y
		p_w = _w
		p_h = _h
		
		if( _title = 0 ) then
			_title = @"untitled"
		end if
		
		p_title = *_title
	end constructor

	''
	destructor window
		color 7, 0
		cls
	end destructor

	''
	property window.title as string
		title = p_title		
	end property

	''
	property window.title ( new_title as string )		
		p_title = new_title
		drawtitle
	end property
	
	''
	property window.x as integer
		return p_x
	end property

	''
	property window.x ( new_x as integer )
		p_x = new_x
		redraw
	end property

	''
	property window.y as integer
		property = p_y
	end property

	''
	property window.y ( new_y as integer )
		p_y = new_y
		redraw
	end property
	
	''
	sub window.show
		redraw
	end sub

	''	
	sub window.drawtitle
		locate p_y, p_x
		color 15, 1
		print space( p_w );
		
		locate p_y, p_x + (p_w \ 2) - (len( p_title ) \ 2)
		print p_title;
		
	end sub

	''
	sub window.redraw
		color 7, 0
		cls
		
		drawtitle
	
		dim as integer i
		color 8, 7
		for i = p_y + 1 to p_y + p_h - 1
			locate i, p_x
			print space( p_w );
		next
	end sub
	
end namespace

	
sub main
	dim win as tui.window = tui.window( 3, 5, 50, 15 )
	
	with win
		.show
		sleep 500
		
		.title = "Window 1"	
		sleep 250
		.x = .x + 5
		sleep 250
			
		.title = "Window 2"
		sleep 250
		.y = .y - 2
		sleep 250
	end with
	
	locate 25, 1
	color 7, 0
	print "Press any key...";
	
	sleep
end sub

	main