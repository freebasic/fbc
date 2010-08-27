const FALSE = 0
const TRUE = -1
const NULL = 0
type boolean as integer

const MANIFEST = "../../../manifest/win32.lst"
const SCRIPT_TEMPLATE = "template.nsi"

'' The installer script is put in the root FreeBASIC folder. makensis will cd there.
const SCRIPT = "../../../installer.nsi"

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

sub emitPath(byval o as integer, byref cmd as string, byref path as string)
    print #o, "    " + cmd + " ""$INSTDIR\" + path + """"
end sub

sub emitInstallerFiles(byval o as integer, byval install as boolean)
    dim as integer f = freefile()
    if (open(MANIFEST, for input, as #f)) then
        print "Error: Cannot open " + MANIFEST
        end(1)
    end if

    dim as string filename = ""
    dim as string path = ""
    dim as string prevpath = ""

    while (eof(f) = FALSE)
        line input #f, filename

        if (len(filename)) then
            '' Use backslashes for NSIS...
            filename = strReplace(filename, "/", "\")

            path = pathStripFile(filename)
            if (path <> prevpath) then
                if (install) then
                    emitPath(o, "SetOutPath", path)
                else
                    '' RMDir foo\bar\baz
                    '' RMDir foo\bar
                    '' RMDir foo
                    while ((len(prevpath) > 0) and (prevpath <> left(path, len(prevpath))))
                        emitPath(o, "RMDir ", prevpath)
                        prevpath = pathStripComponent(prevpath)
                    wend
                end if
                prevpath = path
            end if

            if (install) then
                filename = "                   File """ + filename + """"
            else
                filename = "    Delete ""$INSTDIR\" + filename + """"
            end if

            print #o, filename
        end if
    wend

    close #f
end sub

dim as integer i = freefile()
if (open(SCRIPT_TEMPLATE, for input, as #i)) then
    print "Error: Cannot open " + SCRIPT_TEMPLATE
    end(1)
end if

dim as integer o = freefile()
if (open(SCRIPT, for output, as #o)) then
    print "Error: Cannot open " + SCRIPT
    end(1)
end if

dim as string ln = ""

while (eof(i) = FALSE)
    line input #i, ln

    select case (trim(ln))
    case ";;;INSTALL;;;"
        emitInstallerFiles(o, TRUE)

    case ";;;UNINSTALL;;;"
        emitInstallerFiles(o, FALSE)

    case else
        print #o, ln

    end select
wend

close #o
close #i
