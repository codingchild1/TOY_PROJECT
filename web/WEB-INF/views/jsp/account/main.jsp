<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<jsp:useBean id="now" class="java.util.Date"/>
<jsp:include page="/WEB-INF/views/jsp/header/navibar.jsp"/>
<body>
<%--사이드바--%>
<nav class="sidenav">
    <div>
        <fmt:formatDate value="${now}" var="thisDay" pattern="yyyy-MM-dd"/> <%--2022-08--%>
        <select id="yearBox">
            <c:forEach begin="${fn:substring(thisDay, 0, 4)-3}" end="${fn:substring(thisDay, 0, 4)+8}" var="year">
                <option value="${year}" ${year == fn:substring(thisDay, 0, 4) ? 'selected' : ''}>${year}년</option>
            </c:forEach>
        </select>
        <select id="monthBox">
            <%--현재 날짜 불러오기--%>
            <%--현재날짜 선택 시작--%>
            <option value="">---</option>
            <c:forEach begin="1" end="12" var="month">
                <option value="${month}" ${month == fn:substring(thisDay, 5, 7) ? 'selected' : ''}>${month}월</option>
            </c:forEach>
        </select>
        <select id="dateBox">
        </select>
    </div>
    <%--${fn:substring(thisDay, 0, 4)}--%>
    <%--${fn:substring(thisDay, 5, 8)}--%>
</nav>
<%--사이드 메뉴 끝--%>

<div class="accdetail">
    <h1 class="total" style="cursor: pointer;"></h1>
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
    </div>
    <label for="createacc"></label>
    <button type="button" id="createacc" class="open"><img style="width: 40px;
    height: 35px;" src="/resources/images/free-icon-web-design-8190501.png"></button>
    <table class="acctable">
        <colgroup>
            <col width="15%">
            <col width="20%">
            <col width="30%">
            <col width="15%">
            <col width="20%">
        </colgroup>
        <thead>
        <tr class="tr-first">
            <th>Date</th>
            <th>Category</th>
            <th>Content</th>
            <th>Amount (원)</th>
            <th>누적 (원)</th>
        </tr>
        </thead>

        <%--가계부 본문--%>
        <tbody>
        </tbody>
    </table>
    <table class="category_Amount">
        <colgroup>
            <col width="20%" style="background: red;">
            <col width="20%" style="background: skyblue;">
            <col width="20%" style="background: green;">
            <col width="20%" style="background: yellow;">
            <col width="20%" style="background: gray;">
        </colgroup>
        <tbody>
        </tbody>
    </table>
