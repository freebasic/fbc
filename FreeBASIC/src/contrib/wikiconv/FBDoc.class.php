<?php
	
	require_once 'DB.class.php';
	require_once 'TPL.class.php';	
	require_once 'Wakka.class.php';	
	require_once 'geshi/geshi.php';
	
class FBDoc 
{
	var $db;
	var $format;
	var $dstPath;
	var $pagesTb = array( );
	var $catKeysTb = array( );
	var $pgBodyTb = array( );
	var $pgInfoTb = array( );
	var $sectsTb = array( );
	var $converter = NULL;
	
	/*:::::*/
	function FBDoc( &$db, $dstPath, $format = 'html' )
	{
		$this->db 	   =& $db;
		$this->dstPath = $dstPath;
		$this->format  = $format;
		
		switch( $format )
		{
		case 'html':
			$this->converter = new Wakka2Html( '', 1 );
			$this->converter->setCssClass( WK_TOKEN_PRE, 'fb_pre' );
			$this->converter->setCssClass( WK_TOKEN_HEADER, 'fb_header' );
			$this->converter->setCssClass( WK_TOKEN_BOXLEFT, 'fb_box' );
			$this->converter->setCssClass( WK_TOKEN_BOXRIGHT, 'fb_box' );
			$this->converter->setCssClass( WK_TOKEN_ACTION_TB, 'fb_table' );
			$this->converter->setCssClass( WK_TOKEN_ACTION_IMG, 'fb_img' );
			$this->converter->setTagDoGen( WK_TOKEN_HORZLINE, false );
			$this->converter->setTagDoGen( WK_TOKEN_SECT_ITEM, false );
			break;
		}
	}

	/*:::::*/
	function loadPages( )
	{
		$this->pagesTb =& 
			$this->db->getRecords( "SELECT tag, body FROM wikka_pages WHERE `latest` = 'Y'" );
			
		$this->pgBodyTb = array( );
		
		foreach( $this->pagesTb as $p => $page )
			$this->pgBodyTb[$page['tag']] =& $this->pagesTb[$p]['body'];
	}
	
	/*:::::*/
	function findSections( )
	{
		$tokensTb =& Wakka::parse( $this->pgInfoTb, 
								   'DocToc', 
								   $this->pgBodyTb['DocToc'] );
		
		$this->sectsTb = array( );
		
		$last = -1;
		$i = 0;
		foreach( $tokensTb as $token )
		{
			switch( $token['id'] )
			{
			case WK_TOKEN_ACTION:
				if( $token['name'] == 'fbdoc' )
					switch( $token['paramsTb']['item'] )
					{
					case 'section':
						$this->sectsTb[$i]['name'] = $token['paramsTb']['value'];
						$this->sectsTb[$i]['subTb'] = array( );
						$last = $i;
						++$i;
						break;
					
					case 'subsect':
						if( $last != -1 )
							$this->sectsTb[$last]['subTb'][] = $token['paramsTb']['value'];
						break;
						
					}
				break;
			
			case WK_TOKEN_LINK:
				if( $last != -1 )
					$this->sectsTb[$last]['subTb'][] = $token['url'] . '|' . $token['text'];
				break;
			}
		}
	}
	
	/*:::::*/
	function _emitPage( &$page, $title )
	{
		if( isset( $this->pgInfoTb[$page]['emitted'] ) )
			if( $this->pgInfoTb[$page]['emitted'] != 0 )
				return 0;
		
		print( 'Emitting: ' . $page . '...' );
				
		$this->pgInfoTb[$page]['emitted'] = 1;
				
		if( !isset( $this->pgBodyTb[$page] ) )
		{
			print( "***FIXME*** Page missing<br>\n" );
			return 1;
		}
		
		$filename = $this->dstPath . '/' . $page . '.html';
		
		//if( !file_exists( $filename ) )
		//{
			$tokensTb =& Wakka::parse( $this->pgInfoTb,
									   $page, 
									   $this->pgBodyTb[$page], 
									   $this->dstPath );
					
			if( count( $tokensTb ) == 0 )
			{
				print( "***FIXME*** No page body<br>\n" );
				return 1;
			}
					
			switch( substr( $page, 0, 5 ) )
			{
			case 'KeyPg':
				$title = ucfirst( strtolower( trim( $title ) ) );
				// fall through
					
			case 'CatPg':
				$this->_emitCatPage( $page, $title, $tokensTb );
				break;

			default:
				$this->_emitDefPage( $page, $title, $tokensTb );
			}
		//}
				
		print( "<br> \n \n \n \n \n \n \n \n" );
		
		return 1;
	}

