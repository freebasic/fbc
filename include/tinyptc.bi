''
'' TinyPTC by Gaffer
'' www.gaffer.org/tinyptc
''

''
'' add the -d PTC_WIN option to fbc's command-line to use the windowed version
''
#if defined(PTC_WIN) and not defined(__FB_DOS__)
# inclib "tinyptc-win"
#else
# inclib "tinyptc"
#endif

'' tinyptc api
declare function ptc_open	cdecl alias "ptc_open"		(byval title as zstring ptr, _
								 byval width as integer, _
								 byval height as integer ) as integer

declare function ptc_update	cdecl alias "ptc_update"	(byval buffer as integer ptr) as integer

declare function ptc_close	cdecl alias "ptc_close"		() as integer

#ifdef __FB_WIN32__
# inclib "ddraw"
# inclib "user32"
# inclib "gdi32"
#elseif defined(__FB_LINUX__)
# inclib "X11"
# libpath "/usr/X11R6/lib"
#elseif defined(__FB_DOS__)
'''
#else
# error Platform not supported!
#endif
