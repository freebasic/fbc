'' Can use zstring or wstring (libexpat or libexpatw)
''#define XML_UNICODE
#include once "expat.bi"

#define FALSE 0
#define TRUE (-1)
#define NULL 0

const BUFFER_SIZE = 1024

type Context
    as integer nesting
    as XML_char * (BUFFER_SIZE+1) text
    as integer textlength
end type

dim shared as Context ctx

sub elementBegin cdecl _
    ( _
        byval userdata as any ptr, _
        byval element as XML_char ptr, _
        byval attributes as XML_char ptr ptr _
    )

    '' Begin of XML tag

    '' Show its name
    print space(ctx.nesting);*element;

    '' and its attributes (attributes are given as an array of XML_char pointers
    '' much like argv, for each attribute there will apparently be the one
    '' element representing the name and a second element representing the
    '' specified value)
    while (*attributes)
        print " ";**attributes;
        attributes += 1
        print "='";**attributes;"'";
        attributes += 1
    wend
    print

    ctx.nesting += 1
    ctx.text[0] = 0
    ctx.textlength = 0
end sub

sub elementEnd cdecl _
    ( _
        byval userdata as any ptr, _
        byval element as XML_char ptr _
    )

    '' End of XML tag

    '' Show text collected in charData() callback below
    print space(ctx.nesting);ctx.text
    ctx.text[0] = 0
    ctx.textlength = 0
    ctx.nesting -= 1
end sub

sub charData cdecl _
    ( _
        byval userdata as any ptr, _
        byval chars as XML_char ptr, _  '' Note: not NULL-terminated
        byval length as integer _
    )

    '' This callback will apparently recieve every data between xml tags
    '' (really?), including newlines and space.

    '' Append to our buffer, if there still is free room, so we can print it out later
    if (length <= (BUFFER_SIZE - ctx.textlength)) then
        fb_MemCopy(ctx.text[ctx.textlength], chars[0], length * sizeof(XML_char))
        ctx.textlength += length
        ctx.text[ctx.textlength] = 0
    end if
end sub

''
'' Main
''

    dim as string filename = command(1)
    if (len(filename) = 0) then
        print "Usage: expat <xmlfilename>"
        end 1
    end if

    dim as XML_Parser parser = XML_ParserCreate(NULL)
    if (parser = NULL) then
        print "XML_ParserCreate failed"
        end 1
    end if

    ''XML_SetUserData(parser, userdata_pointer)
    XML_SetElementHandler(parser, @elementBegin, @elementEnd)
    XML_SetCharacterDataHandler(parser, @charData)


    if (open(filename, for input, as #1)) then
        print "Could not open file: '";filename;"'"
        end 1
    end if

    static as ubyte buffer(0 to (BUFFER_SIZE-1))

    dim as integer reached_eof = FALSE
    do
        dim as integer size = BUFFER_SIZE
        dim as integer result = get(#1, , buffer(0), size, size)
        if (result or (size <= 0)) then
            print "File input error"
            end 1
        end if

        reached_eof = (eof(1) <> FALSE)

        if (XML_Parse(parser, @buffer(0), size, reached_eof) = FALSE) then
            print filename & "(" & XML_GetCurrentLineNumber(parser) & "): Error from XML parser: "
            print *XML_ErrorString(XML_GetErrorCode(parser))
            end 1
        end if
    loop while (reached_eof = FALSE)

    XML_ParserFree(parser)
