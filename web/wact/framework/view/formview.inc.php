<?php

require_once WACT_ROOT . 'template/template.inc.php';


class FormView  
{
    var $Form;
    var $Template;
	
    function FormView($TemplateFile = NULL) {
        if (!is_null($TemplateFile)) {
            $this->Template =& new Template($TemplateFile);
            $this->findForm();
        }
    }
    
    function findForm() {
        $this->Form =& $this->Template->findChildByClass('FormComponent');
    }

    function prepare(&$controller, &$request, &$responseModel) {
    }

    
    function display(&$controller, &$request, &$responseModel) {
        $this->Form->registerDataSource($responseModel);

        if (!$responseModel->isValid()) {
            $this->Form->setErrors($responseModel->getErrorList());
        }

        $this->prepare($controller, $request, $responseModel);
        $this->Template->display();
    }
    
}
?>