<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<jsp:include page="/include/main_top.jsp" />

<!-- summernote 위해 필요한 js, css -->

<script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>

<style type="text/css">

#notice_board_title{
	border-left: none;
	border-top: none;
	border-right: none;
	border-bottom: 1px solid lightgray;
	width:60%; 
	background: transparent;
}
</style>

<style type="text/css">
.pagination{
justify-content: center;
}
</style>


<script type="text/javascript">
	function writeCheck(){
		
			alert("글쓰기 권한이 없습니다.");
	}
	
	// upload_file1이 존재할 경우 upload_file2를 활성화시키는 등의 작업 수행
	function checkUpload1() {
		  var file1 = document.getElementsByName('upload_file1')[0];
		  if (file1.value == "") {
		    alert("1번 파일을 먼저 선택해주세요.");
		    return false;
		  }
		return true;
	}
</script>

</head>


	<!-- Main -->
	<div align="center" style="margin-bottom: 150px; padding-top: 0;" id="main">
		<div class="board_banner">
			<p style="font-family: 'Cafe24Ssurround'; font-size: 40px;">공지사항</p>
		</div>
		
		<c:set var="session" value="${user_id }" />
		<c:set var="dto" value="${Modify }" />
		<%-- enctype : 파일을 업로드하기 위한 속성 --%>
		<form method="post" enctype="multipart/form-data" action="<%=request.getContextPath() %>/board_write_ok.do?id=${user_id }&board_name=notice_board">
			<table border="1" cellspacing="0">
				<tr>
					<th>제목</th>
					<td> <input name="notice_board_title" id="notice_board_title" style=""> </td>
				</tr>
				
				<tr>
					<th>첨부파일</th>
					<td> <input type="file" name="upload_file1">
						 <br><br>
						 <input type="file" name="upload_file2" onclick="return checkUpload1()">
						 <br>
						 <br>
						 <span>* 첨부파일 형식 : jpg, png, pdf, zip 등 형식으로 10MB 이하 파일 첨부</span>
						 <br>
						 <span>* 보안 정책상 위반되는 파일은 업로드 불가</span>
					</td>
				</tr>
				
				<tr>
					<td colspan="2"><textarea id="summernote" name="editordata"></textarea></td>
					<script type="text/javascript">
				      $('#summernote').summernote({
				        placeholder: '내용을 입력하세요.',
				        tabsize: 2,
				        height: 400
				      });
    				</script>
				</tr>
			</table>
			
			<input type="submit" value="완료">&nbsp;&nbsp;
			<input type="button" value="취소" onclick="history.back()">
		</form>
	</div>
	
	<jsp:include page="/include/main_bottom.jsp" />