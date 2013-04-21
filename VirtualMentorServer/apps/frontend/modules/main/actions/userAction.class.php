<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of userAction
 *
 * @author markbadiola
 */
class userAction extends sfAction {
    public function execute($request) {
        try {
            //if($request->isMethod('get')) {
                $id = $request->getParameter('uid');
                if($id && $this->getUser()->hasCredential($id)) {
                    $uprofile = Doctrine_Query::create()
                            ->select('m.id, m.firstname, m.lastname, m.email, m.membership')
                            ->from('Member m')
                            ->where("m.id = $id")
                            ->fetchArray();
                    return $this->renderText(json_encode($uprofile));
                }
            //}
        } catch (Exception $e) {
            echo json_encode($e->getMessage());
            return sfView::NONE;
        }
    }
}

?>
