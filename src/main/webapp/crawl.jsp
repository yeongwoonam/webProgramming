<%-- 
    Document   : crawls.jsp
    Created on : 2020. 12. 6., 오후 9:45:26
    Author     : hyeon
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <title>나의 남은 과제는...</title>
        <script src="https://code.jquery.com/jquery-3.5.1.js"
        integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
        <link rel="stylesheet" href="./css/bootstrap.css">
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>

        <script>
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
                                /////과목명///////
                                let headingElement = document.createElement("h4");
                                headingElement.innerText = parsedData[i]["subjectName"];
                                node.appendChild(headingElement);
                                /////공지사항//////
                                let headingElement2 = document.createElement("h4");
                                headingElement2.innerText = "공지사항";
                                node.appendChild(headingElement2)
                                let gongjiElement = parsedData[i]["gongji"];
                                let gongjiTable = makeTable(gongjiElement);
                                node.appendChild(gongjiTable);
                                /////과제///////
                                let headingElement3 = document.createElement("h4");
                                headingElement3.innerText = "과제";
                                node.appendChild(headingElement3);
                                let homeworkElement = parsedData[i]["homework"];
                                let homeworkTable = makeTable(homeworkElement);
                                node.appendChild(homeworkTable);
                                ///강의자료////
                                let headingElement4 = document.createElement("h4");
                                headingElement4.innerText = "강의자료"
                                node.appendChild(headingElement4)
                                let reference = parsedData[i]["reference"];
                                let referenceTable = makeTable(reference);
                                node.appendChild(referenceTable);
                            }
                            const container = document.getElementById("container");
                            container.appendChild(node);
                        }

                    },
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
                tableNode.setAttribute("border", "1");
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
        </style>
    </head>
    <body>
        <div class="bs-docs-section clearfix">
            <div class="row">
                <div class="col-xs-12">

                    <div class="page-header" style="text-align:right;">
                        <% if (session.getAttribute("id") != null) {%>
                        <h6 style=" display: inline" ><%=session.getAttribute("id")%> 님 안녕하세요!!!&nbsp; &nbsp;</h6>
                        <%}%>
                        <%if (session.getAttribute("id") != null) {%>
                        <h5 style=" display: inline" onclick="window.location = 'Logout.do'">Logout</h5>
                        <%} else {%>
                        <h5 style=" display: inline" onclick="window.location = 'login.jsp'">Login</h5>
                        <%}%>
                    </div>
                    <div class="page-header" style="display: inline;">
                        <center><h1 id="navbars" onclick="location.href = 'index.jsp'">Homework Calendar</h1><center>
                                </div>



                                <div class="bs-component">
                                    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">

                                        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarColor01" aria-controls="navbarColor01" aria-expanded="false" aria-label="Toggle navigation">
                                            <span class="navbar-toggler-icon"></span>
                                        </button>

                                        <div class="collapse navbar-collapse" id="navbarColor01">
                                            <ul class="navbar-nav mr-auto">
                                                <li class="nav-item active">
                                                    <a class="nav-link" href="index.jsp">홈
                                                        <span class="sr-only">(current)</span>
                                                    </a>
                                                </li>
                                                <li class="nav-item" style="background-color: #555555"">
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
                                <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /> 
                                <footer class="card-footer" style=" font-size: 50px">
                                    <center>HomeWork Calendar</center>
                                    <center style=" font-size: 15px">Copyright(C) 2020.웹 개발 활용 1조.All rights reserved</center>

                                </footer>
                                </body>
                                </html>
