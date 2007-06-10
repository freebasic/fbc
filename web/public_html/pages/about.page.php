<?php

//
// copyleft 2004-2006 Andre Victor T. Vicentini (av1ctor[at]yahoo.com.br)
//

class DefaultPageCtrl extends FBPageController
{
    //
	function DefaultPageCtrl( )
	{
		parent::FBPageController( );
        $this->setDefaultView( new FBIniListView( 'about', 'about' ) );
    }
}


class FeatPageCtrl extends FBPageController
{
    //
	function FeatPageCtrl( )
	{
		parent::FBPageController( );
		$this->setDefaultView( new FBDbListView( 'about_feat', 'about_feat', 'about' ) );
	}
}

class CredPageCtrl extends FBPageController
{
    //
	function CredPageCtrl( )
	{
		parent::FBPageController( );
		$this->setDefaultView( new FBCatListView( 'about_cred', 'aboutcred', 'about' ) );
	}
}

class DiffPageCtrl extends FBPageController
{
    //
	function DiffPageCtrl( )
	{
		parent::FBPageController( );
		$this->setDefaultView( new FBDbListView( 'about_diff', 'about_diff', 'about' ) );
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
    	static $pages = array( 'default|about|DefaultPageCtrl',
    						   'features|about|FeatPageCtrl',
    						   'credits|about|CredPageCtrl',
    						   'diff|about|DiffPageCtrl' );

        $childTb = array( );

		foreach( $pages as $page )
		{
			$hnd =& new Handle( FBSite::_pageToHandleArg( $page ) );

			list( $page, , ) = explode( '|', $page );

			$childTb[$page] =& $hnd;
		}

        parent::ParameterDispatchController( $childTb, 'default', 'section' );

   }

}

?>

