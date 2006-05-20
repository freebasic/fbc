<?php

	define( 'WK_TOKEN_NULL'			, 0	);
	define( 'WK_TOKEN_LT'			, 1 ); 
	define( 'WK_TOKEN_GT'			, 2 );
	define( 'WK_TOKEN_BOXLEFT'		, 3 );
	define( 'WK_TOKEN_BOXRIGHT'		, 4 );
	define( 'WK_TOKEN_CLEAR'		, 5 );
	define( 'WK_TOKEN_KBD'			, 6 );
	define( 'WK_TOKEN_BOLD'			, 7 );
	define( 'WK_TOKEN_ITALIC'		, 8 );
	define( 'WK_TOKEN_UNDERLINE'	, 9 );
	define( 'WK_TOKEN_MONOSPACE'	, 10 );
	define( 'WK_TOKEN_NOTES'		, 11 );
	define( 'WK_TOKEN_STRIKE'		, 12 );
	define( 'WK_TOKEN_CENTER'		, 13 );
	define( 'WK_TOKEN_HEADER'		, 14 );
	define( 'WK_TOKEN_NEWLINE'		, 15 );
	define( 'WK_TOKEN_CODE'			, 16 );
	define( 'WK_TOKEN_PRE'			, 17 );
	define( 'WK_TOKEN_LINK'			, 18 );
	define( 'WK_TOKEN_ACTION'		, 19 );
	define( 'WK_TOKEN_INDENT'		, 20 );
	define( 'WK_TOKEN_LIST'			, 21 );
	define( 'WK_TOKEN_TEXT'			, 22 );
	define( 'WK_TOKEN_FORCENL'		, 23 );
	define( 'WK_TOKEN_HORZLINE'		, 24 );
	define( 'WK_TOKEN_SECT_ITEM'	, 25 );
	define( 'WK_TOKEN_ACTION_TB'	, 26 );
	define( 'WK_TOKEN_ACTION_IMG'	, 27 );
	define( 'WK_TOKENS'				, 28 );

	define( 'WK_PATTERN'			, '/(' .
				  	  				  '%%.*?%%|' .
				  	  				  '"".*?""|' .
				  	  				  '\[\[[^\[]*?\]\]|' .
				  	  				  '-{4,}|---|' .
				  	  				  '\b[a-z]+:\/\/\S+|' . 
				  	  				  '\*\*|\'\'|\#\#|\#\%|\@\@|\:\:c\:\:|\>\>|\<\<|\+\+|\_\_|\<|\>|\/\/|' .
				  	  				  '======|=====|====|===|==|' .
				  	  				  '^[\t|\~]+(-|&|[0-9a-zA-Z]+\))?|' .
				  	  				  '\{\{.*?\}\}|' .
				  	  				  '\n' .
				  	  				  ')/ms' );
	
	define( 'WK_TAG_BOLD'			,  0 );
	define( 'WK_TAG_ITALIC'			,  1 );
	define( 'WK_TAG_UNDERLINE'		,  2 );
	define( 'WK_TAG_MONOSPACE'		,  3 );
	define( 'WK_TAG_NOTES'			,  4 );
	define( 'WK_TAG_STRIKE'			,  5 );
	define( 'WK_TAG_BOXLEFT'		,  6 );
	define( 'WK_TAG_BOXRIGHT'		,  7 );
	define( 'WK_TAG_KEYS'			,  8 );
	define( 'WK_TAG_CENTER'			,  9 );
	define( 'WK_TAG_HEADER'			, 10 );
	define( 'WK_TAG_LEVEL'			, 11 );
	define( 'WK_TAG_SECTION'		, 12 );
	define( 'WK_TAGS'				, 13 );
	
