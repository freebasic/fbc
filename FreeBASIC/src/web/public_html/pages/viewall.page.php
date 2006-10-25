<?php

//
// copyleft 2004-2006 Andre Victor T. Vicentini (av1ctor[at]yahoo.com.br)
//

//
// view
//
class PageView extends FBView
{
    //
    function PageView( $tplfile, $dbpage = NULL )
    {
        parent::FBView( $tplfile, $dbpage );
    }

    //
    function prepare( &$controller, &$request, &$responseModel )
    {
    	parent::prepare( $controller, $request, $responseModel );

		$page =& $request->getParameter( 'page' );
		$category =& $request->getParameter( 'category' );

		$ds =& new FBDetailRecSet( $page,
							   	   $category,
							   	   $this->getPgLang( ),
							   	   $this->getDbLang( ),
							   	   $this->Template );

    	$this->Template->setChildDataSource( 'recordList', $ds );

    	$this->Template->set( 'page', $page );
    	$this->Template->set( 'category', $category );
    }
}

//
// controller
//
class PageCtrl extends FBPageController
{
    //
    function PageCtrl( )
    {
        parent::FBPageController( );

        $this->registerOnActivateListener( new Delegate( $this, '_onActivate' ) );

        $this->setDefaultView( new PageView( 'viewall' ) );
    }

    //
    function _onActivate( &$source, &$request, &$responseModel )
    {
        static $paramTb = array( 'page', 'category' );

        foreach( $paramTb as $param )
        	if( !$request->hasParameter( $param ) ||
        		!FBSite::validate( $request->getParameter( $param ) ) )
        	{
            	return 'invalid';
        	}

		if( !$source->parent->hasChild( $request->getParameter( 'page' ) ) )
			return 'invalid';
    }

}

?>

