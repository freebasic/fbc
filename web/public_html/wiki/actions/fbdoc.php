<?php

	$itemTB = array( 
		'category' => 'Category', 
		'keyword' => 'Keyword', 
		'title' => 'Title', 
		'syntax' => 'Syntax', 
		'usage' => 'Usage',
		'param' => 'Parameters', 
		'ret'=> 'Return Value', 
		'desc' => 'Description', 
		'ex' => 'Examples', 
		'lang' => 'Dialect Differences',
		'target' => 'Platform Differences',
		'diff' => 'Differences from QB',
		'see' => 'See also', 
		'back' => 'Back',
		'close' => 'Close',
		'tag' => 'tag',
		'filename' => 'filename' 
	);
    
	If( $item )
		$item = $this->ReturnSafeHTML( $item );
	Else 
	{ 
		If( $wikka_vars ) 
			$item = $this->ReturnSafeHTML( $wikka_vars );
		Else 
			$item = $this->GetPageTag( );
	}

	If( $value )
		$value = $this->ReturnSafeHTML( $value );

	switch( $item )
	{
	Case 'title':
		Print( "<h3>$value</h3>" );
		break;

	Case 'section':
		Print( "<b><u>$value</u></b>" );
		break;

	Case 'subsect':
		Print( "<b>$value</b>" );
		break;

	Case 'category':
		list( $page, $name ) = explode( '|', $value );
		
		Print( "<a name=\"#cat_$page\"></a><b>$name:</b>" );
		break;
			
	Case 'keyword':
		list( $page, $name ) = explode( '|', $value );
		
		$class = '';
		/*If( $this->ExistsPage( $page ) == FALSE )
			$class = 'class="missingpage"';*/
				
		Print( "<a $class href=\"" . $this->config['base_url'] . $page . "\">$name</a>" );
		break;
	
	Case 'back':
		list( $page, $name ) = explode( '|', $value );
		
		Print( "<div align=\"center\">Back to <a href=\"" . $this->config['base_url'] . $page . "\">$name</a></div>" );
		break;

	Case 'close':
		break;

	Case 'tag':
		break;

	Case 'filename':
		break;
	
	default:
		If( $itemTB[$item] )
		{
			$name = $itemTB[$item];
			Print( "<b>$name:</b>" );
		}
		else
		{
			Print( "<i>Unknown item " . $item . "</i>" );
		}
	}
				
				
?>