class Wakka 
{
	/*:::::*/
	function &parse( &$pageInfoTb, $page, &$text )
	{
		$tokensTb = array( );
		
		$offs = 0;
		$len = strlen( $text );
		
		$i = 0;
		while( $offs < $len )
		{
			$matches = preg_match( WK_PATTERN, 
								   $text, 
								   $matchesTb, 
								   PREG_OFFSET_CAPTURE, 
								   $offs );
			if( $matches == 0 )
			{
				$tokensTb[$i]['id'] = WK_TOKEN_TEXT;
				$tokensTb[$i]['text'] = substr( $text, $offs );
				++$i;
				break;
			}
			
			$mtext =& $matchesTb[0][0];
			$moffs =& $matchesTb[0][1];
		
			if( $moffs > $offs )
			{
				$tokensTb[$i]['id'] = WK_TOKEN_TEXT;
				$tokensTb[$i]['text'] = substr( $text, $offs, $moffs - $offs );
				++$i;
			}
		
			Wakka::_parseToken( $pageInfoTb, 
								$page, 
								$mtext, 
								$tokensTb[$i] );
			++$i;
		
			$offs = $moffs + strlen( $mtext );
		}
		
		return $tokensTb;
	}
	
	/*:::::*/
	function _parseToken( &$pageInfoTb, &$page, &$text, &$token )
	{
		switch( $text )
		{
		case '<':
			$token['id'] = WK_TOKEN_LT;
			return;

		case '>':
			$token['id'] = WK_TOKEN_GT;
			return;
			
		case '<<':
			$token['id'] = WK_TOKEN_BOXLEFT;
			return;

		case '>>':
			$token['id'] = WK_TOKEN_BOXRIGHT;
			return;
			
		case '::c::':
			$token['id'] = WK_TOKEN_CLEAR;
			return;
	
		case '#%':
			$token['id'] = WK_TOKEN_KBD;
			return;
	
		case '==':
		case '**':
			$token['id'] = WK_TOKEN_BOLD;
			return;

		case '//':
			$token['id'] = WK_TOKEN_ITALIC;
			return;
	
		case '__':
			$token['id'] = WK_TOKEN_UNDERLINE;
			return;
	
		case '##':
			$token['id'] = WK_TOKEN_MONOSPACE;
			return;
	
		case "''":
			$token['id'] = WK_TOKEN_NOTES;
			return;
	
		case '++':
			$token['id'] = WK_TOKEN_STRIKE;
			return;
	
		case '@@':
			$token['id'] = WK_TOKEN_CENTER;
			return;
	
		case '===':
		case '====':
		case '=====':
		case '======':
			$token['id'] = WK_TOKEN_HEADER;
			return;
		
		case '---':
			$token['id'] = WK_TOKEN_FORCENL;
			return;
		
		case '----':
			$token['id'] = WK_TOKEN_HORZLINE;
			return;

		case "\n":
			$token['id'] = WK_TOKEN_NEWLINE;
			return;
		}
		
		// code?
		if( preg_match( '/^%%(.*?)%%$/s', $text, $matchesTb ) )
		{
			if( substr( $matchesTb[1], 0, 8 ) == '(qbasic)' )
			{
				$token['id'] = WK_TOKEN_CODE;
				$token['text'] = substr( $matchesTb[1], 8 );
			}
			else
			{
				$token['id'] = WK_TOKEN_PRE;
				$token['text'] = $matchesTb[1];
			}
			return;
		}
	
		// raw?
		if( preg_match( '/\"\"(.*?)\"\"/', $text, $matchesTb ) )
		{
			$token['id'] = WK_TOKEN_TEXT;
			$token['text'] = $matchesTb[1];
			return;
		}
		
		// link?
		if( preg_match( '/^\[\[(\S*)(\s+(.+))?\]\]$/s', $text, $matchesTb ) )
		{
			$token['id'] = WK_TOKEN_LINK;
			$token['url']  = $matchesTb[1];
			$token['text'] = trim( $matchesTb[2] );
			
			if( substr( $token['url'], 0, 5 ) == 'KeyPg' )
				$token['text'] = ucfirst( strtolower( $token['text'] ) );

			$pg =& $token['url'];
			if( strpos( $pg, ':' ) === false )
				if( !isset( $pageInfoTb[$pg]['emitted'] ) )
				{
					$pageInfoTb[$pg]['emitted'] = 0;
					$pageInfoTb[$pg]['title'] = $token['text'];
				}
			
			return;
		}
		
		// action?
		if( preg_match( '/^\{\{(.*?)\}\}$/s', $text, $matchesTb ) )
		{
			if( $matchesTb[1] )
			{
				$token['id'] = WK_TOKEN_ACTION;
				preg_match( '/([a-zA-Z0-9_]+)[\t ]+(.*?$)/', $matchesTb[1], $matchesTb );
				$token['name'] = $matchesTb[1];
				$token['paramsTb'] = Wakka::_getActionParams( $matchesTb[2] );
				Wakka::_checkAction( $pageInfoTb, $page, $token );
			}
			else
			{
				$token['id'] = WK_TOKEN_TEXT;
				$token['text']  = '{{}}';
			}
			
			return;
		}
	
		// indent?
		if( preg_match( '/^([\t|\~]+)((-|&|[0-9a-zA-Z]+\))?)/s', $text, $matchesTb ) )
		{			
			$level = strlen( $matchesTb[1] );
			
			if( ($matchesTb[1]{0} == '~') || (strlen( $matchesTb[2] ) == 0) ) 
			{
				$token['id'] = WK_TOKEN_INDENT;
				$token['level'] = $level;
			}
			else
			{
				$token['id'] = WK_TOKEN_LIST;
				$token['level'] = $level;
			}
				
			return;
		}	
		
		// text..
		$token['id'] = WK_TOKEN_TEXT;
		$token['text'] = $text;
	}
	
