#include once "misc.bi"
#include once "datetime.bi"
#include once "string.bi"

function strReplace _
    ( _
        byref text as string, _
        byref a as string, _
        byref b as string _
    ) as string

    static as string result
    static as string keep

    result = text

    dim as integer alen = len(a)
    dim as integer blen = len(b)

    dim as integer p = 0
    do
        p = instr(p + 1, result, a)
        if (p = 0) then
            exit do
        end if

        keep = mid(result, p + alen)
        result = left(result, p - 1)
        result += b
        result += keep
        p += blen - 1
    loop

    return result
end function

sub strSplit _
    ( _
        byref s as string, _
        byref delimiter as string, _
        byref l as string, _
        byref r as string _
    )
    dim as integer leftlen = instr(s, delimiter) - 1
    if (leftlen > 0) then
        l = left(s, leftlen)
        r = right(s, len(s) - leftlen - len(delimiter))
    else
        l = s
        r = ""
    end if
end sub

function fileExists(byref file as string) as boolean
    dim as integer fnum = freefile()
    if (open(file, for binary, access read, as #fnum) = 0) then
        close #fnum
        return TRUE
    end if
    return FALSE
end function

function getDateStamp() as string
    return format(now(), "yyyy-mm-dd")
end function

'' Searches backwards for the last '/' or '\'.
private function findFileName(byref path as string) as integer
    for i as integer = (len(path)-1) to 0 step -1
        dim as integer ch = path[i]
        if ((ch = asc("/")) or (ch = asc("\"))) then
            return i + 1
        end if
    next
    return 0
end function

function pathStripFile(byref path as string) as string
    return left(path, findFileName(path))
end function

function pathStripComponent(byref path as string) as string
    dim as string s = path

    '' Strip path div at the end
    dim as integer length = len(s)
    if (length > 0) then
        dim as integer ch = s[length-1]
        if ((ch = asc("/")) or (ch = asc("\"))) then
            s = left(s, len(s) - 1)
        end if
    end if

    '' Strip the last component
    return pathStripFile(s)
end function
