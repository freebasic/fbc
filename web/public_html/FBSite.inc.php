<?php

//
// copyleft 2004-2006 Andre Victor T. Vicentini (av1ctor[at]yahoo.com.br)
//

	//
	// definitions
	//
	define( 'FB_PAGES_PATH'			, 'pages/' );
	define( 'FB_SHOTS_PATH'			, '../images/' );
	define( 'FB_TPL_DEFAULT'		, '/b_on_w' );
	define( 'FB_TPL_PREFIX'			, '/page.' );
	define( 'FB_TPL_EXT'			, '.tpl.html' );
	define( 'FB_LANG_DEFAULT'		, 'en' );
	define( 'FB_RE_EXCLUDE'			, '/(\'|\"|\#|\(|\)|\<|\>)/' );

	$fb_langTb 				 = array( 'ar' => array( 'ar_SA', 'en', 'utf-8' ),
									  'br' => array( 'pt_BR', 'en', 'iso-8859-1' ),
									  'de' => array( 'de'   , 'en', 'iso-8859-1' ),
									  'en' => array( 'en_US', 'en', 'iso-8859-1' ),
									  'es' => array( 'es'   , 'es', 'iso-8859-1' ),
									  'fr' => array( 'fr'   , 'en', 'iso-8859-1' ),
									  'ru' => array( 'ru_RU', 'en', 'utf-8' )
									);

    define( 'FB_ROOT'				, dirname( __FILE__ ) );

    //
    // include files
    //
	define( 'WACT_ERROR_FACTORY', 'FBSite.inc.php' );

	require_once( FB_ROOT . '/../wact/framework/common.inc.php' );

	define( 'TMPL_FILESCHEME_PATH', WACT_ROOT . 'template/fileschemes/multilang/' );

	require_once( WACT_ROOT . 'controller/pathinfo.inc.php' );

	require_once( 'magpierss/rss_fetch.inc' );


//
function RaiseErrorHandler($group, $id, $info=NULL)
{
	$url = FBSite::getCtrlPath( ) . '/error';

	header('Location: ' . $url );
	die( '<html><head><meta http-equiv="refresh" content="url=' .
		  $url .
		  '; 0">' . '</head></html>' );
}

//
//
//
class FBSite
{
	//
	function _pageToHandleArg( $page )
	{
		if( strpos( $page, '|' ) === false )
			return FB_PAGES_PATH . $page . '.page.php|PageCtrl';

		list( , $pagename, $classname ) = explode( '|', $page );

		return FB_PAGES_PATH . $pagename . '.page.php|' . $classname;
	}

	//
	function startController( &$pages )
	{
		$ctrl =& new PathInfoDispatchController( );

		foreach( $pages as $page )
		{
			$hnd =& new Handle( FBSite::_pageToHandleArg( $page ) );

			if( strpos( $page, '|' ) !== false )
				list( $page, , ) = explode( '|', $page );

			$ctrl->addChild( $page, $hnd );
		}

		$page = $pages[0];
		if( strpos( $page, '|' ) !== false )
			list( $page, , ) = explode( '|', $page );

		$ctrl->setDefaultChild( $page );

		$ctrl->start();

		return TRUE;
	}

	//
	function getCtrlPath( )
	{
		static $path = NULL;

		if( $path == NULL )
		{
			$ctrl =& $_SERVER['SCRIPT_NAME'];

			$p = strpos( $ctrl, '.php/' );
			if( $p === FALSE )
				$path = $ctrl;
            else
				$path = substr( $ctrl, 0, $p+4 );
		}

		return $path;
	}

	//
	function getTplPath( )
	{
		return FB_TPL_DEFAULT;
	}

	//
	function getFullLangPath( )
	{
		static $path = NULL;

		if( $path == NULL )
			$path = GetLanguagePath( );

		return $path;
	}

