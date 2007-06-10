<?php


set_magic_quotes_runtime(0);


define('WACT_ROOT', dirname(__FILE__) . '/');


if ( !defined('WACT_MAIN_DIR') ) {
    if ( php_sapi_name() != 'cli' ) {
        define('WACT_MAIN_DIR',getcwd());
    } else {
                define('WACT_MAIN_DIR',dirname(getcwd().'/'.$_SERVER['SCRIPT_FILENAME']));
    }
}


if (!function_exists('is_a')) {
    require_once WACT_ROOT . 'util/phpcompat/is_a.php';
}

if (! defined('WACT_ERROR_FACTORY')) {
    define('WACT_ERROR_FACTORY', WACT_ROOT . 'error/factory/wact.inc.php');
}

if (! defined('WACT_ERROR_HANDLER')) {
    define('WACT_ERROR_HANDLER', WACT_ROOT . 'error/handler/debug.inc.php');
}


function RaiseError($group, $id, $info=NULL) {
    require_once WACT_ERROR_FACTORY;
    RaiseErrorHandler($group, $id, $info);
}


function ErrorHandlerDispatch($ErrorNumber, $ErrorMessage, $FileName, $LineNumber) {

    if ( ( $ErrorNumber & error_reporting() ) != $ErrorNumber ) {
        return;     }

    require_once WACT_ERROR_HANDLER;
    HandleError($ErrorNumber, $ErrorMessage, $FileName, $LineNumber);
}

if (set_error_handler('ErrorHandlerDispatch') !== NULL) {
    restore_error_handler();
}

if (! defined('WACT_CONFIG_MODULE')) {
    define('WACT_CONFIG_MODULE', WACT_ROOT . 'config/ini/single.inc.php');
}
require_once WACT_CONFIG_MODULE;

?>