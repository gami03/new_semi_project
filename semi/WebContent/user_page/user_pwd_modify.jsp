<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비밀번호 변경</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script src="../js/modify_user.js"></script>
	<link rel="stylesheet" href="../assets/css/main.css" />
</head>
<body>
    <table>
  <tr>
    <td colspan="2" align="center"><h2>비밀번호 변경</h2></td>
  </tr>
  <tr>
    <td><label for="current_password">현재 비밀번호:</label></td>
    <td><input type="password" id="current_password" name="current_password" required /></td>
  </tr>
  <tr>
    <td><label for="new_password">새로운 비밀번호:</label></td>
    <td><input type="password" id="new_password" name="new_password" required /></td>
  </tr>
  <tr>
    <td></td>
    <td><span id="newpwdcheck"></span></td>
  </tr>
  <tr>
    <td><label for="confirm_new_password">새로운 비밀번호 확인:</label></td>
    <td><input type="password" id="confirm_new_password" name="confirm_new_password" required /></td>
  </tr>
  <tr>
    <td></td>
    <td><span id="newconfirm_pwdcheck"></span></td>
  </tr>
  <tr>
    <td colspan="2" align="center">
      <button type="submit" class="btn btn-light" id="passwordUpdateButton">비밀번호 변경</button>
    </td>
  </tr>
</table>

</body>
</html>
