<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of feedbackAction
 *
 * @author markbadiola
 */
class feedbackAction extends sfAction {

    public function execute($request) {
        try {
            $uid = $request->getParameter('uid');
            $mid = $request->getParameter('mid');
            $lid = $request->getParameter('lid');

            if ($request->isMethod('get')) {
                $dblid = Doctrine_Query::create()
                        ->select('l.owner')
                        ->from('LessonPlan l')
                        ->where("l.id = $lid")
                        ->fetchArray();
                if (!$dblid || $uid != $dblid[0]['id']) {
                    throw new Exception('Action forbidden.');
                } else {
                    $qids = Doctrine_Query::create()
                            ->select('q.id')
                            ->from('Question q')
                            ->where("q.lessonplan = $lid")
                            ->fetchArray();

                    $qidsArr = array();
                    for ($i = 0; $i < count($qids); $i++) {
                        $qidsArr[$i] = $qids[$i]['id'];
                    }

                    $answers = Doctrine_Query::create()
                            ->select('*')
                            ->from('Answer a')
                            ->whereIn('a.question', $qidsArr)
                            ->andWhere('a.mentee = ?', $mid)
                            ->fetchArray();

                    //REAL OUTPUT
                    //return $this->renderText($answers);
                    //TESTER
                    $this->uid = $uid;
                    $this->mid = $mid;
                    $this->lid = $lid;
                    $feedbacks = array();
                    for ($i = 0; $i < count($qids); $i++) {
                        $feedback = new Feedback();
                        $feedback->interest = 1;
                        $feedback->questionability = 1;
                        $feedback->videochat = 1;
                        $feedback->website = 1;
                        $feedback->question = $qids[$i]['id'];
                        $feedbacks[$i] = array('answerid' => $answers[$i]['id'], 'feedback' => $feedback->exportTo('json'));
                    }
                    $this->json = json_encode($feedbacks);
                    return sfView::INPUT;
                }
            } else if ($request->isMethod('post')) {
                $json = $request->getParameter('json');
                $data = json_decode($json);
                
                foreach ($data as $datum) {
                    $fbtemp = json_decode($datum->feedback);
                    $feedback = new Feedback();
                    $feedback->interest = $fbtemp->interest;
                    $feedback->questionability = $fbtemp->questionability;
                    $feedback->videochat = $fbtemp->videochat;
                    $feedback->website = $fbtemp->website;
                    $feedback->question = $fbtemp->question;
                    $feedback->save();
                    
                    Doctrine_Query::create()
                            ->update('Answer a')
                            ->set('a.feedback', '?', $feedback->id)
                            ->execute();
                }
                
                return $this->renderText(json_encode(true));
            }
        } catch (Exception $e) {
            return $this->renderText(json_encode($e->getMessage()));
        }
    }

}

?>
