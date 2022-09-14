<%--
  Created by IntelliJ IDEA.
  User: ncloud
  Date: 2022-08-22
  Time: 오후 2:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/resources/css/login.css">
</head>
<body>
<jsp:include page="/WEB-INF/views/jsp/header/navibar.jsp"/>
<section style="min-height: 700px; padding-top: 80px;">
    <form id="login" action="login.do" method="post">
        <div style="width: 100%;max-width: 1500px;margin: 0 auto;padding: 0 20px;">
            <div style="max-width: 800px;margin: 70px auto 0;width: 100%;box-shadow: 0 0 30px 0 rgb(0 0 0 / 7%);">
                <div style="display: flex;">
                    <div class="signupLeft" style="width: 55%;background: url(/resources/images/login.jpg) no-repeat center center;background-size: cover;text-align: center;">

                    </div>
                    <div class="signup" style="width: 45%;max-width: 380px;margin: 0 auto;padding: 30px 10px;">
                        <h3 style="font-size: 24px;text-align: center;margin-bottom: 10px;">Log In</h3>
                        <div class="formbox" style="width: 93%;margin: 0 auto;display: flex; flex-direction: column;">
                            <input type="text" style="border: solid 1px #ddd;padding: 5px; font-size: 13px;line-height: 20px;margin-bottom: 10px;" placeholder="Id" id="mberId" name="mberId">
                            <input type="password" style="border: solid 1px #ddd;padding: 5px; font-size: 13px;line-height: 20px;margin-bottom: 10px;" placeholder="Password" id="password" name="password">
                            <button id="submit" style="background: #222222; color: #fff;font-weight: bold;padding: 10px;margin: 10px 0px 20px;text-align: center;cursor: pointer; user-select: none;border: none;height: 41px;">
                                Log In
                            </button>
                        </div>
                        <span style="display: block;text-align: center;font-size: 13px;">OR</span>
                        <div class="snsLogin" style="width: 80%;margin: 10px auto 20px;display: flex;max-width: 300px;justify-content: center;align-items: center;flex-direction: row;">
                            <a id="naverIdLogin_loginButton" style="background: url(/resources/images/n.png) no-repeat center center #4d72b9;background-size: 24px;" ></a>
                            <a id="GgCustomLogin" style="background: url(/resources/images/g.png) no-repeat center center #4d72b9;background-size: 20px;cursor:pointer;" ></a>
                            <%--<li onclick="naverLogout(); return false;">--%>
                                <%--<a href="javascript:void(0)">--%>
                                    <%--<span>네이버 로그아웃</span>--%>
                                <%--</a>--%>
                            <%--</li>--%>
                        </div>
                        <div class="toLogin" style="display: flex;justify-content: center;align-items: center;">
                            <span style="display: block;text-align: center;font-size: 13px;">Have no account?<a href="joinform.do">Sign Up</a></span><br>
                        </div>
                    </div>
                </div>
            </div>

            <c:if test="${not empty error}">
                <input id="err" type="hidden" value="${error}">
            </c:if>

        </div>
    </form>
</section>

<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="https://static.nid.naver.com/js/naverLogin_implicit-1.0.3.js" charset="utf-8"></script>
<script src="https://apis.google.com/js/platform.js?onload=init" async defer></script>
<script>
    $('#login').submit(function(){
        let mberId=$('#mberId').val();
        if(mberId==''){
            alert("아이디를 입력하세요.");
            $('#mberId').focus();
            return false;
        }
        let password=$('#password').val();
        if(password==''){
            alert("비밀번호를 입력하세요.");
            $('#password').focus();
            return false;
        }
    });

    error()
    function error() {
        if ($("#err").length > 0) {
            alert($('#err').val());
        }
    }

    // 네이버 로그인
    // https://tyrannocoding.tistory.com/60
    var naverLogin = new naver.LoginWithNaverId(
        {
            clientId: "QpXcZhZXaWlFXujufX7I", //내 애플리케이션 정보에 cliendId를 입력해줍니다.
            callbackUrl: "http://localhost:8087/sw/main", // 내 애플리케이션 API설정의 Callback URL 을 입력해줍니다.
            isPopup: false,
            callbackHandle: true
        }
    );

    naverLogin.init();

    window.addEventListener('load', function () {
        naverLogin.getLoginStatus(function (status) {
            if (status) {
                var email = naverLogin.user.getEmail(); // 필수로 설정할것을 받아와 아래처럼 조건문을 줍니다.

                console.log(naverLogin.user);

                if( email == undefined || email == null) {
                    alert("이메일은 필수정보입니다. 정보제공을 동의해주세요.");
                    naverLogin.reprompt();
                    return;
                }
            } else {
                console.log("callback 처리에 실패하였습니다.");
            }
        });
    });


    var testPopUp;
    function openPopUp() {
        testPopUp= window.open("https://nid.naver.com/nidlogin.logout", "_blank", "toolbar=yes,scrollbars=yes,resizable=yes,width=1,height=1");
    }
    function closePopUp(){
        testPopUp.close();
    }

    function naverLogout() {
        openPopUp();
        setTimeout(function() {
            closePopUp();
        }, 1000);

    }
</script>
</body>
</html>
