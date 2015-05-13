/' example.c -- usage example of the zlib compression library
 * Copyright (C) 1995-2006, 2011 Jean-loup Gailly.
 * For conditions of distribution and use, see copyright notice in zlib.h
'/

/' @(#) $Id$ '/

#include "zlib.bi"
#include "crt/stdio.bi"

#include "crt/string.bi"
#include "crt/stdlib.bi"

#define TESTFILE @"foo.gz"

#macro CHECK_ERR(err_, msg)
    if (err_ <> Z_OK) then
        print #stderr_,msg;" error : ";err_
        exit_(1)
    end if
#endmacro

dim shared hello as zstring ptr = @"hello, hello!"
/' "hello world" would be more standard, but the repeated "hello"
 * stresses the compression code better, sorry...
 '/

dim shared dictionary as zstring ptr = @"hello"
dim shared dictId as uLong /' Adler32 value of the dictionary '/

declare sub test_deflate (byval compr as Byte ptr, byval comprLen as uLong)
declare sub test_inflate (byval compr as Byte ptr, byval comprLen as uLong,_
                          byval uncompr as Byte ptr, byval uncomprLen as uLong)
declare sub test_large_deflate (byval compr as byte ptr, byval comprLen as uLong,_
                                byval uncompr as Byte ptr, byval uncomprLen as uLong)
declare sub test_large_inflate (byval compr as Byte ptr, byval comprLen as uLong,_
                                byval uncompr as Byte ptr, byval uncomprLen as uLong)
declare sub test_flush (byval compr as Byte ptr, byval comprLen as uLong ptr)
declare sub test_sync  (byval compr as Byte ptr, byval comprLen as uLong,_
                        byval uncompr as Byte ptr, byval uncomprLen as uLong)
declare sub test_dict_deflate  (byval compr as Byte ptr, byval comprLen as uLong)
declare sub test_dict_inflate  (byval compr as Byte ptr, byval comprLen as uLong,_
                                byval uncompr as Byte ptr, byval uncomprLen as uLong)

declare sub test_compress (byval compr as Byte ptr, byval comprLen as uLong,_
                           byval uncompr as Byte ptr, byval uncomprLen as uLong)
declare sub test_gzio     (byval fname as const zstring ptr,_
                           byval uncompr as Byte ptr, byval uncomprLen as uLong)
declare function mymain() as integer

''used as replacement for fprintf(stderr_,...)
dim shared stderr_ as integer
stderr_ = freefile()

mymain()

/' ===========================================================================
 * Test compress() and uncompress()
 '/
sub test_compress (byval compr as Byte ptr, byval comprLen as uLong,_
                   byval uncompr as Byte ptr, byval uncomprLen as uLong)

    dim err_ as integer
    dim as uLong len_ = len(*hello) + 1

    err_ = compress(compr, @comprLen, hello, len_)
    CHECK_ERR(err_, @"compress")

    strcpy(uncompr, @"garbage")

    err_ = uncompress(uncompr, @uncomprLen, compr, comprLen)
    CHECK_ERR(err_, "uncompress")

    if (*uncompr <> *hello) then
        print #stderr_, "bad uncompress"
        exit_(1)
    else 
        print "uncompress(): ";*cast(zstring ptr,uncompr)
    end if

end sub

/' ===========================================================================
 * Test read/write of .gz files
 '/
