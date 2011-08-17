'' Small program to embed the fbportio.sys binary into a C module, as an array
'' of bytes.

#define NULL 0

sub fatalCantAccessFile(byref filename as string)
    print "Error: Could not access file: '" + filename + "'"
    end 1
end sub

function fileLoad(byref filename as string, byval psize as integer ptr) as ubyte ptr
    dim as integer f = freefile()
    if (open(filename, for binary, access read, as #f)) then
        fatalCantAccessFile(filename)
    end if

    dim as ubyte ptr p = NULL
    dim as integer size = lof(f)

    if (size > 0) then
        p = allocate(size)

        dim as integer result = get(#f, , *p, size, size)
        if (result or (size <= 0)) then
            fatalCantAccessFile(filename)
        end if
    end if

    close #f

    *psize = size
    return p
end function

sub writeOut(byref filename as string, byref text as string)
    dim as integer f = freefile()
    if (open(filename, for output, as #f)) then
        fatalCantAccessFile(filename)
    end if
    print #f, text;
    close #f
end sub

    if (__FB_ARGC__ <> 3) then
        print "Usage: makedriver fbportio.sys fbportio-driver.h"
        end 1
    end if

    dim as string inputfile = *__FB_ARGV__[1]
    dim as string outputfile = *__FB_ARGV__[2]

    dim as integer size = 0
    dim as ubyte ptr p = fileLoad(inputfile, @size)

    dim as string emit
    emit += "#define FBPORTIO_DRIVER_SIZE " + str(size) + !"\n"
    emit += !"const unsigned char fbportio_driver[FBPORTIO_DRIVER_SIZE] = {\n"

    for i as integer = 0 to (size - 1)
        if ((i mod 16) = 0) then
            '' Indent at line begin
            emit += "    "
        end if

        emit += "0x" + hex(p[i], 2)

        if (i < (size - 1)) then
            emit += ","
            '' Emit a newline every 16 bytes
            if (((i + 1) mod 16) = 0) then
                emit += !"\n"
            else
                emit += " "
            end if
        else
            emit += !"\n"
        end if
    next

    emit += !"};\n"

    writeOut(outputfile, emit)
