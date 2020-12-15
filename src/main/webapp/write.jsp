<%-- 
    Document   : write
    Created on : 2020. 12. 4., 오후 4:27:49
    Author     : hyeon
--%>

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
    </style>

    <script>
        function w3_open() {
            document.getElementById("mySidebar").style.display = "block";
            document.getElementById(this).style.display = "none";
        }
        function w3_close() {
            document.getElementById("mySidebar").style.display = "none";
        }
    </script>

    <body>

        <!-- Navbar
      ================================================== -->
        <div class="bs-docs-section clearfix">
            <div class="row">
                <div class="col-xs-12">
                    <div class="page-header" style="text-align:right;">
                        <% if(session.getAttribute("id") != null){%>
                        <h6 style=" display: inline" ><%=session.getAttribute("id")%> 님 안녕하세요!!!&nbsp; &nbsp;</h6>
                        <%}%>
                        <%if(session.getAttribute("id") != null){%>
                        <h5 style=" display: inline" onclick="window.location='Logout.do'">Logout</h5>
                        <%}else{%>
                        <h5 style=" display: inline" onclick="window.location='login.jsp'">Login</h5>
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
                                        <center><p style="font-size: 30px">게시판 글쓰기</p></center>
                                        <div class="container">
                                            <form method="POST" action="WriteAction.do?boardType=<%=request.getParameter("major")%>">
                                      
                                            <table class="table" style="text-align: center; border: 1px solid thistle">
                                                <thead>
                                                    <tr>
                                                        <th colspan="2" style=" background-color: #eeeeee; text-align: center;">게시판 글쓰기 양식</th>
                                                        
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50"></td>
                                                    </tr>
                                                    <tr>
                                                    <td><textarea class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" style="height: 350px"></textarea></td>
                                                    </tr>
                                                </tbody>
                                                
                                            </table>
                                            <button class="btn btn-secondary my-2 my-sm-0" type="submit">글쓰기</button>
                                            </form>
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