	//
	function getFullTplPath( )
	{
		static $path = NULL;

		if( $path == NULL )
			$path = GetTemplatesPath( ) . FBSite::getTplPath( );

		return $path;
	}

	//
	function getRelTplPath( )
	{
		static $path = NULL;

		if( $path == NULL )
		{
			$path = 'templates/source/templates' . FBSite::getTplPath( );
			if( strpos( $_SERVER['REQUEST_URI'], '.php/' ) !== FALSE )
				$path = '../' . $path;
		}

		return $path;

	}

	//
	function getRelImgPath( )
	{
		static $path = NULL;

		if( $path == NULL )
			$path = FBSite::getRelTplPath( ) . '/images';

		return $path;
	}

	//
	function getTplName( $pagename )
	{
		return FBSite::getTplPath( ) . FB_TPL_PREFIX . $pagename . FB_TPL_EXT;
	}

	//
	function &getLangTb( )
	{
		global $fb_langTb;

		return $fb_langTb;
	}

	//
	function getLastCtrl( )
	{
		if( isset( $_SESSION['fb_lastctrl'] ) )
			return $_SESSION['fb_lastctrl'];
		else
			return NULL;
	}

	//
	function setLastCtrl( $ctrl )
	{
		$_SESSION['fb_lastctrl'] = $ctrl;
	}

	//
	function validate( $name )
	{
		if( preg_match( '/[a-zA-Z0-9_]+/', $name, $matches ) == 0 )
			return FALSE;

		return ($matches[0] == $name? TRUE: FALSE);
	}


	//
	function initLanguage( &$local, &$pglang, &$dblang, &$charset )
	{
		global $fb_langTb;

		if( isset( $_SESSION['fb_lang'] ) )
			$pglang = $_SESSION['fb_lang'];
		else
			$pglang = FB_LANG_DEFAULT;

		if( !isset( $fb_langTb[$pglang] ) )
			$pglang = FB_LANG_DEFAULT;

		$local = $fb_langTb[$pglang][0];
		$dblang = $fb_langTb[$pglang][1];
		$charset = $fb_langTb[$pglang][2];

		setlocale( LC_ALL, $local );
		$GLOBALS['CurrentLanguage'] = $pglang;
	}

	//
	function setLanguage( $lang )
	{
		global $fb_langTb;

		if( !isset( $fb_langTb[$lang] ) )
			$lang = FB_LANG_DEFAULT;

		$_SESSION['fb_lang'] = $lang;
	}

	//
	function renderImgLink( $link, $imgpath )
	{
		return '<a href="' . $link . '" title="' . $link . '"><img border="0" src="' .
			   $imgpath . '/button_dl.gif" width="18" height="18"></a>';
	}

	//
	function renderDynImgLink( $link, $attrib, $imgpath )
	{
		return FBSite::renderImgLink( str_replace( '{name}', $link, $attrib ), $imgpath );
	}

	//
	function renderDetailsLink( $pagename, $catname, $id, $text )
	{
		return '<a class="detail_link" href="' .
				FBSite::getCtrlPath( ) . '/details?page=' . $pagename .
			   '&category=' . $catname .
			   '&id=' . $id . '">' . $text . '</a>';
	}

	//
	function renderUrlLink( $link, $text )
	{
		return '<a class="ord_link" href="' . $link . '">' . $text . '</a>';
	}

	//
	function renderDynUrlLink( $link, $text )
	{
		$url = str_replace( '{name}', $link, $text );
		return FBSite::renderUrlLink( $url, $url );
	}

	//
	function renderText( $text, $pagename, $catname, $id, $chars = 55 )
	{
		if( strlen( $text ) <= $chars-5 )
			return $text;

		$text = substr( $text, 0, $chars-5 );

		$p = strrpos( $text, ' ' );
		if( $p != $chars-5 )
			if( $p < $chars-10 )
				substr( $text, 0, $chars-10 );
			else
				$text = substr( $text, 0, $p );

		return $text . ' ' .
			   FBSite::renderDetailsLink( $pagename, $catname, $id, '{...}' );
	}

