<?php



class DataSpaceMapper {
	
	var $map=array();

	
	function DataSpaceMapper($map) {
		$this->map = $map;
	}

	
	function doFilter(&$vars) {
		foreach ( $this->map as $ref => $name ) {
			if ( isset($vars[$name]) ) {
				if ( isset($vars[$ref]) ) {
					RaiseError('runtime','MAP_VAR_EXISTS',array(
						'mapfrom'=>$name,
						'mapto'=>$ref
						));
				} else {
					$vars[$ref] = $vars[$name];
					$vars[$name]=NULL;
				}
			}
		}
	}
}
?>