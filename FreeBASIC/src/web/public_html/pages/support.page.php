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
        $this->setDefaultView( new FBCatListView( 'support', 'support' ) );
    }
}

?>

