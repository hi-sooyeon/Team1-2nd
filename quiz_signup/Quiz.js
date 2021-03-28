$(function(){
	//아이디
	$("#userId").on("input",function(){
		var regex = /^[a-z\d]{3,11}$/; 
		var result = regex.exec($("#userId").val());
		if(result != null){
			$(".id.regex").html("");
		}else{
		    $(".id.regex").html("3~10자리의 영 소문자+숫자 조합으로 입력해주세요.");
		    $(".id.regex").css("color","red");
		}
	});

	//이름
	$("#userName").on("input",function(){
		var regex = /[가-힣]{2,}/;
		var result = regex.exec($("#userName").val());
		if(result != null){
			$(".name.regex").html("");   
		}else{
			$(".name.regex").html("한글만 입력 가능합니다.");
			$(".name.regex").css("color","red");
		}
	});

	//비밀번호
	$("#userPass").on("input",function(){
		var regex = /^[A-Za-z\d]{8,12}$/;
		var result = regex.exec($("#userPass").val())
		if(result != null){
			$(".pw.regex").html("");
		}else{
			$(".pw.regex").html("8~11자리의 영문 대소문자+숫자 조합으로 입력해주세요.");
			$(".pw.regex").css("color","red");
		}
	});

	//비밀번호 확인    
	$("#userPassCheck").on("keyup",function(){
		if($("#userPass").val()==$("#userPassCheck").val()){
			$(".repw.regex").html("비밀번호가 일치합니다");
			$(".repw.regex").css("color","black");
		}else{
			$(".repw.regex").html("비밀번호가 일치하지않습니다");
			$(".repw.regex").css("color","red");
		}
	});

	//이메일
	$("#userEmail").on("input",function(){
		var regex = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;
		var result = regex.exec($("#userEmail").val());
		if(result != null){
			$(".email.regex").html("");   
		}else{
			$(".email.regex").html("사용 가능한 이메일로 입력해주세요. ex) team1@email.com");
			$(".email.regex").css("color","red");
		}
	});

	//주민번호1
	$("#userSsn1").on("input",function(){
		var regex = /^(?:[0-9]{2}(?:0[1-9]|1[0-2])(?:0[1-9]|[1,2][0-9]|3[0,1]))/;
		var result = regex.exec($("#userSsn1").val());
		if(result != null){
			$(".ssn.regex").html("");   
		}else{
			$(".ssn.regex").html("입력하신 주민번호를 확인해주세요");
			$(".ssn.regex").css("color","red");
		}
	});

	//주민번호2
	$("#userSsn2").on("input",function(){
		var regex = /[1-4][0-9]{6}$/;
		var result = regex.exec($("#userSsn2").val());
		if(result != null){
			$(".ssn.regex").html("");   
		}else{
			$(".ssn.regex").html("입력하신 주민번호를 확인해주세요");
			$(".ssn.regex").css("color","red");
		}
	});

	//핸드폰번호
	$("#userPhone").on("input",function(){
		var regex = /^01[0179][0-9]{7,8}$/;
		var result = regex.exec($("#userPhone").val());
		if(result != null){
			$(".phone.regex").html("");   
		}else{
			$(".phone.regex").html("올바른 휴대폰 번호를 입력해주세요");
			$(".phone.regex").css("color","red");
		}
	});

		// 우편번호 기능
        $("#btnAddr").on("click",function(){  // 우편검색에 id 박아버려 
          new daum.Postcode({ 
         oncomplete: function(data) {  
            // 변수가 값이 없는 경우 공백값을 가짐
            var fullAddr = '';   //최종 주소 변수
            var extraAddr = '';  // 조합 주소 변수
         
            
            // 선택한 주소 타입에 따라 해당 주소를 가져옴
            if (data.userSelectedType === 'R') {  // 도로명 주소 선택시 -> R이 도로명
               fullAddr = data.roadAddress; 
            } else {  // 아니면 지번선택시 -> J지번
               fullAddr = data.jibunAddress; 
            } 
            
         
            // 사용자가 선택한 주소가 도로명 타입일때 조합
            if(data.userSelectedType === 'R'){ 
            
               // 법정동명이 있을경우 추가
               if(data.bname !== ''){ 
                  extraAddr += data.bname; 
               } 
            
               // 건물명 있을 경우 추가
               if(data.buildingName !== ''){ 
                  extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName); 
               } 
            
               // 조합형주소의 유무에 따라 양쪽 괄호 추가 최종주소 만듦
               fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : ''); 
            } 

            // 우편번호와 주소 정보 필드 넣고
                document.getElementById('userZipCode').value=data.zonecode; // 5자리 우편번호
                document.getElementById('userAddr1').value=fullAddr; 
                document.getElementById('userAddr2').focus();// 커서로 상세주소 필드 이동

                }
            }).open(); 
        });

	//생일 날짜 체크 (미래인지)
	$('#birth').change(()=>{
		checkDate($('#birth').val().replace(/-/gi,""),today());
	});

	$('#submit').click((e)=>{
		const idCheck = $('#userId').val()!==''?$('#userId').val():null;
		const nameCheck = $('#userName').val()!==''?$('#userName').val():null;
		const pwCheck = $('#userPass').val()!==''?$('#userPass').val():null;
		const pwCheck2 = $('#userPassCheck').val()!==''?$('#userPassCheck').val():null;
		const mailCheck = $('#userEmail').val()!==''?$('#userEmail').val():null;
		const ssn1Check = $('#userSsn1').val()!==''?$('#userSsn1').val():null;
		const ssn2Check = $('#userSsn2').val()!==''?$('#userSsn2').val():null;
		const zipCheck = $('#userZipCode').val()!==''?$('#userZipCode').val():null;
		const addr1Check = $('#userAddr1').val()!==''?$('#userAddr1').val():null;
		const addr2Check = $('#userAddr2').val()!==''?$('#userAddr2').val():null;
		const phoneCheck = $('#userPhone').val()!==''?$('#userPhone').val():null;
		const hobbyCheck = $('input:checkbox[name=hobby]:checked').length!==0?$('input:checkbox[name=hobby]:checked').val():null;
		const birthCheck = $('#birth').val()!==''?$('#birth').val():null;
		
		if(idCheck&&nameCheck&&pwCheck&&pwCheck2&&mailCheck&&ssn1Check&&ssn2Check&&zipCheck&&addr1Check&&addr2Check&&phoneCheck&&hobbyCheck&&birthCheck){
			alert('가입완료');
		}else{
			e.preventDefault();
			alert('입력하지 않은 항목이 있습니다. 확인해주세요.');
		}
	});

});

			function today(){
	            let date = new Date();
	            let resultDate;
	            if(date.getMonth() < 9){ // 1월~9월 인 경우
	                resultDate = date.getFullYear()+"0"+(date.getMonth()+1)+""+date.getDate();
	            } else{ // 10~12월 인 경우
	                resultDate = date.getFullYear()+""+(date.getMonth()+1)+""+date.getDate();
	            }
	            return resultDate;
	        }

	        function checkDate(userDate, today){
	            if(parseInt(userDate) > parseInt(today)){
	                alert("미래에서 오셨나요?");
	                $('#birth').val("");
	            }
	        }