sub test_gzio     (byval fname as const zstring ptr,_
                   byval uncompr as Byte ptr, byval uncomprLen as uLong)
                                 

    dim err_ as integer
    dim len_ as integer = len(*hello)+1
    dim as gzFile file_
    dim pos_ as z_off_t

    file_ = gzopen(fname, "wb")
    if (file_ = NULL) then
        print #stderr_, "gzopen error"
        exit_(1)
    end if
    gzputc(file_, asc("h"))
    if (gzputs(file_, "ello") <> 4) then
        print #stderr_, "gzputs err: ";gzerror(file_, @err_)
        exit_(1)
    end if
    if (gzprintf(file_, @", %s!", @"hello") <> 8) then
        print #stderr_, "gzprintf err: ";gzerror(file_, @err_)
        exit_(1)
    end if
    gzseek(file_, 1L, SEEK_CUR) /' add one zero byte '/
    gzclose(file_)

    file_ = gzopen(fname, "rb")
    if (file_ = NULL) then
        print #stderr_, "gzopen error"
        exit_(1)
    end if

    assert( uncomprLen >= len( "garbage" ) + 1 )
    *cptr( zstring ptr, uncompr ) = "garbage"

    if (gzread(file_, uncompr, uncomprLen) <> len_) then
        print #stderr_, "gzread err: ";gzerror(file_, @err_)
        exit_(1)
    end if
    if (*uncompr <> *hello) then
        print #stderr_, "bad gzread: ", *cast(zstring ptr,uncompr)
        exit_(1)
    else 
        print "gzread(): ";*cast(zstring ptr,uncompr)
    end if

    pos_ = gzseek(file_, -8L, SEEK_CUR)
    if (pos_ <> 6 orelse gztell(file_) <> pos_) then
        print #stderr_, "gzseek error, pos=";pos_;" gztell= ";gztell(file_)
        exit_(1)
    end if

    if (gzgetc_(file_) <> asc(" ")) then
        print #stderr_,"gzgetc error"
        exit_(1)
    end if

    if (gzungetc(asc(" "), file_) <> asc(" ")) then
        print #stderr_, "gzungetc error"
        exit_(1)
    end if

    gzgets(file_, cast(Byte ptr,uncompr), uncomprLen)
    if (len(*cast(zstring ptr,uncompr)) <> 7) then /' " hello!" '/
      print #stderr_, "gzgets err after gzseek: "; gzerror(file_, @err_)
      exit_(1)
    end if
    
    if (*cast(zstring ptr,uncompr) <> *(hello + 6))  then
      print #stderr_, "bad gzgets after gzseek"
      exit_(1)
    else        
      print "gzgets() after gzseek: ";*cast(zstring ptr,uncompr)
    end if

    gzclose(file_)

end sub


/' ===========================================================================
 * Test deflate() with small buffers
 '/
sub test_deflate (byval compr as Byte ptr, byval comprLen as uLong)

    dim as z_stream c_stream /' compression stream '/
    dim as integer err_
    dim as uLong len_ = len(*hello)+1

    c_stream.zalloc = NULL
    c_stream.zfree = NULL
    c_stream.opaque = NULL

    err_ = deflateInit(@c_stream, Z_DEFAULT_COMPRESSION)
    CHECK_ERR(err_, "deflateInit")

    c_stream.next_in  = hello
    c_stream.next_out = compr

    while (c_stream.total_in <> len_ andalso c_stream.total_out < comprLen) 
        c_stream.avail_in = 1:c_stream.avail_out = 1 /' force small buffers '/
        err_ = deflate(@c_stream, Z_NO_FLUSH)
        CHECK_ERR(err_, "deflate")
    wend
    /' Finish the stream, still forcing small buffers: '/
    while(1)
        c_stream.avail_out = 1
        err_ = deflate(@c_stream, Z_FINISH)
        if (err_ = Z_STREAM_END) then
          exit while
        end if
        CHECK_ERR(err_, "deflate")
    wend

    err_ = deflateEnd(@c_stream)
    CHECK_ERR(err_, "deflateEnd")

end sub

/' ===========================================================================
 * Test inflate() with small buffers
 '/
