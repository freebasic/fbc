'Real World Demonstration Program for the QuickLZ compression library

#include "quicklz.bi"

declare sub PrintUsage()
declare sub CompressFile( infile as string, outfile as string )
declare sub DeCompressFile( infile as string, outfile as string )

if len(trim(command())) < 5 then PrintUsage()
if len(trim(command(1))) > 1 then PrintUsage()

select case lcase(command(1))
	case "c"
		CompressFile( command(2), command(3) )
	case "d"
		DeCompressFile( command(2), command(3) )
	case else
		PrintUsage()
end select

sub CompressFile ( infile as string, outfile as string )
	
	dim as ubyte ptr inBuffer, outBuffer
	dim as uinteger CSize, FSize
	dim as ubyte FF
	
	FF = freefile()
	
	open infile for binary access read as #FF
	if err > 0 then
		? "Unable to open file for input"
		end 2
	end if
	
	FSize = lof(FF)
	inBuffer = allocate(FSize)
	outBuffer = allocate(QLZ_BUFFER_SIZE(FSize))
	
	get #FF, , *inBuffer, FSize
	close #FF
	
	CSize = qlz_compress(inBuffer, outBuffer, FSize)
	
	FF = freefile()
	
	open outfile for binary access write as #FF
	if err > 0 then
		? "Unable to write compressed data!"
		end 3
	end if
	
	put #FF, ,*outBuffer, CSize
	close #FF
	
	deallocate(inBuffer)
	deallocate(outBuffer)
	
	? "Uncompressed file: " & FSize & " bytes"
	? "Compressed file: " & CSize & " bytes"
	? "Difference: " & (FSize - CSize) & " bytes"
	
End Sub

sub DeCompressFile ( infile as string, outfile as string )
		
	dim as ubyte ptr inBuffer, outBuffer
	dim as uinteger CSize, FSize
	dim as ubyte FF
	
	FF = freefile()
	
	open infile for binary access read as #FF
	if err > 0 then
		? "Unable to open compressed file for input"
		end 4
	end if
	
	FSize = lof(FF)
	inBuffer = allocate(FSize)

	
	get #FF, , *inBuffer, FSize
	close #FF
	
	outBuffer = allocate(qlz_size_decompressed(inBuffer))
	
	CSize = qlz_decompress(inBuffer, outBuffer)
	
	FF = freefile()
	
	open outfile for binary access write as #FF
	if err > 0 then
		? "Unable to write uncompressed data!"
		end 5
	end if
	
	put #FF, ,*outBuffer, CSize
	close #FF
	
	deallocate(inBuffer)
	deallocate(outBuffer)
	
	? "Uncompressed file: " & CSize & " bytes"
	? "Compressed file: " & FSize & " bytes"
	? "Difference: " & (CSize - FSize) & " bytes"
	
End Sub

sub PrintUsage()
	? "QuickLZ Demonstration Program"
	? "Usage: qlz [c|d] infile outfile"
	? "c flag is for compression"
	? "d flag is for decompression"
	?
	end 1
End Sub