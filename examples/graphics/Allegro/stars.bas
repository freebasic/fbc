'' This example draws a 3D starfield (depth-cued) and a polygon
'' starship (controllable), using the Allegro math functions.
'' Code by Dave Thomson.

#include once "allegro.bi"

'' starfield system
type VECTOR
	x as single
	y as single
	z as single
end type


#define NUM_STARS          512

#define Z_NEAR             24
#define Z_FAR              1024
#define XY_CUBE            2048

#define SPEED_LIMIT        20

#define SCR_WIDTH			320*1
#define SCR_HEIGHT			240*1

dim shared stars(NUM_STARS-1) as VECTOR
dim shared star_x(NUM_STARS-1) as single
dim shared star_y(NUM_STARS-1) as single

dim shared delta as VECTOR

'' polygonal models
#define NUM_VERTS          4
#define NUM_FACES          4

#define ENGINE             3     '' which face is the engine
#define ENGINE_ON          64    '' colour index
#define ENGINE_OFF         32

type FACE              '' for triangular models
	v1 as integer
	v2 as integer
	v3 as integer
	colour as integer
	range as integer
	normal as VECTOR
	rnormal as VECTOR
end type

type MODEL
	points(NUM_VERTS-1) as VECTOR
	faces(NUM_FACES-1) as FACE
	x as single
	y as single
	z as single
	rx as single
	ry as single
	rz as single
	minx as integer
	miny as integer
	maxx as integer
	maxy as integer
	aim as VECTOR
	velocity as integer
end type

dim shared ship as MODEL
dim shared direction as VECTOR
dim shared buffer as BITMAP ptr

'' initialises the starfield system
sub init_stars()
	for i as integer = 0  to NUM_STARS-1
		stars(i).x = (rand() mod XY_CUBE) - (XY_CUBE shr 1)
		stars(i).y = (rand() mod XY_CUBE) - (XY_CUBE shr 1)
		stars(i).z = (rand() mod (Z_FAR - Z_NEAR)) + Z_NEAR
	next

	delta.x = 0
	delta.y = 0
	delta.z = 0
end sub

'' draws the starfield
sub draw_stars()
	dim c as integer
	dim m as MATRIX_f
	dim outs(NUM_STARS-1) as VECTOR

	for i as integer = 0 to NUM_STARS-1
		get_translation_matrix_f(@m, delta.x, delta.y, delta.z)
		apply_matrix_f(@m, stars(i).x, stars(i).y, stars(i).z, @outs(i).x, @outs(i).y, @outs(i).z)
		persp_project_f(outs(i).x, outs(i).y, outs(i).z, @star_x(i), @star_y(i))
		c = (cint(outs(i).z) shr 8) + 16
		putpixel( buffer, star_x(i), star_y(i), palette_color[c] )
	next
end sub

'' deletes the stars from the screen
sub erase_stars()
	for i as integer = 0 to NUM_STARS-1
		putpixel(buffer, star_x(i), star_y(i), palette_color[0])
	next
end sub

'' moves the stars
sub move_stars()
	for i as integer = 0 to NUM_STARS-1
		stars(i).x = stars(i).x + delta.x
		stars(i).y = stars(i).y + delta.y
		stars(i).z = stars(i).z + delta.z

		if (stars(i).x > XY_CUBE shr 1) then
			stars(i).x = -(XY_CUBE shr 1)
		elseif (stars(i).x < -(XY_CUBE shr 1)) then
			stars(i).x = XY_CUBE shr 1
		end if

		if (stars(i).y > XY_CUBE shr 1) then
			stars(i).y = -(XY_CUBE shr 1)
		elseif (stars(i).y < -(XY_CUBE shr 1)) then
			stars(i).y = XY_CUBE shr 1
		end if

		if (stars(i).z > Z_FAR) then
			stars(i).z = Z_NEAR
		elseif (stars(i).z < Z_NEAR) then
			stars(i).z = Z_FAR
		end if
	next
end sub