	//
	function renderList( $text )
	{
		return '<ul>' . str_replace( '>>', '<li>', $text ) . '</ul>';
	}

	//
	function renderTime( $text )
	{
		return date( 'Y-m-d', $text );
	}


	//
	function renderScreenshots( $pagename, $catname, $recid, $shots )
	{
		$shotTb = explode( '|', $shots );

		if( (count( $shotTb ) == 0) || (strlen( $shotTb[0] ) == 0) )
			return '&nbsp;';

		$path = FB_SHOTS_PATH . $pagename . '.' . $catname . '/id_' . $recid . '/';

		$res = '<table align="center" cellpadding="4px" cellspacing="10px">';
		foreach( $shotTb as $shot )
			$res .= '<tr><td class="cat_table"><img border="0" src="' . $path . $shot . '"></td></tr>';
		$res .= '</table>';

		return $res;
	}

	//
	function &initPages( )
	{
		$pagesTb =& parse_ini_file( FBSite::getFullLangPath( ) . '/pages.ini', TRUE );

		return $pagesTb;
	}

	//
	function &initMenu( $pagename )
	{
		$menuTb =& parse_ini_file( FBSite::getFullLangPath( ) . '/menu.ini', TRUE );

		FBSite::_menusel( $menuTb, $pagename );

		return $menuTb;
	}

	//
	function &getRssRecords( $url, $limit )
	{
		$rss =& fetch_rss( $url );

		if( $limit <= 0 )
			$itemTb =& $rss->items;
		else
			$itemTb =& array_slice( $rss->items, 0, $limit );

		foreach( $itemTb as $k => $item )
			$itemTb[$k]['id'] = $k;

		return new FBRecordSet( new ArrayDataSet( $itemTb ) );
	}

	//
	function &getRssRecord( $url, $id )
	{
		$rss =& fetch_rss( $url );

		$itemTb =& $rss->items;

		if( ($id < 0) || ($id >= count( $itemTb )) )
			$id = 0;

		$itemTb[$id]['id'] = $id;

		$ds =& new DataSpace( );
		$ds->import( $itemTb[$id] );

		return $ds;
	}

    //
    function _menusel( &$menuTb, $pagename )
    {
    	foreach( $menuTb as $k => $menu )
    		if( $menu['page'] == $pagename )
    		{
    			$menuTb[$k]['sel'] = 'sel';
    			break;
    		}
    }

	//
	function &getPageI18N( $pagename )
	{
		return parse_ini_file( FBSite::getFullLangPath( ) .
					           '/page.' . $pagename . '.ini', TRUE );
	}

    //
	function &getPageCategories( $pageName )
	{
		return DBC::NewRecordSet( 'SELECT * FROM fb_categorytb WHERE `page`=' .
								  "'" . $pageName . "'" .
								  ' ORDER BY `order`' );
	}

    //
	function &getPageCategory( $pageName, $catName )
	{
		return DBC::FindRecord( 'SELECT * FROM fb_categorytb' .
								' WHERE `page`=' . "'" . $pageName . "'" .
								' AND `name`=' . "'" . $catName . "'" );
	}

    //
	function &getCategoryFields( $catId, $isdetail )
	{
		if( !$isdetail )
			$detailonly = ' AND `detailonly`=0 ';
		else
			$detailonly = '';

		return DBC::getRowArray( 'SELECT * FROM fb_fieldtb' .
								 ' WHERE `category`=' . $catId .
								 $detailonly .
								 ' ORDER BY `column`' );
	}

    //
	function &getCategoryFieldsByName( $pageName, $catName, $isdetail )
	{
		if( $catName == NULL || strlen( $catName ) == 0 )
			return NULL;

		$id = DBC::getOneValue( 'SELECT id FROM fb_categorytb' .
								' WHERE `page`=' . "'" . $pageName . "'" .
								' AND `name`=' . "'" . $catName . "'" );

		if( $id === NULL )
			return NULL;

		return FBSite::getCategoryFields( $id, $isdetail );
	}

