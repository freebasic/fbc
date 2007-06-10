<?php

//
// copyleft 2004-2006 Andre Victor T. Vicentini (av1ctor[at]yahoo.com.br)
//

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

        $this->setDefaultView( new FBCatListView( 'changelang', 'changelang' ) );

		$this->addView( 'redir', new RedirectView( '/news' ) );

    }

    function _onActivate( &$source, &$request, &$responseModel )
    {
        static $paramTb = array( 'lang' );

        foreach( $paramTb as $param )
        	if( $request->hasParameter( $param ) )
        		if( !FBSite::validate( $request->getParameter( $param ) ) )
        		{
            		return 'invalid';
        		}

		if( $request->hasParameter( 'lang' ) )
		{
			FBSite::setLanguage( $request->getParameter( 'lang' ) );

			return 'redir';
		}

    }

}

?>

