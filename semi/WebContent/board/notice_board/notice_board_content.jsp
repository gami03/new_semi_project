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


<style type="text/css">
.pagination{
justify-content: center;
}

.txt1{
	font-weight: bold;
	font-size: 18px;
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
}

</style>

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

	<jsp:include page="/include/main_top.jsp" />

	<!-- Main -->
	<div align="center" id="main" style="padding-top: 0;">
		
		<div class="board_banner">
			<p style="font-family: 'Cafe24Ssurround'; font-size: 40px;">공지사항</p>
		</div>
		
		<c:set var="dto" value="${Content }"/>
		<table border="1" cellspacing="0">
			
			<c:if test="${!empty dto }">
				<tr id="title_tr">
					<td id="title_td"><span class="txt1">${dto.getBoard_title() }</span> <span class="txt2">${Nickname } | ${dto.getBoard_date().substring(0, 10) }</span></td>
				</tr>
				
				<tr>
					<c:set var="board_id" value="${board_id }" />
					<c:if test="${!empty dto.getBoard_file1() }">
						<td> 첨부파일 1
							<a href="<%=request.getContextPath() %>/board/notice_board/notice_board_fileUpload/${dto.getBoard_file1() }" target="_blank">${dto.getBoard_file1() }</a>
						
						<c:if test="${!empty dto.getBoard_file2() }">
						    <br><br>
							첨부파일 2
							<a href="<%=request.getContextPath() %>/board/notice_board/notice_board_fileUpload/${dto.getBoard_file2() }" target="_blank">${dto.getBoard_file2() }</a>
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
		<div align="left">
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
	      url: "board_rec_update.do",
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
	      url: "board_rec_count.do",
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
														location.href='board_delete.do?board_no=${dto.getBoard_no() }&page=${Page }&board_name=${dto.getBoard_name() }'
													}else { return; }">&nbsp;
			</c:if>
			
			<%--수정  폼 처리 --%>
			<c:if test="${Nickname == session_nickname }">
				<input type="button" name="modify" value="수정" onclick="location.href='board_modify.do?no=${dto.getBoard_no() }&page=${Page }&board_name=${dto.getBoard_name() }'" style="margin-bottom: 20px;">
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
		<table border="1" cellspacing="0" id="list">
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
		
		<%-- 목록버튼 기능 --%>
		<c:if test="${empty keyword }">
			<input type="button" name="golist" value="목록" style="margin-bottom: 100px;" onclick="location.href='board_list.do?page=${Page }&board_name=${dto.getBoard_name() }&orderBy=${orderBy }'">
		</c:if>
		
		<c:if test="${!empty keyword }">
			<input type="button" name="golist" value="목록" style="margin-bottom: 100px;" onclick="location.href='board_search.do?page=${Page }&field=${field }&keyword=${keyword }&board_name=${dto.getBoard_name() }&orderBy=${orderBy }'">
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
			url : "board_reply_list.do",
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
			url : "board_reply_write.do",
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
	
	
	
	</div>
	
	<jsp:include page="/include/main_bottom.jsp" />
	