    //
	function &getCategoryRecords( $pagename, $catname, $dblang,
								  $order, $isdesc, $limit, $table, $extra )
	{
		if( is_null( $table ) )
			if( substr( $extra, 0, 6 ) == 'rss://' )
				return FBSite::getRssRecords( 'http://' . substr( $extra, 6 ), $limit );

		if( $isdesc )
			$ordmod = ' DESC';
		else
			$ordmod = ' ASC';

		if( $limit > 0 )
			$limmod = ' LIMIT ' . $limit;
		else
			$limmod = '';

		if( is_null( $table ) )
			$table = 'fb_rectb_' . $pagename . '_' . $catname . '_' . $dblang;

		return DBC::NewRecordSet( 'SELECT * FROM ' . $table .
								  ' ' . $extra .
								  ' ORDER BY `' . $order . '`' . $ordmod .
								  $limmod );
	}

    //
	function &getCategoryRecord( $pagename, $catname, $dblang, $recid,
								  $table, $idfield, $extra )
	{
		if( is_null( $table ) )
			if( substr( $extra, 0, 6 ) == 'rss://' )
				return FBSite::getRssRecord( 'http://' . substr( $extra, 6 ), $recid );

		if( is_null( $table ) )
			$table = 'fb_rectb_' . $pagename . '_' . $catname . '_' . $dblang;

		if( is_null( $idfield ) )
			$idfield = 'id';

		return DBC::FindRecord( 'SELECT * FROM ' . $table .
								' WHERE `'. $idfield . '`=' . "'" . $recid . "'" );
	}

	//
	function &prepareEmail( &$email )
	{
		static $atTb = array( '[-at-]', '[*at*]', '[.at.]', '[_at_]',
						  	  '(-at-)', '(*at*)', '(.at.)', '(_at_)' );

		static $dtTb = array( '[-dot-]', '[*dot*]', '[.dot.]', '[_dot_]',
						  	  '(-dot-)', '(*dot*)', '(.dot.)', '(_dot_)' );

		static $started = FALSE;

		if( $started == FALSE )
		{
			$started = TRUE;
			srand( time( ) );
		}

		$i = rand(0, 7);

		return str_replace( '@',
        					$atTb[$i],
        					str_replace( '.',
        					 		 	 $dtTb[$i],
        					 		 	 $email ) );
	}
}

	define( 'FBUSER_TABLE', 'phpbb_users' );
	define( 'FBUSER_BANTABLE', 'phpbb_banlist' );
	define( 'FBUSER_FIELDS', 'user_id,username,user_password,user_level' );

//
//
//
class FBUser
{
    //
    function &_field( $name, $default )
    {
    	static $fieldTb = array( );

    	if( !isset( $fieldTb[$name] ) )
    		$fieldTb[$name] = $default;

    	return $fieldTb[$name];
    }

    //
	function _getId( )
	{
		$id =& FBUser::_field( 'id', -1 );

		if( $id == -1 )
		{
			if( isset( $_COOKIE['FBSite_userId'] ) )
			{
				if( isset( $_COOKIE['FBSite_userHash'] ) )
					$id = (int)$_COOKIE['FBSite_userId'];
			}
		}

		return $id;
	}

    //
	function _getHash( )
	{
		$hash =& FBUser::_field( 'hash', '' );

		if( $hash == '' )
		{
			if( isset( $_COOKIE['FBSite_userHash'] ) )
			{
				$hash = $_COOKIE['FBSite_userHash'];
				if( !FBSite::validate( $hash ) )
					$hash = '';
			}
		}

		return $hash;
	}

