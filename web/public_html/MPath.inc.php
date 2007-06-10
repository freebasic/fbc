<?php

//
// copyleft 2004-2006 Andre Victor T. Vicentini (av1ctor[at]yahoo.com.br)
//

	require_once( WACT_ROOT . 'db/db.inc.php' );

/*
CREATE TABLE ... (
	mpath_id		INT UNSIGNED 	NOT NULL 	AUTO_INCREMENT,
	mpath_path		VARCHAR(255) 	NOT NULL,

	... user defined fields ...

	PRIMARY KEY(mpath_id),
	KEY(mpath_path)
) TYPE = MYISAM ROW_FORMAT = FIXED;
*/

//
//
//
class MPNode
{
	var $id			= NULL;
	var $level		= 0;
	var $parent 	= NULL;
	var $elements  	= array( );
	var $fieldTb   	= array( );
}

	define( 'MP__PATH_SEP', '.' );
	define( 'MP__ID_LEN',  4 );
	define( 'MP__PAD_LEFT', '0' );

//
//
//
class MPath
{
	var $table;
	var $orderBy;
	var $path;
	var $node;
	var $tree;
	var $recSet;

	//
	function MPath( $table, $orderBy = '' )
	{
    	$this->table = $table;

    	if( $orderBy != '' )
    		$this->orderBy = ' ORDER BY ' . $orderBy;
    	else
    		$this->orderBy = '';

        $this->path = '';
        $this->node = NULL;
        $this->tree = array( );
        $this->recSet =& DBC::NewRecordSet( NULL );
	}

	//
	function insertSubNode( &$fieldTb )
	{
        //
        $this->recSet->import( $fieldTb );

        $id = $this->recSet->insertId( $this->table, $fieldTb, 'mpath_id' );

		if( $id === FALSE )
			return -1;

		//
		$path = $this->path . MP__PATH_SEP .
				str_pad( dechex( $id ), MP__ID_LEN, '0', MP__PAD_LEFT );

		$query = 'UPDATE ' . $this->table . ' SET'.
				 ' mpath_path=\'' . $path . '\'' .
				 ' WHERE mpath_id=\'' . $id . '\'';

		DBC::execute( $query );

		return $id;
	}

	//
	function update( &$fieldTb )
	{
        if( $this->path == '' )
        	return FALSE;

        $this->recSet->import( $fieldTb );

		return $this->recSet->update( $this->table,
							   		  $fieldTb,
							   		  'mpath_id=\'' . $this->node->id . '\'' );
	}

	/*
	function &getPathToNode( &$nodeId )
	{
        if( ($nodeId == -1) || ($nodeId == '') )
        	return '';

        $result = DBC::getOneValue( 'SELECT mpath_path FROM ' . $this->table .
        					    	' WHERE mpath_id=\'' . $nodeId . '\'' );

		if( $result === FALSE )
			return NULL;

		return $result;
	}*/

	//
	function removeByPath( $path )
	{
		$query = 'DELETE FROM ' . $this->table .
				 ' WHERE mpath_path LIKE \'' . $path . '%\'';

		return DBC::execute( $query );
	}

	//
	function remove( )
	{
        if( $this->path == '' )
        	return FALSE;

        if( !$this->removeByPath( $this->path ) )
        	return FALSE;

        $this->path = '';
        $this->node = NULL;
        $this->tree = array( );

        return TRUE;
	}

	//
	function &_load( &$id, &$path )
	{
        $node =& new MPNode( );

        if( ($id == -1) || ($id == '') )
        	return $node;

        //
        $row =& DBC::getRowArray( 'SELECT * FROM ' . $this->table .
        					   	  ' WHERE mpath_id=\'' . $id . '\'' );

		if( count( $row ) == 0 )
			return NULL;

		$node->fieldTb = $row[0];

		//
		$node->id = $id;
		$node->level = substr_count( $node->fieldTb['mpath_path'], MP__PATH_SEP );

		//
		$path = $node->fieldTb['mpath_path'];

		return $node;
	}

	//
	function setId( &$id )
	{
        if( $this->node != NULL )
        	if( $this->node->id == $id )
        		return TRUE;

        $this->node = $this->_load( $id, $this->path );

        if( $this->node == NULL )
        {
        	$this->path = '';
        	return FALSE;
        }

        return TRUE;
	}

    //
	function _makeTree( &$tree, &$query )
	{
        // reset
        $tree = array( );

        // add root node
        $tree[0] =& new MPNode( );
        $tree[0]->id = -1;

        // for each node..
        $this->recSet->query( $query );

        $this->recSet->reset( );

        while( $this->recSet->next( ) )
        {
        	$id = (int)$this->recSet->get( 'mpath_id' );
        	$path =& $this->recSet->get( 'mpath_path' );

        	// node can exist already, because ORDER BY
        	if( !array_key_exists( $id, $tree ) )
        		$tree[$id] =& new MPNode( );

        	// fill it
        	$node = &$tree[$id];

        	$node->id = $id;
        	$node->level = substr_count( $path, MP__PATH_SEP );

        	if( $node->level > 1 )
        		$parentId = (int)hexdec( substr( $path,
        										 -(MP__ID_LEN+1+MP__ID_LEN),
        										 MP__ID_LEN ) );
        	else
        		$parentId = 0;

        	// parent node can't exist yet, see above
        	if( !array_key_exists( $parentId, $tree ) )
        		$tree[$parentId] =& new MPNode( );

        	$node->parent =& $tree[$parentId];

        	$node->fieldTb = $this->recSet->export( );

        	// add to parent's list
        	$tree[$parentId]->elements[] =& $node;
        }
	}

	//
	function &getTreeByPath( $path )
	{
        $query = 'SELECT * FROM ' . $this->table;

        if( strlen( path ) > 0 )
       		$query .= ' WHERE mpath_path LIKE \'' . $path . '%\' ';

        $query .= $this->orderBy;

        $this->_makeTree( $this->tree, $query );

        return ( $this->node == NULL? $this->tree[0]: $this->tree[$this->node->id] );
	}


	//
	function &getTree( )
	{
        return $this->getTreeByPath( $this->path );
	}

	//
	function &getParentTree( )
	{
        //
        if( strlen( $this->path ) == 0 )
        {
        	$this->tree = array( );
        	return NULL;
        }

        //
        $in_str = '';
        $len = strlen( $this->path );
        while( $len > 0 )
        {
        	$in_str .= "'" . substr( $this->path, 0, $len ) . "',";
        	$len -= (MP__ID_LEN + 1);
        }

        $in_str = substr( $in_str, 0, -1 );

        //
        $query = 'SELECT * FROM ' . $this->table .
        		 ' WHERE mpath_path IN (' . $in_str . ')';

    	$this->_makeTree( $this->tree, $query );

        return ( $this->node == NULL? $this->tree[0]: $this->tree[$this->node->id] );
    }

	//
	function getParent( )
	{
        if( strlen( $this->path ) < (MP__ID_LEN+1)*2 )
        	return -1;

        return hexdec( substr( $this->path, -((MP__ID_LEN+1)*2), MP__ID_LEN+1 ) );
	}
}

?>
