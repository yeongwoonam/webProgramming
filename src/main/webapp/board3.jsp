<%-- 
    Document   : board3
    Created on : 2020. 12. 3., 오후 9:11:41
    Author     : hyeon
--%>

<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>학과별 게시판</title>
        <link rel="stylesheet" href="./css/bootstrap.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


    </head>

    <style type="text/css">
        .w3-sidebar{height:150px;width:150px;background-color:#fff;position:relative!important;z-index:1;overflow:auto}
        .w3-bar-block .w3-dropdown-hover,.w3-bar-block .w3-dropdown-click{width:100%}
        .w3-bar-block .w3-dropdown-hover .w3-dropdown-content,.w3-bar-block .w3-dropdown-click .w3-dropdown-content{min-width:100%}
        .w3-bar-block .w3-dropdown-hover .w3-button,.w3-bar-block .w3-dropdown-click .w3-button{width:100%;text-align:left;padding:8px 16px}
        .w3-border-right{border-right:1px solid #ccc!important}
        #topButton {position: fixed; right: 2%; bottom: 50px; display: none; z-index: 999;}
    </style>

    <script>
        function w3_open() {
            document.getElementById("mySidebar").style.display = "block";
            document.getElementById(this).style.display = "none";
        }
        function w3_close() {
            document.getElementById("mySidebar").style.display = "none";
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
    </script>

    <script>

        $(document).ready(function () {
            if (sessionStorage.getItem("isLogin") && (!parseInt(sessionStorage.getItem("count")) == 1)) {
                sessionStorage.setItem("second", 0);
                sessionStorage.setItem("minute", 0);
                sessionStorage.setItem("hour", 0);
                sessionStorage.setItem("count", 1);
                tid = setInterval('count()', 1000); // 타이머 1초간격으로 수행
            } else if (sessionStorage.getItem("isLogin") && parseInt(sessionStorage.getItem("count")) == 1) {
                tid = setInterval('count()', 1000); // 타이머 1초간격으로 수행
                console.log("엘스");
            } else {
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
                sessionStorage.setItem("second", parseInt(sessionStorage.getItem('second')) + 1);
                if (sessionStorage.getItem('second') === "60") {
                    sessionStorage.setItem("second", 0);
                    sessionStorage.setItem("minute", parseInt(sessionStorage.getItem('minute')) + 1);
                } else if (sessionStorage.getItem('minute') === "60") {
                    sessionStorage.setItem("minute", 0);
                    sessionStorage.setItem("hour", parseInt(sessionStorage.getItem('hour')) + 1);
                }
            }
        }


    </script>

    <body>
        
        <div id="topButton" style="cursor: pointer"><img src="./images/topbutton.png" id="topButtonImg"></div>

        <!-- Navbar
      ================================================== -->
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

                        <script>

                            if (sessionStorage.getItem("isLogin")) {
                                document.write("<p id='checktime'></p>");

                            } else {


                            }
                        </script>
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
                                                <li class="nav-item">
                                                    <a class="nav-link" id="test" href="crawl.jsp">과제 모아보기</a>
                                                </li>
                                                <li class="nav-item" style="background-color: #555555">
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
                                </div>
                                </div>
                                </div>
                                <!-- Navbar
                               ================================================== 끝-->


                                <div class="row">
                                    <!-- Sidebar -->
                                    <br /><br />
                                    <div class="col-sm-2">
                                        <button class="btn btn-secondary my-2 my-sm-0" onclick="w3_open()">학과 선택</button>

                                        <div class="w3-sidebar w3-bar-block w3-border-right" style="display:none" id="mySidebar" style="width: 25%; height: 50px">
                                            <br />
                                            <a href="board.jsp" style="font-size: 15px">경영정보학과</a> <br><br />
                                            <a href="board2.jsp" style="font-size: 15px">e비즈니스학과</a> <br><br />
                                            <a href="board3.jsp" style="font-size: 15px">컴퓨터소프트웨어공학과</a> <br><br />
                                            <button class="btn btn-secondary my-2 my-sm-0" onclick="w3_close()">Close &times;</button> <br>	

                                        </div>
                                    </div>
                                    <div class="col-sm-10">
                                        <center><p style="font-size: 30px">컴퓨터소프트웨어공학과 게시판</p></center>
                                        <div class="container">
                                            <table class="table" style="text-align: center; border: 1px solid thistle">
                                                <thead>
                                                    <tr>
                                                        <th style=" background-color: #eeeeee; text-align: center;">번호</th>
                                                        <th style=" background-color: #eeeeee; text-align: center;">제목</th>
                                                        <th style=" background-color: #eeeeee; text-align: center;">작성자</th>
                                                        <th style=" background-color: #eeeeee; text-align: center;">작성일</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <%!
                                                        private Connection conn;
                                                        private PreparedStatement pstmt; // 쿼리문을 실행하기 위한 객체
                                                        private ResultSet rs;   // 실행한 쿼리문에서 반환될 결과를 담을 객체
                                                        private String URL = "jdbc:mysql://localhost:3306/webteam?serverTimezone=Asia/Seoul";
                                                        private String DBID = "root";
                                                        private String DBPWD = "dldbfla0"; // 자신의 비밀번호
                                                        String query;
                                                    %>                  
                                                    <%
                                                        Class.forName("com.mysql.cj.jdbc.Driver"); // JDBC 드라이버 적재
                                                        conn = DriverManager.getConnection(URL, DBID, DBPWD); // Connection 객체 생성

                                                        query = "SELECT * FROM board3 ORDER BY number desc";
                                                        pstmt = conn.prepareStatement(query);
                                                        rs = pstmt.executeQuery();

                                                        while (rs.next()) {%>
                                                    <tr> 
                                                        <td><%=rs.getInt("number")%></td>
                                                        <td><a href="read.jsp?boardType=3&number=<%=rs.getInt("number")%>"><%=rs.getString("title")%></a></td>
                                                        <td><%=rs.getString("userid")%></td>
                                                        <td><%=rs.getString("dates")%></td>

                                                        <%}%>
                                                </tbody>
                                            </table> 
                                            <button class="btn btn-secondary my-2 my-sm-0" type="submit" onclick="window.location.href = 'write.jsp?major=3'">글쓰기</button>
                                        </div>

                                        <br />
                                    </div>

                                </div>


                                <!-- Sidebar 끝 -->


                                <footer class="card-footer" style=" font-size: 50px">
                                    <center>HomeWork Calendar</center>
                                    <center style=" font-size: 15px">Copyright(C) 2020.웹 개발 활용 1조.All rights reserved</center>

                                </footer>


                                </body>
                                </html>