<?php

$max_upload_size = $this->GetConfigValue( 'max_upload_size' );

if ($download <> '') 
{

    // link to download a file
    if ($text == '') 
    	$text = $download;
    
    echo '<a href="' . 
    	 $this->href( 'files.xml', 
    	 			  $this->GetPageTag( ), 
    	 			  'action=download&amp;file=' . urlencode( $download ) ) .
    	 '">' . $text . '</a>';

}
?> 