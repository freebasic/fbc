<?php

//
// copyleft 2004-2006 Andre Victor T. Vicentini (av1ctor[at]yahoo.com.br)
//

	require_once( 'geshi/geshi.php' );

//
//
//
class AddCodePageCtrl extends FBFormController
{
    var $_cod;
    var $_browseView;

    //
	function AddCodePageCtrl( )
	{
        static $fieldTb = array( 'parent' => array( 'type'  => 'edit' ),
								 'user' => array( 'type'  => 'edit' ),
        						 'name' => array( 'type' => 'edit',
        										  'len' => FB_CODELIB_MAXNAMELEN ),
        						 'desc' => array( 'type' => 'edit',
        						 				  'len' => FB_CODELIB_MAXDESCLEN ),
								 'code' => array( 'type'  => 'text',
								 				  'len' => FB_CODELIB_MAXCODELEN ),
        						 'submit'  => array( 'type'  => 'submit',
        						 				  	 'callback' => '_onSend' ) );

        parent::FBFormController( 'AddForm', $fieldTb );

        $this->_cod =& new CodeLibCode( new CodeLibCategory( ) );

        $formView =& new CodeLibFormView( 'codelib_add_code', 'AddForm' );
        $this->_browseView =& new CodeLibBrowseView( TRUE );

        $this->setDefaultView( $formView );
        $this->addView( 'success', $this->_browseView );
        $this->addViewById( 'failure', WACT_DEFAULT_VIEW );
    }

    //
    function _onLoad( &$source, &$request, &$responseModel )
    {
        $id = $request->getParameter( 'catid' );
        if( !FBSite::validate( $id ) )
        	return 'failure';

        $responseModel->set( 'parent', $id );

        $responseModel->set( 'user', FBUser::getId( ) );
    }

    //
    function _onAdd( &$source, &$request, &$responseModel )
    {
        if( $responseModel->isValid( ) )
        {
        	$category =& $responseModel->get( 'parent' );

        	// add snippet
        	$id = $this->_cod->add( $category,
        					 		$responseModel->get( 'user' ),
        					 		$responseModel->get( 'name' ),
        					 		$responseModel->get( 'desc' ) );
        	if( $id == -1 )
        		return 'failure';

			// add the snippet files
			$fileTb[0]['name'] = '';
			$fileTb[0]['format'] = '';
			$fileTb[0]['description'] = '';
			$fileTb[0]['text'] =& $responseModel->get( 'code' );

        	$this->_cod->addFiles( $id, 1, $fileTb );

        	//
        	$this->_browseView->setCatId( $category );
        	$this->_browseView->_showFullPath = FALSE;

        	return 'success';
        }
    }

    //
    function _onCancel( &$source, &$request, &$responseModel )
    {
        if( $responseModel->hasProperty( 'parent' ) )
        	$id = $responseModel->get( 'parent' );
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
    	if( $responseModel->hasProperty( 'addButton' ) )
    		return $this->_onAdd( $source, $request, $responseModel );
    	else
    		return $this->_onCancel( $source, $request, $responseModel );
    }
}

//
//
//
class EditCodePageCtrl extends FBFormController
{
    var $_formView;
    var $_codeView;
    var $_cod;

    //
	function EditCodePageCtrl( )
	{
        static $fieldTb = array( 'id' => array( 'type'  => 'edit' ),
        						 'name' => array( 'type' => 'edit',
        										  'len' => FB_CODELIB_NAMELEN ),
        						 'desc' => array( 'type' => 'edit',
        						 				  'len' => FB_CODELIB_MAXDESCLEN ),
								 'code' => array( 'type'  => 'text',
								 				  'len' => FB_CODELIB_MAXCODELEN ),
        						 'submit' => array( 'type'  => 'submit',
        						 			        'callback' => '_onSend' ) );

        $this->_cod =& new CodeLibCode( new CodeLibCategory( ) );

        parent::FBFormController( 'EditForm', $fieldTb );

        $this->_formView =& new CodeLibFormView( 'codelib_edit_code', 'EditForm' );
        $this->_codeView =& new CodeLibCodeView( );

        $this->setDefaultView( $this->_formView );
        $this->addView( 'success', $this->_codeView );
        $this->addViewById( 'failure', WACT_DEFAULT_VIEW );
    }

    //
    function _onLoad( &$source, &$request, &$responseModel )
    {
        $id = $request->getParameter( 'id' );
        if( !FBSite::validate( $id ) )
        	return 'failure';

        $responseModel->set( 'id', $id );

        $fieldTb =& $this->_cod->load( $id );

        if( $fieldTb != NULL )
        {
        	$responseModel->set( 'name', $fieldTb['name'] );
        	$responseModel->setRef( 'desc', $fieldTb['description'] );
        	$responseModel->setRef( 'code', $fieldTb['fileTb'][0]['text'] );

        	$this->_formView->setCatId( $fieldTb['category_id'] );
        }
    }

