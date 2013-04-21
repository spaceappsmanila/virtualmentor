<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of LoginForm
 *
 * @author markbadiola
 */
class LoginForm extends sfForm {
    public function setup() {
        parent::setup();
        
        $this->setWidgets(array(
            'email' => new sfWidgetFormInputText(),
            'password' => new sfWidgetFormInputPassword()
        ));
        
        $this->setValidators(array(
            'email' => new sfValidatorEmail(array('required' => true)),
            'password' => new sfValidatorString(array('required' => true))
        ));
        
        $this->widgetSchema->setLabels(array(
            'email' => 'Email',
            'password' => 'Password'
        ));
        
        $this->widgetSchema->setNameFormat('login[%s]');
        $this->disableCSRFProtection();
    }
}

?>
