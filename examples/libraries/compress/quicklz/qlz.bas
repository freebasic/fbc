'Real World Demonstration Program for the QuickLZ 1.20 compression library

#include "quicklz.bi"

declare sub PrintUsage()
declare sub CompressFile( byref infile as string, byref outfile as string )
declare sub DecompressFile( byref infile as string, byref outfile as string )

if len(command(1)) <> 1 then PrintUsage()
if len(command(2)) = 0 then PrintUsage()
if len(command(3)) = 0 then PrintUsage()

select case lcase(command(1))
	case "c"
		CompressFile( command(2), command(3) )
	case "d"
		DeCompressFile( command(2), command(3) )
	case else
		PrintUsage()
end select

sub CompressFile ( byref infile as string, byref outfile as string )
	
	dim as ubyte ptr inBuffer, outBuffer
	dim as uinteger CSize, FSize
	dim as ubyte FF
	
	FF = freefile()
	
	if open(infile for binary access read as #FF) <> 0 then
		print "Unable to open file for input"
		end 2
	end if
	
	FSize = lof(FF)
	inBuffer = allocate(FSize)
	outBuffer = allocate(QLZ_BUFFER_SIZE(FSize))
	
	get #FF, , *inBuffer, FSize
	close #FF
	
	CSize = qlz_compress(inBuffer, outBuffer, FSize)
	
	if CSize = 0 then
		print "Compression failed!"
		end 3
	end if
	
	FF = freefile()
	
	if open(outfile for binary access write as #FF) <> 0 then
		print "Unable to write compressed data!"
		end 4
	end if
	
	put #FF, ,*outBuffer, CSize
	close #FF
	
	deallocate(inBuffer)
	deallocate(outBuffer)
	
	print "Uncompressed file: " & FSize & " bytes"
	print "Compressed file: " & CSize & " bytes"
	print "Difference: " & cint(CSize - FSize) & " bytes"
	
End Sub

sub DecompressFile ( byref infile as string, byref outfile as string )
		
	dim as ubyte ptr inBuffer, outBuffer
	dim as uinteger CSize, FSize
	dim as ubyte FF
	
	FF = freefile()
	
	if open(infile for binary access read as #FF) <> 0 then
		print "Unable to open compressed file for input"
		end 5
	end if
	
	FSize = lof(FF)
	inBuffer = allocate(FSize)
	
	
	get #FF, , *inBuffer, FSize
	close #FF
	
	outBuffer = allocate(qlz_size_decompressed(inBuffer))
	
	CSize = qlz_decompress(inBuffer, outBuffer)
	
	if CSize = 0 then
		print "Decompression failed, or uncompressed file is empty!"
		end 6
	end if
	
	FF = freefile()
	
	if open(outfile for binary access write as #FF) <> 0 then
		print "Unable to write uncompressed data!"
		end 7
	end if
	
	put #FF, ,*outBuffer, CSize
	close #FF
	
	deallocate(inBuffer)
	deallocate(outBuffer)
	
	print "Compressed file: " & FSize & " bytes"
	print "Uncompressed file: " & CSize & " bytes"
	print "Difference: " & cint(CSize - FSize) & " bytes"
	
End Sub

sub PrintUsage()
	print "QuickLZ 1.20 Demonstration Program"
	print "Usage: qlz {c|d} infile outfile"
	print "c flag is for compression"
	print "d flag is for decompression"
	
	end 1
End Sub
