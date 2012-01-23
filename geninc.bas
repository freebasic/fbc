'generate includes for makefile depending on platform

#define LIST_DOS "contrib/manifest/dos.lst"
#define OUT_DOS  "includes.dos"

#define LIST_WIN "contrib/manifest/win32.lst"
#define OUT_WIN  "includes.win"

#define LIST_NIX "contrib/manifest/linux-standalone.lst"
#define OUT_NIX  "includes.nix"

#define OUT_COMMON_MOD "includes.mod"
#define OUT_COMMON "includes.cmn"

declare function count_incs( byref file_to_count as const string ) as uinteger
declare sub get_incs( byref file2c as const string, arr() as string )
declare sub merge2arrays( arr1() as string, arr2() as string, outarr() as string )
declare sub merge3arrays( arr1() as string, arr2() as string, arr3() as string, outarr() as string )
declare function find_in_2array( byref fnd as const string, arr1() as string, arr2() as string ) as integer
declare sub remove_common( arr1() as string )
declare sub write_file( byref fn as const string, arr1() as string )

'main
dim dos_incs() as string
dim win_incs() as string
dim nix_incs() as string
dim comm_incs() as string
dim comm_mod_incs() as string

get_incs( LIST_DOS, dos_incs() )
get_incs( LIST_WIN, win_incs() )
get_incs( LIST_NIX, nix_incs() )

merge3arrays( dos_incs(), win_incs(), nix_incs(), comm_incs() )

var before_dos = ubound(dos_incs)
var before_win = ubound(win_incs)
var before_nix = ubound(nix_incs)

remove_common( dos_incs() )
remove_common( win_incs() )
remove_common( nix_incs() )

merge2arrays( win_incs(), nix_incs(), comm_mod_incs() )

remove_common( win_incs() )
remove_common( nix_incs() )

if command() <> "-q" or command() <> "--quiet" then
    ? using "#### DOS #### -> &"; before_dos, ubound(dos_incs), OUT_DOS
    ? using "#### WIN #### -> &"; before_win, ubound(win_incs), OUT_WIN
    ? using "#### NIX #### -> &"; before_nix, ubound(nix_incs), OUT_NIX
    ? using "COM #### -> &"; ubound(comm_incs), OUT_COMMON
    ? using "COM MODERN #### -> &"; ubound(comm_mod_incs), OUT_COMMON_MOD
end if

write_file( OUT_DOS, dos_incs() )
write_file( OUT_WIN, win_incs() )
write_file( OUT_NIX, nix_incs() )
write_file( OUT_COMMON, comm_incs() )
write_file( OUT_COMMON_MOD, comm_mod_incs() )

'end main

function count_incs( byref ftc as const string ) as uinteger

    var ff = freefile
    var sx = ""
    dim count as uinteger = 0

    open ftc for input access read as #ff
    while not eof(ff)
        line input #ff, sx
        if left(sx,4) = "inc/" then
            count += 1
        end if
    wend

    close #ff

    return count

end function

sub get_incs( byref file2c as const string, arr() as string )

    var cnt = count_incs( file2c )
    redim arr(cnt)
    dim as uinteger index = 0


    var ff = freefile
    var sx = ""

    open file2c for input access read as #ff
    while not eof(ff)
        line input #ff, sx
        if left(sx,4) = "inc/" then
            arr(index) = sx
            index += 1
        end if
    wend

    close #ff


end sub

sub pull_common( arr1() as string, arr2() as string, arr3() as string, outarr() as string )

    var cnt = 0

    for n as integer = lbound(arr1) to ubound(arr1)

        var x = find_in_2array( arr1(n), arr2(), arr3() )
        if x = 3 then
            cnt += 1
        end if

    next

    redim outarr(cnt)
    var index = 0
    for n as integer = lbound(arr1) to ubound(arr1)

        var x = find_in_2array( arr1(n), arr2(), arr3() )
        if x = 3 then
            outarr(index) = arr1(n)
            arr1(n) = ""
            index += 1
        end if

    next

    for n as integer = lbound(outarr) to ubound(outarr)
        for m as integer = lbound(arr2) to ubound(arr2)
            if outarr(n) = arr2(m) then
                arr2(m) = ""
            end if
        next m
        for o as integer = lbound(arr3) to ubound(arr3)
            if outarr(n) = arr3(o) then
                arr3(o) = ""
            end if
        next o
    next n

end sub

sub merge2arrays( arr1() as string, arr2() as string, outarr() as string )

    var cnt = 0

    for n as integer = lbound(arr1) to ubound(arr1)
        for m as integer = lbound(arr2) to ubound(arr2)
            if arr1(n) = arr2(m) then cnt += 1
        next m
    next n

    redim outarr(cnt)
    var ind = 0

    for n as integer = lbound(arr1) to ubound(arr1)
        for m as integer = lbound(arr2) to ubound(arr2)
            if arr1(n) = arr2(m) then
                outarr(ind) = arr1(n)
                ind += 1
                arr1(n) = ""
                arr2(m) = ""
                exit for
            end if
        next m
    next n


end sub

sub merge3arrays( arr1() as string, arr2() as string, arr3() as string, outarr() as string )

    var max_len = 1
    if ubound(arr1) < ubound(arr2) then max_len = 2
    if ubound(arr2) < ubound(arr3) then max_len = 3

    select case max_len
    case 1
        pull_common(arr1(),arr2(),arr3(),outarr())
    case 2
        pull_common(arr2(),arr1(),arr3(),outarr())
    case 3
        pull_common(arr3(),arr1(),arr2(),outarr())
    end select

end sub

function find_in_2array( byref fnd as const string, arr1() as string, arr2() as string ) as integer

    var foundin = 0

    for n as integer = lbound(arr1) to ubound(arr1)
        if fnd = arr1(n) then
            foundin = 1
        end if
    next n

    for n as integer = lbound(arr2) to ubound(arr2)
        if fnd = arr2(n) then
            foundin = foundin or 2
        end if
    next n

    return foundin

end function

sub remove_common( arr1() as string )

    var cnt = 0

    for n as integer = lbound(arr1) to ubound(arr1)
        if arr1(n) <> "" then
            cnt += 1
        end if
    next n

    dim arr2(cnt) as string
    var ind = 0
    for n as integer = lbound(arr1) to ubound(arr1)
        if arr1(n) <> "" then
            arr2(ind) = arr1(n)
            ind += 1
        end if
    next n

    redim arr1(cnt)
    for n as integer = lbound(arr1) to ubound(arr1)
        arr1(n) = arr2(n)
    next n


end sub

sub write_file( byref fn as const string, arr1() as string )

    var prefix = "inc"
    if environ("TARGET_OS") <> "dos" or fn <> OUT_DOS then
        prefix = "include"
    end if


    var ff = freefile
    open fn for output as #ff

    select case fn
    case OUT_COMMON
        print #ff, "INCLUDES := \"
    case else
        print #ff, "INCLUDES += \"
    end select

    for n as integer = lbound(arr1) to ubound(arr1)
        if arr1(n) <> "" then
            var suffix = " \"
            if n = ubound(arr1) -1 then suffix = ""
            print #ff, prefix & right(arr1(n),len(arr1(n))-3) & suffix
        end if
    next n

    print #ff, !"\n"

    close #ff

end sub
