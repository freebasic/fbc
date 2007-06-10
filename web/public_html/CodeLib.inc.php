<?php

//
// copyleft 2004-2006 Andre Victor T. Vicentini (av1ctor[at]yahoo.com.br)
//

	require_once( 'MPath.inc.php' );

	define( FB_CODELIB_CATTABLE, 'fb_codelib_categories' );
	define( FB_CODELIB_SNIPTABLE, 'fb_codelib_snippets' );
	define( FB_CODELIB_FILETABLE, 'fb_codelib_files' );
	define( FB_CODELIB_ORDERBY, 'name' );

	define( FB_CODELIB_MAXNAMELEN, '31' );
	define( FB_CODELIB_MAXDESCLEN, '255' );
	define( FB_CODELIB_MAXCODELEN, '4093' );

/*
CREATE TABLE ... (
	mpath_id		INT UNSIGNED 	NOT NULL 	AUTO_INCREMENT,
	mpath_path		VARCHAR(255) 	NOT NULL,

	name char(32) NOT NULL default '',
	description char(128) NOT NULL default '',
	snippets int unsigned default 0,

	PRIMARY KEY(mpath_id),
	KEY name (name),
	KEY mpath_path (mpath_path)
) TYPE=InnoDB;
*/

//
//
//
class CodeLibCategory
{
	var $table;
	var $path;
	var $id;

	//
	function CodeLibCategory( $table = FB_CODELIB_CATTABLE )
	{
		$this->table = $table;
		$this->path =& new MPath( $table, FB_CODELIB_ORDERBY );
		$this->id = -1;
    }

	//
	function setId( $id )
	{
        if( $this->path->setId( $id ) )
        {
        	$this->id = $id;
        	return TRUE;
        }

        return FALSE;
    }

	//
	function &getPath( $setLast = TRUE )
	{
		$pathTb = array( );

		if( $this->id == -1 )
			 return $pathTb;

		$node =& $this->path->getParentTree( );

		if( $node == NULL )
			return $pathTb;

		$cnt = 0;
		do
		{
			$item =& $pathTb[$cnt++];

			$item['catid'] = $node->id;
			$item['name'] = $node->fieldTb['name'];
			$item['desc'] = $node->fieldTb['description'];

			$node = &$node->parent;
		} while( ($node != NULL) && (count( $node->fieldTb ) != 0) );

		if( $setLast )
			$pathTb[0]['isLast'] = TRUE;

		return array_reverse( $pathTb );
	}

	//
	function _addNode( &$node, &$listTb, &$ctx )
	{
		$item = NULL;

		if( $node->id != $ctx['topid'] )
		{
            $snippets = $node->fieldTb['snippets'];

			if( $ctx['nesting'] <= $ctx['maxnest'] )
			{
				$item =& $listTb[$ctx['cnt']++];

            	$item['catid'] = $node->id;
            	$item['name'] = $node->fieldTb['name'];
            	$item['desc'] = $node->fieldTb['description'];
				$item['indent'] = str_repeat( "&nbsp; ", $node->level - $ctx['toplevel'] );
			}
		}
		else
			$snippets = 0;

		++$ctx['nesting'];

		foreach( $node->elements as $e )
				$snippets += $this->_addNode( $e, $listTb, $ctx );

		--$ctx['nesting'];

		if( $item != NULL )
			$item['cnt'] = $snippets;

		return $snippets;
	}

	//
	function &getList( $topOnly = FALSE )
	{
		$listTb = array( );

        $node =& $this->path->getTree( );

        $ctx['cnt'] = 0;
        $ctx['topid'] = $node->id;
        $ctx['toplevel'] = $node->level + 1;
        $ctx['nesting'] = 0;
        $ctx['maxnest'] = ($topOnly? 1: 65545);

        $this->_addNode( $node, $listTb, $ctx );

        return $listTb;
	}

	//
	function insertSub( &$name, &$desc )
	{
		$tb = array( 'name' => DBC::makeLiteral( $name, 'string' ),
					 'description' => DBC::makeLiteral( $desc, 'string' ) );
		return $this->path->insertSubNode( $tb );
	}