	/*:::::*/
	function emitSubSections( )
	{
		foreach( $this->sectsTb as $section )
		{
			foreach( $section['subTb'] as $sub )
				if( strpos( $sub, '|' ) !== false )
				{
					list( $page, $title ) = explode( '|', $sub );
					$this->_emitPage( $page, $title );
				}
		}
	}

	/*:::::*/
	function emitCrossRefPages( )
	{
		if( count( $this->pgInfoTb ) == 0 )
			return;
		
		while( true )
		{
			$cnt = 0;
			foreach( $this->pgInfoTb as $page => $info )
			{
				if( $info['emitted'] != 0 )
					continue;
				
				if( isset( $info['title'] ) )
					$title =& $info['title'];
				else
					$title = 'No Title';
				
				$cnt += $this->_emitPage( $page, $title );
			}
		
			if( $cnt == 0 )
				break;
		}
	
	}

	/*:::::*/
	function _loadTemplate( &$tpl, $prefix )
	{
		if( is_null( $tpl ) )
		{
			if( !file_exists( $this->dstPath ) )
				mkdir( $this->dstPath );
			
			$tpl = new TPL( $this->getTemplateCodePath( ) . $prefix . '.tpl.html' );
		
			$tpl->loadLangFile( $this->getTemplateLangPath( ) . 'common.ini' );
		}
	}

	/*:::::*/
	function _emitDefPage( &$page, &$title, &$tokensTb )
	{
		static $tpl = NULL;
		
		$this->_loadTemplate( $tpl, 'def' );
	
		$fd = fopen( $this->dstPath . '/' . $page . '.html', 'wb' );
				
		if( substr( $page, 0, 5 ) == 'KeyPg' )
		{
			$this->converter->setIndentBase( 1 );
		}
		else
		{
			$this->converter->setIndentBase( 0 );
		}
		
		$tpl->assign( 'pg_title', $title );
		$tpl->assignRef( 'pg_body', $this->converter->gen( $page, $tokensTb ) );
		
		$body =& $tpl->fetch( );
					
		fwrite( $fd, $body, strlen( $body ) );
		fclose( $fd );
	}

