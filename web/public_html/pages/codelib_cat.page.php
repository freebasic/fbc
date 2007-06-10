<?php

//
// copyleft 2004-2006 Andre Victor T. Vicentini (av1ctor[at]yahoo.com.br)
//

//
//
//
class AddCatPageCtrl extends FBFormController
{
    var $_browseView;

    //
	function AddCatPageCtrl( )
	{
        static $fieldTb = array( 'name' => array( 'type' => 'edit',
        										  'len' => FB_CODELIB_MAXNAMELEN ),
        						 'desc' => array( 'type' => 'edit',
        						 				  'len' => FB_CODELIB_MAXDESCLEN ),
        						 'add'  => array( 'type'  => 'submit',
        						 				  'callback' => '_onSubmit' ) );

        parent::FBFormController( 'AddForm', $fieldTb );

        $formView =& new CodeLibFormView( 'codelib_add_cat', 'AddForm' );
        $this->_browseView =& new CodeLibBrowseView( TRUE );

        $this->setDefaultView( $formView );
        $this->addView( 'success', $this->_browseView );
        $this->addViewById( 'failure', WACT_DEFAULT_VIEW );
    }

    //
    function _onLoad( &$source, &$request, &$responseModel )
    {
        if( $request->hasParameter( 'catid' ) )
        {
        	$id = $request->getParameter( 'catid' );
        	if( !FBSite::validate( $id ) )
        		return 'failure';

        	$responseModel->set( 'parent', $id );
        }
    }

    //
    function _onSubmit( &$source, &$request, &$responseModel )
    {
        if( $responseModel->isValid( ) )
        {
        	$cat =& $this->_browseView->_cat;

        	if( $responseModel->hasProperty( 'parent' ) )
        	{
        		$parent = $responseModel->get( 'parent' );
        		if( strlen( $parent ) > 0 )
        		{
        			if( !FBSite::validate( $parent ) )
            			return 'invalid';

        			$cat->setId( $parent );
        		}
        	}

        	if( FBUser::isAdmin( ) )
        	{
        		$id = $cat->insertSub( $responseModel->get( 'name' ),
        						   	   $responseModel->get( 'desc' ) );
        		if( $id == -1 )
        			return 'failure';
        	}

        	$this->_browseView->setCatId( $id );
        	$this->_browseView->_showFullPath = FALSE;

        	return 'success';
        }
    }
}


//
//
//
class DelCatPageCtrl extends FBFormController
{
    var $_cat;
    var $_formView;
    var $_browseView;

	//
	function DelCatPageCtrl( )
	{
        static $fieldTb = array( 'id' => array( 'type'  => 'edit' ),
        						 'submit' => array( 'type'  => 'submit',
        						 			        'callback' => '_onSend' ) );

        parent::FBFormController( 'DelForm', $fieldTb );

        $this->_cat =& new CodeLibCategory( );

        $this->_formView =& new CodeLibFormView( 'codelib_del_code', 'DelForm' );
        $this->_browseView =& new CodeLibBrowseView( TRUE );

        $this->setDefaultView( $this->_formView );
        $this->addView( 'success', $this->_browseView );
        $this->addViewById( 'failure', WACT_DEFAULT_VIEW );
    }

    //
    function _onLoad( &$source, &$request, &$responseModel )
    {
        $id = $request->getParameter( 'catid' );
        if( !FBSite::validate( $id ) )
        	return 'failure';

        $responseModel->set( 'id', $id );

        if( $this->_cat->setId( $id ) )
        {
        	$responseModel->set( 'name', $this->_cat->getName( ) );

        	$this->_formView->setCatId( $id );
        }
    }

    //
    function _onDelete( &$source, &$request, &$responseModel )
    {
    	if( FBUser::isAdmin( ) )
    	{
        	if( $responseModel->hasProperty( 'id' ) )
        		$id = $responseModel->get( 'id' );
        	else
        		$id = -1;

        	if( ($id == -1) || !FBSite::validate( $id ) )
        		return 'failure';

        	if( $this->_cat->setId( $id ) )
        	{
    	   		$id = $this->_cat->getParent( );

    			$this->_cat->remove( );
    		}

    	   	$this->_browseView->setCatId( $id );
    	   	$this->_browseView->_showFullPath = FALSE;

    		return 'success';
    	}
	}