	//
	function update( &$name, &$desc )
	{
		if( $this->id == -1 )
			return FALSE;

		$tb = array( 'name' => DBC::makeLiteral( $name, 'string' ),
					 'description' => DBC::makeLiteral( $desc, 'string' ) );

        return $this->path->update( $tb );
	}

	//
	function remove( )
	{
		if( $this->id == -1 )
			return FALSE;

		return $this->path->remove( );
	}

	//
	function incCount( $category )
	{
		$query = 'UPDATE ' . $this->table . ' SET'.
				 ' snippets = snippets + 1' .
				 ' WHERE mpath_id=\'' . $category . '\'';

		return DBC::execute( $query );
    }

	//
	function decCount( $category )
	{
		$query = 'UPDATE ' . $this->table . ' SET'.
				 ' snippets = snippets - 1' .
				 ' WHERE mpath_id=\'' . $category . '\'';

		return DBC::execute( $query );
    }

	//
	function getParent( )
	{
		if( $this->id == -1 )
			return -1;

		return $this->path->getParent( );
	}

	//
	function &getName( )
	{
		if( $this->id == -1 )
			return '';

		return $this->path->node->fieldTb['name'];
	}

	//
	function &getDescription( )
	{
		if( $this->id == -1 )
			return '';

		return $this->path->node->fieldTb['description'];
	}
}

/*
CREATE TABLE ... (
	id int UNSIGNED NOT NULL AUTO_INCREMENT,
	category_id int UNSIGNED NOT NULL default '0',
	author_id int UNSIGNED NOT NULL default '0',
	name char(32) NOT NULL default '',
	description text NOT NULL default '',

	PRIMARY KEY (id),
	KEY category_id (category_id),
	KEY author_id (author_id),
	KEY name (name),
	FOREIGN KEY (category_id) REFERENCES codelib_categories(mpath_id)
		ON UPDATE CASCADE ON DELETE CASCADE
) TYPE=InnoDB;

CREATE TABLE ... (
	id int UNSIGNED NOT NULL AUTO_INCREMENT,
	snippet_id int UNSIGNED NOT NULL default '0',
	name char(32) NOT NULL default '',
	format char(16) NOT NULL default 'fb',
	description char(128) NOT NULL default '',
	modified datetime NOT NULL default '0000-00-00 00:00:00',
	text longtext NOT NULL,

	PRIMARY KEY (id),
	KEY snippet_id (snippet_id),
	FOREIGN KEY (snippet_id) REFERENCES codelib_snippets(id)
		ON UPDATE CASCADE ON DELETE CASCADE
) TYPE=InnoDB;
*/

//
//
//
class CodeLibCode
{
    var $cat;
    var $table;
    var $fileTable;
    var $userTable;
    var $recSet;

	//
	function CodeLibCode( &$cat,
						  $table = FB_CODELIB_SNIPTABLE,
						  $fileTable = FB_CODELIB_FILETABLE,
						  $userTable = FBUSER_TABLE )
	{
		$this->cat =& $cat;
		$this->table = $table;
		$this->fileTable = $fileTable;
		$this->userTable = $userTable;
		$this->recSet =& DBC::NewRecordSet( NULL );
	}

	//
	function add( &$category, &$user, &$name, &$desc )
	{
        static $descTb = array( 'category_id' => 'string',
        						'author_id' => 'string',
        						'name' => 'string',
        						'description' => 'string' );


        $fieldTb = array( 'category_id' => $category,
                		  'author_id' => $user,
        				  'name' => $name,
        				  'description' => $desc );

        $this->recSet->import( $fieldTb );

        $id = $this->recSet->insertId( $this->table, $descTb, 'id' );
        if( $id === FALSE )
        	return -1;

		$this->cat->incCount( $category );

        return $id;
	}

