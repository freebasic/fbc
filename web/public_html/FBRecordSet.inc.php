<?php

//
// copyleft 2004-2006 Andre Victor T. Vicentini (av1ctor[at]yahoo.com.br)
//

	require_once( WACT_ROOT . 'db/db.inc.php' );

//
//
//
class FBRecordSet
{
	var $recSet;

	//
	function FBRecordSet( &$dataset )
	{
		$this->recSet =& $dataset;
	}

	//
	function get( $name )
	{
		return $this->recSet->get( $name );
	}

	//
	function query( $query )
	{
		return $this->recSet->query( $query );
	}

	//
	function paginate( $pager )
	{
		return $this->recSet->paginate( $pager );
	}

	//
	function reset( )
	{
		return $this->recSet->reset( );
	}

	//
	function next( )
	{
		return $this->recSet->next( );
	}

	//
	function &export( )
	{
		return $this->recSet->export( );
	}

	//
	function getRowCount( )
	{
		return $this->recSet->getRowCount( );
	}

	//
	function getTotalRowCount( )
	{
		return $this->recSet->getTotalRowCount( );
	}
}

//
//
//
class FBFieldHeadRecSet extends ArrayDataSet
{
    var $_pageName;
    var $_catName;
    var $_i18nTb;

    //
	function FBFieldHeadRecSet( $pagename, $catname, &$fieldTb, &$i18nTb )
	{
		$this->_pageName= $pagename;
		$this->_catName = $catname;

		parent::ArrayDataSet( $fieldTb );

		$this->_i18nTb =& $i18nTb;
	}

	//
	function &get( $field )
	{
		if( parent::get( 'detailonly' ) != 0 )
			return NULL;

		$res =& parent::get( $field );

		if( $field == 'name' )
		{
			if( parent::get( 'nohead' ) != 0 )
				return '&nbsp;';
			else
				return $this->_i18nTb[$this->_catName][$res];		// translate
		}
		else
		{
			if( is_null( $res ) || ($res{0} == '/') )
				$res = 'align="left"';
		}

		return $res;
	}
}

//
//
//
class FBFieldRecSet
{
    var $_pageName;
    var $_catName;
    var $_catIdField;
    var $_recSet;
    var $_fieldTb;
    var $_imgPath;
    var $_idx;

	//
	function FBFieldRecSet( $pagename, $catname, $idfield, &$recSet, &$fieldTb )
	{
		$this->_pageName	= $pagename;
		$this->_catName 	= $catname;
		$this->_catIdField 	= $idfield;

		$this->_recSet  	=& $recSet;

		$this->_imgPath 	= FBSite::getRelImgPath( );

		$this->_setupFieldTb( $fieldTb );
	}

	//
	function reset( )
	{
		if( $this->_catIdField != 'id' )
			$this->_recSet->set( 'id', $this->_recSet->get( $this->_catIdField ) );

		$this->_idx = 0;
	}

	//
	function next( )
	{
		$this->_idx += 1;
		return ($this->_idx <= count( $this->_fieldTb )? TRUE: FALSE);
	}

	//
	function &get( $fieldName )
	{
		$field =& $this->_fieldTb[$this->_idx];

		if( $field['detailonly'] != 0 )
			return NULL;

		$text =& $this->_recSet->get( $field['name'] );

		switch( $field['type'] )
		{
		case 'link':
			return FBSite::renderImgLink( $text, $this->_imgPath );

		case 'dynlink':
			return FBSite::renderDynImgLink( $text, $field['attributes'], $this->_imgPath );

		case 'text_html':
			$text = preg_replace( '/[\t ][\t ]+/', ' ', strip_tags( $text ) );
			/* fall-through */

		case 'text':
			$chars = 55;
			if( substr( $field['attributes'], 0, 7 ) == 'width="' )
				$chars = substr( $field['attributes'], 7, 2 );

			return FBSite::renderText( $text,
									   $this->_pageName, $this->_catName,
									   $this->_recSet->get( $this->_catIdField ),
									   $chars );

		case 'list':
			return FBSite::renderList( $text );

		case 'time_gmt':
			$text = strtotime( $text );
			/* fall-through */

		case 'time':
			return FBSite::renderTime( $text );

		default:
				return $text;
		}
	}

