<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:useBean id="now" class="java.util.Date"/>
<html>
<head>
    <title>마이 가계부</title>
    <link rel="stylesheet" href="/resources/css/main.css">
    <link rel="shortcut icon" href="#">
</head>
<script>
    $(document).ready(() => {
        document.querySelector(".modal__closeBtn").addEventListener("click", function () {
            modal.classList.add("hidden");
            diaryReset();
        });
    });
</script>
<body>
<%--헤더--%>
<nav class="nav">
    <li class="item">
        <ul>
            <div class="menu"><a href="main">Home</a></div>
        </ul>
    </li>
    <li class="item">
        <ul>
            <div class="menu"><a href="diaymainform.do">Diary</a></div>
        </ul>
    </li>
    <li class="item">
        <ul>
            <div class="menu"><a href="main">account</a></div>
        </ul>
    </li>
    <li class="item">
        <ul>
            <div class="menu"><a href="#">미구현1</a></div>
        </ul>
    </li>
    <li class="item">
        <ul>
            <div class="menu"><a href="#">미구현2</a></div>
        </ul>
    </li>
    <li class="item">
        <ul>
            <div class="menu"><a href="#">미구현3</a></div>
        </ul>
    </li>
    <c:choose>
        <c:when test="${vo eq null}">
            <li class="item login">
                <ul>
                    <div class="menu"><a href="/sw/loginform.do">로그인</a></div>
                </ul>
            </li>
        </c:when>
        <c:otherwise>
            <li class="item login">
                <ul>
                    <div class="menu logout"><a href="/sw/logout.do">로그아웃</a></div>
                </ul>
            </li>
            <li class="item login">
                <ul>
                    <div class="menu"><a href="#">&nbsp;&nbsp;&nbsp;${vo.mberId}</a></div>
                </ul>
            </li>

        </c:otherwise>
    </c:choose>
</nav>
<%--헤더 끝--%>