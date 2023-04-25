<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <title>주소 입력</title>
    <style>
        .user_addr {
            display: block;
            margin-bottom: 10px;
        }
        .addr-container {
            width: 100%;
            text-align: center;
        }
        .button-container {
            display: inline-block;
        }
    </style>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
			<script>
			function sample4_execDaumPostcode() {
		        new daum.Postcode({
		            oncomplete: function(data) {
		                var roadAddr = data.roadAddress; // 도로명 주소 변수
		                var extraRoadAddr = ''; // 참고 항목 변수
		
		                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
		                    extraRoadAddr += data.bname;
		                }
		                if(data.buildingName !== '' && data.apartment === 'Y'){
		                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                }
		                if(extraRoadAddr !== ''){
		                    extraRoadAddr = ' (' + extraRoadAddr + ')';
		                }
		
		                document.getElementById('sample4_postcode').value = data.zonecode;
		                document.getElementById("sample4_roadAddress").value = roadAddr;
		                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
		                
		                if(roadAddr !== ''){
		                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
		                } else {
		                    document.getElementById("sample4_extraAddress").value = '';
		                }
		
		                var guideTextBox = document.getElementById("guide");
		                if(data.autoRoadAddress) {
		                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
		                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
		                    guideTextBox.style.display = 'block';
		
		                
		                } else {
		                    guideTextBox.innerHTML = '';
		                    guideTextBox.style.display = 'none';
		                }
		            }
		        }).open();
		    }

			function submitAddress() {
				
				 var roadAddr = document.getElementById("sample4_roadAddress").value;
				  var detailAddr = document.getElementById("sample4_detailAddress").value;
				  var extraAddr = document.getElementById("sample4_extraAddress").value;
				  var zipCode = document.getElementById("sample4_postcode").value;

				  var fullAddress = roadAddr + " " + detailAddr + " " + extraAddr + " (" + zipCode + ")";

				  console.log("Full address:", fullAddress); // 새로 추가된 줄

				  // 주소 정보를 user_mypage.jsp로 전달합니다.
			 if (window.opener && typeof window.opener.setAddress === "function") {
			    window.opener.setAddress(fullAddress);
			  } else {
			    console.error("Unable to call setAddress() function in the parent window.");
			  }
							  window.close();


				}
			

</script>
</head>
<body>

	<div align="center">
		<h3>주소 변경</h3>
	
	</div>
<div class="addr-container" width="400">
        <input type="text" class="user_addr" id="sample4_postcode" name="postcode" placeholder="우편번호">
        <button class="user_addr" onclick="sample4_execDaumPostcode()">우편번호 찾기</button>
        <input type="text" class="user_addr" id="sample4_roadAddress" name="road_address" placeholder="도로명주소">
        <input type="text" class="user_addr" id="sample4_jibunAddress" name="jibun_address" placeholder="지번주소">
        <span id="guide" style="color:#999;display:none"></span>
        <input type="text" class="user_addr" id="sample4_detailAddress" name="detail_address" placeholder="상세주소" required>
        <input type="text" class="user_addr" id="sample4_extraAddress" name="extra_address" placeholder="참고항목">
        <div class="button-container">
            <button onclick="submitAddress()">주소 변경 등록</button>
        </div>
    </div>


</body>
</html>