option explicit

#include "openhook.bi"

defint a-z

private function IsNumberedDevice( filename as string, _
                                   prefix as string ) as integer
    if ucase$(left$(filename,len(prefix)))=ucase$(prefix) then
        dim as integer i, ch, index
        i = len(prefix)
        ch = filename[i]
        while ch>=&H30 and ch<=&H39
            index = index * 10 + (ch - &H30)
            i += 1
	        ch = filename[i]
        wend
        if ch=&H3A then function = index
    end if
end function

private function MyOpenHook( filename as string, _
                             byval open_mode as FB_FILE_MODE, _
                             byval access_mode as FB_FILE_ACCESS, _
                             byval lock_mode as FB_FILE_LOCK, _
                             byval record_length as integer, _
                             byval pfnFileOpen as fb_FnFileOpen ptr ) as integer
    print "Testing file name " & filename
    *pfnFileOpen = @fb_DevFileOpen
    select case ucase$(filename)
    case "SCRN:"
        *pfnFileOpen = @fb_DevScrnOpen
    case "CONS:", "CON:"
        *pfnFileOpen = @fb_DevConsOpen
    case "ERR:"
        *pfnFileOpen = @fb_DevErrOpen
    case else
        if ucase$(left$(filename,5))="PIPE:" then
            *pfnFileOpen = @fb_DevPipeOpen
        elseif ucase$(left$(filename,8))="FILE:///" then
            filename = mid$(filename, 9)
        elseif IsNumberedDevice(filename, "LPT") then
            *pfnFileOpen = @fb_DevLptOpen
        end if
    end select
end function

fb_pfnDevOpenHook = @MyOpenHook

open "O", 1, "SCRN:"
print #1, "Output to SCRN:"
close 1

open "O", 1, "file:///output.txt"
print #1, "Output to output.txt"
close 1
