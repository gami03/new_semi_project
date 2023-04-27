
function kakaoLogin() {
	
	Kakao.init('7fcc1b219164dc15e111f15c93b7511d'); //javascript키
	console.log(Kakao.isInitialized()); // sdk초기화여부판단
	//카카오로그인
	
	//1. 로그인 시도
    Kakao.Auth.login({
      success: function (response) {
    	  
    	  //2. 로그인 성공시, API 호출
       		 Kakao.API.request({
        	  url: '/v2/user/me',
     		  success: function (response) {
        	 		 console.log(response)	//json형식 >> String 변환 후 벨류값을 변수에 넣어서 이걸 db로 넣어서 회원관리하기.
        	       
        	 		
        	 		 var token = response.id;
        	       	 var nickname = response.properties.nickname;
        	       	 var email = response.kakao_account.email;
        	       	 
        	       	const form = document.createElement('form');

        	       	let objs1 = document.createElement('input');
        	       	objs1.setAttribute('type', 'hidden');
        	       	objs1.setAttribute('name', 'member_token');
        	       	objs1.setAttribute('value', token);
        	       	form.appendChild(objs1);

        	       	let objs2 = document.createElement('input');
        	       	objs2.setAttribute('type', 'hidden');
        	       	objs2.setAttribute('name', 'member_name');
        	       	objs2.setAttribute('value', nickname);
        	       	form.appendChild(objs2);

        	       	let objs3 = document.createElement('input');
        	       	objs3.setAttribute('type', 'hidden');
        	       	objs3.setAttribute('name', 'member_email');
        	       	objs3.setAttribute('value', email);
        	       	form.appendChild(objs3);

        	       	form.setAttribute('method', 'post');
        	       	form.setAttribute('action', "user_KakaoLogin.do");
        	       	document.body.appendChild(form);
        	       	form.submit();
        	       	 
        	       	
        	 		
         	  			},
         fail: function (error) {
            console.log(error)
          },
        })
      },
      fail: function (error) {
        console.log(error)
      },
    })
  }
  
function kakaoLogout() {
    if (Kakao.Auth.getAccessToken()) {
      Kakao.API.request({
        url: '/v1/user/unlink',
        success: function (response) {
        	console.log(response)
        },
        fail: function (error) {
          console.log(error)
        },
      })
      Kakao.Auth.setAccessToken(undefined)
    }
  }


function requestUserInfo() {
    Kakao.API.request({
      url: '/v2/user/me',
      
    })
      .then(function(res) {
    	var id = res.id;
    	 var nickname = res.properties.nickname;
    	 var email = res.kakao_account.email;
    
   	    alert(id);
		alert(nickname);
		alert(email);
		  scope : 'account_email';
		alert('카카오 계정 동기화가 완료 되었습니다. [확인]을 눌러 추가정보 입력 페이지로 이동합니다.');
					
     			location.href="<%=request.getContextPath()%>/member_Kakaojoin.do?member_id="+id+"&member_name="+nickname+"&member_email="+email+"&member_img="+profileImg;
   
    	 
      })
      .catch(function(err) {
        alert(
          '회원정보를 불러오는데 실패했습니다. ' + JSON.stringify(err)
        );
      });
  }
  
  
  
  
displayToken()
function displayToken() {
  var token = getCookie('authorize-access-token');

  if(token) {
    Kakao.Auth.setAccessToken(token);
    document.querySelector('#token-result').innerText = 'login success, ready to request API';
    document.querySelector('button.api-btn').style.visibility = 'visible';
  }
}

function getCookie(name) {
  var parts = document.cookie.split(name + '=');
  if (parts.length === 2) { return parts[1].split(';')[0]; }
}