	/*:::::*/
	function &_findCatKeywords( &$tokensTb )
	{
		$resTb = array( );
		
		foreach( $tokensTb as $token )
			if( $token['id'] == WK_TOKEN_ACTION )
				if( $token['name'] == 'fbdoc' )
					if( $token['paramsTb']['item'] == 'keyword' )
					{
						list( $page, $title ) = explode( '|', $token['paramsTb']['value'] );
						$resTb[$page] = ucfirst( strtolower( trim( $title ) ) );
					}					
				
		return $resTb;
	}

/*
	function _genCatKeyList( &$keysTb, $rows, $leftrows, $rightrows, &$tpl )
	{
		// left		
		reset( $keysTb );
		$lcol = '<ul>';
		for( $i = 0; $i < $leftrows; $i++ )
		{
			$title =& current( $keysTb );
			$lcol .= '<li><a href="' . key( $keysTb ) . '.html">' . $title . '</a>';
			next( $keysTb );
		}
		$lcol .= '</ul>';
		
		$tpl->assignRef( 'pg_left', $lcol );
	
		// right
		if( $rightrows > 0 )
		{
			$rcol = '<ul>';
			for( $i = $leftrows; $i < $rows; $i++ )
			{
				$title =& current( $keysTb );
				$rcol .= '<li><a href="' . key( $keysTb ) . '.html">' . $title . '</a>';
				next( $keysTb );
			}
			$rcol .= '</ul>';
		}
		else
			$rcol = '';
		
		$tpl->assignRef( 'pg_right', $rcol );
	}

	function _genCatAlphaKeyList( &$keysTb, $rows, $leftrows, $rightrows, &$tpl )
	{
		
		// left		
		reset( $keysTb );
		$lastinit = '';
		$lcol = '';
		for( $i = 0; $i < $leftrows; $i++ )
		{
			$title =& current( $keysTb );
			if( $title{0} != $lastinit )
			{
				if( strlen( $lastinit ) > 0 )
					$lcol .= '</ul></div>';
				$lastinit = $title{0};
				$lcol .= '<div class="fb_sect_title">' . $lastinit . '</div><br />';
				$lcol .= '<div class="fb_sect_cont"><ul>';
			}
					
			$lcol .= '<li><a href="' . key( $keysTb ) . '.html">' . $title . '</a>';
			next( $keysTb );
		}
		$lcol .= '</ul></div>';
		
		$tpl->assignRef( 'pg_left', $lcol );
	
		// right
		$lastinit = '';
		$rcol = '';
		if( $rightrows > 0 )
		{
			for( $i = $leftrows; $i < $rows; $i++ )
			{
				$title =& current( $keysTb );
				if( $title{0} != $lastinit )
				{
					if( strlen( $lastinit ) > 0 )
						$rcol .= '</ul></div>';
					$lastinit = $title{0};
					$rcol .= '<div class="fb_sect_title">' . $lastinit . '</div><br />';
					$rcol .= '<div class="fb_sect_cont"><ul>';
				}

				$rcol .= '<li><a href="' . key( $keysTb ) . '.html">' . $title . '</a>';
				next( $keysTb );
			}
			$rcol .= '</ul></div>';
		}
		
		$tpl->assignRef( 'pg_right', $rcol );
	}

	function _genCatBody( &$page, &$title, &$tokensTb, &$tpl )
	{
		$tpl->assign( 'pg_name', $title );
		
		$keysTb =& $this->catKeysTb[$page];
	
		$rows = (int)count( $keysTb );
		if( $rows <= 1 )
		{
			$leftrows = 1;
			$rightrows = 0;
		}
		else
		{
			$leftrows = ceil( $rows / 2 );
			$rightrows = $rows - $leftrows;
		}
		
		switch( $page )
		{
		case 'CatPgFullIndex':
			$this->_genCatAlphaKeyList( $keysTb, $rows, $leftrows, $rightrows, $tpl );
			break;

		default:
			$this->_genCatKeyList( $keysTb, $rows, $leftrows, $rightrows, $tpl );
		}
			
	}
	
	function _emitCatPage( &$page, &$title, &$tokensTb )
	{
		static $tpl = NULL;
		
		$this->_loadTemplate( $tpl, 'cat' );
	
		$fd = fopen( $this->dstPath . '/' . $page . '.html', 'wb' );
		
		$this->catKeysTb[$page] =& $this->_findCatKeywords( $tokensTb );
		asort( $this->catKeysTb[$page] );

		$tpl->assign( 'pg_title', $title );
		$this->_genCatBody( $page, $title, $tokensTb, $tpl );
		
		$body =& $tpl->fetch( ); 
					
		fwrite( $fd, $body, strlen( $body ) );
		fclose( $fd );
	}
*/

	/*:::::*/
	function _emitCatPage( &$page, &$title, &$tokensTb )
	{
		$this->catKeysTb[$page] =& $this->_findCatKeywords( $tokensTb );
		asort( $this->catKeysTb[$page] );

		return $this->_emitDefPage( $page, $title, $tokensTb );
	}

	/*:::::*/
	function _emitChmIndex( &$keyPagesTb )
	{
		static $tpl = NULL;
		
		$this->_loadTemplate( $tpl, 'chm_index' );
		
		$fd = fopen( $this->dstPath . '/index.hhk', 'wb' );
		
		$body = '';
		foreach( $keyPagesTb as $page => $title )
			$body .= '<li><object type="text/sitemap">' .
					 '<param name="Name" value="' . $title . '">' .
					 '<param name="Local" value="' . $page . '.html">' .
					 "</object>\r\n";

		$tpl->assign( 'pg_title', 'Index' );
		$tpl->assignRef( 'pg_body', $body );
		$body =& $tpl->fetch( ); 
					
		fwrite( $fd, $body, strlen( $body ) );
		fclose( $fd );
	}

