<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/jsp/header/navibar.jsp" %>

<%--사이드바--%>
<nav class="sidenav">
    <div>

    </div>
</nav>
<%--사이드 메뉴 끝--%>

<div class="accdetail diaryBackImg">
    <div class="modal hidden" id="jsModal">
        <span class="modal_title">내 지출 </span>
        <ul class="modal_list">
            <li>Date</li>
            <li class="input_list">Catrgory</li>
            <li class="input_list">Content</li>
            <li class="input_list">Amount</li>
        </ul>
        <div id="modal_inputboxid">
            <input type="date" id="modal_date" class="modal_inputbox"/>
            <select id="modal_category" class="modal_inputbox">
                <option value="선택" selected>선택</option>
                <option value="식비">식비</option>
                <option value="건강">건강</option>
                <option value="놀이">놀이</option>
                <option value="쇼핑">쇼핑</option>
                <option value="기타">기타</option>
            </select>
            <input type="text" id="modal_content" class="modal_inputbox"/>
            <input type="text" id="modal_amount" class="modal_inputbox">
        </div>

        <div id="modal_btns">
            <button class="modal__insertBtn" id="jsinsertBtn">등록</button>
            <button class="modal__closeBtn" id="jsCloseBtn">취소</button>
        </div>
        <input type="hidden" id="accNo"/>
        <input type="hidden" id="modal_mberId" value="${vo.mberId}"/>
    </div>
    <label for="createacc"></label>
    <button type="button" id="createacc" class="open" style="top: 0px; opacity: 1;"><img style="width: 40px;
    height: 35px;" src="/resources/images/free-icon-web-design-8190501.png"></button>
    <div id="diaryList">
        <%--<div class="test box_right">--%>
        <%--<h2 class="diary_box diary_box_date">2022-08-25</h2>--%>
        <%--<h1 class="diary_box diary_box_title">제목</h1>--%>
        <%--<h3 class="diary_box diary_box_account">지출: 100000원</h3>--%>
        <%--</div>--%>
        <%--<div class="test box_right"></div>--%>
        <%--<div class="test box_right"></div>--%>
        <%--<div class="test box_on"></div>--%>
        <%--<div class="test box_right"></div>--%>
        <%--<div class="test box_right"></div>--%>
        <%--<div class="test box_right"></div>--%>
        <%--<div class="test box_on"></div>--%>
        <%--가계부 본문--%>
    </div>

    <%--모달창 시작--%>
    <div class="modal hidden">
        <span class="modal_title">다이어리</span>

    </div>

</div>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
    const open = document.querySelector(".open");
    // const close = document.querySelector(".modal__closeBtn");
    // const modal = document.querySelector(".modal");

    modal();
    function modal() {
        $(document).on("click", ".open", function () {
            modal.classList.remove("hidden");
        });
    }

    start();

    function start() {
        $.ajax({
            url: "http://localhost:8087/rest/diarylist.do",
            type: "get",
            dataType: "json",
            success: function (returnData, textStatus) {
                str = "";
                let j = 0;
                for (const i of returnData) {
                    console.log()
                    j++;
                    str += "<div class='test " +  (i % 4 === 0 ? "diary_box_on" : "box_right") + " '>";
                    str += "<h2 class='diary_box box_right'>" + i.diaryDate + "</h2>";
                    str += "<h1 class='diary_box box_right diary_box_title'>" + i.diaryTitle + "</h1>";
                    str += "<h3 class='diary_box box_on diary_box_account'>" + i.amount + "</h3>";
                    str += '</div>'
                }
                $('#diaryList').append(str);
            },
            error: function (textStatus) {
                alert("에러");
            }
        });
    }


</script>
</body>
</html>