	/*:::::*/
	function &_getActionParams( &$text )
	{
		$matches = preg_match_all( '/([a-zA-Z]+)[ \t]*\=[ \t]*\"(.*?)\"/', $text, $matchesTb );
		
		$paramsTb = array( );
		
		if( $matches > 0 )
			for( $i = 0; $i < $matches; $i++ )
				$paramsTb[$matchesTb[1][$i]] = $matchesTb[2][$i];
		
		return $paramsTb;
	}
	
	/*:::::*/
	function &_checkAction( &$pageInfoTb, &$page, &$token )
	{
		if( $token['name'] == 'fbdoc' )
		{
			$value =& $token['paramsTb']['value'];
			switch( $token['paramsTb']['item'] )
			{
			case 'title':
				if( substr( $page, 0, 5 ) == 'KeyPg' )
					$value = ucfirst( strtolower( trim( $value ) ) );
				
				$pageInfoTb[$page]['title'] = $value;
				break;
			
			case 'keyword':
				list( $pg, $title ) = explode( '|', $value );
				if( !isset( $pageInfoTb[$pg]['emitted'] ) )
				{
					if( substr( $g, 0, 5 ) == 'KeyPg' )
						$title = ucfirst( strtolower( trim( $title ) ) );

					$pageInfoTb[$pg]['emitted'] = 0;
					$pageInfoTb[$pg]['title'] = $title;
				}
				break;
			}
		}
	}

}

class Wakka2Html
{
	var $urlbase = '';
	var $indentbase = 0;
	var $tagFlags = array( );
	var $cssClassTb = array( );
	var $tagGenTb = array( );
	var $page;
	
	/*:::::*/
	function Wakka2Html( $urlbase = '', $indentbase = 0 )
	{
		if( strlen( $urlbase ) > 0 )
			if( substr( $urlbase, -1 ) != '/' )
				$urlbase .= '/';

		$this->urlbase = $urlbase;
		$this->indentbase = $indentbase;
		$this->cssClassTb = array_fill( 0, WK_TOKENS, '' );
		$this->tagGenTb = array_fill( 0, WK_TOKENS, true );
	}
	
	/*:::::*/
	function setUrlBase( $value )
	{
		$this->urlbase = $value;
	}

	/*:::::*/
	function setIndentBase( $value )
	{
		$this->indentbase = $value;
	}
	
