<?php


require_once WACT_ROOT . 'template/template.inc.php';


class View
{
    var $Template;

    function View($TemplateFile = NULL) {
        if (!is_null($TemplateFile)) {
            $this->Template =& new Template($TemplateFile);
        }
    }

    function prepare(&$controller, &$request, &$responseModel) {
    }

    function display(&$controller, &$request, &$responseModel) {
        $this->Template->registerDataSource($responseModel);
        $this->prepare($controller, $request, $responseModel);
        $this->Template->display();
    }
}

?>