'' initialises the ship model
sub init_ship()
	dim v1 as VECTOR, v2 as VECTOR, pts as VECTOR ptr
	dim face as FACE ptr
	dim i as integer

	ship.points(0).x = 0
	ship.points(0).y = 0
	ship.points(0).z = 32

	ship.points(1).x = 16
	ship.points(1).y = -16
	ship.points(1).z = -32

	ship.points(2).x = -16
	ship.points(2).y = -16
	ship.points(2).z = -32

	ship.points(3).x = 0
	ship.points(3).y = 16
	ship.points(3).z = -32

	ship.faces(0).v1 = 3
	ship.faces(0).v2 = 0
	ship.faces(0).v3 = 1
	pts = @ship.points(0)
	face = @ship.faces(0)
	v1.x = pts[face->v2].x - pts[face->v1].x
	v1.y = pts[face->v2].y - pts[face->v1].y
	v1.z = pts[face->v2].z - pts[face->v1].z
	v2.x = pts[face->v3].x - pts[face->v1].x
	v2.y = pts[face->v3].y - pts[face->v1].y
	v2.z = pts[face->v3].z - pts[face->v1].z
	cross_product_f(v1.x, v1.y, v1.z, v2.x, v2.y, v2.z, @face->normal.x, @face->normal.y, @face->normal.z)

	ship.faces(1).v1 = 2
	ship.faces(1).v2 = 0
	ship.faces(1).v3 = 3
	face = @ship.faces(1)
	v1.x = pts[face->v2].x - pts[face->v1].x
	v1.y = pts[face->v2].y - pts[face->v1].y
	v1.z = pts[face->v2].z - pts[face->v1].z
	v2.x = pts[face->v3].x - pts[face->v1].x
	v2.y = pts[face->v3].y - pts[face->v1].y
	v2.z = pts[face->v3].z - pts[face->v1].z
	cross_product_f(v1.x, v1.y, v1.z, v2.x, v2.y, v2.z, @face->normal.x, @face->normal.y, @face->normal.z)

	ship.faces(2).v1 = 1
	ship.faces(2).v2 = 0
	ship.faces(2).v3 = 2
	face = @ship.faces(2)
	v1.x = pts[face->v2].x - pts[face->v1].x
	v1.y = pts[face->v2].y - pts[face->v1].y
	v1.z = pts[face->v2].z - pts[face->v1].z
	v2.x = pts[face->v3].x - pts[face->v1].x
	v2.y = pts[face->v3].y - pts[face->v1].y
	v2.z = pts[face->v3].z - pts[face->v1].z
	cross_product_f(v1.x, v1.y, v1.z, v2.x, v2.y, v2.z, @face->normal.x, @face->normal.y, @face->normal.z)

	ship.faces(3).v1 = 2
	ship.faces(3).v2 = 3
	ship.faces(3).v3 = 1
	face = @ship.faces(3)
	v1.x = pts[face->v2].x - pts[face->v1].x
	v1.y = pts[face->v2].y - pts[face->v1].y
	v1.z = pts[face->v2].z - pts[face->v1].z
	v2.x = pts[face->v3].x - pts[face->v1].x
	v2.y = pts[face->v3].y - pts[face->v1].y
	v2.z = pts[face->v3].z - pts[face->v1].z
	cross_product_f(v1.x, v1.y, v1.z, v2.x, v2.y, v2.z, @face->normal.x, @face->normal.y, @face->normal.z)

	for i = 0 to NUM_FACES-1
		ship.faces(i).colour = 32
		ship.faces(i).range = 15
		normalize_vector_f(@ship.faces(i).normal.x, @ship.faces(i).normal.y, @ship.faces(i).normal.z)
		ship.faces(i).rnormal.x = ship.faces(i).normal.x
		ship.faces(i).rnormal.y = ship.faces(i).normal.y
		ship.faces(i).rnormal.z = ship.faces(i).normal.z
	next

	ship.x = 0: ship.y = 0
	ship.z = 192
	ship.rx = 0: ship.ry = 0: ship.rz = 0

	ship.aim.x = 0: direction.x = 0
	ship.aim.y = 0: direction.y = 0
	ship.aim.z = -1: direction.z = -1
	ship.velocity = 0
end sub

'' draws the ship model
sub draw_ship()
	dim outs(NUM_VERTS-1) as VECTOR
	dim m as MATRIX_f
	dim col as integer

	ship.minx = SCREEN_W
	ship.miny = SCREEN_H
	ship.maxx = 0: ship.maxy = 0

	get_rotation_matrix_f(@m, ship.rx, ship.ry, ship.rz)
	apply_matrix_f(@m, ship.aim.x, ship.aim.y, ship.aim.z, @outs(0).x, @outs(0).y, @outs(0).z)
	direction.x = outs(0).x
	direction.y = outs(0).y
	direction.z = outs(0).z

	for i as integer = 0 to NUM_FACES-1
		apply_matrix_f(@m, ship.faces(i).normal.x, ship.faces(i).normal.y, ship.faces(i).normal.z, @ship.faces(i).rnormal.x, @ship.faces(i).rnormal.y, @ship.faces(i).rnormal.z)
	next

	get_transformation_matrix_f(@m, 1, ship.rx, ship.ry, ship.rz, ship.x, ship.y, ship.z)

	for i as integer = 0 to NUM_VERTS-1
		apply_matrix_f(@m, ship.points(i).x, ship.points(i).y, ship.points(i).z, @outs(i).x, @outs(i).y, @outs(i).z)
		persp_project_f(outs(i).x, outs(i).y, outs(i).z, @outs(i).x, @outs(i).y)
		if (outs(i).x < ship.minx) then _
			ship.minx = outs(i).x
		if (outs(i).x > ship.maxx) then _
			ship.maxx = outs(i).x
		if (outs(i).y < ship.miny) then _
			ship.miny = outs(i).y
		if (outs(i).y > ship.maxy) then _
		ship.maxy = outs(i).y
	next

	for i as integer = 0 to NUM_FACES-1
		if (ship.faces(i).rnormal.z < 0.0) then
			col = dot_product_f(ship.faces(i).rnormal.x, ship.faces(i).rnormal.y, ship.faces(i).rnormal.z, 0, 0, 1) * ship.faces(i).range
			if (col < 0) then
				col = -col + ship.faces(i).colour
			else
				col = col + ship.faces(i).colour
			end if

			triangle(buffer, outs(ship.faces(i).v1).x, outs(ship.faces(i).v1).y, _
			                 outs(ship.faces(i).v2).x, outs(ship.faces(i).v2).y, _
			                 outs(ship.faces(i).v3).x, outs(ship.faces(i).v3).y, _
			                 palette_color[col] )
		end if
	next