	//
	function _setupFieldTb( &$propTb )
	{
		$this->_fieldTb = array( );

		$idx = (int)1;
		foreach( $propTb as $prop )
			$this->_fieldTb[(int)$idx++] = $prop;
	}
}

//
//
//
class FBCategoryRecSet extends FBRecordSet
{
	var $_pageName;
	var $_pglang;
	var $_dblang;
	var $_tplObj;
	var $_catName;
	var $_catId;
	var $_catList;
	var $_catOrder;
	var $_catIdField;
	var $_i18nTb;

	//
	function FBCategoryRecSet( $pagename, $pglang, $dblang, &$tplObj )
	{
		$this->_pglang	= $pglang;
		$this->_dblang	= $dblang;
		$this->_pageName= $pagename;

		parent::FBRecordSet( FBSite::getPageCategories( $pagename ) );

		$this->_i18nTb  =& FBSite::getPageI18N( $pagename );

		$this->_tplObj 	=& $tplObj;

		$this->_catList =& $this->_tplObj->getChild( 'categoryList' );
	}

	//
	function next( )
	{
		if( $this->recSet->next( ) != TRUE )
			return FALSE;

		$this->_catName  	=  $this->recSet->get( 'name' );
		$this->_catId 	 	=  $this->recSet->get( 'id' );
		$order 			 	=& $this->recSet->get( 'orderby' );
		$isdesc 		 	=& $this->recSet->get( 'isdesc' );
		$limit 		 	 	=& $this->recSet->get( 'limit' );
		$table 		 	 	=& $this->recSet->get( 'table' );
		$this->_catIdField  =  $this->recSet->get( 'idfield' );
		$extra				=& $this->recSet->get( 'extra' );

        // fields head
        $fieldTb =& FBSite::getCategoryFields( $this->_catId, FALSE );

        $fhds =& new FBFieldHeadRecSet( $this->_pageName,
        								$this->_catName,
        						        $fieldTb,
        						        $this->_i18nTb );

        $this->_catList->setChildDataSource( 'fieldHeadList', $fhds );

        // records
        $recds =& FBSite::getCategoryRecords( $this->_pageName,
        						   			  $this->_catName,
        						   			  $this->_dblang,
        						   			  $order,
        						   			  $isdesc,
        						   			  $limit,
        						   			  $table,
        						   			  $extra );

        $this->_catList->setChildDataSource( 'recordList', $recds );

		// rec fields
		$fds =& new FBFieldRecSet( $this->_pageName,
								   $this->_catName,
								   $this->_catIdField,
        						   $recds,
        						   $fieldTb );

		$recList =& $this->_catList->getChild( 'recordList' );
		$recList->setChildDataSource( 'fieldList', $fds );

	    return TRUE;
	}

	//
	function &get( $field )
	{
		/* translate category name */
		switch( $field )
		{
		case 'name':
			return $this->_i18nTb[$this->_catName]['category_name'];

        case 'orgname':
        	return $this->_catName;

        default:
			return $this->recSet->get( $field );
		}
	}


}

//
//
//
class FBDetailRecBase extends ArrayDataSet
{
    var $_pageName;
    var $_catName;
    var $_catIdField;
    var $_pglang;
    var $_dblang;
    var $_recData;
    var $_i18nTb;
    var $_lastName;
    var $_lastType;
    var $_fieldTb;

