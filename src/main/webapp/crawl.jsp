<%-- 
    Document   : crawls.jsp
    Created on : 2020. 12. 6., 오후 9:45:26
    Author     : hyeon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>나의 남은 과제는...</title>
        <script src="https://code.jquery.com/jquery-3.5.1.js"
        integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="./css/bootstrap.css">
        <script type="text/javascript"
        src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>

        <script>
            
            $(document).ready(function () {
                if (sessionStorage.getItem("isLogin") && (!parseInt(sessionStorage.getItem("count")) == 1)) {
                    sessionStorage.setItem("second", 0);
                    sessionStorage.setItem("minute", 0);
                    sessionStorage.setItem("hour", 0);
                    sessionStorage.setItem("count", 1);
                    tid = setInterval('count()', 1000); // 타이머 1초간격으로 수행
                }else if(sessionStorage.getItem("isLogin") && parseInt(sessionStorage.getItem("count")) == 1){
                    tid = setInterval('count()', 1000); // 타이머 1초간격으로 수행
                    console.log("엘스");
                }else {    
                    console.log(parseInt(sessionStorage.getItem("count")));
                }
            });
    
        

            function count() {

                if (sessionStorage.getItem("hour") == null || sessionStorage.getItem("minute") == null || sessionStorage.getItem("second") == null) {
                    document.getElementById("checktime").innerHTML = '사이트 이용 시간 : 00 : 00 : 00';
                    console.log("여기옴!!!");
                } else {
                    sessionStorage.setItem("second", sessionStorage.getItem('second'));
                    sessionStorage.setItem("minute", sessionStorage.getItem('minute'));
                    sessionStorage.setItem("hour", sessionStorage.getItem('hour'));
                    document.getElementById("checktime").innerHTML = '사이트 이용 시간 : ' + sessionStorage.getItem("hour") + ' : ' + sessionStorage.getItem("minute") + ' : ' + sessionStorage.getItem("second");
                    sessionStorage.setItem("second", parseInt(sessionStorage.getItem('second'))+1);
                    if (sessionStorage.getItem('second') === "60") {
                        sessionStorage.setItem("second", 0);
                        sessionStorage.setItem("minute", parseInt(sessionStorage.getItem('minute'))+1);
                    } else if (sessionStorage.getItem('minute') === "60") {
                        sessionStorage.setItem("minute", 0);
                        sessionStorage.setItem("hour", parseInt(sessionStorage.getItem('hour'))+1);
                    }
                }
            }

            $(window).scroll(function () {
                // top button controll
                if ($(this).scrollTop() > 100) {
                    $('#topButton').fadeIn();
                } else {
                    $('#topButton').fadeOut();
                }
            });
            $(document).ready(function () {
                // Top Button click event handler
                $("#topButtonImg").click(function () {
                    $('html, body').animate({scrollTop: 0}, '300');
                });
            });

            function submit() {
                $.ajax({
                    url: "/WebProjecct/crawling.do",
                    method: "POST",
                    success: function (data) {
                        console.log(data);
                        let parsedData = JSON.parse(data)["result"];
                        if (parsedData === "failed") {
                            //로그인 실패한 것 처리
                        } else {
                            let node = document.createElement("div");
                            let cookies = JSON.parse(data)["cookies"];
                            for (let i = 0; i < cookies.length; i++) {
                                $.cookie(cookies[i]["key"], cookies[i]["value"], {expires: 7, path: '/'});
                            }
                            for (let i = 0; i < Object.keys(parsedData).length; i++) {
                                let divWrapper = document.createElement("div");
                                divWrapper.setAttribute("class", "mt-3 wrapper"); // 래퍼
                                /////과목명///////
                                let headingElement = document.createElement("h4");
                                headingElement.innerText = parsedData[i]["subjectName"];
                                divWrapper.appendChild(headingElement);
                                /////공지사항//////
                                let headingElement2 = document.createElement("h3");
                                headingElement2.innerText = "공지사항";
                                divWrapper.appendChild(headingElement2)
                                let gongjiElement = parsedData[i]["gongji"];
                                let gongjiTable = makeTable(gongjiElement);
                                divWrapper.appendChild(gongjiTable);
                                /////과제///////
                                let headingElement3 = document.createElement("h3");
                                headingElement3.innerText = "과제";
                                divWrapper.appendChild(headingElement3);
                                let homeworkElement = parsedData[i]["homework"];
                                let homeworkTable = makeTable(homeworkElement);
                                divWrapper.appendChild(homeworkTable);
                                ///강의자료////
                                let headingElement4 = document.createElement("h3");
                                headingElement4.innerText = "강의자료"
                                divWrapper.appendChild(headingElement4)
                                let reference = parsedData[i]["reference"];
                                let referenceTable = makeTable(reference);
                                divWrapper.appendChild(referenceTable);
                                node.appendChild(divWrapper);
                            }
                            const container = document.getElementById("container");
                            container.appendChild(node);
                        }
                    }
                    ,
                    beforeSend: function () {
                        $('div.display-none').removeClass('display-none');
                    }
                    ,
                    complete: function () {
                        $('.wrap-loading').remove();
                        $('div.logo-area').remove();
                        $('img.infinite_rotating_logo').remove();
                    },
                    error: function () {
                        //실패처리
                    }
                })
            }
            function makeTable(parsedData) {
                let tableNode = document.createElement("table");
                tableNode.setAttribute("border", "0");
                tableNode.setAttribute("class", "border-left-0 border-right-0 table tableClass");
                let thRecord = document.createElement("tr");
                for (let j = 0; j < parsedData["thead"].length; j++) {
                    let thElement = document.createElement("th");
                    thElement.innerText = parsedData["thead"][j];
                    console.log(parsedData["thead"][j]);
                    thRecord.appendChild(thElement);
                }
                tableNode.appendChild(thRecord);
                for (let j = 0; j < parsedData["record"].length / parsedData["thead"].length; j++) {
                    let tableRecordElement = document.createElement("tr");
                    for (let k = 0; k < parsedData["thead"].length; k++) {
                        let tableDataElement = document.createElement("td");
                        if (parsedData["record"][j * parsedData["thead"].length + k].split(" LINK ").length !== 1) {
                            let linkElement = document.createElement("a");
                            linkElement.setAttribute("target", "_blank");
                            linkElement.setAttribute("href", parsedData["record"][j * parsedData["thead"].length + k].split(" LINK ")[1]);
                            linkElement.innerText = parsedData["record"][j * parsedData["thead"].length + k].split(" LINK ")[0];
                            tableDataElement.appendChild(linkElement);
                        } else {
                            tableDataElement.innerText = parsedData["record"][j * parsedData["thead"].length + k];
                        }
                        console.log(parsedData["record"][j * parsedData["thead"].length + k])
                        tableRecordElement.appendChild(tableDataElement);
                    }
                    tableNode.appendChild(tableRecordElement);
                }

                console.log(tableNode);
                return tableNode;
            }


            submit();
        </script>

        <%
            if (session.getAttribute("id") == null) {
                StringBuilder Popup = new StringBuilder();
                Popup.append("<script>alert('로그인이 필요합니다!'); location.href='login.jsp';</script>");
                out.println(Popup.toString());
            }
        %>

        <style>
            #topButton {position: fixed; right: 2%; bottom: 50px; display: none; z-index: 999;}

            img.infinite_rotating_logo {
                animation: rotate_image 10s linear infinite;
                transform-origin: 50% 50%;
            }

            @keyframes rotate_image {
                100% {
                    transform: rotate(360deg);
                }
            }

            .wrap-loading {
                position: fixed;
                left: 0;
                right: 0;
                top: 0;
                bottom: 0;
                background: rgba(0, 0, 0, 0.2);
                filter: progid:DXImageTransform.Microsoft.Gradient(startColorstr='#20000000', endColorstr='#20000000');
            }

            .wrap-loading div {
                position: fixed;
                top: 50%;
                left: 50%;
                margin-left: -21px;
                margin-top: -21px;
            }

            .display-none {
                display: none;
            }

            .logo-area {
                display: -webkit-box;
                display: -ms-flexbox;
                display: flex;
                -webkit-box-align: center;
                -ms-flex-align: center;
                align-items: center;
                -webkit-box-pack: center;
                -ms-flex-pack: center;
                justify-content: center;
            }

            .tableClass {
                margin: auto;
                /* 테이블에 적용할 css 삽입 */
            }

            .wrapper {
                padding: 30px;
                text-align: center;
                font-family: 맑은고딕, Malgun Gothic, dotum, gulim, sans-serif;


                /* 과목마다 감싼 div에 적용할 css 삽입 */
            }

            h3 {
                margin-top: 50px;
                font-family: 맑은고딕, Malgun Gothic, dotum, gulim, sans-serif;
            }

            h4 {
                font-family: 맑은고딕, Malgun Gothic, dotum, gulim, sans-serif;
            }

            th {
                background: #f7f7f7 !important;
            }
        </style>
    </head>
    <body>
        <div id="topButton" style="cursor: pointer"><img src="./images/topbutton.png" id="topButtonImg"></div>
        <div class="bs-docs-section clearfix">
            <div class="row">
                <div class="col-xs-12">

                    <div class="page-header" style="text-align:right;">
                        <% if (session.getAttribute("id") != null) {%>
                        <h6 style=" display: inline"><%=session.getAttribute("id")%> 님 안녕하세요!!!&nbsp; &nbsp;</h6>
                        <%}%>
                        <%if (session.getAttribute("id") != null) {%>
                        <h5 style=" display: inline" onclick="window.location = 'Logout.do'">Logout</h5>
                        <%} else {%>
                        <h5 style=" display: inline" onclick="window.location = 'login.jsp'">Login</h5>
                        <%}%>
                        
                        <script>

                            if (sessionStorage.getItem("isLogin")) {
                                document.write("<p id='checktime'></p>");

                            } else {


                            }
                        </script>
                    </div>
                    <div class="page-header" style="display: inline;">
                        <center><h1 id="navbars" onclick="location.href = 'index.jsp'">Homework Calendar</h1>
                            <center>
                                </div>


                                <div class="bs-component">
                                    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">

                                        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor01"
                                                aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
                                            <span class="navbar-toggler-icon"></span>
                                        </button>

                                        <div class="collapse navbar-collapse" id="navbarColor01">
                                            <ul class="navbar-nav mr-auto">
                                                <li class="nav-item active">
                                                    <a class="nav-link" href="index.jsp">홈
                                                        <span class="sr-only">(current)</span>
                                                    </a>
                                                </li>
                                                <li class="nav-item" style="background-color: #555555"
                                                    ">
                                                    <a class="nav-link" id="test" href="crawls.jsp">과제 모아보기</a>
                                                </li>
                                                <li class="nav-item">
                                                    <a class="nav-link" href="board.jsp">질문 게시판</a>
                                                </li>
                                                <li class="nav-item">
                                                    <a class="nav-link" href="#">자유 게시판</a>
                                                </li>
                                                <li class="nav-item">
                                                    <a class="nav-link" href="#">고객센터</a>
                                                </li>

                                            </ul>
                                            <form class="form-inline my-2 my-lg-0">
                                                <input class="form-control mr-sm-2" type="text" placeholder="Search">
                                                <button class="btn btn-secondary my-2 my-sm-0" type="submit">Search</button>
                                            </form>
                                        </div>
                                    </nav>
                                </div>

                                <div class="logo-area wrap-loading">
                                    <a href="#" target="_blank"><img src="images/load1.gif" alt="로딩 화면" rel="noopener noreferrer"></a>
                                </div>
                                <div id="container">

                                </div>
                                <br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/><br/>
                                <footer class="card-footer" style=" font-size: 50px">
                                    <center>HomeWork Calendar</center>
                                    <center style=" font-size: 15px">Copyright(C) 2020.웹 개발 활용 1조.All rights reserved</center>

                                </footer>
                                </body>
                                </html>
