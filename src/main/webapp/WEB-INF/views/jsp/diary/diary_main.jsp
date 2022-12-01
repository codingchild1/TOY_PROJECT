<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/jsp/header/navibar.jsp" %>

<%--사이드바--%>
<nav class="sidenav">
    <div>
        <ul class="navDiary">
            <c:forEach var="name" items="${mberVO}" >
                <li class="diaryUserList" onclick="start('${name.mberId}');"><c:out value="${name.mberId}" /></li>
            </c:forEach>
        </ul>
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
            <input type="text" id="modal_content" class="modal_inputbox cont_textarea"/>
            <%--<textarea id="modal_Content" class="modal_inputbox cont_textarea"></textarea>--%>
        </div>
        <%--다른 사람의 다이어리 클릭 시 수정 취소 버튼 숨김--%>
        <%--<div>--%>
            <%--${acc} and ${vo.mberId}--%>
        <%--</div>--%>
        <%--<c:if test="${acc.mberId eq vo.mberId}">--%>
        <input type="checkbox" name="secretBtn" class="secretBtn" id="secretBtn"/>
        <%--<input type="hidden" name="secretBtn" class="secretBtn" id="secretBtn_hidden" value="true"/>--%>
        <span class="secretWriting">비밀글</span>
        <div id="modal_btns">
            <button class="modal__insertBtn" id="jsinsertBtn">등록</button>
            <button class="modal__closeBtn" id="jsCloseBtn">취소</button>
        </div>
        <button class="modal__okBtn">확인</button>
    <%--</c:if>--%>
        <input type="hidden" id="diaryNo"/>
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
<%@ include file="/WEB-INF/views/jsp/header/footer.jsp" %>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
    const open = document.querySelector(".open");
    const close = document.querySelector(".modal__closeBtn");
    const modal = document.querySelector(".modal");
    const diary = document.querySelector(".test");
    const modalBtn = document.querySelector("#modal_btns");
    const okBtn = document.querySelector(".modal__okBtn");

    init();

    function init() {
        $(document).on("click", ".open", function () {
            modal.classList.remove("hidden");
            okBtn.classList.add("hidden");
            diaryReset();
        });

        close.addEventListener("click", function () {
            modalBtn.classList.remove("hidden");
            okBtn.classList.remove("hidden");
            modal.classList.add("hidden");
            diaryReset();
        });

        okBtn.addEventListener("click", function () {
            modalBtn.classList.remove("hidden");
            okBtn.classList.remove("hidden");
            modal.classList.add("hidden");
            diaryReset();
        });

        $(document).on("click", ".test", function () {
            modal.classList.remove("hidden");
            console.log($(this).attr('data-no'));
            console.log($(this).attr('data-no'));
            let diaryNo = $(this).attr('data-no');
            let listMberId = $('#list_mber_id').val();
            let modalMberId = $('#modal_mberId').val();
            // 로그인 아이디와 글 작성자의 아이디가 다를경우 수정 취소 버튼 hidden
            if (listMberId != modalMberId) {
                modalBtn.classList.add("hidden")
            };
            if (listMberId == modalMberId) {
                okBtn.classList.add("hidden")
            };
            // 세션에 있는 mberId와 글 작성자인 mberId
            diaryDiaryNoData(diaryNo);
            diaryReset();
        })
    }

    start();

    function start(mberId) {
        $.ajax({
            url: "http://localhost:8087/rest/diarylist.do",
            type: "get",
            dataType: "json",
            data: {"mberId": mberId},
            success: function (returnData, textStatus) {
                str = "";
                let j = 0;
                for (const i of returnData) {
                    j++;
                    str += "<div class='test " + (i % 4 === 0 ? "diary_box_on" : "box_right") + "'" + " data-no=" + i.diaryNo + ">";
                    // str += "<div class='test " + (i % 4 === 0 ? "diary_box_on" : "box_right") + " data-no=" + i.diaryNo + "'" + "onclick='modal.classList.remove(\"hidden\");'>";
                    str += "<h2 class='diary_box box_right'>" + i.diaryDate + "</h2>";
                    str += "<h1 class='diary_box box_right diary_box_title'>" + i.diaryTitle + "</h1>";
                    str += "<h3 class='diary_box box_on diary_box_account'>" + i.amount + "</h3>";
                    str += "<input type='hidden' id='list_mber_id' value='" + i.mberId + "' />";
                    // 글 작성자의 mberId 불러오기
                    str += '</div>'
                }
                $('#diaryList').empty();    //그 전 요소들 초기화
                $('#diaryList').append(str);    //요소추가
                console.log(mberId);
            },
            error: function (textStatus) {
                alert("에러");
            }
        });
    }

    // 등록버튼
    $("#jsinsertBtn").on('click', function () {
        let diaryNo = $("#diaryNo").val();
        if (diaryNo != "" && diaryNo != null) {
            updateDiary(diaryNo);
        } else {
            insertDiary();
        }
    });

    // 다이어리 글 쓰기
    function insertDiary() {
            if($("#secretBtn").prop("checked")){
                $("#secretBtn").val("true");
            }else{
                $("#secretBtn").val("false");
            }
        var Diary = {
            "mberId": $("#modal_mberId").val(),
            "diaryDate": $("#modal_date").val(),
            "diaryTitle": $("#modal_Title").val(),
            "diaryContents": $("#modal_content").val(),
            "secretBtn": $("#secretBtn").val()
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
            },
        })
        diaryReset();
    }

    function diaryDiaryNoData(diaryNo) {
        $.ajax({
            url: '/rest/diarynodata.do',
            type: 'get',
            dataType: 'json',
            data: {
                "diaryNo": diaryNo
            },
            success: function (data) {
                $("#modal_date").val(data.diaryDate);
                $("#modal_Title").val(data.diaryTitle);
                $("#modal_content").val(data.diaryContents);
                $("#diaryNo").val(diaryNo);
            },
            error: function (textStatus) {
                alert("에러");
            }
        })
    }

    //모달폼 초기화
    function diaryReset() {
        $("#modal_date").val('');
        $("#modal_Title").val('');
        $("#modal_content").val('');
        $("#diaryNo").val('');
    }

</script>
</body>
</html>
