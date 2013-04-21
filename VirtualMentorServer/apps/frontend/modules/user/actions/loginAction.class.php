<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of loginAction
 *
 * @author markbadiola
 */
class loginAction extends sfAction {

    public function execute($request) {
        try {
            $this->form = new LoginForm();
            if ($request->isMethod('get')) {
                return sfView::INPUT;
            } else if ($request->isMethod('post')) {
                $this->form->bind($request->getParameter('login'));
                if (!$this->form->isValid()) {
                    $errors = $this->form->getErrorSchema()->getMessage();
                    throw new Exception($errors);
                } else {
                    $email = $this->form->getValue('email');
                    $pass = $this->form->getValue('password');
                    $logindtls = Doctrine_Query::create()->select('u.id, u.email, u.password, m.name')
                                    ->from('member u')->innerJoin('u.Membership m')
                                    ->where("u.email = '$email'")->fetchArray();
                    
                    $hasher = new PasswordHash(sfConfig::get('app_pw_iteration'), sfConfig::get('app_pw_portability'));

                    if ($hasher->CheckPassword($pass, $logindtls[0]['password'])) {
                        $this->getUser()->setAuthenticated(true);
                        $this->getUser()->addCredentials(array('membership'=>$logindtls[0]['Membership']['name'], 'uid' => $logindtls[0]['id']));
                        echo json_encode($logindtls[0]['id']);
                        return sfView::NONE;
                    } else {
                        return $this->renderText(json_encode(false));
                    }
                    return sfView::NONE;
                }
            }
            return sfview::NONE;
        } catch (Exception $e) {
            echo json_encode($e->getMessage());
            return sfView::NONE;
        }
    }

}