</div>
<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<script>
    // const open = document.querySelector(".open");
    const close = document.querySelector(".modal__closeBtn");
    const modal = document.querySelector(".modal");
    //처음시작
    getList();
    // init();
    function init() {
        $(document).on("click", ".open", function () {
            modal.classList.remove("hidden");
            if ($(this).attr('data-no') == undefined) {
                return
            }
            // undefined면 실행 X / 아니면 실행 O
            console.log($(this).attr('data-no'));
            console.log($(this).attr('data-no'));
            //hidden이라는 클래스가 있으면 없앤다.
            let accNo = $(this).attr('data-no');
            accountaccnodata(accNo);
            // => 해당함수 success 를 이용해서 모달창에 값 넣어주기
        });

        // 삭제버튼
        $(document).on('click', ".delete-btn", function () {
            let accNo = $(this).attr('data-no');
            deleteList(accNo);
        })

        close.addEventListener("click", function () {
            modal.classList.add("hidden");
            accreset();
        });

        // getList();
        date();
    }

    // 등록버튼
    $("#jsinsertBtn").on('click', function () {
        let accNo = $("#accNo").val();
        if (accNo != "" && accNo != null) {
            updateList(accNo);
        } else {
            insertList();
        }
    });

    // 년, 월 바뀌면

    $("#yearBox, #monthBox").on('change', function () {
        date();
        getList();
    });

    $("#dateBox").on('change', function () {
        getList();
    });

    // 날짜 박스
    function date() {
        let thisYear = $("#yearBox").val();
        let thisMonth = $("#monthBox").val();
        let firstDay = new Date(thisYear, thisMonth - 1, 1);
        let lastDay = new Date(thisYear, thisMonth, 0);
        let str = "";
        str += "<option value='' selected>" + '---' + "</option>";
        if (thisMonth != '') {
            for (let i = firstDay.getDate(); i <= lastDay.getDate(); i++) {
                str += "<option value='" + i + "'>" + i + "</option>";
            }
        }
        $("#dateBox").val();
        $('#dateBox').empty();  //값 초기화
        $('#dateBox').append(str);  //요소 추가
    }

    function deleteList(accNo) {
        let accdelete = {
            "accNo": accNo,
            "accDelete": true
        };
        $.ajax({
            url: '/rest/accdelete',
            type: 'post',
            dataType: "json",
            data: accdelete,
            success: function () {
                console.log(accNo)
                getList();
            },
            error: function () {
                alert('실패');
            }
        })
    }

    // 가계부 추가
    function insertList() {
        var Account = {
            "accDate": $("#modal_date").val(),
            "category": $("#modal_category").val(),
            "content": $("#modal_content").val(),
            "amount": $("#modal_amount").val()
        }
        $.ajax({
            url: '/rest/insertlist',
            type: 'post',
            dataType: "json",
            data: Account,
            success: function () {
                getList();
                modal.classList.add("hidden");
            },
            error: function (data, textStatus) {
                alert('실패');
            }
        })
    }

    // 데이터 불러오기
    function accountaccnodata(accNo) {
        $.ajax({
            url: '/rest/accountaccnodata',
            type: 'get',
            dataType: 'json',
            data: {
                "accNo": accNo
            },
            success: function (data, textStatus) {
                

                $("#modal_date").val(data.accDate);
                $("#modal_category").val(data.category);
                $("#modal_content").val(data.content);
                $("#modal_amount").val(data.amount);

                $("#accNo").val(accNo);   // input태그에 요소 추가

            },
            error:function(request, status, error){

                alert("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);

            }
        })
    }

    // 가계부 수정
    function updateList(accNo) {
        var Account = {
            "accDate": $("#modal_date").val(),
            "category": $("#modal_category").val(),
            "content": $("#modal_content").val(),
            "amount": $("#modal_amount").val(),
            "accNo": accNo  // parameter 가져오기
        }
        
        $.ajax({
            url: '/rest/modifylist',
            type: 'post',
            dataType: "json",
            data: Account,
            success: function () {
                getList();
                modal.classList.add("hidden");
            },
            error: function (data, textStatus) {
                alert('실패');
            }
        })
    }

    // 목록 불러오기
    function getList() {
        let today = {
            "year": $("#yearBox").val(),
            "month": $("#monthBox").val(),
            "date": $("#dateBox").val()
        }
        $.ajax({
            url: '/rest/getlist',
            dataType: 'json',
            type: 'GET',
            data: today,
            success: function (returnData, textStatus) {
                str = "";
                strCate = "";
                let allAmount = 0;
                let foodAmount = 0;
                let healthAmount = 0;
                let playAmount = 0;
                let shoppingAmount = 0;
                let etcAmount = 0;
                for (const i of returnData) {
                    allAmount += i.amount;

                    switch (i.category) {
                        case '식비':
                            foodAmount += i.amount;
                            break;
                        case '건강':
                            healthAmount += i.amount;
                            break;
                        case '놀이':
                            playAmount += i.amount;
                            break;
                        case '쇼핑':
                            shoppingAmount += i.amount;
                            break;
                        case '기타':
                            etcAmount += i.amount;
                            break;
                    }
                }
                $(".total").text("Total:" + allAmount + "원");
                for (const i of returnData) {
                    str += "<tr class=tr-second-1>";
                    str += "<td class=notice-data>" + i.accDate + "</td>";
                    str += "<td class=notice-category>" + i.category + "</td>";
                    str += "<td class=notice-content>" + i.content + "</td>";
                    str += "<td class=notice-amount>";
                    str += "<span class=notice-label>" + i.amount.format()+ "</span>";
                    str += "</td>";
                    str += "<td class=noticce-total>";
                    str += "<span class=notice-file-icon>" + allAmount.format() + "</span>";
                    allAmount -= i.amount;
                    str += "<button class='open modify-btn' data-no='" + i.accNo + "'>" + "수정" + "</button>";    //data-no=''
                    str += "<button class='delete-btn' id='delete-btn' data-no='" + i.accNo + "'>" + "삭제" + "</button>";
                    str += "</td>"
                    str += "</tr>"
                }
                // 카테고리 별 금액
                strCate += "<tr>";
                strCate += "<th>" + "식비: " + foodAmount.format() + " 원" + "</th>";
                strCate += "<th>" + "건강: " + healthAmount.format() + " 원" + "</th>";
                strCate += "<th>" + "쇼핑: " + playAmount.format() + " 원" + "</th>";
                strCate += "<th>" + "놀이: " + shoppingAmount.format() + " 원" + "</th>";
                strCate += "<th>" + "기타: " + etcAmount.format() + " 원" + "</th>";
                strCate += "</tr>";

                $(".acctable tbody").empty();   //초기화
                $(".acctable tbody").append(str);   //요소추가
                $(".category_Amount tbody").empty();
                $(".category_Amount tbody").append(strCate);    // 카테고리별 요소 추가
            },
            error: function (returnData, textStatus) {
                alert('실패');
            }
        });
        init();
    }

    //모달폼 초기화
    function accreset() {
        $("#modal_date").val('');
        $('#modal_category').val('');
        $("#modal_content").val('');
        $("#modal_amount").val('');
        $("#accNo").val('');
    }

    // format() 함수 추가
    Number.prototype.format = function () {
        if (this==0) return 0;

        let reg = /(^[+-]?\d+)(\d{3})/;
        let num = (this + '');

        while (reg.test(num)) num = num.replace(reg, '$1' + ',' + '$2');

        return num;
    }

</script>
</body>
</html>
