''
'' gfxlib input methods demo
''

declare sub center( byval y as integer, byval text as string, byval col as integer )
declare sub keyboard_demo( )
declare sub mouse_demo( )
declare sub joystick_demo( )

'' main

	screen 15, , 3

	screenset 2
	color ,15
	cls

	center( 1, "FreeBASIC Gfxlib input methods demo", 4 )
	line (0, 20)-(399, 299), 4, b

	screenset 1

	keyboard_demo( )
	mouse_demo( )
	joystick_demo( )

	end

sub center( byval y as integer, byval text as string, byval col as integer )
	color col
	locate y, ((51 - len(text)) / 2) + 1
	print text;
end sub

sub keyboard_demo( )
	dim key(1 to &h58) as string * 12 => _
	{ _
		"Esc", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "-", "=", "Backspace", _
		"Tab", "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P", "(", ")", "Enter", _
		"Control", "A", "S", "D", "F", "G", "H", "J", "K", "L", ";", "'", "~", "Left shift", _
		"\", "Z", "X", "C", "V", "B", "N", "M", ",", ".", "/", "Right shift", "*", "Alt", _
		"Space", "Capslock", "F1", "F2", "F3", "F4", "F5", "F6", "F7", "F8", "F9", "F10", _
		"Numlock", "Scrolllock", "Home", "Up", "Page up", "-", "Left", "unknown key", _
		"Right", "+", "End", "Down", "Page down", "Insert", "Delete", "unknown key", _
		"unknown key", "unknown key", "F11", "F12" _
	}

	do
		screencopy 2, 1

		center( 2, "Keyboard demo", 9 )
		center( 4, "Press any combination of keys, ESC to continue.", 12 )

		dim as integer numkeys = 0
		for i as integer = 1 to 127
			'' test keypress
			if multikey(i) then
				if i <= &h58 then
					center 6 + numkeys, key(i) + " (scancode &h" + hex(i) + ")", 4
				else
					center 6 + numkeys, "unknown key (scancode &h" + hex(i) + ")", 4
				end if
				numkeys += 1
			end if
			if (numkeys > 25) then exit for
		next

		screencopy 1, 0

		'' Until ESC is pressed
	loop until multikey(1)

	'' Wait for ESC key to be released
	while multikey(1)
	wend

	'' Clear the keyboard buffer by calling inkey() repeatedly
	while inkey <> ""
	wend
end sub

sub mouse_demo( )
	dim as integer x, y, z, buttons, shown = 1

	setmouse 200, 150, 1
	do
		screencopy 2, 1
		center( 2, "Mouse demo", 9 )
		center( 4, "Space toggles mouse visibility, ESC to continue.", 12 )
		if inkey() = " " then
			shown xor= 1
			if shown then
				setmouse , , 1
			else
				setmouse , , 0
			end if
		end if

		'' Get mouse information
		getmouse x, y, z, buttons

		if x = -1 then
			center( 19, "Mouse not available or not in program window", 4 )
		else
			center( 18, "Mouse is at " + str(x) + "," + str(y), 4 )
			center( 19, "Buttons: " + bin(buttons), 4 )
			center( 20, "Wheel is at " + str(z), 4 )
		end if

		screencopy 1, 0
	loop until multikey(1)

	setmouse , , 1

	while multikey(1)
	wend

	while inkey() <> ""
	wend
end sub

sub joystick_demo
	dim cursor(130) as ushort
	dim as integer buttons, col, hue, num_axis, axis_pos
	dim as single x, y, cur_x, cur_y, additional_axis(4)

	cursor(0) = 16 shl 3
	cursor(1) = 16
	line cursor, (0, 0)-(15, 15), 0, bf
	draw cursor, "c1 s4 bm7,0 d4 bd6 d4 bm0,7 r4 br6 r4"
	cur_x = 200
	cur_y = 150

	do
		screencopy 2, 1
		center( 2, "Joystick demo", 9 )
		center( 4, "Move joystick 1 around, ESC to exit.", 12 )

		'' Get joystick 1 informations
		getjoystick 0, buttons, x, y, additional_axis(0), additional_axis(1), additional_axis(2), additional_axis(3)

		if buttons = -1 then
			center( 19, "Joystick 1 not available", 4 )
		else
			num_axis = 0
			for i as integer = 0 to 3
				if (additional_axis(i) >= -1.0) then num_axis += 1
			next
			if num_axis > 0 then
				for i as integer = 0 to num_axis-1
					axis_pos = ((300 - ((num_axis + 1) * 16)) / 2) + (i * 16)
					line (71, axis_pos)-(329, axis_pos + 11), 4, b
					line (72, axis_pos + 1)-(72 + ((additional_axis(i) + 1.0) * 128.0), axis_pos + 10), 12, bf
				next
				center( 19 + num_axis, "Buttons: " + bin(buttons), 4 )
			else
				center( 19, "Buttons: " + bin(buttons), 4 )
			end if
			
			cur_x += x / 32
			cur_y += y / 32
			if (cur_x < 0) then cur_x = 0
			if (cur_x > 399) then cur_x = 399
			if (cur_y < 0) then cur_y = 0
			if (cur_y > 299) then cur_y = 299
			put (cur_x - 7, cur_y - 7), cursor, trans
			col += 1
			hue = 128 + (((col shr 8) and 3) * 32)
			palette 1, hue, hue, hue
		end if

		screencopy 1, 0
	loop until multikey(1)
end sub
