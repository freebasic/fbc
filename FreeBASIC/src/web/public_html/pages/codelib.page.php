<?php

//
// copyleft 2004-2006 Andre Victor T. Vicentini (av1ctor[at]yahoo.com.br)
//

	require_once( 'MPath.inc.php' );

	require_once( 'CodeLib.inc.php' );

//
//
//
class CodeLibView extends FBView
{
    var $_subMenuTb;
    var $_cat;
    var $_catId;
    var $_showFullPath;
    var $_cod;

	//
	function &_initSubMenu( $pagename )
	{
		$menuTb =& parse_ini_file( FBSite::getFullLangPath( ) . '/codelib_submenu.ini', TRUE );

		FBSite::_menusel( $menuTb, $pagename );

		return $menuTb;
	}

    //
	function CodeLibView( $pagename, $showFullPath = FALSE, $ctrlname = NULL )
	{
		parent::FBView( $pagename, $ctrlname );

		$this->_subMenuTb =& $this->_initSubMenu( $pagename );

		$this->_cat =& new CodeLibCategory( );
		$this->_catId = -1;
		$this->_showFullPath = $showFullPath;

		$this->_cod =& new CodeLibCode( $this->_cat );

		parent::View( FBSite::getTplName( $pagename ) );
	}

	//
	function setCatId( $id )
	{
    	if( $this->_catId == -1 )
    	{
			if( $id != 0 )
			{
				$this->_catId = $id;
				$this->_cat->setId( $id );
			}
		}
	}

	//
	function _prepareSubMenu( )
	{
		//
		if( FBUser::isLogged( ) )
			$this->_subMenuTb['menu_login']['isHidden'] = TRUE;
		else
			$this->_subMenuTb['menu_logout']['isHidden'] = TRUE;

		//
		end( $this->_subMenuTb );
		$k = key( $this->_subMenuTb );
		$this->_subMenuTb[$k]['isLast'] = TRUE;

        $ds =& new ArrayDataSet( $this->_subMenuTb );
        $this->Template->setChildDataSource( 'subMenuList', $ds );
	}

    //
    function prepare( &$controller, &$request, &$responseModel )
    {
    	parent::prepare( $controller, $request, $responseModel );

    	if( $request->hasParameter( 'catid' ) )
    		$this->setCatId( $request->getParameter( 'catid' ) );

    	if( $this->_catId != -1 )
    	{
    		$responseModel->set( 'catid', $this->_catId );
    		$parentId = $this->_cat->getParent( );
    		if( $parentId == -1 )
    			$parentId = 0;

    		$responseModel->set( 'parentId', $parentId );
    	}

        // the submenu list
        $this->_prepareSubMenu( );

		// category path
		$ds =& new ArrayDataSet( $this->_cat->getPath( $this->_showFullPath == FALSE ) );
        $this->Template->setChildDataSource( 'codelib_catPath', $ds );

        $responseModel->set( 'showFullPath', $this->_showFullPath );

        //
        $responseModel->set( 'isLogged', FBUser::isLogged( ) );
        $responseModel->set( 'isAdmin', FBUser::isAdmin( ) );
  }
}


//
//
//
class CodeLibBrowseView extends CodeLibView
{
    //
	function CodeLibBrowseView( $showFullPath = FALSE )
	{
		parent::CodeLibView( 'codelib', $showFullPath );
	}

    //
    function prepare( &$controller, &$request, &$responseModel )
    {
    	parent::prepare( $controller, $request, $responseModel );

		// category list
		$ds =& new ArrayDataSet( $this->_cat->getList( $this->_catId == -1 ) );
        $this->Template->setChildDataSource( 'codelib_catList', $ds );

		if( $this->_catId != -1 )
		{
        	// snippets
			$ds =& new ArrayDataSet( $this->_cod->getList( $this->_catId ) );
        	$this->Template->setChildDataSource( 'codelib_codeList', $ds );
        }
	}
}

//
//
//
class CodeLibFormView extends CodeLibView
{
    var $_form;

    //
	function CodeLibFormView( $pagename, $formname, $ctrlname = NULL )
	{
		parent::CodeLibView( $pagename, TRUE, $ctrlname );

		$this->_form =& $this->Template->findChild( $formname );
	}

    //
    function prepare( &$controller, &$request, &$responseModel )
    {
        $this->_form->registerDataSource( $responseModel );

        if( !$responseModel->isValid( ) )
            $this->_form->setErrors( $responseModel->getErrorList( ) );

    	parent::prepare( $controller, $request, $responseModel );
	}

}

//
//
//
class DefaultPageCtrl extends FBPageController
{
    //
	function DefaultPageCtrl( )
	{
		parent::FBPageController( );

        $this->setDefaultView( new CodeLibBrowseView( ) );
    }
}

//
// controller
//
class PageCtrl extends ParameterDispatchController
{

    //
    function PageCtrl( )
    {
    	static $pages = array( 'default|codelib|DefaultPageCtrl',
    						   'login|codelib_user|LoginPageCtrl',
    						   'logout|codelib_user|LogoutPageCtrl',
    						   'add_cat|codelib_cat|AddCatPageCtrl',
    						   'del_cat|codelib_cat|DelCatPageCtrl',
    						   'edit_cat|codelib_cat|EditCatPageCtrl',
    						   'add_code|codelib_code|AddCodePageCtrl',
    						   'del_code|codelib_code|DelCodePageCtrl',
    						   'edit_code|codelib_code|EditCodePageCtrl',
    						   'view_code|codelib_code|ViewCodePageCtrl' );

        $childTb = array( );

		foreach( $pages as $page )
		{
			$hnd =& new Handle( FBSite::_pageToHandleArg( $page ) );

			list( $page, , ) = explode( '|', $page );

			$childTb[$page] =& $hnd;
		}

        parent::ParameterDispatchController( $childTb, 'default', 'section' );

        $this->addView( 'invalid',
        				new Handle( FBSite::_pageToHandleArg( 'invalid|error|ErrorInvalidView' ) ) );

        $this->registerOnActivateListener( new Delegate( $this, '_onActivate' ) );
    }

    //
    function _onActivate( &$source, &$request, &$responseModel )
    {
        static $paramTb = array( 'catid' );

        foreach( $paramTb as $param )
        {
        	if( $request->hasParameter( $param ) )
        		if( !FBSite::validate( $request->getParameter( $param ) ) )
            		return 'invalid';
		}
	}

}

?>