	//
	function _setId( $new_id, $new_hash )
	{
		$expire = mktime(0, 0, 0, 12, 31, 2010);

		if( $newid != -1 )
		{
			setcookie( 'FBSite_userId', $new_id, $expire, '/' );

			$new_hash = md5( $new_hash );
			setcookie( 'FBSite_userHash', $new_hash, $expire, '/' );
		}
		else
		{
			if( isset( $_COOKIE['FBSite_userId'] ) )
				unset( $_COOKIE['FBSite_userId'] );

			if( isset( $_COOKIE['FBSite_userHash'] ) )
				unset( $_COOKIE['FBSite_userHash'] );

			setcookie( 'FBSite_userId', '', $expire, '/' );
			setcookie( 'FBSite_userHash', '', $expire, '/' );
		}

		$id =& FBUser::_field( 'id', -1 );
		$id = $new_id;

		$hash =& FBUser::_field( 'hash', '' );
		$hash = $new_hash;
	}

	//
	function &_getData( )
	{
		$data =& FBUser::_field( 'data', NULL );

		if( $data == NULL )
		{
			$id = FBUser::_getId( );
			if( $id == -1 )
				return NULL;

			$hash = FBUser::_getHash( );
			if( $hash == '' )
				return NULL;

			$row = DBC::getRowArray( 'SELECT ' . FBUSER_FIELDS . ' FROM ' . FBUSER_TABLE .
								 	 ' WHERE user_id=\'' . $id . '\'' );

			if( count( $row ) == 0 )
				return NULL;

			if( $hash != md5( $row[0]['user_password'] ) )
				return NULL;

			$data = $row[0];
		}

		return $data;
	}

	//
	function _setData( $newdata )
	{
		$data =& FBUser::_field( 'data', NULL );
		$data = $newdata;
	}

    //
    function login( $name, $pwd )
    {
		$row = DBC::getRowArray( 'SELECT ' . FBUSER_FIELDS . ' FROM ' . FBUSER_TABLE .
							 	 ' WHERE username=\'' . $name . '\' AND user_password=\'' .
							 	 md5( $pwd ) . '\'' );

		if( count( $row ) == 0 )
			return FALSE;

		$id = (int)$row[0]['user_id'];

		// banned?
		if( DBC::getOneValue( 'SELECT ban_userid FROM ' . FBUSER_BANTABLE .
						  	  ' WHERE ban_userid=\'' . $id . '\'' ) != NULL )
			return FALSE;

		//
		FBUser::_setId( $id, $row[0]['user_password'] );
        FBUser::_setData( $row[0] );

		return TRUE;
    }

    //
    function logout( )
    {
    	FBUser::_setId( -1, '' );
    	FBUser::_setData( NULL );
    }

	//
	function getId( )
	{
		$id = FBUser::_getId( );
		if( $id == -1 )
			return -1;

        $data =& FBUser::_getData( );
    	return ($data != NULL? $id : -1 );
	}

	//
	function isAdmin( )
	{
        $data =& FBUser::_getData( );
    	if( $data == NULL )
    		return FALSE;

    	return ($data['user_level'] == 1);
	}

	//
	function isLogged( )
	{
		if( FBUser::_getId( ) == -1 )
			return FALSE;

        $data =& FBUser::_getData( );
    	return $data != NULL;
	}

	//
	function getName( )
	{
        $data =& FBUser::_getData( );
    	if( $data == NULL )
    		return NULL;

    	return $data['username'];
	}

}

//
//
//
	require_once( WACT_ROOT . 'view/view.inc.php' );

	require_once( WACT_ROOT . 'view/redirect.inc.php' );

	require_once( WACT_ROOT . 'util/arraydataset.inc.php' );

	require_once( TMPL_FILESCHEME_PATH . '/compilersupport.inc.php' );

	require_once( 'FBRecordSet.inc.php' );

class FBView extends View
{
    var $_local;
    var $_pglang;
    var $_dblang;
    var $_charset;
    var $_menuTb;
    var $_pageName;
    var $_pagesTb;
    var $_lastCtrl;

