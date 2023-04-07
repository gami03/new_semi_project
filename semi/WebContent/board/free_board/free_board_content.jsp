<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<%-- jQuery 사용위한 스크립트 --%>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.6.1.js"></script>

<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="assets/css/main.css" />
<noscript><link rel="stylesheet" href="assets/css/noscript.css" /></noscript>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css" integrity="sha384-xOolHFLEh07PJGoPkLv1IbcEPTNtaed2xpHsD9ESMhqIYd0nLMwNLD69Npy4HI+N" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-Fy6S3B9q64WdZWQUiU+q4/2Lc9npb8tCaSX9FK7E8HnRr0Jz8D6OP9dO5Vg3Q9ct" crossorigin="anonymous"></script>

<script src="https://cdn.jsdelivr.net/npm/jquery@3.5.1/dist/jquery.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.min.js" integrity="sha384-+sLIOodYLS7CIrQpBjl+C7nPvqq+FbNUBDunl/OZv93DB7Ln/533i8e/mZXLi/P+" crossorigin="anonymous"></script>

<style type="text/css">
.pagination{
justify-content: center;
}

.txt1{
	padding-right : 20%;
	font-weight: bold;
	font-size: 18px;
}

.txt2{
	padding-left : 30%;
}

.content{
	background-color: white;
	
}

.reply {
	display: flex;
	justify-content: center;
	align-items: center;
}

#reply-wrap {
	align: center;
	margin-bottom: 80px; 
	background-color: #f7f7f7;
    padding-top: 30px;
    padding-bottom: 20px;
    width: 75%;
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
		
			alert("로그인 후 다시 시도해주세요.");
	}
	
	function heartcheck() {
		
		alert("좋아요는 로그인 후 가능합니다.")
	}
	
	function validateComment() {
		  var commentContent = document.getElementById("comment-content").value;
		  if (commentContent.trim() == "") {
		    alert("댓글 내용을 작성해주세요.");
		    return false;
		  }
		  return replywrite();
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
	<div align="center">
		<hr width="50%" color="marmoon">
			<h3>자유게시판</h3>
		<hr width="50%" color="marmoon">
		<br>
		
		<c:set var="dto" value="${Content }"/>
		<table border="1" cellspacing="0" width="50%" class="col-9">
			
			<c:if test="${!empty dto }">
				<tr>
					<td><span class="txt1">${dto.getBoard_title() }</span> <span class="txt2">${Nickname } | ${dto.getBoard_date().substring(0, 10) }</span></td>
				</tr>
				
				<tr>
					<c:set var="board_id" value="${board_id }" />
					<c:if test="${!empty dto.getBoard_file1() }">
						<td> 첨부파일 1
							<a href="<%=request.getContextPath() %>/board/free_board/free_board_fileUpload/${dto.getBoard_file1() }" target="_blank">${dto.getBoard_file1() }</a>
						
						<c:if test="${!empty dto.getBoard_file2() }">
						    <br><br>
							첨부파일 2
							<a href="<%=request.getContextPath() %>/board/free_board/free_board_fileUpload/${dto.getBoard_file2() }" target="_blank">${dto.getBoard_file2() }</a>
					</c:if>
						</td>
					</c:if>
				</tr>
				
				<tr>
					<td class="content"><br>${dto.getBoard_content() }<br></td>
				</tr>
			</c:if>
		</table>
		
		<c:set var="id" value="${user_id }" />
		
		<%-- 추천 기능 --%>
		<div align="left" style="margin-left: 13%;">
			<div class="w3-border w3-center w3-padding">
				<c:if test="${empty id }">
					좋아요 <i class="fa fa-heart" style="font-size:16px;color:red" onclick="heartcheck()"></i>
					<span class="rec_count"></span>					
				</c:if>
				<c:if test="${!empty id }">
					<button class="w3-button w3-black w3-round" id="rec_update" style="width: 125px; height: 40px;">
						<span style="font-size: 14px; letter-spacing: 3px;">좋아요</span> <i class="fa fa-heart" style="font-size:16px;color:red"></i>
						&nbsp;<span class="rec_count"></span>
					</button> 
				</c:if>
			</div>
		</div>
		<br>
		
<script type="text/javascript">

$(function() {
	  // 추천버튼 클릭시(추천 추가 또는 추천 제거)
	  $("#rec_update").click(function() {
	    $.ajax({
	      url: "free_board_rec_update.do",
	      type: "post",
	      data: {
	        no: ${dto.getBoard_no()},
	        id: "${id}"
	      },
	      success: function(data) {
	        alert(data);
	        recCount();
	      },
	      error: function() {
	        alert("데이터 통신 오류입니다!!!");
	      }
	    });
	  });

	  // 게시글 추천수
	  function recCount() {
	    $.ajax({
	      url: "free_board_rec_count.do",
	      type: "post",
	      data: {
	        no: ${dto.getBoard_no()}
	      },
	      success: function(count) {
	        $(".rec_count").html(count);
	      },
	      error: function() {
	        alert("데이터 통신 오류입니다!!!");
	      }
	    });
	  };
	  
	  recCount(); // 처음 시작했을 때 실행되도록 해당 함수 호출
	});

</script>
			
			<%-- 삭제 폼 처리 --%>
			<c:set var="session_nickname" value="${session_nickname }" />
			
			<c:if test="${Nickname == session_nickname }">
				<input type="button" name="delete" value="삭제" onclick="if(confirm('게시글을 정말 삭제 하시겠습니까?')) {
														location.href='free_board_delete.do?board_no=${dto.getBoard_no() }&page=${Page }'
													}else { return; }">&nbsp;
			</c:if>
			
			<%--수정  폼 처리 --%>
			<c:if test="${Nickname == session_nickname }">
				<input type="button" name="modify" value="수정" onclick="location.href='free_board_modify.do?no=${dto.getBoard_no() }&page=${Page }'" style="margin-bottom: 20px;">
			</c:if>
			
			<%-- 게시글 데이터가 없는 경우 --%>
			<c:if test="${empty dto }">
				<tr>
					<td colspan="2" align="center">
						<h3>자유게시판 게시물 리스트가 없습니다</h3>
					</td>
				</tr>
			</c:if>
			
		<%-- 댓글 기능 --%>
		<table border="1" cellspacing="0" width="50%" class="col-9" id="list">
			<tr>
			</tr>
		</table>
		<div id="reply-wrap">
			<div class="reply">
				<textarea style="height: 75px; width: 85%; background-color: white;" name="re_content" id="re_content" placeholder="댓글을 입력하세요."></textarea>&nbsp;
				<c:if test="${!empty id }">
					<input type="button" id="replyBtn" value="등록" onclick="replywrite()">
				</c:if>
				<c:if test="${empty id }">
					<input type="button" value="등록" onclick="writeCheck()">
				</c:if>
			</div>
			<span style="font-size: 12px; color: gray;">
				<br>통신예절에 어긋나는 글이나 상업적인 글, 타 사이트에 관련된 글은 관리자에 의해 사전 통보없이 삭제될 수 있습니다.
			</span>
		</div>
		
		<c:if test="${empty keyword }">
			<input type="button" name="golist" value="목록" style="margin-bottom: 100px;" onclick="location.href='free_board_list.do?page=${Page }'">
		</c:if>
		
		<c:if test="${!empty keyword }">
			<input type="button" name="golist" value="목록" style="margin-bottom: 100px;" onclick="location.href='free_board_search.do?page=${Page }&field=${field }&keyword=${keyword }'">
		</c:if>
		
		
