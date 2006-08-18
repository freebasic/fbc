' This example application shows how to implement a QB compatible
' OPEN statement using the OPEN hook.
'

#include "openhook.bi"

''
private function IsNumberedDevice _
	( _
		byref filename as string, _
        byref prefix as string _
    ) as integer
    
    if ucase(left(filename,len(prefix)))=ucase(prefix) then
        dim as integer i, ch, index
        i = len(prefix)
        ch = filename[i]
        ' &H30 .. &H39 = '0' .. '9'
        while ch>=&H30 and ch<=&H39
            index = index * 10 + (ch - &H30)
            i += 1
	        ch = filename[i]
        wend
        ' &H3A = ':'
        if ch=&H3A then return index
    end if
    function = -1
end function

''
private function MyOpenHook _
	( _
		byref filename as string, _
		byval open_mode as FB_FILE_MODE, _
        byval access_mode as FB_FILE_ACCESS, _
        byval lock_mode as FB_FILE_LOCK, _
        byval record_length as integer, _
        byval pfnFileOpen as fb_FnFileOpen ptr _
    ) as integer
    
    print "Testing file name " & filename
    *pfnFileOpen = @fb_DevFileOpen
    
    select case ucase(filename)
    case "SCRN:","CON","CON:"
        *pfnFileOpen = @fb_DevScrnOpen
    
    case "CONS:"
        *pfnFileOpen = @fb_DevConsOpen
    
    case "ERR:"
        *pfnFileOpen = @fb_DevErrOpen
    
    case else
        if ucase(left(filename,5))="PIPE:" then
            *pfnFileOpen = @fb_DevPipeOpen
            filename = mid(filename, 6)
    
        elseif ucase(left(filename,8))="FILE:///" then
            filename = mid(filename, 9)
    
        elseif IsNumberedDevice(filename, "LPT")>=0 then
            *pfnFileOpen = @fb_DevLptOpen

#if defined(__FB_WIN32__) or defined(__FB_CYGWIN__)
        elseif IsNumberedDevice(filename, "COM")>=1 then
            *pfnFileOpen = @fb_DevComOpen
#endif
        end if
    end select
    
    function = 0
    
end function

'' main
	fb_pfnDevOpenHook = @MyOpenHook

	open "O", 1, "SCRN:"
	print #1, "Output to SCRN:"
	close 1
	
	open "O", 1, "file:///output.txt"
	print #1, "Output to output.txt"
	close 1
