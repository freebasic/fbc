'' parser-assignment.bas
#print parser-assignment.bas

sub parser_assignment()
	dim i as integer
	let% i = 1
end sub


'' parser-comment.bas
#print parser-comment.bas

'$lang: "fblite"
'$include once%: "suffix-inc.bi"

'$dynamic%
'$static%


'' parser-decl-option.bas
#print parser-decl-option.bas

defbyte% A%-Z%
defubyte% A-Z
defshort% A-Z
defushort% A-Z
defint% A-Z
defuint% A-Z
deflng% A-Z
defulng% A-Z
deflongint% A-Z
defulongint% A-Z
defsng% A-Z
defdbl% A-Z
defstr% A-Z

option% byval%
option  dynamic%
option  static%
option  gosub%
option  explicit%
option  private%
option  escape%
option  base% 1
#define scrap
option  nokeyword% scrap
option  nogosub%
option  gosub


'' parser-quirk-goto-return.bas
#print parser-quirk-goto-return.bas

	goto% label%
	gosub% label%
	return% label%
	resume% next%
label%:
	goto label%


'' parser-quirk-on.bas
#print parser-quirk-on.bas

	sub proc()
		goto label1%
		label1%:
		dim a as integer
		on% local% a goto% label1%
		on% local% a gosub% label1%
		on% error% goto% label1%
		goto label1%
	end sub