<script type="text/javascript">
	$(function() {
		
		// ajax에서 동일하게 사용되는 속성 설정
		$.ajaxSetup({
			// ajax에서 한글 깨짐 문제 해결
			ContentType : "application/x-www-form-urlencoded;charset=UTF-8",
			type : "post"
		});
		
		getList();
	});
	// TBL_BOARD 테이블의 전체 데이터를 가져오는 함수.
	function getList() {
		
		$.ajax({
			url : "free_board_reply_list.do",
			data : {
						com_no : ${dto.getBoard_no() } 
					},
			datatype : "xml",
			success : function(data) {
				// 테이블 태그의  타이틀 태그를 제외한 나머지 댓글 목록을 지우는 작업.
				$("#list tr:gt(0)").remove();
				let table = "";
				
				$(data).find("reply").each(function() {
					table += "<tr><td>"
								+$(this).find("user_nickname").text()+"<br>"
								+$(this).find("br_content").text()+"<br>"
								+$(this).find("br_regdate").text()+
							"</td></tr>";
				});
				
				$('#list tr:eq(0)').after(table);
			},
			
			error : function() {
				alert("데이터 통신 오류입니다!!!");
			}
		});
	} // getList() 함수 end
	
	// 제이쿼리 실행 시 마다 전체댓글목록 화면에 출력이 되어야 함.
	function replywrite() {
		
		var reContent = $("#re_content").val();
		   
		   if (!reContent.trim()) { // 댓글란이 비어있는지 확인
		      alert('댓글 내용을 입력해주세요.');
		      return;
		   }
		
		$.ajax({
			url : "free_board_reply_write.do",
			data : {
				re_cont : reContent,
				re_writer : "${session_nickname}",
				board_no : ${dto.getBoard_no() },
				user_no : ${session_user_no }
			},
			datatype : "text",
			success : function(data) {
				if(data > 0) {
					
					// 댓글 작성 후 다시 전체 댓글 리스트를 화면에 뿌려주면 된다.
					getList();
					
					// input 태그에 입력된 내용 지우기.
					$("textarea").each(function() {
						$(this).val(""); // 입력된 값 지우기.
					});
				}else {
					alert('댓글 작성 실패했습니다.');
				}
				
			},
			
			error : function() {
				alert("데이터 통신 오류입니다!!!");
			}
		});
	} // replywrite() 함수 end
	
	// 제이쿼리 실행 시 마다 전체댓글목록 화면에 출력이 되어야 함.
	
</script>		
	
	
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