<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<table class="table table-bordered" width="1000">
  <tr>
    <th>주소</th>
    <td>
      <div>
        <input type="text" class="user_addr" id="sample4_postcode" name="postcode" placeholder="우편번호">
        <input type="button" class="user_addr" onclick="sample4_execDaumPostcode()" value="우편번호 찾기">
      </div>
      <div>
        <input type="text" class="user_addr" id="sample4_roadAddress" name="road_address" placeholder="도로명주소">
      </div>
      <div>
        <input type="text" class="user_addr" id="sample4_jibunAddress" name="jibun_address" placeholder="지번주소">
        <span id="guide" style="color:#999;display:none"></span>
      </div>
      <div>
        <input type="text" class="user_addr" id="sample4_detailAddress" name="detail_address" placeholder="상세주소" required>
      </div>
      <div>
        <input type="text" class="user_addr" id="sample4_extraAddress" name="extra_address" placeholder="참고항목">
      </div>
    </td>
  </tr>
</table>

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
</script>
			

</body>
</html>