	//
	function addFiles( &$id, $files, &$fileTb )
	{
        static $descTb = array( 'snippet_id' => 'string',
        						'name' => 'string',
        						'description' => 'string',
        						'text' => 'string',
        						'modified' => 'string' );


        for( $i = 0; $i < $files; $i++ )
        {
        	$fieldTb = array( 'snippet_id' => $id,
        				  	  'name' => $fileTb[$i]['name'],
        				  	  'description' => $fileTb[$i]['description'],
        				  	  'text' => addslashes( $fileTb[$i]['text'] ),
        				  	  'modified' => date( 'Y-m-d H:i:s' ) );

        	$this->recSet->import( $fieldTb );

        	$id = $this->recSet->insertId( $this->fileTable, $descTb, 'id' );
        	if( $id === FALSE )
        		return 0;
		}

		return $files;
	}

	//
	function update( &$id, &$name, &$desc )
	{
        static $descTb = array( 'name' => 'string',
        						'description' => 'string' );


        $fieldTb = array( 'name' => $name,
        				  'description' => $desc );

        $this->recSet->import( $fieldTb );

		if( !$this->recSet->update( $this->table,
        							$descTb,
        							'id = \'' . $id . '\'' ) )
			return FALSE;

        return TRUE;
	}

	//
	function updateFiles( &$id, $files, &$fileTb )
	{
        static $descTb = array( 'name' => 'string',
        						'description' => 'string',
        						'text' => 'string',
        						'modified' => 'string' );


        for( $i = 0; $i < $files; $i++ )
        {
        	$fieldTb = array( 'name' => $fileTb[$i]['name'],
        				  	  'description' => $fileTb[$i]['description'],
        				  	  'text' => addslashes( $fileTb[$i]['text'] ),
        				  	  'modified' => date( 'Y-m-d H:i:s' ) );

        	$this->recSet->import( $fieldTb );

			if( !$this->recSet->update( $this->fileTable,
        								$descTb,
        								'id = \'' . $fileTb[$i]['id'] . '\'' .
        								' and snippet_id = \'' . $id . '\'' ) )
        		return 0;
		}

		return $files;
	}

	//
	function del( $id, $category )
	{
		$query = 'DELETE FROM ' . $this->table .
				 ' WHERE id = \'' . $id . '\'';

		if( !DBC::execute( $query ) )
			return FALSE;

		return $this->cat->decCount( $category );
	}

	//
	function &getList( $category )
	{
        $listTb = array( );

        if( $category == -1 )
        	return $listTb;

        $query = 'SELECT * FROM ' . $this->table .
        		 ' WHERE category_id = \'' . $category . '\'' .
				 ' ORDER BY name';

        // for each node..
        $this->recSet->query( $query );

        $this->recSet->reset( );

        while( $this->recSet->next( ) )
        	$listTb[] = $this->recSet->export( );

        return $listTb;
   }

	//
	function &load( $id )
	{
        $query = 'SELECT * FROM ' . $this->table .
        		 ' WHERE id = \'' . $id . '\'';

		$row =& DBC::getRowArray( $query );

		if( count( $row ) == 0 )
			return NULL;

		$fieldTb = $row[0];

        $query = 'SELECT id, text FROM ' . $this->fileTable .
        		 ' WHERE snippet_id = \'' . $id . '\'';

        $this->recSet->query( $query );

        $this->recSet->reset( );

        $i = 0;
        while( $this->recSet->next( ) )
        {
			$fieldTb['fileTb'][$i]['id'] = $this->recSet->get( 'id' );
			$fieldTb['fileTb'][$i]['text'] = stripslashes( $this->recSet->get( 'text' ) );
            ++$i;
        }

        $fieldTb['files'] = $i;

		return $fieldTb;
	}

	//
	function loadAuthor( &$fieldTb )
	{
        $query = 'SELECT username,user_email FROM ' . $this->userTable .
        		 ' WHERE user_id=\'' . $fieldTb['author_id'] . '\'';

		$row =& DBC::getRowArray( $query );

		if( count( $row ) == 0 )
			return FALSE;

		$fieldTb['author_name'] = $row[0]['username'];
		$fieldTb['author_email'] = $row[0]['user_email'];

		return TRUE;
	}
}

?>