sub test_inflate (byval compr as Byte ptr, byval comprLen as uLong,_
                  byval uncompr as Byte ptr, byval uncomprLen as uLong)

    dim err_ as integer
    dim d_stream as z_stream    /' decompression stream '/

    strcpy(cast(zstring ptr,uncompr), @"garbage")

    d_stream.zalloc = NULL
    d_stream.zfree = NULL
    d_stream.opaque = NULL

    d_stream.next_in  = compr
    d_stream.avail_in = 0
    d_stream.next_out = uncompr

    err_ = inflateInit(@d_stream)
    CHECK_ERR(err_, "inflateInit")

    while (d_stream.total_out < uncomprLen andalso d_stream.total_in < comprLen) 
        d_stream.avail_in = 1:d_stream.avail_out = 1 /' force small buffers '/
        err_ = inflate(@d_stream, Z_NO_FLUSH)
        if (err_ = Z_STREAM_END) then
          exit while
        end if
        CHECK_ERR(err_, @"inflate")
    wend

    err_ = inflateEnd(@d_stream)
    CHECK_ERR(err_, "inflateEnd")

    if (*cast(zstring ptr,uncompr) <> *hello) then
        print #stderr_, "bad inflate"
        exit_(1)
    else 
        print "inflate(): ";*cast(zstring ptr,uncompr)
    end if

end sub

/' ===========================================================================
 * Test deflate() with large buffers and dynamic change of compression level
 '/
sub test_large_deflate (byval compr as byte ptr, byval comprLen as uLong,_
                        byval uncompr as Byte ptr, byval uncomprLen as uLong)

    dim as z_stream c_stream /' compression stream '/
    dim as integer err_

    c_stream.zalloc = NULL
    c_stream.zfree = NULL
    c_stream.opaque = NULL

    err_ = deflateInit(@c_stream, Z_BEST_SPEED)
    CHECK_ERR(err_, "deflateInit")

    c_stream.next_out = compr
    c_stream.avail_out = comprLen

    /' At this point, uncompr is still mostly zeroes, so it should compress
     * very well:
     '/
    c_stream.next_in = uncompr
    c_stream.avail_in = uncomprLen
    err_ = deflate(@c_stream, Z_NO_FLUSH)
    CHECK_ERR(err_, "deflate")
    if (c_stream.avail_in <> 0) then
        print #stderr_, "deflate not greedy"
        exit_(1)
    end if

    /' Feed in already compressed data and switch to no compression: '/
    deflateParams(@c_stream, Z_NO_COMPRESSION, Z_DEFAULT_STRATEGY)
    c_stream.next_in = compr
    c_stream.avail_in = comprLen/2
    err_ = deflate(@c_stream, Z_NO_FLUSH)
    CHECK_ERR(err_, "deflate")

    /' Switch back to compressing mode: '/
    deflateParams(@c_stream, Z_BEST_COMPRESSION, Z_FILTERED)
    c_stream.next_in = uncompr
    c_stream.avail_in = uncomprLen
    err_ = deflate(@c_stream, Z_NO_FLUSH)
    CHECK_ERR(err_, "deflate")

    err_ = deflate(@c_stream, Z_FINISH)
    if (err_ <> Z_STREAM_END) then
        print #stderr_, "deflate should report Z_STREAM_END"
        exit_(1)
    end if
    err_ = deflateEnd(@c_stream)
    CHECK_ERR(err_, "deflateEnd")

end sub

/' ===========================================================================
 * Test inflate() with large buffers
 '/
sub test_large_inflate (byval compr as Byte ptr, byval comprLen as uLong,_
                        byval uncompr as Byte ptr, byval uncomprLen as uLong)
    
    dim as integer err_
    dim as z_stream d_stream /' decompression stream '/

    strcpy(cast(zstring ptr,uncompr), @"garbage")

    d_stream.zalloc = NULL
    d_stream.zfree = NULL
    d_stream.opaque = NULL

    d_stream.next_in  = compr
    d_stream.avail_in = comprLen

    err_ = inflateInit(@d_stream)
    CHECK_ERR(err_, "inflateInit")

    while(1)
        d_stream.next_out = uncompr            /' discard the output '/
        d_stream.avail_out = uncomprLen
        err_ = inflate(@d_stream, Z_NO_FLUSH)
        if (err_ = Z_STREAM_END) then
          exit while
        end if
        CHECK_ERR(err_, "large inflate")
    wend

    err_ = inflateEnd(@d_stream)
    CHECK_ERR(err_, "inflateEnd")

    if (d_stream.total_out <> 2*uncomprLen + comprLen/2) then
        print #stderr_, "bad large inflate: "; d_stream.total_out
        exit_(1)
    else
        print "large_inflate(): OK"
    end if