	/*:::::*/
	function setCssClass( $token, $value )
	{
		$this->cssClassTb[$token] = $value;
	}

	/*:::::*/
	function setTagDoGen( $token, $value )
	{
		$this->tagGenTb[$token] = $value;
	}
	
	/*:::::*/
	function &gen( $page, &$tokensTb )
	{
		$this->page = $page;
		$this->tagFlags = array_fill( 0, WK_TAGS, 0 );
		
		$text = '';
		
		foreach( $tokensTb as $token )
			$text .= $this->_tokenToHtml( $token );
		
		return $this->_closeTags( $text );
	}

	/*:::::*/
	function &_closeTags( &$text )
	{
		if( $this->tagFlags[WK_TAG_BOLD] & 1 )
		{
			--$this->tagFlags[WK_TAG_BOLD];
			$text .= '</b>';
		}
		
		if( $this->tagFlags[WK_TAG_ITALIC] & 1 )
		{
			--$this->tagFlags[WK_TAG_ITALIC];
			$text .= '</i>';
		}
		
		if( $this->tagFlags[WK_TAG_UNDERLINE] & 1 )
		{
			--$this->tagFlags[WK_TAG_UNDERLINE];
			$text .= '</u>';
		}
		
		if( $this->tagFlags[WK_TAG_MONOSPACE] & 1 )
		{
			--$this->tagFlags[WK_TAG_MONOSPACE];
			$text .= '</tt>';
		}
		
		if( $this->tagFlags[WK_TAG_NOTES] & 1 )
		{
			--$this->tagFlags[WK_TAG_NOTES];
			$text .= '</span>';
		}
		
		if( $this->tagFlags[WK_TAG_STRIKE] & 1 )
		{
			--$this->tagFlags[WK_TAG_STRIKE];
			$text .= '</strike>';
		}
		
		if( $this->tagFlags[WK_TAG_KEYS] & 1 )
		{
			--$this->tagFlags[WK_TAG_KEYS];
			$text .= '</kbd>';
		}
		
		if( $this->tagFlags[WK_TAG_CENTER] & 1 )
		{
			--$this->tagFlags[WK_TAG_CENTER];
			$text .= '</div>';
		}
		
		if( $this->tagFlags[WK_TAG_HEADER] & 1 )
		{
			--$this->tagFlags[WK_TAG_HEADER];
			$text .= '</div>';
		}

		while( $this->tagFlags[WK_TAG_LEVEL] > 0 )
		{
			--$this->tagFlags[WK_TAG_LEVEL];
			$text .= '</ul>';
		}

		if( $this->tagFlags[WK_TAG_BOXLEFT] & 1 )
		{
			--$this->tagFlags[WK_TAG_BOXLEFT];
			$text .= '</td>';

			if( !($this->tagFlags[WK_TAG_BOXRIGHT] & 1) )
				$text .= '</tr></table>';	
		}
		
		if( $this->tagFlags[WK_TAG_BOXRIGHT] & 1 )
		{
			--$this->tagFlags[WK_TAG_BOXRIGHT];
			$text .= '</td></tr></table>';
		}
		
		if( $this->tagFlags[WK_TAG_SECTION] != 0 )
		{
			$this->tagFlags[WK_TAG_SECTION] = 0;
			$text .= '</div>';
		}
			
		return preg_replace( '/^\s*(\<br \/\>)+|(\<br \/\>)+\s*$/', '', $text );
	}

	/*:::::*/
	function &_codeToHtml( &$text )
	{
		static $geshi = NULL;
		
		if( $geshi == NULL )
		{
			$geshi = new GeSHi( '', 'qbasic', 'geshi/geshi/' );
			$geshi->set_header_type( GESHI_HEADER_DIV );
			$geshi->enable_classes( true );
		}
		
		$geshi->set_source( preg_replace( '/^\s*\n+|\n+\s*$/', '', $text ) );
		
		return $geshi->parse_code( );
	}