    //
	function FBView( $pagename, $ctrlname = NULL )
	{
		$this->_pageName = $pagename;

		// choose the lang
		FBSite::initLanguage( $this->_local, $this->_pglang, $this->_dblang, $this->_charset );

		$this->_pagesTb =& FBSite::initPages( );

		$this->_lastCtrl = FBSite::getLastCtrl( );

		if( $ctrlname == NULL )
			$ctrlname = $pagename;
		FBSite::setLastCtrl( $ctrlname );

		$this->_menuTb =& FBSite::initMenu( $pagename );

		parent::View( FBSite::getTplName( $pagename ) );
	}

    //
    function getPgLang( )
    {
    	return $this->_pglang;
    }

    //
    function getDbLang( )
    {
    	return $this->_dblang;
    }

    //
    function prepare( &$controller, &$request, &$responseModel )
    {
        // paths to be used in the templates
        $this->Template->set( 'imgpath', FBSite::getRelImgPath( ) );
        $this->Template->set( 'ctrlpath', FBSite::getCtrlPath( ) );
        $this->Template->set( 'lastctrl', $this->_lastCtrl );

		// charset
		$this->Template->set( 'page_lang', $this->_pglang );
		$this->Template->set( 'page_charset', $this->_charset );

        // the menu list
        $ds =& new ArrayDataSet( $this->_menuTb );
        $this->Template->setChildDataSource( 'menuList', $ds );

        // title
        if( isset( $this->_pagesTb[$this->_pageName] ) )
        	$title = $this->_pagesTb[$this->_pageName]['title'];
        else
        	$title = '';

        $title .= ' [' . $this->_pglang . ']';

        $this->Template->set( 'page_subtitle', $title );
    }
}

//
//
//
class FBCatListView extends FBView
{
    var $_dbpage;

    //
	function FBCatListView( $pagename, $dbpage, $ctrlname = NULL )
	{
		parent::FBView( $pagename, $ctrlname );

		$this->_dbpage = $dbpage;

		parent::View( FBSite::getTplName( $pagename ) );
	}

    //
    function prepare( &$controller, &$request, &$responseModel )
    {
    	parent::prepare( $controller, $request, $responseModel );

        // categories
        $ds =& new FBCategoryRecSet( $this->_dbpage,
        							 $this->_pglang,
        							 $this->_dblang,
        							 $this->Template );
        $this->Template->setChildDataSource( 'categoryList', $ds );
    }
}

//
//
//
class FBDbListView extends FBView
{
    var $_pageName;
    var $_secName;
    var $_recSet;

    //
	function FBDbListView( $pagename, $secname, $ctrlname = NULL )
	{
		parent::FBView( $pagename, $ctrlname );

        $this->_pageName = $pagename;
		$this->_secName  = $secname;

		parent::View( FBSite::getTplName( $pagename ) );
	}

    //
    function prepare( &$controller, &$request, &$responseModel )
    {
    	parent::prepare( $controller, $request, $responseModel );

    	$this->_recSet =& DBC::NewRecordSet( 'SELECT * FROM fb_pagesec_' .
    										 $this->_secName . '_' . $this->_dblang );

        //
        if( is_object( $this->Template->findChild( 'fbHeadList' ) ) )
        	$this->Template->setChildDataSource( 'fbHeadList', $this->_recSet );

        $this->Template->setChildDataSource( 'fbList', $this->_recSet );
  }
}

//
//
//
class FBIniListView extends FBView
{
    var $_pageName;
    var $_iniFile;
    var $_recSet;

    //
	function FBIniListView( $pagename, $inifile, $ctrlname = NULL )
	{
		parent::FBView( $pagename, $ctrlname );

		$this->_pageName = $pagename;
		$this->_iniFile  = $inifile;

		parent::View( FBSite::getTplName( $pagename ) );
	}

