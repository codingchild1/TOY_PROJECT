<%--
  Created by IntelliJ IDEA.
  User: ncloud
  Date: 2022-08-22
  Time: 오후 3:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/resources/css/join.css">
</head>
<body>
<section style="min-height: 700px;padding-top: 80px;">
    <form id="signupForm" action="join" method="post">
        <input type="hidden" value="">
        <div style="width: 100%;max-width: 1500px;margin: 0 auto;padding: 0px 20px;">
            <div class="lgBox">
                <div class="signupWrap" style="display: flex;">
                    <div class="signupLeft">
                        <h3></h3>
                    </div>
                    <div class="signup">
                        <h3>Sign Up</h3>
                        <div class="formBox">
                            <div style="position:relative;">
                                <input type="text" class="borderform" style="width:95%;" placeholder="Id" id="mberId" name="mberId">
                                <div id="memidoverlap" style="position:absolute;top:0;right:0;height:22px;width:22px;padding:5px;background:#5085d3;background-image:url('/resources/images/w.png');background-repeat:no-repeat;background-position:center center;color:white;cursor:pointer;user-select:none;">
                                </div>
                            </div>
                            <input type="password" class="borderform" placeholder="Password" id="password" name="password" >
                            <input type="password" class="borderform" placeholder="Confirm password" id="password2" name="password2">
                            <input type="text" class="borderform" placeholder="Your name (shown to the public)" id="mberNm" name="mberNm">
                            <input type="text" class="borderform" placeholder="Email" id="email" name="email">
                            <input type="text" class="borderform" placeholder="Phone" id="phoneNum" name="phoneNum">
                            <button id="submit" class="btn_signup" style="border: none;">Register</button>
                        </div>
                        <span>OR</span>
                        <div class="snsLogin" title="준비중입니다...">
                            <a id="naver_id_login" class="sns01" style="background: url(/resources/images/n.png) no-repeat center center #4d72b9;background-size: 24px;">Continue with Facebook</a>
                            <a id="GgCustomLogin" class="sns02" style="background: url(/resources/images/g.png) no-repeat center center #4d72b9;background-size: 24px;">Continue with Google</a>
                        </div>
                        <div class="toLogin">
                            <span>Have an account? <a href="/sw/loginform.do">Login</a></span>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </form>
</section>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script src="https://apis.google.com/js/platform.js?onload=init" async defer></script>
<script>
    $('#signupForm').submit(function(){
        let mberId=$('#mberId').val();
        if(mberId==''){
            alert("아이디를 입력하세요.");
            $('#mberId').focus();
            $('#submit').attr("disabled", true);
            return false;
        }
        let password=$('#password').val();
        if(password==''){
            alert("비밀번호를 입력하세요.");
            $('#password').focus();
            return false;
        }
        let password2=$('#password2').val();
        if(password!=password2){
            alert("비밀번호 확인이 일치하지 않습니다.");
            $('#password2').focus();
            return false;
        }
        let mberNm=$('#mberNm').val();
        if(mberNm==''){
            alert("이름을 입력하세요.");
            $('#mberNm').focus();
            return false;
        }
        let email=$('#email').val();
        if(email==''){
            alert("이메일을 입력하세요.");
            $('#email').focus();
            return false;
        }
        let phoneNum=$('#phoneNum').val();
        if(phoneNum==''){
            alert("핸드폰 번호를 입력하세요.");
            $('#phoneNum').focus();
            return false;
        }
    });

    $('#memidoverlap').click(function(){
        debugger
        let mberId=$('#mberId').val();
        if(mberId==''){
            alert("아이디를 입력하세요.");
            $('#mberId').focus();
            $('#submit').attr("disabled", true);
            return false;
        }
        $.ajax({
            type:"post",
            dataType:"text",
            url:"/rest/memidoverlap",
            data:{
                mberId : $('#mberId').val()
            },
            success: function(data, textStatus){
                if(data=="true"){
                    alert("사용 불가능합니다.");
                    $('#submit').attr("disabled", true);
                } else {
                    alert("사용 가능합니다.");
                    $('#submit').attr("disabled", false);
                }
            }
        });
    })

    var naver_id_login = new naver_id_login("2R257h5lNLRrx1vJnLgV", "http://49.50.161.113:8090/callback");
    var state = naver_id_login.getUniqState();
    /*  naver_id_login.setButton("white", 2,40);  */
    naver_id_login.setDomain("http://localhost:8090/login");
    naver_id_login.setState(state);
    /*  naver_id_login.setPopup();  */
    naver_id_login.init_naver_id_login();
    function init() {
        gapi.load('auth2', function() {
            gapi.auth2.init();
            options = new gapi.auth2.SigninOptionsBuilder();
            options.setPrompt('select_account');
            // 추가는 Oauth 승인 권한 추가 후 띄어쓰기 기준으로 추가
            options.setScope('email profile openid https://www.googleapis.com/auth/user.birthday.read');
            // 인스턴스의 함수 호출 - element에 로그인 기능 추가
            // GgCustomLogin은 li태그안에 있는 ID, 위에 설정한 options와 아래 성공,실패시 실행하는 함수들
            gapi.auth2.getAuthInstance().attachClickHandler('GgCustomLogin', options, onSignIn, onSignInFailure);
        })
    }
    function onSignInFailure(t){
        console.log(t);
    }
    function onSignIn(googleUser) {
        var profile = googleUser.getBasicProfile();
        console.log('mberId: ' + profile.getmberId()); // Do not send to your backend! Use an ID token instead.
        console.log('mberNm: ' + profile.getmberNm());
        /* console.log('Image URL: ' + profile.getImageUrl()); */
        console.log('Email: ' + profile.getEmail()); // This is null if the 'email' scope is not present.
        let email = profile.getEmail();
        let mberId = profile.getmberId();
        let mberNm = profile.getmberNm();
        $.ajax({
            type:"post",
            dataType:"text",
            async:false,
            url:"/naverlogin",
            data:{"mberId":mberId,
                "mberNm":mberNm,
                "email":email},
            success: function(data, textStatus){
                location.href="mypage";
                console.log("success");

            },
            error:function(data, textStatus){
                alert("실패");
            }
        });
    }
</script>
</body>
</html>