	/*:::::*/
	function &_actionGenFbDoc( &$paramsTb )
	{
		static $itemTB = array( 'category' 	=> array( false, '{#fb_sect_cat}'	), 
					 			'keyword' 	=> array( false, '{#fb_sect_key}'	), 
					 			'title' 	=> array( false, '{#fb_sect_title}'	), 
					 			'syntax' 	=> array( true , '{#fb_sect_syntax}'), 
					 			'usage' 	=> array( true , '{#fb_sect_usage}' ), 
					 			'param' 	=> array( true , '{#fb_sect_param}' ), 
					 			'ret' 		=> array( true , '{#fb_sect_ret}'   ), 
					 			'desc' 		=> array( true , '{#fb_sect_desc}'  ), 
					 			'ex' 		=> array( true , '{#fb_sect_ex}'    ), 
					 			'diff' 		=> array( true , '{#fb_sect_diff}'  ),
					 			'see' 		=> array( true , '{#fb_sect_see}'   ), 
					 			'back' 		=> array( false, '{#fb_sect_back}'  ), 
					 			'close'		=> array( false, '{#fb_sect_close}' ) 
					 		  );
		
		if( isset( $paramsTb['item'] ) )
			$item =& $paramsTb['item'];
		else
			$item = '';
		
		if( isset( $paramsTb['value'] ) )
			$value =& $paramsTb['value'];
		else
			$value = '';
		
		$isblock =& $itemTB[$item][0];
		$res = '';
		if( $isblock )
		{
			$this->_closeTags( $res );
			$this->tagFlags[WK_TAG_SECTION] = 1;
		}
				
		switch( $item )
		{
		case 'title':
			if( $this->tagGenTb[WK_TOKEN_SECT_ITEM] )
				return $res . '<div class="fb_header">' . ucfirst( strtolower( trim( $value ) ) ) . '</div>';
			else
				return $res;
	
		case 'section':			
			return $res . '<b><u>' . $value . '</u></b>';

		case 'subsect':			
			return $res . '<b>' . $value . '</b>';
	
		case 'category':
			list( $page, $name ) = explode( '|', $value );
			
			return $res . "<a name=\"#cat_$page\"></a><b>$name:</b>";
			
		case 'keyword':
			list( $page, $name ) = explode( '|', $value );
			
			if( strpos( $page, ':' ) === false )
			{
				if( substr( $page, 0, 5 ) == 'KeyPg' )
					$name = ucfirst( strtolower( trim( $name ) ) );
				$ext = '.html';
			}
			else
				$ext = '';
			
			return $res . '<a href="' . $this->urlbase . $page . $ext . '">' . $name . '</a>';
		
		case 'back':
			if( $this->tagGenTb[WK_TOKEN_SECT_ITEM] )
			{
				list( $page, $name ) = explode( '|', $value );
				
				return $res . "<div align=\"center\">{#fb_sect_back} <a href=\"" . 
					   $this->urlbase . $page . "\">$name</a></div>";
			}
			else
				return $res;
	
		case 'close':
			if( $this->tagFlags[WK_TAG_SECTION] != 0  )
			{
				$this->tagFlags[WK_TAG_SECTION] = 0;
				$res = '</div>';
			}
			else
				$res = '';
			
			return $res;

		default:			
			$value =& $itemTB[$item][1];
			return $res . '<div class="fb_sect_title">' . $value . 
						  '</div><div class="fb_sect_cont">';
		}
	}
	
	/*:::::*/
	function &_actionGenTable( &$paramsTb )
	{
		$res = $this->_closeList( );
		
		$cellTb = explode( ';', $paramsTb['cells'] );
				
		$res .= '<div class="' . $this->cssClassTb[WK_TOKEN_ACTION_TB] . '"><table>';
			
		if( isset( $paramsTb['columns'] ) )
			$cols = (int)$paramsTb['columns'];
		else
		$cols = 1;
				
		$col = 1;
		foreach( $cellTb as $cell )
			{
			if ($col == 1) 
				$res .= "<tr>";
			if( $cell == '###' ) 
				$cell = '&nbsp;';
					
			$res .= '<td>' . $cell . '</td>';
					
			++$col;
					
			if( $col > $cols )
			{
				$col = 1;
				$res .= '</tr>';
			}
		}
	
		$res .= '</table></div>';
			
		return $res;
	}

