'' Dialog example

#include once "allegro.bi" 
 
#define S_RED 2 
#define S_GREEN 3 
#define S_BLUE 4 
 
declare function update_color cdecl (byval dp3 as any ptr, byval d2 as integer) as integer 
 
type xPOINT 
	x as integer 
	y as integer 
end type 
 
dim shared midpoint As xPOINT = (30,50) 
dim shared five_midpoints(4) As xPOINT = {(30,50), (62,19), (11,15), (38,30), (27,82)} 

dim shared color_builder(0 TO 5) As DIALOG = _
{ _ 
	(@d_clear_proc, 0, 0, 0, 0, 255, 0, 0, 0, 0, 0, NULL, NULL), _ 
	(@d_box_proc, 0, 0, 100, 100, 0, 254, 0, 0, 0, 0, NULL, NULL, NULL), _ 
	(@d_slider_proc, 10, 110, 16, 64, 1, 0, 0, 0, 63, 0, NULL, @update_color, NULL), _ 
	(@d_slider_proc, 42, 110, 16, 64, 2, 0, 0, 0, 63, 0, NULL, @update_color, NULL), _ 
	(@d_slider_proc, 74, 110, 16, 64, 4, 0, 0, 0, 63, 0, NULL, @update_color, NULL), _ 
	(NULL, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, NULL, NULL, NULL) _ 
}  
 
'' Callback 
function update_color cdecl (byval dp3 as any ptr, byval d2 as integer) as integer 
	dim col as RGB 
	col.r = color_builder(S_RED).d2 
	col.g = color_builder(S_GREEN).d2 
	col.b = color_builder(S_BLUE).d2 
	vsync() 
	set_color( 254, @col ) 
	return 0
end function 
 

'' Main

	allegro_init( )
	install_keyboard( ) 
	install_mouse( ) 
	install_timer( ) 
	set_gfx_mode( GFX_AUTODETECT_WINDOWED, 640, 480, 0, 0 ) 
	set_palette( @desktop_palette(0) ) 
 
	'initialize the color box 
	update_color( NULL, 0 ) 
 
	'run the dialog 
	do_dialog( @color_builder(0), -1 ) 

	END_OF_MAIN()
