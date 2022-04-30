'' examples/manual/proguide/enumerations2.bas
''
'' Example extracted from the FreeBASIC Manual
'' from topic 'Constants and Enumerations'
''
'' See Also: https://www.freebasic.net/wiki/wikka.php?wakka=ProPgEnumerations
'' --------

Enum Colors Explicit
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

Type Console_Colors
	Public:
		Declare Property foreground () As Colors
		Declare Property foreground (ByVal c As Colors)
		Declare Property background () As Colors
		Declare Property background (ByVal c As Colors)
	Private:
		Dim As Colors _foreground
		Dim As Colors _background
End Type

Property Console_Colors.foreground () As Colors
	Return This._foreground
End Property

Property Console_Colors.foreground (ByVal c As Colors)
	This._foreground = c
End Property

Property Console_Colors.background () As Colors
	Return This._background
End Property

Property Console_Colors.background (ByVal c As Colors)
	This._background = c
End Property

Sub print_fbc (ByVal foreground As Colors, ByVal background As Colors)
	Color foreground, background
	Print " " & __FB_SIGNATURE__ & " "
End Sub


Dim As Console_Colors std_colors
std_colors.foreground = Cast(Colors, LoWord(Color()))  '' explicit cast mandatory because of property declaration
std_colors.background = Cast(Colors, HiWord(Color()))  '' explicit cast mandatory because of property declaration

Dim As Console_Colors my_colors
my_colors.foreground = Colors.bright_yellow
my_colors.background = Colors.cyan

print_fbc(my_colors.foreground, my_colors.background)

Color std_colors.foreground, std_colors.background
Print "end"

Sleep
		
