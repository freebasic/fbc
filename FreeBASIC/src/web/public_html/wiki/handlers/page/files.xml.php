<?php

// upload path
$upload_path = $this->config['upload_path'] . '/' . $this->GetPageTag();

if( !is_dir( $upload_path ) ) 
	mkdir_r( $upload_path );

$file = basename( urldecode( $_REQUEST['file'] ) );

// do the action
switch( $_REQUEST['action'] ) 
{
case 'download':
    if( $this->HasAccess( 'read' ) ) 
    {
    	$path = $upload_path . '/' . $file;
		Header( 'Content-Length: ' . filesize( $path ) );
		Header( 'Content-Type: application/x-download' );
		Header( 'Content-Disposition: attachment; filename=' . $file );
    	Header( 'Connection: close' );
    	@readfile( $path );
		exit( );
	}
	break;
    
case 'delete':   
	if( $this->IsAdmin( ) ) 
	{
    	@unlink( $upload_path . '/' . $file );
    }
            
    print $this->redirect( $this->Href( ) );
    break;
}
?> 