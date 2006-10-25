<?php
	if( $name )
	{
		$name = $this->ReturnSafeHTML( $name );
		if( strpos( $name, '|' ) === false )
		{
			print( "<a name=\"$name\"></a>" );
		}
		else
		{
			list( $target, $link ) = explode( '|', $this->ReturnSafeHTML( $name ) );
			print( "<a href=\"" . $this->Href( '', $this->tag ) . "#$target\">$link</a>" );
		}
	}
?>
