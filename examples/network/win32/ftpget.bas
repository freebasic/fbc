#include once "windows.bi"
#include once "win/wininet.bi"

type ftp_ctx
	as HINTERNET hint, hconn
end type

function ftp_open _
	( _
		byval ctx as ftp_ctx ptr, _
		byval ctrlname as string = "FTP Nameless Control", _
		byval accesstype as integer = INTERNET_OPEN_TYPE_DIRECT, _
		byval proxyname as string = "", _
		byval proxybypass as string = "" _
	) as integer

	if( ctx->hint <> NULL ) then
		return TRUE
	end if

	ctx->hint = InternetOpen( ctrlname, accesstype, proxyname, proxybypass, 0 )
	if( ctx->hint = NULL ) then
		return FALSE
	end if

	function = TRUE
end function

function ftp_connect _
	( _
		byval ctx as ftp_ctx ptr, _
		byval servername as string, _
		byval serverport as integer = INTERNET_DEFAULT_FTP_PORT, _
		byval username as string = "anonymous", _
		byval useremail as string = "anonymous@anonymous", _
		byval ispassive as integer = FALSE _
	) as integer

	if( ftp_open( ctx ) = FALSE ) then
		return FALSE
	end if

	ctx->hconn = InternetConnect( ctx->hint, _
	                              servername, serverport, _
	                              username, useremail, _
	                              INTERNET_SERVICE_FTP, _
	                              iif( ispassive <> FALSE, INTERNET_FLAG_PASSIVE, 0 ), _
	                              NULL )

	if( ctx->hconn = NULL ) then
		InternetCloseHandle( ctx->hint )
		ctx->hint = NULL
		return FALSE
	end if

	function = TRUE
end function

sub ftp_close( byval ctx as ftp_ctx ptr )
	if( ctx->hconn <> NULL ) then
		InternetCloseHandle( ctx->hconn )
		ctx->hconn = NULL
	end if

	if( ctx->hint <> NULL ) then
		InternetCloseHandle( ctx->hint )
		ctx->hint = NULL
	end if
end sub

function ftp_getfile _
	( _
		byval ctx as ftp_ctx ptr, _
		byval remotefile as string, _
		byval localfile as string, _
		byval mode as integer = FTP_TRANSFER_TYPE_BINARY _
	) as integer

	if( ctx->hconn = NULL ) then
		return FALSE
	end if

	function = FtpGetFile( ctx->hconn, remotefile, localfile, FALSE, 0, mode, NULL )
end function

'' Demo
dim as ftp_ctx ftp

'' connect
if( ftp_connect( @ftp, "ftp.gnu.org" ) = FALSE ) then
	print "ERROR: Calling ftp_connect()"
	end 1
end if

'' read file
if( ftp_getfile( @ftp, "README", "gnu.org.readme.txt", FTP_TRANSFER_TYPE_ASCII ) = FALSE ) then
	print "ERROR: Calling ftp_getfile()"
	ftp_close( @ftp )
	end 1
end if	

'' exit
ftp_close( @ftp )
end 0
