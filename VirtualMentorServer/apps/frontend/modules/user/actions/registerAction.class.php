<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of registerAction
 *
 * @author markbadiola
 */
class registerAction extends sfAction {

    public function execute($request) {
        try {
            $this->form = new RegistrationForm();
            if ($request->isMethod('get')) {
                $membertype = $request->getParameter('type');
                $typeid = 0;
                if ($membertype) {
                    $tblMembership = MembershipTable::getInstance();
                    $results = $tblMembership->findBy('name', $membertype, Doctrine_Core::HYDRATE_ARRAY);
                    if ($results) {
                        $typeid = $results[0]['id'];
                        $this->type = $membertype;
                    } else {
                        throw new Exception("Invalid user type registration. Attempt to register type $membertype.");
                    }
                } else {
                    throw new Exception('Invalid user type registration.');
                }
                
                $this->form->setDefault('membership', $typeid);
                return sfView::INPUT;
            } else if($request->isMethod('post')) {
                $this->form->bind($request->getParameter('member'));
                if(!$this->form->isValid()) {
                    $errors = $this->form->getErrorSchema()->getMessage();
                    throw new Exception($errors);
                } else {
                    $hasher = new PasswordHash(intval(sfConfig::get('app_pw_iteration'))
                            , (bool)sfConfig::get('app_pw_portability'));
                    $member = new Member();
                    $member->firstname = trim($this->form->getValue('firstname'));
                    $member->lastname = trim($this->form->getValue('lastname'));
                    $member->email = trim($this->form->getValue('email'));
                    $member->password = $hasher->HashPassword($this->form->getValue('password'));
                    $member->membership = $this->form->getValue('membership');
                    $member->save();
                    
                    echo json_encode(true);
                    return sfView::NONE;
                }
            }
        } catch (Exception $e) {
            echo json_encode($e->getMessage());
            return sfView::NONE;
        }
    }

}

?>
