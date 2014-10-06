'' Read in the current readme.txt and generate
''  * CompilerCredits FB wiki page
''  * freebasic.net Credits HTML

const TRUE = -1
const FALSE = 0
const NULL = 0

sub errorExit(message as string)
	print "error: " + message
	end 1
end sub

function strStartsWith(s as string, lookfor as string) as integer
	function = (left(s, len(lookfor)) = lookfor)
end function

type PersonInfo
	name as string
	contact as string
	text as string
end type

type ReadmeParser
	f as integer
	declare constructor()
	declare destructor()
	declare sub skipUntil(lookfor as string)
	declare function nextLine() as string
	declare sub skipLine(expected as string)
	declare sub readPersonList(people() as PersonInfo)
end type

constructor ReadmeParser()
	var readmefilename = exepath() + "/../readme.txt"
	print "reading '" + readmefilename + "'..."
	f = freefile()
	if open(readmefilename, for input, as #f) <> 0 then
		errorExit("failed to open " + readmefilename)
	end if
end constructor

destructor ReadmeParser()
	close #f
end destructor

sub ReadmeParser.skipUntil(lookfor as string)
	dim ln as string
	do
		if eof(f) then
			errorExit("reached EOF before finding <" + lookfor + ">")
		end if
		line input #f, ln
	loop until ln = lookfor
end sub

function ReadmeParser.nextLine() as string
	dim ln as string
	line input #f, ln
	function = ln
end function

sub ReadmeParser.skipLine(expected as string)
	var ln = nextLine()
	if ln <> expected then
		errorExit("expected <" + expected + "> but found <" + ln + ">")
	end if
end sub

sub ReadmeParser.readPersonList(people() as PersonInfo)
	do
		const personLineBegin         = "    - "
		const textLineBegin           = "        "
		const personFollowUpLineBegin = "      "
		'' (must check for textLineBegin before personFollowUpLineBegin,
		'' because the latter is a subset of the former)

		'' Not doing ltrim() because we're using the spaces at the
		'' beginning to identify the type of line.
		var ln = rtrim(nextLine())

		if strStartsWith(ln, personLineBegin) then
			redim preserve people(0 to ubound(people)+1)
			with people(ubound(people))
				.name = right(ln, len(ln) - len(personLineBegin))
			end with
		elseif strStartsWith(ln, textLineBegin) then
			ln = right(ln, len(ln) - len(textLineBegin))
			if ubound(people) = -1 then errorExit("found text <" + ln + ">, but no person registered yet")
			with people(ubound(people))
				if len(.text) > 0 then
					if right(.text, 1) <> "," then .text += ","
					if right(.text, 1) <> " " then .text += " "
				end if
				.text += ln
			end with
		elseif strStartsWith(ln, personFollowUpLineBegin) then
			ln = right(ln, len(ln) - len(personFollowUpLineBegin))
			if ubound(people) = -1 then errorExit("person line continued with <" + ln + ">, but no person registered yet")
			with people(ubound(people))
				if len(.name) > 0 then
					if right(.name, 1) <> " " then .name += " "
				end if
				.name += ln
			end with
		else
			exit do
		end if
	loop
end sub

type FileWriter
	f as integer
	declare constructor(filename as string)
	declare destructor()
	declare sub writeLine(ln as string)
end type

constructor FileWriter(filename as string)
	print "writing '" + filename + "'..."
	f = freefile()
	if open(filename, for output, as #f) <> 0 then
		errorExit("failed to create/overwrite " + filename)
		end 1
	end if
end constructor

destructor FileWriter()
	close #f
end destructor

sub FileWriter.writeLine(ln as string)
	print #f, ln
end sub

function formatPerson(person as PersonInfo, boldprefix as string, boldsuffix as string, newline as string) as string
	var ln = person.name
	if len(person.text) > 0 then
		ln = boldprefix + ln + boldsuffix
	end if
	if len(person.contact) > 0 then
		ln += " (" + person.contact + ")"
	end if
	if len(person.text) > 0 then
		ln += ":" + newline + person.text
	end if
	function = ln
end function

sub wakkaWritePeopleList(wakka as FileWriter, people() as PersonInfo, first as integer, last as integer)
	for i as integer = first to last
		wakka.writeLine(!"\t- " + formatPerson(people(i), "**", "**", !"\n\t\t"))
	next
end sub

sub wakkaWriteSection(wakka as FileWriter, title as string, people() as PersonInfo, first as integer, last as integer)
	wakka.writeLine("==__" + title + "__==")
	wakka.writeLine("")
	wakkaWritePeopleList(wakka, people(), first, last)
	wakka.writeLine("")
end sub

sub htmlWritePeopleList(html as FileWriter, people() as PersonInfo, first as integer, last as integer)
	for i as integer = first to last
		html.writeLine(!"\t<li>" + formatPerson(people(i), "<b>", "</b>", "<br>") + "</li>")
	next
end sub

sub htmlWriteSection(html as FileWriter, title as string, people() as PersonInfo, first as integer, last as integer)
	html.writeLine("<h2>" + title + "</h2>")
	html.writeLine("<ul>")
	htmlWritePeopleList(html, people(), first, last)
	html.writeLine("</ul>")
	html.writeLine("")
end sub

dim people(any) as PersonInfo
var lastmember = -1, lastcontributor = -1

scope
	dim parser as ReadmeParser

	parser.skipUntil("  o Credits")
	parser.skipLine("")

	'' Members
	parser.skipLine("    Project members:")
	parser.readPersonList(people())
	lastmember = ubound(people)

	'' Contributors
	parser.skipLine("    Contributors:")
	parser.readPersonList(people())
	lastcontributor = ubound(people)

	'' Greetings
	parser.skipLine("    Greetings:")
	parser.readPersonList(people())

	'' Post-process person name lines: If the line contains "(...)", extract
	'' that as email address, and only use the rest as name.
	for i as integer = 0 to ubound(people)
		with people(i)
			var lparen = instr(.name, "(")
			var rparen = instr(.name, ")")
			if 0 < lparen and lparen < rparen then
				'' Extract email address from in between parentheses
				.contact = mid(.name, lparen + 1, rparen - lparen - 1)

				'' Rebuild the name string but without the " (...) " part.
				var lhs = trim(left(.name, lparen - 1))
				var rhs = trim(right(.name, len(.name) - rparen))
				.name = lhs
				if len(rhs) > 0 then
					if len(.name) > 0 then
						if right(.name, 1) <> " " then .name += " "
					end if
					.name += rhs
				end if
			end if
		end with
	next

#if 0
	for i as integer = 0 to ubound(people)
		with people(i)
			print "name: <" + .name + ">"
			print "contact: <" + .contact + ">"
			print "text: <" + .text + ">"
			print
		end with
	next
#endif
end scope

scope
	dim wakka as FileWriter = FileWriter(exepath()  + "/../doc/manual/cache/CompilerCredits.wakka")
	wakka.writeLine("{{fbdoc item=""title"" value=""Credits (in alphabetical order)""}}----")
	wakka.writeLine("")
	wakkaWriteSection(wakka, "Project Members", people(), 0, lastmember)
	wakkaWriteSection(wakka, "Contributors", people(), lastmember + 1, lastcontributor)
	wakkaWriteSection(wakka, "Greetings", people(), lastcontributor + 1, ubound(people))
	wakka.writeLine("{{fbdoc item=""back"" value=""FBWiki|Main Page""}}")
end scope

scope
	dim html as FileWriter = FileWriter(exepath()  + "/../credits.html")
	htmlWriteSection(html, "Project Members", people(), 0, lastmember)
	htmlWriteSection(html, "Contributors", people(), lastmember + 1, lastcontributor)
	htmlWriteSection(html, "Greetings", people(), lastcontributor + 1, ubound(people))
end scope