	/*:::::*/
	function &_actionGenImage( &$paramsTb )
	{
		/*if( isset( $paramsTb['class'] ) )
			$class = $paramsTb['class'];
		else*/
			$class = $this->cssClassTb[WK_TOKEN_ACTION_IMG];
			
		$res = '<div class="' . $class . '"><img';
						
		if( isset( $paramsTb['alt'] ) )
			$res .= ' alt="' . $paramsTb['alt'] . '"';

		if( isset( $paramsTb['url'] ) )
			$res .= ' src="' . $paramsTb['url'] . '"';
			
		return $res . ' /></div>';
	}

	/*:::::*/
	function &_actionGenAnchor( &$paramsTb )
	{
		$res = $this->_closeList( );
		
		$name =& $paramsTb['name'];

		if( strpos( $name, '|' ) === false )
			return $res . '<a name="' . $name . '"></a>';

		list( $target, $link ) = explode( '|', $name );
		return $res . '<a href="#' . $target . '">' . $link . '</a>';
	}

	/*:::::*/
	function &_actionToHtml( &$name, &$paramsTb )
	{
		switch( $name )
		{
		case 'fbdoc':
			return $this->_actionGenFbDoc( $paramsTb );
			break;
		
		case 'table':
			return $this->_actionGenTable( $paramsTb );

		case 'image':
			return $this->_actionGenImage( $paramsTb );

		case 'anchor':
			return $this->_actionGenAnchor( $paramsTb );
			
		default:
			return '';
		}
	}
	
	/*:::::*/
	function &_linkToHtml( $url, $text )
	{		
		if( $url == NULL )
			return '';
			
		if( !$text ) 
			$text = $url;

		if( strpos( $url, ':' ) === false )
			$ext = '.html';
		else
			$ext = '';

		return '<a href="' . $this->urlbase . $url . $ext . '">' . $text . '</a>';
	}

	/*:::::*/
	function &_listToHtml( $level )
	{
		$res = '';
			
		while( $level > $this->tagFlags[WK_TAG_LEVEL] )
		{			
			$res .= '<ul>';
			++$this->tagFlags[WK_TAG_LEVEL];
		}
	
		while( $level < $this->tagFlags[WK_TAG_LEVEL] )
		{
			$res .= '</ul>';
			--$this->tagFlags[WK_TAG_LEVEL];
		}
		
		$res .= '<li>';
			
		return $res;
	}
	
	/*:::::*/
	function &_closeList( )		
	{
		$text = '';
		
		while( $this->tagFlags[WK_TAG_LEVEL] > 0 )
		{
			$text .= '</ul>';
			--$this->tagFlags[WK_TAG_LEVEL];
		}
		
		return $text;
	}

