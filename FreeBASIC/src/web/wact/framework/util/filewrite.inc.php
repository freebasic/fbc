<?php



function EnsureDirectoryExists($dirname) {
	$open_basedir = ini_get('open_basedir');
	if($open_basedir && substr($dirname, 0, strlen($open_basedir)) == $open_basedir){
		$path = $open_basedir;
		$dirname = substr($dirname, strlen($open_basedir));
	} else {
		$path = '';
	}
	foreach (explode('/', $dirname) as $dir) {
		$path  .= $dir . '/';
		if (!file_exists($path)) {
			if (!@mkdir($path, 0777)) {
                RaiseError('compiler', 'CANNOTCREATEDIRECTORY', array(
                    'path' => $path));
			}
		}
	}
}


function WriteFile($file, $data) {
	EnsureDirectoryExists(dirname($file));
	$fp=fopen($file, "wb");
	if (fwrite($fp, $data, strlen($data))){
		  fclose($fp);
	}
}

?>