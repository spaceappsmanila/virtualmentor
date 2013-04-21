<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of logoutAction
 *
 * @author markbadiola
 */
class logoutAction extends sfAction {
    public function execute($request) {
        $this->getUser()->setAuthenticated(false);
        $this->getUser()->clearCredentials();
        echo json_encode(true);
        return sfView::NONE;
    }
}

?>