end sub

/' ===========================================================================
 * Test deflate() with full flush
 '/
sub test_flush (byval compr as Byte ptr, byval comprLen as uLong ptr)

    dim as z_stream c_stream /' compression stream '/
    dim err_ as integer
    dim as uInt len_ = len(hello)+1

    c_stream.zalloc = NULL
    c_stream.zfree = NULL
    c_stream.opaque = NULL

    err_ = deflateInit(@c_stream, Z_DEFAULT_COMPRESSION)
    CHECK_ERR(err_, "deflateInit")

    c_stream.next_in  = cast(Bytef ptr,hello)
    c_stream.next_out = compr
    c_stream.avail_in = 3
    c_stream.avail_out = *comprLen
    err_ = deflate(@c_stream, Z_FULL_FLUSH)
    CHECK_ERR(err_, "deflate")

    compr[3] += 1 /' force an error in first compressed block '/
    c_stream.avail_in = len_ - 3

    err_ = deflate(@c_stream, Z_FINISH)
    if (err_ <> Z_STREAM_END) then
        CHECK_ERR(err_, "deflate")
    end if
    err_ = deflateEnd(@c_stream)
    CHECK_ERR(err_, "deflateEnd")

    *comprLen = c_stream.total_out

end sub

/' ===========================================================================
 * Test inflateSync()
 '/
sub test_sync  (byval compr as Byte ptr, byval comprLen as uLong,_
                byval uncompr as Byte ptr, byval uncomprLen as uLong)

    dim err_ as integer
    dim as z_stream d_stream /' decompression stream '/

    strcpy(cast(zstring ptr,uncompr), @"garbage")

    d_stream.zalloc = 0
    d_stream.zfree = 0
    d_stream.opaque = cast(voidpf,0)

    d_stream.next_in  = compr
    d_stream.avail_in = 2 /' just read the zlib header '/

    err_ = inflateInit(@d_stream)
    CHECK_ERR(err_, "inflateInit")

    d_stream.next_out = uncompr
    d_stream.avail_out = uncomprLen

    inflate(@d_stream, Z_NO_FLUSH)
    CHECK_ERR(err_, "inflate")

    d_stream.avail_in = comprLen-2          /' read all compressed data '/
    err_ = inflateSync(@d_stream)           /' but skip the damaged part '/
    CHECK_ERR(err_, "inflateSync")

    err_ = inflate(@d_stream, Z_FINISH)
    if (err_ <> Z_DATA_ERROR) then
        print #stderr_, "inflate should report DATA_ERROR"
        /' Because of incorrect adler32 '/
        exit_(1)
    end if
    err_ = inflateEnd(@d_stream)
    CHECK_ERR(err_, "inflateEnd")

    print "after inflateSync(): hel";*cast(zstring ptr,uncompr)

end sub

/' ===========================================================================
 * Test deflate() with preset dictionary
 '/
sub test_dict_deflate  (byval compr as Byte ptr, byval comprLen as uLong)

    dim as z_stream c_stream /' compression stream '/
    dim as integer err_

    c_stream.zalloc = NULL
    c_stream.zfree = NULL
    c_stream.opaque = NULL

    err_ = deflateInit(@c_stream, Z_BEST_COMPRESSION)
    CHECK_ERR(err_, "deflateInit")

    err_ = deflateSetDictionary(@c_stream,_
                cast(Bytef ptr,dictionary), cast(integer,sizeof(dictionary)))
    CHECK_ERR(err_, "deflateSetDictionary")

    dictId = c_stream.adler
    c_stream.next_out = compr
    c_stream.avail_out = cast(uInt,comprLen)

    c_stream.next_in = cast(Bytef ptr,hello)
    c_stream.avail_in = len(*hello)+1

    err_ = deflate(@c_stream, Z_FINISH)
    if (err_ <> Z_STREAM_END) then
        print #stderr_,"deflate should report Z_STREAM_END"
        exit_(1)
    end if
    err_ = deflateEnd(@c_stream)
    CHECK_ERR(err_, "deflateEnd")