end sub

'' removes the ship model from the screen
sub erase_ship()
   rectfill( buffer, ship.minx, ship.miny, ship.maxx, ship.maxy, palette_color[0] )
end sub

	dim pal(PAL_SIZE - 1) as RGB
	dim buf as string

	allegro_init()
	install_keyboard()
	install_timer()
	if (set_gfx_mode(GFX_AUTODETECT_WINDOWED, SCR_WIDTH, SCR_HEIGHT, 0, 0) <> 0) then
		set_gfx_mode(GFX_TEXT, 0, 0, 0, 0)
		end 1
	end if

	for i as integer = 0 to 16-1
		pal(i).r = 0
		pal(i).g = 0
		pal(i).b = 0
	next

	'' greyscale
	pal(16).r = 63: pal(16).g = 63: pal(16).b = 63
	pal(17).r = 48: pal(17).g = 48: pal(17).b = 48
	pal(18).r = 32: pal(18).g = 32: pal(18).b = 32
	pal(19).r = 16: pal(19).g = 16: pal(19).b = 16
	pal(20).r =  8: pal(20).g =  8: pal(20).b =  8

	'' red range
	for i as integer = 0 to 16-1
		pal(i+32).r = 31 + i*2
		pal(i+32).g = 15
		pal(i+32).b = 7
	next

	'' a nice fire orange
	for i as integer = 63 to 68-1
		pal(i).r = 63
		pal(i).g = 17 + (i-64)*3
		pal(i).b = 0
	next

	set_palette(@pal(0))

	buffer = create_bitmap(SCREEN_W, SCREEN_H)
	clear_bitmap(buffer)

	set_projection_viewport(0, 0, SCREEN_W, SCREEN_H)
   
	init_stars()
	draw_stars()
	init_ship()
	draw_ship()

	do
		erase_stars()
		erase_ship()

		move_stars()
		draw_stars()

		textout_centre(buffer, font, "Press ESC to exit", SCREEN_W\2, 16, palette_color[18])
		textout_centre(buffer, font, "Press CTRL to fire engine", SCREEN_W\2, 32, palette_color[18])

		draw_ship()

		vsync()
		blit(buffer, screen, 0, 0, 0, 0, SCREEN_W, SCREEN_H)

		poll_keyboard()

		'' exit program
		if( key(KEY_ESC) <> 0 )then
			exit do
		end if

		'' rotates
		if (key(KEY_UP)) then
			ship.rx = ship.rx - 5
		elseif (key(KEY_DOWN)) then
			ship.rx = ship.rx + 5
		end if

		if (key(KEY_LEFT)) then
			ship.ry = ship.ry - 5
		elseif (key(KEY_RIGHT)) then
			ship.ry = ship.ry + 5
		end if

		if (key(KEY_PGUP)) then
			ship.rz = ship.rz - 5
		elseif (key(KEY_PGDN)) then
			ship.rz = ship.rz + 5
		end if

		'' thrust
		if (key(KEY_LCONTROL) <> 0) or (key(KEY_RCONTROL) <> 0) then
			ship.faces(ENGINE).colour = ENGINE_ON
			ship.faces(ENGINE).range = 3
			if (ship.velocity < SPEED_LIMIT) then 
				ship.velocity = ship.velocity + 2
			end if
		else
			ship.faces(ENGINE).colour = ENGINE_OFF
			ship.faces(ENGINE).range = 15
			if (ship.velocity > 0) then
				ship.velocity = ship.velocity - 2
			end if
		end if

		ship.rx = ship.rx mod 256
		ship.ry = ship.ry mod 256
		ship.rz = ship.rz mod 256

		delta.x = direction.x * ship.velocity
		delta.y = direction.y * ship.velocity
		delta.z = direction.z * ship.velocity
	loop

	destroy_bitmap(buffer)
   
	END_OF_MAIN()