    //
    function _onCancel( &$source, &$request, &$responseModel )
    {
        if( $responseModel->hasProperty( 'id' ) )
        	$id = $responseModel->get( 'id' );
        else
        	$id = -1;

        if( ($id == -1) || !FBSite::validate( $id ) )
        	return 'failure';

    	$this->_browseView->setCatId( $id );
    	$this->_browseView->_showFullPath = FALSE;

        return 'success';
    }

    //
    function _onSend( &$source, &$request, &$responseModel )
    {
    	if( $responseModel->hasProperty( 'delButton' ) )
    		return $this->_onDelete( $source, $request, $responseModel );
    	else
    		return $this->_onCancel( $source, $request, $responseModel );
    }

}

//
//
//
class EditCatPageCtrl extends FBFormController
{
    var $_formView;
    var $_browseView;
    var $_cat;

    //
	function EditCatPageCtrl( )
	{
        static $fieldTb = array( 'id' => array( 'type'  => 'edit' ),
        						 'name' => array( 'type' => 'edit',
        										  'len' => FB_CODELIB_MAXNAMELEN ),
        						 'desc' => array( 'type' => 'edit',
        						 				  'len' => FB_CODELIB_MAXDESCLEN ),
        						 'submit' => array( 'type'  => 'submit',
        						 			        'callback' => '_onSend' ) );

        $this->_cat =& new CodeLibCategory( );

        parent::FBFormController( 'EditForm', $fieldTb );

        $this->_formView =& new CodeLibFormView( 'codelib_edit_cat', 'EditForm' );
        $this->_browseView =& new CodeLibBrowseView( TRUE );

        $this->setDefaultView( $this->_formView );
        $this->addView( 'success', $this->_browseView );
        $this->addViewById( 'failure', WACT_DEFAULT_VIEW );
    }

    //
    function _onLoad( &$source, &$request, &$responseModel )
    {
        $id = $request->getParameter( 'catid' );
        if( !FBSite::validate( $id ) )
        	return 'failure';

        $responseModel->set( 'id', $id );

        if( $this->_cat->setId( $id ) )
        {
        	$responseModel->set( 'name', $this->_cat->getName( ) );
        	$responseModel->set( 'desc', $this->_cat->getDescription( ) );

        	$this->_formView->setCatId( $id );
        }
    }

    //
    function _onSave( &$source, &$request, &$responseModel )
    {
        if( $responseModel->isValid( ) )
        {
    		if( FBUser::isAdmin( ) )
    		{
        		$id = $responseModel->get( 'id' );
        		if( $this->_cat->setId( $id ) )
        		{
        			$res = $this->_cat->update( $responseModel->get( 'name' ),
        					 			    	$responseModel->get( 'desc' ) );
        			if( $res == FALSE )
        				return 'failure';

    	    		$this->_browseView->setCatId( $id );
    	    		$this->_browseView->_showFullPath = FALSE;

        			return 'success';
        		}
        	}
        }
    }

    //
    function _onCancel( &$source, &$request, &$responseModel )
    {
        if( $responseModel->hasProperty( 'id' ) )
        	$id = $responseModel->get( 'id' );
        else
        	$id = -1;

        if( ($id == -1) || !FBSite::validate( $id ) )
        	return 'failure';

    	$this->_browseView->setCatId( $id );
    	$this->_browseView->_showFullPath = FALSE;

        return 'success';
    }

    //
    function _onSend( &$source, &$request, &$responseModel )
    {
    	if( $responseModel->hasProperty( 'saveButton' ) )
    		return $this->_onSave( $source, $request, $responseModel );
    	else
    		return $this->_onCancel( $source, $request, $responseModel );
    }
}

?>
