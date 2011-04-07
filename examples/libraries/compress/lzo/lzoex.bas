#include "lzo/lzo1x.bi"

dim inbuf as zstring ptr = @"string to compress (or not, since it's too short)"
dim inlen as integer = len(*inbuf) + 1
dim complen as lzo_uint = 100
dim compbuf as zstring ptr = allocate(complen)
dim decomplen as lzo_uint = 100
dim decompbuf as zstring ptr = allocate(decomplen)
dim workmem as any ptr

print "initializing LZO: ";

if lzo_init() = 0 then
	print "ok"
else
	print "failed!"
	end 1
end if

print "compressing '" & *inbuf & "': ";

workmem = allocate(LZO1X_1_15_MEM_COMPRESS)

if lzo1x_1_15_compress(inbuf, inlen, compbuf, @complen, workmem) = 0 then
	print "ok (" & inlen & " bytes in, " & complen & " bytes compressed)"
else
	print "failed!"
	end 1
end if

deallocate(workmem)

print "decompressing: ";

workmem = allocate(LZO1X_MEM_DECOMPRESS)

if lzo1x_decompress(compbuf, complen, decompbuf, @decomplen, NULL) = 0 then
	print "ok: '" & *decompbuf & "' (" & complen & " bytes compressed, " & decomplen & " bytes decompressed)"
else
	print "failed!"
	end 1
end if

deallocate(workmem)
