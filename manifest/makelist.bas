#define NULL 0
#define FALSE 0
#define TRUE (-1)
#define STRINGIFY(s) #s

private sub fatalCantOpenFile(byref file as string)
    print "Error: Could not open file: '" + file + "'"
    end 1
end sub

''
'' main
''

    if (__FB_ARGC__ <> 3) then
        print "Usage: makelist pattern.ini makelist.sh"
        end 1
    end if

    dim as string patternfile = *__FB_ARGV__[1]
    dim as string outfile     = *__FB_ARGV__[2]

    dim as integer fi = freefile()
    if (open(patternfile, for input, as #fi)) then
        fatalCantOpenFile(patternfile)
    end if

    dim as integer fo = freefile()
    if (open(outfile, for append, as #fo)) then
        fatalCantOpenFile(outfile)
    end if

    dim as string ln
    dim as integer skipping = FALSE

    while (eof(fi) = FALSE)
        line input #fi, ln
        ln = trim(ln)

        if (len(ln) = 0) then
            continue while
        end if

        select case (ln[0])
        case asc("+"), asc("-")
            if (skipping) then
                continue while
            end if

            '' '-' means "exclude it".
            dim as integer exclude = (ln[0] = asc("-"))

            '' Cut off +/- at the front.
            ln = trim(right(ln, len(ln) - 1))

            '' Quote the pattern
            ln = " """ + ln + """"

            if (exclude) then
                ln = "exclude" + ln
            else
                ln = "include" + ln
            end if

            print #fo, ln

        case asc("[")   '' '[' [<system>] ']'
            if (right(ln, 1) <> "]") then
                continue while
            end if

            '' Cut off the []'s.
            ln = trim(mid(ln, 2, len(ln)-2))

            '' Finding either empty []'s or the correct system name stops
            '' skipping. If a different system name is found, this section is
            '' skipped until the next [...].
            skipping = ((len(ln) > 0) and (ln <> STRINGIFY(HOST_OSFAMILY)))

        end select
    wend
