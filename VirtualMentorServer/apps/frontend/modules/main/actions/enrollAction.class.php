<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of enrollAction
 *
 * @author markbadiola
 */
class enrollAction extends sfAction {

    public function execute($request) {
        try {
            if ($request->isMethod('get')) {
                $uid = $request->getParameter('uid');
                $cid = $request->getParameter('cid');
                $registration = new CourseRegistration();
                $registration->course = $cid;
                $registration->mentee = $uid;
                $result = Doctrine_Query::create()->select('r.id')
                                ->from('RegistrationStatus r')
                                ->where("name = 'active'")->fetchArray();
                $status = $result[0]['id'];
                $registration->status = $status;
                $registration->save();
                echo json_encode(true);
                return sfView::NONE;
            } else if ($request->isMethod('post')) {
                $uid = $request->getParameter('uid');
                $cid = $request->getParameter('cid');
                $registration = new CourseRegistration();
                $registration->course = $cid;
                $registration->mentee = $uid;
                $result = Doctrine_Query::create()->select('r.id')
                                ->from('RegistrationStatus r')
                                ->where("name = 'active'")->fetchArray();
                $status = $result[0]['id'];
                $registration->status = $status;
                $registration->save();
                echo json_encode(true);
                return sfView::NONE;
            }
        } catch (Exception $e) {
            echo json_encode($e->getMessage());
            return sfView::NONE;
        }
    }

}

?>