    //
    function _onSave( &$source, &$request, &$responseModel )
    {
        if( $responseModel->isValid( ) )
        {
        	$id =& $responseModel->get( 'id' );

        	$fieldTb =& $this->_cod->load( $id );

        	if( ($fieldTb == NULL) || ($fieldTb['id'] != $id) )
        		return 'failure';

        	if( (FBUser::getId( ) == $fieldTb['author_id']) || FBUser::isAdmin( ) )
        	{
        		// update the snippet
        		$res = $this->_cod->update( $id,
        					 			    $responseModel->get( 'name' ),
        					 			    $responseModel->get( 'desc' ) );
        		if( $res == FALSE )
        			return 'failure';

				// update the snippet files
				$fileTb[0]['id'] = $fieldTb['fileTb'][0]['id'];
				$fileTb[0]['name'] = '';
				$fileTb[0]['format'] = '';
				$fileTb[0]['description'] = '';
				$fileTb[0]['text'] =& $responseModel->get( 'code' );

        		$this->_cod->updateFiles( $id, 1, $fileTb );

        		//
        		$this->_codeView->setId( $id );

        		return 'success';
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

        $this->_codeView->setId( $id );

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

//
//
//
class DelCodePageCtrl extends FBFormController
{
    var $_cod;
    var $_formView;
    var $_codeView;
    var $_browseView;

	//
	function DelCodePageCtrl( )
	{
        static $fieldTb = array( 'id' => array( 'type'  => 'edit' ),
        						 'submit' => array( 'type'  => 'submit',
        						 			        'callback' => '_onSend' ) );

        $this->_cod =& new CodeLibCode( new CodeLibCategory( ) );

        parent::FBFormController( 'DelForm', $fieldTb );

        $this->_formView =& new CodeLibFormView( 'codelib_del_code', 'DelForm' );
        $this->_codeView =& new CodeLibCodeView( );
        $this->_browseView =& new CodeLibBrowseView( TRUE );

        $this->setDefaultView( $this->_formView );
        $this->addView( 'success', $this->_browseView );
        $this->addView( 'cancel', $this->_codeView );
        $this->addViewById( 'failure', WACT_DEFAULT_VIEW );
    }

    //
    function _onLoad( &$source, &$request, &$responseModel )
    {
        $id = $request->getParameter( 'id' );
        if( !FBSite::validate( $id ) )
        	return 'failure';

        $responseModel->set( 'id', $id );

        $fieldTb =& $this->_cod->load( $id );
        if( $fieldTb != NULL )
        {
        	$responseModel->set( 'name', $fieldTb['name'] );

        	$this->_formView->setCatId( $fieldTb['category_id'] );
        }
    }

    //
    function _onDelete( &$source, &$request, &$responseModel )
    {
        if( $responseModel->isValid( ) )
        {
        	$id = $responseModel->get( 'id' );

        	$fieldTb =& $this->_cod->load( $id );
        	if( $fieldTb != NULL )
        	{
    	    	$catId = $fieldTb['category_id'];

    			if( (FBUser::getId( ) == $fieldTb['author_id']) || FBUser::isAdmin( ) )
    			{
    				$this->_cod->del( $id, $catId );
    			}

    	    	$this->_browseView->setCatId( $catId );
    	    	$this->_browseView->_showFullPath = FALSE;
    		}

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

        $this->_codeView->setId( $id );

        return 'cancel';
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
class CodeLibCodeView extends CodeLibView
{
	var $_id;

	//
	function CodeLibCodeView( )
	{
		parent::CodeLibView( 'codelib_view_code', TRUE );

		$this->_id = -1;
	}

	function setId( $id )
	{
		$this->_id = $id;
	}

	//
	function _highLight( $files, &$fileTb )
	{
		static $geshi = NULL;

		if( $geshi == NULL )
		{
			$geshi = new GeSHi( '', 'qbasic', 'geshi/geshi/' );
			$geshi->set_header_type( GESHI_HEADER_DIV );
			$geshi->enable_classes( true );
		}

		for( $i = 0; $i < $files; $i++ )
		{
			$geshi->set_source( $fileTb[$i]['text'] );
			$fileTb[$i]['text'] = $geshi->parse_code( );
		}
	}

	function &_loadRecord( &$cod, $id )
	{
        $fieldTb =& $cod->load( $id );
        $cod->loadAuthor( $fieldTb );

        return $fieldTb;
    }

    //
    function prepare( &$controller, &$request, &$responseModel )
    {
        $id = $this->_id;
        if( $id == -1 )
        	$id = $request->getParameter( 'id' );

		$cod =& new CodeLibCode( new CodeLibCategory( ) );

        $fieldTb =& $this->_loadRecord( $cod, $id );

        if( $fieldTb != NULL )
        {
        	$responseModel->set( 'id', $fieldTb['id'] );
        	$this->Template->set( 'name', $fieldTb['name'] );
	        $this->Template->setRef( 'desc', $fieldTb['description'] );

        	$this->Template->setRef( 'author_name', $fieldTb['author_name'] );
        	$this->Template->set( 'author_email',
        						  FBSite::prepareEmail( $fieldTb['author_email'] ) );

			$this->_highLight( $fieldTb['files'], $fieldTb['fileTb'] );
			$ds =& new ArrayDataSet( $fieldTb['fileTb'] );
        	$this->Template->setChildDataSource( 'snippetList', $ds );

    	    $this->setCatId( $fieldTb['category_id'] );

    		if( (FBUser::getId( ) == $fieldTb['author_id']) || FBUser::isAdmin( ) )
    			$responseModel->set( 'isOwner', TRUE );
    	}

    	parent::prepare( $controller, $request, $responseModel );
    }
}

//
//
//
class ViewCodePageCtrl extends FBPageController
{
	var $_view;

	//
	function ViewCodePageCtrl( )
	{
        parent::FBPageController( );

        $this->_view =& new CodeLibCodeView( );

        $this->setDefaultView( $this->_view );

        $this->registerOnActivateListener( new Delegate( $this, '_onActivate' ) );
    }

    //
    function _onActivate( &$source, &$request, &$responseModel )
    {
        static $paramTb = array( 'id' );

        foreach( $paramTb as $param )
        {
        	if( !$request->hasParameter( $param ) ||
        		!FBSite::validate( $request->getParameter( $param ) ) )
            	return 'invalid';
		}
	}
}
?>