	/*:::::*/
	function _emitChmToc( $defPage )
	{
		static $tpl = NULL;
		
		$this->_loadTemplate( $tpl, 'chm_toc' );
		
		$fd = fopen( $this->dstPath . '/toc.hhc', 'wb' );
		
		$body = '<li><object type="text/sitemap">' .
				'<param name="Name" value="Table of Contents">' .
				'<param name="Local" value="' . $defPage . '.html">' .
				"</object>\r\n";

		// for each section..
		foreach( $this->sectsTb as $section )
		{
			$body .= '<li><object type="text/sitemap">' .
					 '<param name="Name" value="' . $section['name'] . '">' .
			 		 "</object>\r\n";
			 		 
			if( count( $section['subTb'] ) == 0 )
				continue;
				
			$body .= "<ul>\r\n";

			// for each sub section..
			$issub = false;
			foreach( $section['subTb'] as $sub )
			{
				// sub sub-section?
				if( strpos( $sub, '|' ) === false )
				{
					if( $issub )
						$body .= "</ul>\r\n";

					$body .= '<li><object type="text/sitemap">' .
							 '<param name="Name" value="' . $sub . '">' .
			 		 		 "</object>\r\n";
				
					$body .= "<ul>\r\n";
					
					$issub = true;
					continue;
				}
				
				list( $page, $title ) = explode( '|', $sub );
				
				$body .= '<li><object type="text/sitemap">' .
						 '<param name="Name" value="' . $title . '">' .
				 		 '<param name="Local" value="' . $page . '.html">' .
				 		 "</object>\r\n";

				switch( substr( $page, 0, 5 ) )
				{
				// category?
				case 'CatPg':
					// for each page..
					if( count( $this->catKeysTb[$page] ) > 0 )
					{
						$body .= "<ul>\r\n";
						foreach( $this->catKeysTb[$page] as $keyPage => $keyTitle )
							$body .= '<li><object type="text/sitemap">' .
							 		 '<param name="Name" value="' . $keyTitle . '">' .
					 		 		 '<param name="Local" value="' . $keyPage . '.html">' .
					 		 		 "</object>\r\n";
						$body .= "</ul>\r\n";
					}
					break;
				}
			}
			
			if( $issub )
				$body .= "</ul>\r\n";
			
			$body .= "</ul>\r\n";
		}

		$tpl->assignRef( 'pg_body', $body );
		$body =& $tpl->fetch( ); 
					
		fwrite( $fd, $body, strlen( $body ) );
		fclose( $fd );
	}
	
	/*:::::*/
	function _emitChmProject( &$prjFile, &$prjDefault, &$keyPagesTb )
	{
		static $tpl = NULL;
		
		$this->_loadTemplate( $tpl, 'chm_prj' );
		
		$fd = fopen( $this->dstPath . '/project.hhp', 'wb' );
		
		$files = '';
		foreach( $keyPagesTb as $page => $title )
			$files .= "$page.html\r\n";

		$tpl->assign( 'pg_file', $prjFile );
		$tpl->assign( 'pg_default', $prjDefault );
		
		$tpl->assignRef( 'pg_files', $files );
		$body =& $tpl->fetch( ); 
					
		fwrite( $fd, $body, strlen( $body ) );
		fclose( $fd );
	}

	/*:::::*/
	function &_createKeyPagesTb( )
	{
		$pagesTb = array( );
		
		foreach( $this->pgInfoTb as $page => $info )
		{
			switch( substr( $page, 0, 5 ) )
			{
			case 'KeyPg':
				if( !isset( $info['emitted']) || ($info['emitted'] == 0) )
					continue;
				
				$pagesTb[$page] = ucfirst( strtolower( trim( $info['title'] ) ) );
				break;
			}	
		}

		asort( $pagesTb );
		
		return $pagesTb;
	}	

	/*:::::*/
	function emitChm( $fileName, $defaultPage )
	{
		$keyPagesTb =& $this->_createKeyPagesTb( );
		
		$this->_emitChmToc( $defaultPage );
		$this->_emitChmIndex( $keyPagesTb );
		$this->_emitChmProject( $fileName, $defaultPage, $keyPagesTb );
	}
	
	/*:::::*/
	function getTemplateCodePath( )
	{
		return 'templates/default/code/';
	}
	
	/*:::::*/
	function getTemplateLangPath( )
	{
		return 'templates/default/lang/en/';
	}
	
}

?>