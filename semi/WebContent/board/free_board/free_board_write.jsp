<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="assets/css/main.css" />
<noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>

<!-- summernote 위해 필요한 js, css -->

<script src="https://code.jquery.com/jquery-3.5.1.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>

<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>

<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>


<!-- <script src="../assets/js/summernote/summernote-lite.js"></script>
<script src="../assets/js/summernote/lang/summernote-ko-KR.js"></script>

<link rel="stylesheet" href="../assets/css/summernote/summernote-lite.css">

<script type="text/javascript">
$(document).ready(function() {
	//여기 아래 부분
	$('#summernote').summernote({
		  height: 300,                 // 에디터 높이
		  minHeight: null,             // 최소 높이
		  maxHeight: null,             // 최대 높이
		  focus: true,                  // 에디터 로딩후 포커스를 맞출지 여부
		  lang: "ko-KR",					// 한글 설정
		  placeholder: '최대 2048자까지 쓸 수 있습니다'	//placeholder 설정
          
	});
});
</script> -->
<!-- summernote 위해 필요한 js, css end-->

<style type="text/css">

#free_board_title{
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

	function check(){
		
		if(f.user_id.value==""){
			alert("아이디를 입력하세요.");
			f.user_id.focus();
			return false;
		}
		if(f.user_pwd.value==""){
			alert("비밀번호를 입력하세요.");
			f.user_pwd.focus();
			return false;
		}
	}

</script>

<script type="text/javascript">
	function writeCheck(){
		
			alert("글쓰기 권한이 없습니다.");
	}
</script>

</head>
<body class="is-preload">
	<!-- Wrapper -->
		<div id="wrapper">

			<!-- Header -->
				<header id="header">
					<div class="inner">

						<!-- Logo -->
							<a href="index.html" class="logo">
								<span class="symbol"><img src="images/logo.svg" alt="" /></span><span class="title">Phantom</span>
							</a>

						<!-- Nav -->
							<nav>
								<form method="post" name="f"  action="<%=request.getContextPath()%>/login_check.do" onsubmit="return check()" align="center">
									
								<c:set var="id" value="${user_id }" />
								<c:if test="${empty id }">
									<ul>
										<li><input type="button" class="btn btn-primary" name="login" value="로그인" data-toggle="modal" data-target="#boardModal"></li>
										<li><a href="#menu">Menu</a></li>
									</ul>
									
									<!-- Modal -->
									<div class="modal fade" id="boardModal" tabindex="-1" aria-labelledby="boardModalLabel" aria-hidden="true">
									  <div class="modal-dialog">
									    <div class="modal-content">
									      <div class="modal-header">
									        <h5 class="modal-title" id="boardModalLabel">로그인 모달창</h5>
									        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
									          <span aria-hidden="true">&times;</span>
									        </button>
									      </div>
									      <div class="modal-body">
										
											<table border="1" cellspacing="0" width="400">
												<tr>
													<th>아이디</th>
													<td> <input type="text" name="user_id"></td>
												</tr>
											
												<tr>
													<th>비밀번호</th>
													<td> <input type="password" name="user_pwd"></td>
												</tr>
											
												
											
											</table>
											<br>
											<div class="submit1" align="center">
												<input class="submit_btn btn-primary" type="submit" value="로그인" >
											</div>
									      </div>
									    </div>
									  </div>
									</div>
								</c:if>
								<br>
								
								<c:if test="${!empty id }">
									<ul>
										<li><input type="button" name="login" value="로그아웃" onclick="location.href='logintest/logout.jsp'"></li>
										<li><a href="#menu">Menu</a></li>
									</ul>
								</c:if>
								</form>
							</nav>

					</div>
				</header>

			<!-- Menu -->
				<nav id="menu">
					<h2>Menu</h2>
					<ul>
						<li><a href="index.jsp">Home</a></li>
						<li><a href="<%=request.getContextPath() %>/free_board_list.do">자유게시판</a></li>
						<li><a href="">판매게시판</a></li>
						<li><a href="">Q&A</a></li>
						<li><a href="">마이페이지</a></li>
					</ul>
				</nav>

	<!-- Main -->
	<div align="center" style="margin-bottom: 150px;">
		<hr width="50%" color="marmoon">
			<h3>자유게시판</h3>
		<hr width="50%" color="marmoon">
		<br>
		
		<c:set var="session" value="${user_id }" />
		<%-- enctype : 파일을 업로드하기 위한 속성 --%>
		<form method="post" enctype="multipart/form-data" action="<%=request.getContextPath() %>/free_board_write_ok.do?id=${user_id }">
			<table border="1" cellspacing="0" width="50%" class="col-9">
				<tr>
					<th>제목</th>
					<td> <input name="free_board_title" id="free_board_title" style=""> </td>
				</tr>
				
				<tr>
					<th>카테고리</th>
					<td>
						<select name="free_board_category" style="width:30%;">
			   			<option value="auction">경매</option>
			   			<option value="funny">유머</option>
			   			<option value="curious">궁금해요</option>
			   			<option value="etc">기타</option>
			   		</select>
					</td>
				</tr>
				
				<tr>
					<th>첨부파일</th>
					<td> <input type="file" name="upload_file1">
						 <br><br>
						 <input type="file" name="upload_file2">
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
	
	<!-- Footer -->
	<footer id="footer">
		<div class="inner">
			<section>
				<h2>Get in touch</h2>
				<!-- form은 추후 삭제 또는 F&B 메시지 보내는 걸로 사용 -->
				<form method="post" action="#">
					<div class="fields">
						<div class="field half">
							<input type="text" name="name" id="name" placeholder="Name" />
						</div>
						<div class="field half">
							<input type="email" name="email" id="email" placeholder="Email" />
						</div>
						<div class="field">
							<textarea name="message" id="message" placeholder="Message"></textarea>
						</div>
					</div>
					<ul class="actions">
						<li><input type="submit" value="Send" class="primary" /></li>
					</ul>
				</form>
			</section>
			<section>
				<h2>Follow</h2>
				<ul class="icons">
					<li><a href="#" class="icon brands style2 fa-twitter"><span class="label">Twitter</span></a></li>
					<li><a href="#" class="icon brands style2 fa-facebook-f"><span class="label">Facebook</span></a></li>
					<li><a href="#" class="icon brands style2 fa-instagram"><span class="label">Instagram</span></a></li>
					<li><a href="#" class="icon brands style2 fa-dribbble"><span class="label">Dribbble</span></a></li>
					<li><a href="#" class="icon brands style2 fa-github"><span class="label">GitHub</span></a></li>
					<li><a href="#" class="icon brands style2 fa-500px"><span class="label">500px</span></a></li>
					<li><a href="#" class="icon solid style2 fa-phone"><span class="label">Phone</span></a></li>
					<li><a href="#" class="icon solid style2 fa-envelope"><span class="label">Email</span></a></li>
				</ul>
			</section>
			<ul class="copyright">
				<li>&copy; Untitled. All rights reserved</li><li>Design: <a href="http://html5up.net">HTML5 UP</a></li>
			</ul>
		</div>
	</footer>
	
	
	</div>
	
	<!-- Scripts -->
	<script src="assets/js/jquery.min.js"></script>
	<script src="assets/js/browser.min.js"></script>
	<script src="assets/js/breakpoints.min.js"></script>
	<script src="assets/js/util.js"></script>
	<script src="assets/js/main.js"></script>

</body>
</html>