	/*:::::*/
	function &_tokenToHtml( &$token )
	{
		static $nlcnt = 0, $skipnl = false;
		
		$type =& $token['id'];
		
		if( $type == WK_TOKEN_NEWLINE )
		{
			if( $this->tagFlags[WK_TAG_LEVEL] > 0 )
			{
				if( $nlcnt > 0 )
				{
					--$this->tagFlags[WK_TAG_LEVEL];
					$nlcnt = 0;
					$skipnl = true;
					return "</ul>\n";
				}
			}
			
			$res = '';
			if( !$skipnl )
			{
				++$nlcnt;
				if( $nlcnt < 3 )
					$res = "<br />\n";
				else
					$nlcnt = 0;	
			}
			else
			{
				$skipnl = false;
				$nlcnt = 0;
			}
			
			return $res;
		}

		$nlcnt = 0;
		$skipnl = false;

		$cssclass = $this->cssClassTb[$type];
		if( strlen( $cssclass ) > 0 )
			$cssclass = 'class="' . $cssclass . '"';
			
		$dogen =& $this->tagGenTb[$type];
		
		switch( $type )
		{
		case WK_TOKEN_NULL:
			return '';

		case WK_TOKEN_LT:
			return '&lt;';
		
		case WK_TOKEN_GT:
			return '&gt;';
			
		case WK_TOKEN_KBD:
			return ( ++$this->tagFlags[WK_TAG_KEYS] & 1 ? '<kbd ' . $cssclass . '>' : '</kbd>' );
	
		case WK_TOKEN_BOLD:
			return ( ++$this->tagFlags[WK_TAG_BOLD] & 1 ? '<b>' : '</b>' );
	
		case WK_TOKEN_ITALIC:
			return ( ++$this->tagFlags[WK_TAG_ITALIC] & 1 ? '<i>' : '</i>' );
	
		case WK_TOKEN_UNDERLINE:
			return ( ++$this->tagFlags[WK_TAG_UNDERLINE] & 1 ? '<u>' : '</u>' );
	
		case WK_TOKEN_MONOSPACE:
			return ( ++$this->tagFlags[WK_TAG_MONOSPACE] & 1 ? '<tt>' : '</tt>' );
	
		case WK_TOKEN_NOTES:
			return ( ++$this->tagFlags[WK_TAG_NOTES] & 1 ? '<span '.  $cssclass . '>' : '</span>' );
	
		case WK_TOKEN_STRIKE:
			return ( ++$this->tagFlags[WK_TAG_STRIKE] & 1 ? '<strike>' : '</strike>' );
	
		case WK_TOKEN_CENTER:
			return ( ++$this->tagFlags[WK_TAG_CENTER] & 1 ? '<div style="text-align: center;">' : '</div>' );
	
		case WK_TOKEN_LINK:
			return $this->_linkToHtml( $token['url'], $token['text'] );
	
		case WK_TOKEN_LIST:
			$skipnl = true;
			return $this->_listToHtml( $token['level'] );

		case WK_TOKEN_TEXT:
			return $token['text'];

		case WK_TOKEN_ACTION:
			return $this->_actionToHtml( $token['name'], $token['paramsTb'] );
		}
		
		$skipnl = true;
		
		//
		$res = $this->_closeList( );
		
		switch( $type )
		{
		case WK_TOKEN_FORCENL:
			return $res . '<br />';
			
		case WK_TOKEN_HORZLINE:
			if( $dogen ) 
				return $res . '<hr ' . $cssclass . ' />';
			else
				return $res;

		case WK_TOKEN_BOXLEFT:
			if( ++$this->tagFlags[WK_TAG_BOXLEFT] & 1 )
				return $res . '<table ' . $cssclass . '><tr><td>';
			else
				return $res . '</td>';
	
		case WK_TOKEN_BOXRIGHT:
			if( $this->tagFlags[WK_TAG_BOXLEFT] & 1 ) 
				return $res . '</td></tr></table>';

			if( ++$this->tagFlags[WK_TAG_BOXRIGHT] & 1 ) 
				return $res . '<td>';
			else
				return $res . '</td></tr></table>';
			
		case WK_TOKEN_CLEAR:
			return $res . '<div style="clear:both">&nbsp;</div>';
	
		case WK_TOKEN_HEADER:
			$skipnl = false;
			return $res . ( ++$this->tagFlags[WK_TAG_HEADER] & 1 ? '<div ' . $cssclass . '>' : '</div>' );
		
		case WK_TOKEN_PRE:
			return $res . '<pre ' . $cssclass . '>' . $token['text'] . '</pre>';
		
		case WK_TOKEN_CODE:
			return $res . $this->_codeToHtml( $token['text'] );
		
		case WK_TOKEN_INDENT:
			$skipnl = false;
			return $res . str_repeat( '&nbsp; ', ($token['level'] - $this->indentbase) * 2 );
		}
		
	}
	
}

?>