end sub

/' ===========================================================================
 * Test inflate() with a preset dictionary
 '/
sub test_dict_inflate  (byval compr as Byte ptr, byval comprLen as uLong,_
                        byval uncompr as Byte ptr, byval uncomprLen as uLong)

    dim err_ as integer
    dim as z_stream d_stream /' decompression stream '/

    strcpy(cast(zstring ptr,uncompr), @"garbage")

    d_stream.zalloc = 0
    d_stream.zfree = 0
    d_stream.opaque = 0

    d_stream.next_in  = compr
    d_stream.avail_in = cast(uInt,comprLen)

    err_ = inflateInit(@d_stream)
    CHECK_ERR(err_, "inflateInit")

    d_stream.next_out = uncompr
    d_stream.avail_out = uncomprLen

    while(1)
        err_ = inflate(@d_stream, Z_NO_FLUSH)
        if (err_ = Z_STREAM_END) then
          exit while
        end if
        if (err_ = Z_NEED_DICT) then
            if (d_stream.adler <> dictId) then
                print #stderr_, "unexpected dictionary"
                exit_(1)
            end if
            err_ = inflateSetDictionary(@d_stream, cast(Bytef ptr,dictionary),_
                                       cast(integer,sizeof(dictionary)))
        end if
        CHECK_ERR(err_, "inflate with dict")
    wend

    err_ = inflateEnd(@d_stream)
    CHECK_ERR(err_, "inflateEnd")

    if (*cast(zstring ptr,uncompr) <> *hello) then
        print #stderr_, "bad inflate with dict"
        exit_(1)
    else
        print "inflate with dictionary: ";*cast(zstring ptr,uncompr)
    end if

end sub

/' ===========================================================================
 * Usage:  example [output.gz  [input.gz]]
 '/

function mymain() as integer

    open err for input as #stderr_
    var err_ = err()
    if (err_ <> 0) then
      print "could not open stderr_"
      return -1
    end if
    
    dim as Byte ptr compr
    dim as Byte ptr uncompr
    dim comprLen as uLong = 10000*sizeof(integer) /' don't overflow on MSDOS '/
    dim as uLong uncomprLen = comprLen
    dim myVersion as zstring ptr = @ZLIB_VERSION

    if (zlibVersion()[0][0] <> myVersion[0][0]) then
        print #stderr_,"incompatible zlib version"
        exit_(1)  
    elseif (*zlibVersion() <> ZLIB_VERSION) then
        print #stderr_,"warning: different zlib version"
    end if

    print "zlib version ";ZLIB_VERSION;" = ";hex(ZLIB_VERNUM);" compile flags = ";hex(zlibCompileFlags())

    compr    = callocate(comprLen, 1)
    uncompr  = callocate(uncomprLen, 1)
    /' compr and uncompr are cleared to avoid reading uninitialized
     * data and to ensure that uncompr compresses well.
     '/
    if (compr = NULL orelse uncompr = NULL) then
        print "out of memory"
        exit_(1)
    end if

    test_compress(compr, comprLen, uncompr, uncomprLen)

    if (command(1) <> "") then
      dim s as string = command(1)
      test_gzio(strptr(s),uncompr,uncomprLen)
    else
      test_gzio(TESTFILE,uncompr,uncomprLen)
    end if
    
    test_deflate(compr, comprLen)
    test_inflate(compr, comprLen, uncompr, uncomprLen)

    test_large_deflate(compr, comprLen, uncompr, uncomprLen)
    test_large_inflate(compr, comprLen, uncompr, uncomprLen)

    test_flush(compr, @comprLen)
    test_sync(compr, comprLen, uncompr, uncomprLen)
    comprLen = uncomprLen

    test_dict_deflate(compr, comprLen)
    test_dict_inflate(compr, comprLen, uncompr, uncomprLen)

    deallocate(compr)
    deallocate(uncompr)

    return 0

end function


