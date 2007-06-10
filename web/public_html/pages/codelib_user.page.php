<?php

//
// copyleft 2004-2006 Andre Victor T. Vicentini (av1ctor[at]yahoo.com.br)
//

//
//
//
class LoginPageCtrl extends FBFormController
{
    //
	function LoginPageCtrl( )
	{
        static $fieldTb = array( 'username' => array( 'type' => 'edit',
        										  	  'len' => 63 ),
        						 'password' => array( 'type' => 'edit',
        						 					  'len' => 31 ),
        						 'login' => array( 'type'  => 'submit',
        						 				   'callback' => '_onSubmit' ) );

        parent::FBFormController( 'LoginForm', $fieldTb );

        $formView =& new CodeLibFormView( 'codelib_user_login', 'LoginForm' );
        $browseView =& new CodeLibBrowseView( );

        $this->setDefaultView( $formView );
        $this->addView( 'success', $browseView );
        $this->addViewById( 'failure', WACT_DEFAULT_VIEW );
	}

    //
    function _onLoad( &$source, &$request, &$responseModel )
    {
    }

    //
    function _onSubmit( &$source, &$request, &$responseModel )
    {
        if( $responseModel->isValid( ) )
        {
        	if( !FBUser::login( $responseModel->get( 'username' ),
        					    $responseModel->get( 'password' ) ) )
        		return 'failure';

        	return 'success';
        }
    }
}


//
//
//
class LogoutPageCtrl extends FBPageController
{
    //
	function LogoutPageCtrl( )
	{
        FBUser::logout( );

		parent::FBPageController( );

        $this->setDefaultView( new CodeLibBrowseView( ) );
    }
}


?>
