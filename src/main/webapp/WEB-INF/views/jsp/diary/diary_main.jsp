<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/jsp/header/navibar.jsp" %>

<%--사이드바--%>
<nav class="sidenav">
    <div>

    </div>
</nav>
<%--사이드 메뉴 끝--%>

<div class="accdetail diaryBackImg">
    <div class="modal hidden" id="jsModal" style="text-align: left;">
        <span class="modal_title">내 지출 </span>
        <ul class="modal_list">
            <li>Date</li>
            <li class="input_list">Title</li>
            <li class="input_list">Content</li>
            <%--<li class="input_list">Amount</li>--%>
        </ul>
        <div id="modal_inputboxid">
            <input type="date" id="modal_date" class="modal_inputbox"/>
            <input type="text" id="modal_Title" class="modal_inputbox"/>
            <input type="text" id="modal_content" class="modal_inputbox cont_textarea" />
            <%--<textarea id="modal_Content" class="modal_inputbox cont_textarea"></textarea>--%>
        </div>

        <div id="modal_btns">
            <button class="modal__insertBtn" id="jsinsertBtn">등록</button>
            <button class="modal__closeBtn" id="jsCloseBtn">취소</button>
        </div>
        <input type="text" id="accNo"/>
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

</div>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
    const open = document.querySelector(".open");
    const close = document.querySelector(".modal__closeBtn");
    const modal = document.querySelector(".modal");

    init();
    function init() {
        $(document).on("click", ".open", function () {
            modal.classList.remove("hidden");
        });

        close.addEventListener("click", function () {
            modal.classList.add("hidden");
            accreset();
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
                $('#diaryList').empty();    //그 전 요소들 초기화
                $('#diaryList').append(str);    //요소추가
            },
            error: function (textStatus) {
                alert("에러");
            }
        });
    }

    // 등록버튼
    $("#jsinsertBtn").on('click', function () {
        let accNo = $("#accNo").val();
        if (accNo != "" && accNo != null) {
            updateDiary(accNo);
        } else {
            insertDiary();
        }
    });

    // 다이어리 글 쓰기
    function insertDiary() {
        let Diary = {
            "mberId": $("#modal_mberId").val(),
            "diaryDate": $("#modal_date").val(),
            "diaryTitle": $("#modal_Title").val(),
            "diaryContents": $("#modal_content").val()
        };
        $.ajax({
            url: "/rest/insertDiary.do",
            type: 'post',
            data: Diary,
            success: function (data) {
                start();
                modal.classList.add("hidden");
            },
            error: function (textStatus) {
                alert('실패');
            }

        })
    }

</script>
</body>
</html>
