' SDL_cdrom example adapted to freeBasic from:
' http://www.libsdl.org/cgi/docwiki.cgi/SDL_20CDROM_20Listing_20Track
'
' Lists all the tracks available on a CD.

#include  "SDL\SDL.bi"

	dim cdrom as SDL_CD ptr
	dim i as integer
	dim m as integer, s as integer, f as integer

	' initiate SDL with cdrom support
	if (SDL_Init(SDL_INIT_CDROM) < 0) then
   		print "Unable to initiate SDL: "; *SDL_GetError()
   		end
	end if

	' open up the default cdrom drive
	cdrom = SDL_CDOpen(0)

	' obtain the status of the cdrom
	SDL_CDStatus(cdrom)

	' print the number of available tracks on the cd
	print "Drive tracks:"; cdrom->numtracks

	' we now print info about each track
	for i = 0 to cdrom->numtracks - 1
   		FRAMES_TO_MSF(cdrom->track(i).length, @m, @s, @f)
   		if (f > 0) then s = s + 1
   		print chr(9); "Track (index"; i; ") "; cdrom->track(i).id; ":"; m; ":"; string(2 - len(str(s)), "0"); trim(str(s))
	next

	' end when the user presses a key
	sleep
