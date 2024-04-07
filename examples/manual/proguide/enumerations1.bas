'' examples/manual/proguide/enumerations1.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Constants and Enumerations'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgEnumerations
'' --------

Enum Colors
	black
	blue
	green
	cyan
	red
	pink
	yellow
	grey
	dark_grey
	bright_blue
	bright_green
	bright_cyan
	bright_red
	bright_pink
	bright_yellow
	white
End Enum

Sub print_fbc (ByVal foreground As Colors, ByVal background As Colors)
	Color foreground, background
	Print " " & __FB_SIGNATURE__ & " "
End Sub


Dim As Colors std_foreground, std_background
std_foreground = LoWord(Color())
std_background = HiWord(Color())

Dim As Colors my_foreground, my_background
my_foreground = bright_yellow
my_background = cyan

print_fbc(my_foreground, my_background)

Color std_foreground, std_background
Print "end"

Sleep
		
