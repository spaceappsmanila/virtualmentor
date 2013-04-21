<h1>Feedback Form</h1>
<form action="<?php echo url_for("feedback", array('uid'=>$uid, 'mid' => $mid, 'lid'=>$lid)); ?>" method="post">
    <table>
        <tr>
            <th>JSON</th>
            <td>
                <textarea name="json"><?php echo $json; ?></textarea>
            </td>
        </tr>
        <tr>
            <td colspan="2"><input type="submit"/></td>
        </tr>
    </table>
</form>