/'
    This is a small tool used to compress several font and palette data files
    and turn them into C code (the raw bytes in an array), which is compiled
    into libfb.
'/

extern "c"
    declare function memcpy(byval as any ptr, byval as any ptr, byval as ulong) as any ptr
end extern

#define TRUE (-1)
#define FALSE 0
#define NULL 0

declare function fb_hEncode alias "fb_hEncode" _
    ( _
        byval as const ubyte ptr, _
        byval as integer, _
        byval as ubyte ptr, _
        byval as integer ptr _
    ) as integer

type Entry
    as string type, offsetdef, varname, num1, num2, filename
    as ubyte ptr p
    as integer size
end type

const ENTRIES__MAXCOUNT = 32

type CompilerStuff
    '' Input/output file names from commandline
    as string inputlist
    as string outputc
    as string outputdat

    as Entry entries(0 to (ENTRIES__MAXCOUNT-1))
    as integer entrycount

    '' Output C code buffer
    as string ccode
end type

dim shared as CompilerStuff stuff

private sub fatalError(byval msg as zstring ptr)
    print "makedata: "; *msg
    end(1)
end sub

private sub fatalBadArgs()
    fatalError("Usage: makedata input.lst output.h [output.dat]")
end sub

private sub handleArgs(byval argc as integer, byval argv as zstring ptr ptr)
    if (argc < 3) then
        fatalBadArgs()
    end if

    '' input.lst
    stuff.inputlist = *argv[1]

    '' output.h
    stuff.outputc = *argv[2]

    '' [output.dat]
    if (argc < 4) then
        return
    elseif (argc > 4) then
        fatalBadArgs()
    end if

    stuff.outputdat = *argv[3]
end sub

private sub fatalCantAccessFile(byval file as string)
    fatalError("Couldn't access file '" + file + "'")
end sub

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

private function pathStripFile(byref path as string) as string
    return left(path, findFileName(path))
end function

private function fileLoad(byref filename as string, byval psize as integer ptr) as ubyte ptr
    dim as integer fnum = freefile()
    if (open(filename, for binary, access read, as #fnum)) then
        fatalCantAccessFile(filename)
    end if

    dim as ubyte ptr p = NULL
    dim as integer size = lof(fnum)

    if (size > 0) then
        p = allocate(size)

        dim as integer result = get(#fnum, , *p, size, size)
        if (result or (size <= 0)) then
            fatalCantAccessFile(filename)
        end if
    end if

    close #fnum

    *psize = size
    return p
end function

private sub readInAllDataFiles()
    '' Read in the input list
    dim as integer flist = freefile()
    if (open(stuff.inputlist, for input, as #flist)) then
        fatalCantAccessFile(stuff.inputlist)
    end if

    dim as string datafile

    while (eof(flist) = FALSE)
        if (stuff.entrycount >= ENTRIES__MAXCOUNT) then
            fatalError("Too many data files, soft limit must be raised")
        end if

        with (stuff.entries(stuff.entrycount))
            '' Read out the colums for this entry
            input #flist, .type, .offsetdef, .varname, .num1, .num2, datafile

            '' Read in the data file listed in this list entry

            '' The .lst file simply contains a file name without path;
            '' we expect the data files to be in the same directory as the
            '' .lst file.
            datafile = pathStripFile(stuff.inputlist) + datafile
            ''print "Loading: '" + datafile + "'"
            .p = fileLoad(datafile, @.size)
        end with

        stuff.entrycount += 1
    wend

    close(flist)
end sub

private function concatDataBlocks(byval psize as integer ptr) as ubyte ptr
    dim as integer size = 0

    '' Get size of all entries combined
    for i as integer = 0 to (stuff.entrycount - 1)
        size += stuff.entries(i).size
    next

    dim as ubyte ptr p = allocate(size)

    '' Copy all the data entries into one big buffer
    dim as integer offset = 0
    for i as integer = 0 to (stuff.entrycount - 1)
        with (stuff.entries(i))
            memcpy(p + offset, .p, .size)
            offset += .size
        end with
    next

    *psize = size
    return p
end function

private sub writeOutDataBuffer(byval p as ubyte ptr, byval size as integer)
    '' Only if user wants the .dat file...
    if (stuff.outputdat = "") then
        return
    end if

    dim as integer f = freefile()
    if (open(stuff.outputdat, for binary, access write, as #f)) then
        fatalCantAccessFile(stuff.outputdat)
    end if

    put #f, , *p, size

    close(f)
end sub

private function compressData _
    ( _
        byval dat as ubyte ptr, _
        byval datsize as integer, _
        byval psize as integer ptr _
    ) as ubyte ptr

    *psize = datsize

    dim as ubyte ptr p = allocate(datsize)

    fb_hEncode(dat, datsize, p, psize)

    return p
end function

private sub emit(byref s as string)
    stuff.ccode += s
end sub

private sub emitEntryDecls()
    '' Each entry needs a #define and a declaration
    dim as integer offset = 0
    for i as integer = 0 to (stuff.entrycount - 1)
        with (stuff.entries(i))
            emit("#define DATA_" + .offsetdef + " 0x" + hex(offset, 8) + !"\n")

            emit("const " + .type + " " + .varname + " = {" + .num1 + ", ")
            if (.type = "FONT") then
                emit(.num2 + ", ")
            end if
            emit("&internal_data[DATA_" + .offsetdef + !"]};\n\n")

            offset += .size
        end with
    next
end sub

private sub emitByteArrayInitializer(byval p as ubyte ptr, byval size as integer)
    for i as integer = 0 to (size - 1)
        if ((i mod 16) = 0) then
            emit("    ")
        end if

        emit("0x" + hex(p[i], 2))

        if (i < (size - 1)) then
            emit(",")
            '' Emit a newline every 16 bytes
            if (((i + 1) mod 16) = 0) then
                emit(!"\n")
            else
                emit(" ")
            end if
        else
            emit(!"\n")
        end if
    next
end sub

private sub writeOutCCode()
    dim as integer f = freefile()
    if (open(stuff.outputc, for output, as #f)) then
        fatalCantAccessFile(stuff.outputc)
    end if

    print #f, stuff.ccode;

    close(f)
end sub

''
'' Main
''

    handleArgs(__FB_ARGC__, __FB_ARGV__)

    readInAllDataFiles()

    emit("/* Automatically created by makedata, to be used by libfb_gfx_data.c */" + _
         !"\n/* Compressed internal font/palette data for FB graphics */\n\n")

    emitEntryDecls()

    '' Combine all the data files into one big buffer
    dim as integer rawsize = 0
    dim as ubyte ptr raw = concatDataBlocks(@rawsize)

    '' Optionally store that raw data buffer into the output.dat
    writeOutDataBuffer(raw, rawsize)

    '' Compress the data
    dim as integer compressedsize = 0
    dim as ubyte ptr compressed = compressData(raw, rawsize, @compressedsize)

    '' Emit the compressed data
    emit(!"static const unsigned char compressed_data[] = {\n")
    emitByteArrayInitializer(compressed, compressedsize)
    emit(!"};\n\n")

    emit(!"#define DATA_SIZE " & rawsize & !"\n")

    '' Write out the emitted C code into the output file
    writeOutCCode()

#if 1
    print "makedata: " & rawsize & " bytes in, " & _
                        compressedsize & " bytes out " & _
                        "(" & (rawsize / compressedsize) & ":1 ratio)"
#endif
