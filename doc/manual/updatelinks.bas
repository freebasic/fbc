'' Tool to convert given *.wakka file(s) over to the new [[...]] link format
''
'' old:
''    [[link text...]]
'' new:
''    [[link|text...]]
''
'' Whitespace as link/text seperator is no longer supported by Wikka.
'' Wikka 1.3.1 started allowing whitespace in page names, and 1.3.7 removed
'' support for it in [[...]] links.

#include once "file.bi"

private sub fatalerror(byref message as string)
	print "error: " + message
	end 1
end sub

private function loadFile(byref filename as string) as string
	if not fileexists(filename) then
		fatalerror("file not found: " + filename)
	end if

	dim as ulongint size = filelen(filename)
	if size = 0 then
		return ""
	end if

	var buffer = space(size)

	scope
		var fi = freefile()
		if open(filename, for binary, access read, as #fi) then
			fatalerror("failed to open input file " + filename)
		end if
		var bytesread = 0
		if get(#fi, , *cptr(ubyte ptr, strptr(buffer)), size, bytesread) orelse bytesread <> size then
			fatalerror("file I/O failed: " + filename)
		end if
		close #fi
	end scope

	return buffer
end function

private sub writeFile(byref filename as string, byref buffer as string)
	var size = len(buffer)
	var fo = freefile()
	if open(filename, for binary, access write, as #fo) then
		fatalerror("failed to open output file " + filename)
	end if
	if put(#fo, , *cptr(ubyte ptr, strptr(buffer)), len(buffer)) then
		fatalerror("file I/O failed: " + filename)
	end if
	close #fo
end sub

private sub renameOverwrite(byref oldname as string, byref newname as string)
	if kill(newname) then
	end if
	if name(oldname, newname) then
		fatalerror("failed to rename file " + oldname + " => " + newname)
	end if
end sub

private sub fixLinks(byref buffer as string)
	var i = 1
	while i <= len(buffer)

		var opening = instr(i, buffer, "[[")
		var closing = instr(opening, buffer, "]]")

		if (opening > 0) and (closing > 0) then
			var fulllink = mid(buffer, opening, (closing + 2) - opening)

			'' Does this link already contain a | char?
			if instr(2, fulllink, "|") > 0 then
				'print "skipping link: " + fulllink
			else
				var spacepos = instr(fulllink, " ")
				if spacepos > 0 then
					var link = mid(fulllink, 3, spacepos - 3)
					var text = mid(fulllink, spacepos + 1, len(fulllink) - 2 - spacepos)
					'print "link: " + fulllink + ": <" + link + "> <" + text + ">"
					buffer[opening + spacepos - 2] = asc("|")
				else
					'print "no need to update link: " + fulllink
				end if
			end if

			i = closing + 2
		else
			i += 1
		end if
	wend
end sub

private sub convertFile(byref inputfile as string)
	print "converting " + inputfile
	var text = loadFile(inputfile)
	fixLinks(text)
	var outputfile = inputfile + ".new"
	writeFile(outputfile, text)
	renameOverwrite(outputfile, inputfile)
end sub

if __FB_ARGC__ <= 1 then
	print "usage: ./updatelinks *.wakka"
	end 1
end if

for i as integer = 1 to __FB_ARGC__-1
	convertFile(*__FB_ARGV__[i])
next
