<%--
  Created by IntelliJ IDEA.
  User: ncloud
  Date: 2022-08-22
  Time: 오후 2:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/resources/css/login.css">
</head>
<jsp:include page="/WEB-INF/views/jsp/header/navibar.jsp"/>
<body>
<section style="min-height: 700px; padding-top: 80px;">
    <form id="login" action="login" method="post">
        <div style="width: 100%;max-width: 1500px;margin: 0 auto;padding: 0 20px;">
            <div style="max-width: 800px;margin: 70px auto 0;width: 100%;box-shadow: 0 0 30px 0 rgb(0 0 0 / 7%);">
                <div style="display: flex;">
                    <div class="signupLeft" style="width: 55%;background: url(/resources/images/login.jpg) no-repeat center center;background-size: cover;text-align: center;">

                    </div>
                    <div class="signup" style="width: 45%;max-width: 380px;margin: 0 auto;padding: 30px 10px;">
                        <h3 style="font-size: 24px;text-align: center;margin-bottom: 10px;">Log In</h3>
                        <div class="formbox" style="width: 93%;margin: 0 auto;display: flex; flex-direction: column;">
                            <input type="text" style="border: solid 1px #ddd;padding: 5px; font-size: 13px;line-height: 20px;margin-bottom: 10px;" placeholder="Id" id="id" name="id">
                            <input type="password" style="border: solid 1px #ddd;padding: 5px; font-size: 13px;line-height: 20px;margin-bottom: 10px;" placeholder="Password" id="password" name="password">
                            <button id="submit" style="background: #222222; color: #fff;font-weight: bold;padding: 10px;margin: 10px 0px 20px;text-align: center;cursor: pointer; user-select: none;border: none;height: 41px;">
                                Log In
                            </button>
                        </div>
                        <span style="display: block;text-align: center;font-size: 13px;">OR</span>
                        <div class="snsLogin" style="width: 80%;margin: 10px auto 20px;display: flex;max-width: 300px;justify-content: center;align-items: center;flex-direction: row;">
                            <a id="naver_id_login" style="background: url(/resources/images/n.png) no-repeat center center #4d72b9;background-size: 24px;" ></a>
                            <a id="GgCustomLogin" style="background: url(/resources/images/g.png) no-repeat center center #4d72b9;background-size: 20px;cursor:pointer;" ></a>
                        </div>
                        <div class="toLogin" style="display: flex;justify-content: center;align-items: center;">
                            <span style="display: block;text-align: center;font-size: 13px;">Have no account?<a href="joinform.do">Sign Up</a></span><br>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</section>

<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script src="https://apis.google.com/js/platform.js?onload=init" async defer></script>
<script>
    $('#login').submit(function(){
        let id=$('#id').val();
        if(id==''){
            alert("아이디를 입력하세요.");
            $('#id').focus();
            return false;
        }
        let password=$('#password').val();
        if(password==''){
            alert("비밀번호를 입력하세요.");
            $('#password').focus();
            return false;
        }
    });
    var naver_id_login = new naver_id_login("QpXcZhZXaWlFXujufX7I", "http://localhost:8087/sw/main");
    var state = naver_id_login.getUniqState();
    /*  naver_id_login.setButton("white", 2,40);  */
    naver_id_login.setDomain("http://localhost:8087/sw/loginform.do");
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
        console.log('ID: ' + profile.getId()); // Do not send to your backend! Use an ID token instead.
        console.log('Name: ' + profile.getName());
        /* console.log('Image URL: ' + profile.getImageUrl()); */
        console.log('Email: ' + profile.getEmail()); // This is null if the 'email' scope is not present.
        let email = profile.getEmail();
        let id = profile.getId();
        let name = profile.getName();
        $.ajax({
            type:"post",
            dataType:"text",
            async:false,
            url:"${pageContext.request.contextPath}/naverlogin",
            data:{"id":id,
                "name":name,
                "email":email},
            success: function(data, textStatus){
                location.href="/main";
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