    //
	function FBDetailRecBase( $pageName, $catName, $catId, $idfield,
							  $pglang, $dblang )
    {
    	$this->_pageName	= $pageName;
    	$this->_catName 	= $catName;
    	$this->_pglang		= $pglang;
    	$this->_dblang		= $dblang;
    	$this->_catIdField 	= $idfield;

    	$this->_recData 	= NULL;

    	if( $catId = -1 )
    		$this->_fieldTb =& FBSite::getCategoryFieldsByName( $pageName, $catName, TRUE );
    	else
    		$this->_fieldTb =& FBSite::getCategoryFields( $catId, TRUE );

    	if( $this->_fieldTb != NULL )
    	{
    		parent::ArrayDataSet( $this->_fieldTb );

			$this->_i18nTb  =& FBSite::getPageI18N( $pageName );
    	}
    }

    //
    function reset( )
    {
    	if( $this->_recData == NULL )
    		return FALSE;

    	return parent::reset( );
    }

    //
    function next( )
    {
    	if( $this->_recData == NULL )
    		return FALSE;

    	return parent::next( );
    }

    //
    function &get( $field )
    {
    	if( $this->_recData == NULL )
    		return NULL;

    	if( $field == 'name' )
    	{
    		$this->_lastName = parent::get( 'name' );
    		$this->_lastType = parent::get( 'type' );

    		$name =& $this->_i18nTb[$this->_catName][$this->_lastName];	// translate

    		if( strlen( $name ) == 0 )
    			return '&nbsp;';
    		else
    			return $name;
    	}
    	else
    	{
  			$value =& $this->_recData->get( $this->_lastName );

  			switch( $this->_lastType )
			{
			case 'link':
				return FBSite::renderUrlLink( $value, $value );

			case 'dynlink':
				return FBSite::renderDynUrlLink( $value, parent::get( 'attributes' ) );

			case 'shots':
				return FBSite::renderScreenshots( $this->_pageName,
												  $this->_catName,
												  $this->_recData->get( $this->_catIdField ),
												  $value );

			case 'list':
				return FBSite::renderList( $value );

			case 'time':
				return FBSite::renderTime( $value );

			default:
				if( is_null( $value ) )
					return '&nbsp;';
				else
					return $value;
			}


    	}
    }
}

class FBDetailRec extends FBDetailRecBase
{
    //
    function FBDetailRec( $pageName, $catName, $pglang, $dblang, $recId )
    {
    	$catRec =& FBSite::getPageCategory( $pageName, $catName );

    	$idfield =& $catRec->get( 'idfield' );

    	parent::FBDetailRecBase( $pageName,
    							 $catName,
    							 $catRec->get( 'id' ),
    							 $idfield,
    							 $pglang,
    							 $dblang );

    	if( $this->_fieldTb != NULL )
    	{
        	$this->_recData =& FBSite::getCategoryRecord( $pageName,
        												  $catName,
        												  $dblang,
        												  $recId,
        												  $catRec->get( 'table' ),
        												  $idfield,
        												  $catRec->get( 'extra' ) );
		}
    }

}

class FBDetailRecSet extends FBRecordSet
{
    var $_detRec;

    //
    function FBDetailRecSet( $pageName, $catName, $pglang, $dblang, &$tplObj )
    {
        $catRec =& FBSite::getPageCategory( $pageName, $catName );

    	$this->_detRec =& new FBDetailRecBase( $pageName,
    										   $catName,
    										   $catRec->get( 'id' ),
    										   $catRec->get( 'idfield' ),
    										   $pglang,
    										   $dblang );

    	if( $this->_detRec->_fieldTb != NULL )
    	{
        	parent::FBRecordSet( FBSite::getCategoryRecords( $pageName,
        						   			  	  			 $catName,
        						   			  	  			 $dblang,
        						   			  	  			 $catRec->get( 'orderby' ),
        						   			  	  			 $catRec->get( 'isdesc' ),
        						   			  	  			 $catRec->get( 'limit' ),
        						   			  	  			 $catRec->get( 'table' ),
        						   			  	  			 $catRec->get( 'extra' )
        						   			  	  			) );


			$this->_detRec->_recData =& $this;

			$reclist = $tplObj->getChild( 'recordList' );
			$reclist->setChildDataSource( 'fieldRecList', $this->_detRec );
		}
    }

}

?>
