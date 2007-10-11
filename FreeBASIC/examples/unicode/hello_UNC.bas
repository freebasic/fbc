''
'' "Hello World!" test, in ascii+unc (\u escape sequencies) format
''

#ifdef __FB_WIN32__
# define unicode
# include once "windows.bi"
#endif

const LANG = "Chinese"
	dim helloworld as wstring * 20 => !"\u4f60\u597d\uff0c\u4e16\u754c!"

	print """Hello World!"" in "; LANG; ": "; helloworld

#ifdef __FB_WIN32__
	messagebox( 0, helloworld, """Hello World!"" in " & LANG & ":", MB_OK )
#endif