    //
    function prepare( &$controller, &$request, &$responseModel )
    {
    	parent::prepare( $controller, $request, $responseModel );

    	//
    	$iniTb =& parse_ini_file( FBSite::getFullLangPath( ) .
    							  '/page.' . $this->_iniFile . '.ini', TRUE );

		$this->_recSet =& new ArrayDataSet( $iniTb );

        if( is_object( $this->Template->findChild( 'fbHeadList' ) ) )
        	$this->Template->setChildDataSource( 'fbHeadList', $this->_recSet );

        $this->Template->setChildDataSource( 'fbList', $this->_recSet );
  }
}


//
//
//
class FBArrayListView extends FBView
{
    var $_pageName;
    var $_arrayTb;
    var $_recSet;

    //
	function FBArrayListView( $pagename, &$arrayTb, $ctrlname = NULL )
	{
		parent::FBView( $pagename, $ctrlname );

		$this->_pageName = $pagename;
		$this->_arrayTb   =& $arrayTb;

		parent::View( FBSite::getTplName( $pagename ) );
	}

    //
    function prepare( &$controller, &$request, &$responseModel )
    {
    	parent::prepare( $controller, $request, $responseModel );

		$this->_recSet =& new ArrayDataSet( $this->_arrayTb );

        if( is_object( $this->Template->findChild( 'fbHeadList' ) ) )
        	$this->Template->setChildDataSource( 'fbHeadList', $this->_recSet );

        $this->Template->setChildDataSource( 'fbList', $this->_recSet );
  }
}

//
//
//
	require_once( WACT_ROOT . 'controller/controller.inc.php' );

	require_once( WACT_ROOT . 'controller/parameter.inc.php' );

class FBPageController extends PageController
{
    //
    function FBPageController( )
    {
        parent::PageController( );

        $this->addView( 'invalid',
            			new Handle( 'pages/error.page.php|ErrorInvalidView',
            						array( 'error' ) ) );
    }
}

//
//
//
	require_once( WACT_ROOT . 'controller/form.inc.php' );

class FBFormController extends FBPageController
{
    var $_form;

	function _addSizeRule( &$name, &$field )
	{
        if( isset( $field['len'] ) )
        		$len = $field['len'];
        	else
        		$len = 0;

		if( $len > 0 )
			$this->_form->addRule( new Handle( 'SizeRangeRule', array( $name, $len ) ) );
	}

    //
    function _addEditRule( &$name, &$field )
    {
		$this->_form->addRule( new Handle( 'RequiredRule', array( $name ) ) );

		$this->_addSizeRule( $name, $field );

		$this->_form->addRule( new Handle( 'ExcludePatternRule', array( $name, FB_RE_EXCLUDE ) ) );
	}

    //
    function _addTextRule( &$name, &$field )
    {
		$this->_form->addRule( new Handle( 'RequiredRule', array( $name ) ) );

		$this->_addSizeRule( $name, $field );
	}

    //
    function _addSubmitRule( &$name, &$field )
    {
        $this->_form->addChild( 'submit',
        				 		new ButtonController( new Delegate( $this,
        				 							  				$field['callback'] ) ) );

        $this->_form->setDefaultChild( 'submit' );
	}

    //
    function _addFields( &$fieldTb )
    {

        foreach( $fieldTb as $name => $field )
        {
        	switch( $field['type'] )
        	{
        	case 'edit':
        		$this->_addEditRule( $name, $field );
        		break;

        	case 'text':
        		$this->_addTextRule( $name, $field );
        		break;

        	case 'submit':
        		$this->_addSubmitRule( $name, $field );
        		break;
        	}
		}
    }

    //
    function FBFormController( $formName, &$fieldTb )
    {
		parent::FBPageController( );

        $this->_form =& new FormController();

		$this->_form->registerOnLoadListener( new Delegate( $this, '_onLoad' ) );

        $this->_addFields( $fieldTb );

        $this->addChild( $formName, $this->_form );
        $this->setDefaultChild( $formName );
    }

}

?>
