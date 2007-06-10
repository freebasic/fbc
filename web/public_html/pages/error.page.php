<?php

//
// copyleft 2004-2006 Andre Victor T. Vicentini (av1ctor[at]yahoo.com.br)
//

//
// view
//
class ErrorInvalidView extends FBView
{
    //
    function ErrorInvalidView( $tplfile = NULL )
    {
        if( $tplfile == NULL )
        	$tplfile = 'error';

        parent::FBView( $tplfile, NULL );
    }

    //
    function prepare( &$controller, &$request, &$responseModel )
    {
    	parent::prepare( $controller, $request, $responseModel );

    	$this->Template->set( 'errordesc', 'Invalid parameters' );
    }
}

//
// controller
//
class PageCtrl extends FBPageController
{
    //
    function PageCtrl(  )
    {
		parent::FBPageController( );
		$this->setDefaultView( new ErrorInvalidView( ) );
	}
}

?>

