<?php



function UndoMagicSlashing(&$var) {
	if(is_array($var)) {
		while(list($key, $val) = each($var)) {
			UndoMagicSlashing($var[$key]);
		}
	} else {
		$var = stripslashes($var);
	}
}


if (get_magic_quotes_gpc()) {
	UndoMagicSlashing($_GET);
	UndoMagicSlashing($_POST);
	UndoMagicSlashing($_COOKIES);
	UndoMagicSlashing($_REQUEST);
}


class Request {

    function hasParameters() {
        return count($_GET) > 0;
    }

    function hasParameter($name) {
        return isset($_GET[$name]);
    }

    function getParameter($name) {
        if (isset($_GET[$name])) {
            return $_GET[$name];
        }
    }

    function hasPostProperty($name) {
        if (!strcasecmp($_SERVER['REQUEST_METHOD'], 'POST')) {
            return isset($_POST[$name]);
        } else {
            return isset($_GET[$name]);
        }
    }

    function getPostProperty($name) {
        if (!strcasecmp($_SERVER['REQUEST_METHOD'], 'POST')) {
            if (isset($_POST[$name])) {
                return $_POST[$name];
            }
        } else {
            if (isset($_GET[$name])) {
                return $_GET[$name];
            }
        }
    }

    function exportPostProperties() {
        if (!strcasecmp($_SERVER['REQUEST_METHOD'], 'POST')) {
            return $_POST;
        } else {
            return $_GET;
        }
    }

    function getMethod() {
        return $_SERVER['REQUEST_METHOD'];
    }

    function getPathInfo() {
        if (isset($_SERVER['PATH_INFO'])) {
            return $_SERVER['PATH_INFO'];
        }
    }
}

?>
