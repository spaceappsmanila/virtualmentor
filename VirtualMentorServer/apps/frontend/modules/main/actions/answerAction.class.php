<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of answerAction
 *
 * @author markbadiola
 */
class answerAction extends sfAction {
    public function execute($request) {
        try {
            $this->uid = $request->getParameter('uid');
            $this->cid = $request->getParameter('cid');
            $this->lid = $request->getParameter('lid');
            if($request->isMethod('get')) {
                $qids = Doctrine_Query::create()
                        ->select('q.id')
                        ->from('Question q')
                        ->where("q.lessonplan = $this->lid")
                        ->fetchArray();
                
                $arr = array();
                for($i=0;$i<count($qids);$i++) {
                    $arr[$i] = " \"".$qids[$i]['id']."\" : \"Answer $i\"";
                }
                
                $this->json = '{'.implode(', ', $arr).'}';
                return sfView::INPUT;
            } else if($request->isMethod('post')) {
                $json = json_decode($request->getParameter('json'));
                
                foreach($json as $q=>$a) {
                    $answer = new Answer();
                    $answer->mentee = $this->uid;
                    $answer->question = $q;
                    $answer->answer = $a;
                    $answer->save();
                }
                
                return $this->renderText(json_encode(true));
            }
        } catch (Exception $e) {
            return $this->renderText(json_encode($e->getMessage()));
        }
    }
}

?>
