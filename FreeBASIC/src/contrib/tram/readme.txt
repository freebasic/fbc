TRAM - Testing Release Archive Maker
(c) 2006-2007 by v1ctor

o Usage:

tram [-root=base_path  ] 
     [-date=yyyy/mm/dd ] [-time=hh:mm:ss]
     [-file=output_name] [-dist=win32|linux|dos]

o Notes:
	
	If -date is omitted, all files in the distribution are included.
	
	If -root is omitted, "../../.." is assumed.
	
	If -dist is omitted, "win32" is assumed.
		o The file lists are pulled from [root]/manifest
	
	If -file is omitted, it is constructed as follows:
		FB-v[FB_VER_MAJOR].[FB_VER_MINOR]-[monthname( month( now ), -1 )]-[day( now )]-[year( now )]-[dist].[zip|gz]

    The [root] directory must end in FreeBASIC/.
	
o Example:

tram   -date=2006/05/01 -dist=win32
./tram -date=2006/05/01 -dist=linux
