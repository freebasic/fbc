<?php

	$itemTB = array( 'category' => 'Category', 
					 'keyword' => 'Keyword', 
					 'title' => 'Title', 
					 'syntax' => 'Syntax', 
					 'usage' => 'Usage',
					 'param' => 'Parameters', 
					 'ret'=> 'Return Value', 
					 'desc' => 'Description', 
					 'ex' => 'Examples', 
					 'diff' => 'Differences from QB',
					 'see' => 'See also', 
					 'back' => 'Back',
					 'close' => 'Close' );
	
	if( $item )
		$item = $this->ReturnSafeHTML( $item );
	else 
	{ 
		if( $wikka_vars ) 
			$item = $this->ReturnSafeHTML( $wikka_vars );
		else 
			$item = $this->GetPageTag( );
	}


	if( $value )
		$value = $this->ReturnSafeHTML( $value );


	

	switch( $item )
	{
	case 'title':
		print( "<h3>$value</h3>" );
		break;

	case 'section':
		print( "<b><u>$value</u></b>" );
		break;

	case 'subsect':
		print( "<b>$value</b>" );
		break;

	case 'category':
		list( $page, $name ) = explode( '|', $value );
		
		print( "<a name=\"#cat_$page\"></a><b>$name:</b>" );
		break;
		
	case 'keyword':
		list( $page, $name ) = explode( '|', $value );
		
		$class = '';
		/*if( $this->ExistsPage( $page ) == FALSE )
			$class = 'class="missingpage"';*/
			
		print( "<a $class href=\"" . $this->config['base_url'] . $page . "\">$name</a>" );
		break;
	
	case 'back':
		list( $page, $name ) = explode( '|', $value );
		
		print( "<div align=\"center\">Back to <a href=\"" . $this->config['base_url'] . $page . "\">$name</a></div>" );
		break;

	case 'close':
		break;
	
	default:
		$name = $itemTB[$item];
		print( "<b>$name:</b>" );
	}
		
		
?>
