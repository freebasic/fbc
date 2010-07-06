'' properties example

namespace tui

	type point
		dim as integer x, y
	end type
	
	type char
		dim as ubyte value
		dim as ubyte color
	end type
	
	type window
		'' public
		declare constructor _
			( _
				x as integer = 1, y as integer = 1, _
				w as integer = 20, h as integer = 5, _
				title as zstring ptr = 0 _
			)
		
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
		declare sub remove
		declare sub drawtitle
		
		dim as string p_title
		dim as point pos
		dim as point siz
	end type
	
	''
	constructor window _
		( _
			x_ as integer, y_ as integer, _
			w_ as integer, h_ as integer, _
			title_ as zstring ptr _
		)
		
		pos.x = x_
		pos.y = y_
		siz.x = w_
		siz.y = h_
		
		if( title_ = 0 ) then
			title_ = @"untitled"
		end if
		
		p_title = *title_
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
	property window.title _
		( _
			new_title as string _
		)
		
		p_title = new_title
		drawtitle
	end property
	
	''
	property window.x as integer
		return pos.x
	end property

	''
	property window.x _
		( _
			new_x as integer _
		)
		
		remove
		pos.x = new_x
		redraw
	end property

	''
	property window.y as integer
		property = pos.y
	end property

	''
	property window.y _
		( _	
			new_y as integer _
		)
		
		remove
		pos.y = new_y
		redraw
	end property
	
	''
	sub window.show
		redraw
	end sub

	''	
	sub window.drawtitle
		locate pos.y, pos.x
		color 15, 1
		print space( siz.x );
		
		locate pos.y, pos.x + (siz.x \ 2) - (len( p_title ) \ 2)
		print p_title;
		
	end sub

	''
	sub window.remove
		color 0, 0
		var sp = space( siz.x )
		for i as integer = pos.y to pos.y + siz.y - 1
			locate i, pos.x
			print sp;
		next
	end sub

	''
	sub window.redraw
		drawtitle
		
		color 8, 7
		var sp = space( siz.x )
		for i as integer = pos.y + 1 to pos.y + siz.y - 1
			locate i, pos.x
			print sp;
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
		.x = .x + 10
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
