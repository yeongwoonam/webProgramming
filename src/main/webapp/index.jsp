<%-- 
    Document   : index
    Created on : 2020. 12. 3., 오후 9:09:11
    Author     : hyeon
--%>

<%@page import="cse.web_project.webprojecct.getWeather"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko" id="test">
    <head>
        <meta charset="UTF-8">

        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="./css/bootstrap.css">
        <title>TeamProject</title>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
        <script src="https://tistory3.daumcdn.net/tistory/941717/skin/images/jquery.min.js" type="text/javascript"></script>
        <script src="https://tistory3.daumcdn.net/tistory/941717/skin/images/snowfall.jquery.js" type="text/javascript"></script>
        <script>

            $(document).ready(function () {
                $(document).snowfall({deviceorientation: true, round: true, minSize: 1, maxSize: 8, flakeCount: 250});
            });

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

        <%--
        <%
            session.setAttribute("ID", "20143249");
            // 기상 정보에 맞춰 페이지에 effect 표시하기
            // - 강수형태(PTY) 코드 : 없음(0), 비(1), 비/눈(2), 눈(3), 소나기(4), 빗방울(5), 빗방울/눈날림(6), 눈날림(7)
            // 여기서 비/눈은 비와 눈이 섞여 오는 것을 의미 (진눈개비)
            out.println(getWeather.ob.now);
            if (getWeather.ob.now != null) {
                if (getWeather.ob.now.equals("3") || getWeather.ob.now.equals("7")) {%>

        <script src="https://tistory3.daumcdn.net/tistory/941717/skin/images/jquery.min.js" type="text/javascript"></script>
        <script src="https://tistory3.daumcdn.net/tistory/941717/skin/images/snowfall.jquery.js" type="text/javascript"></script>
        <script>
            $(document).ready(function () {
                $(document).snowfall({deviceorientation: true, round: true, minSize: 1, maxSize: 8, flakeCount: 250});
            });
        </script>

        <%} else if (getWeather.ob.now.equals("1") || getWeather.ob.now.equals("2") || getWeather.ob.now.equals("4") || getWeather.ob.now.equals("5") || getWeather.ob.now.equals("6")) {%>
        <link href="./css/weather.css" rel="stylesheet">
        <script>
            $(document).ready(function () {
                document.getElementById('test').classList.add("weather", "rain");
            });
        </script>

        <%}
            }%>
        --%>


        <style>
            #topButton {position: fixed; right: 2%; bottom: 50px; display: none; z-index: 999;}


            .modal{
			position: fixed;
			top: 0; left: 0;
			width: 100%; height: 100%;
			display: flex;
			justify-content: center;
			align-items : center;
		}
		.md_overlay {
			background-color: rgba(0, 0, 0, 0.6);
			width: 100%; height: 100%;
			position: absolute;
		}
		.md_content {
			width: 800px;
                        height: 400px;
			position: relative;
                        text-align: center;
                        margin: 50px;
                        padding: 50px;

			background-color: #d1ecf1;

			border-radius: 6px;
			box-shadow: 0 10px 20px rgba(0,0,0,0.20), 0 6px 6px rgba(0, 0, 0, 0.20);
		}

            .hidden {
                display: none;
            }
            .modal_text {
                padding: 16px; 
                display: inline;
            }

            @font-face {
                font-family: 'MapoFlowerIsland';
                src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2001@1.1/MapoFlowerIslandA.woff') format('woff');
                font-weight: normal;
                font-style: normal;
            }

            *, *::before, *::after {
                box-sizing: border-box;
                margin: 0;
                padding: 0;
            }


            a:hover {
                border-bottom: 1px dashed #fff;
            }



            /* info */
            .info {
                position: absolute;
                z-index: 1000;
            }

            .info h1 {
                font-size: 20px;
                border-bottom: 1px dashed #fff;
                margin-bottom: 8px;
            }

            .info p, .info li {
                font-size: 14px;
                line-height: 1.8;
                margin-bottom: 3px;
            }

            .info li.active a:last-child {
                background: #fff;
                color: #000;
            }

            .info.left {
                left: 20px;
                top: 20px;
            }

            .info.right {
                right: 10px;
                top: 10px;
            }

            .info.right a {
                display: inline-block;
                margin-left: 5px;
                width: 20px; height: 20px;
                border: 1px dashed #fff;
                border-radius: 50%;
                text-align: center;
                line-height: 20px;
                font-size: 12px;
                transition: all 0.2s;
            }



            .info.right a:hover {
                background: #fff;
                color: #000;
            }

            .info.bottom {
                left: 10px;
                bottom: 10px;
            }

            .info.view {
                right: 20px;
                bottom: 20px;
            }

            .info.view a {
                color: #fff;
                border: 1px solid #fff;
                border-radius: 30px;
                padding: 5px 30px;
            }

            @media (max-width: 800px){
                .info.bottom {display: none;}
                .info.right {display: none;}
            }

            /* slide */
            .slider-wrap {
                display: flex;
                align-items: center;
                justify-content: center;
                height: 40vh;
            }

            .slider-img {
                position: relative;
                width: 100%;
                height: 250px;
                overflow: no-display;
                box-shadow: 4px 4px 20px rgba(0, 0, 0, .5);
            }

            .slider-img .slider {
                position: absolute;
                left: 0;
                top: 0;
                transition: all 0.8s;
            }
            .slider-img .slider:nth-child(1) {z-index: 5;}
            .slider-img .slider:nth-child(2) {z-index: 4;}
            .slider-img .slider:nth-child(3) {z-index: 3;}
            .slider-img .slider:nth-child(4) {z-index: 2;}
            .slider-img .slider:nth-child(5) {z-index: 1;}

            .slider-img .slider span {
                position: absolute;
                left: 5px;
                top: 5px;
            }


        </style>

        <script>
            function popup() {
                window.open("popup.html", "PopupMenu", "width=350, height=500, scrollbars=yes")
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

    </head>
    <body onload="popup()">
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
                        <br />

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
                                <!-- Navbar
                               ================================================== 끝-->

                                <!-- jumbotron
                                ================================================== -->
                                <br />
                                <div class="jumbotron">
                                    <div class="slider-wrap">
                                        <div class="slider-img">
                                            <div class="slider" ><img src="./images/1.jpg" alt="이미지1" style=" width: 1065px; height: 250px"></div>
                                            <div class="slider"><img src="./images/2.jpg" alt="이미지2" style=" width: 1065px; height: 250px"></div>
                                            <div class="slider"><img src="./images/3.jpg" alt="이미지3" style=" width: 1065px; height: 250px"></div>
                                            <div class="slider"><img src="./images/4.jpg" alt="이미지4" style=" width: 1065px; height: 250px"></div>
                                            <div class="slider"><img src="./images/5.jpg" alt="이미지5" style=" width: 1065px; height: 250px"></div>
                                        </div>
                                    </div>

                                    <script>
                                        let sliderWrap = document.querySelector(".slider-wrap");
                                        let sliderImg = document.querySelector(".slider-img");
                                        let slider = document.querySelectorAll(".slider");

                                        let currentIndex = 0;
                                        let sliderCount = slider.length;

                                        console.log(slider[0]);
                                        setInterval(() => {
                                            let nextIndex = (currentIndex + 1) % sliderCount;

                                            slider[currentIndex].style.opacity = "0";
                                            slider[nextIndex].style.opacity = "1";

                                            currentIndex = nextIndex;
                                        }, 2000);
                                    </script>

                                </div>

                                <!-- jumbotron
                                ================================================== 끝-->

                                <!-- 학사일정
                                  ================================================== -->

                                <div class="card">
                                    <center><h2>학사일정</h2></center>
                                    <hr />
                                    <div class="row">

                                        <div class="col-sm-8" style="display: inline-block;">
                                            <table id="calendar" class="table">
                                                <tr class="weekdays">
                                                    <th scope="col" style="background: #C03D0C;">일요일</th>
                                                    <th scope="col" style="background: gray">월요일</th>
                                                    <th scope="col" style="background: gray">화요일</th>
                                                    <th scope="col" style="background: gray">수요일</th>
                                                    <th scope="col" style="background: gray">목요일</th>
                                                    <th scope="col" style="background: gray">금요일</th>
                                                    <th scope="col" style="background: #325C97;">토요일</th>
                                                </tr>

                                                <td class="day other-month" style="background-color: #b3b3cc">
                                                    <div class="date">29</div>
                                                </td>
                                                <td class="day other-month" style="background-color: #b3b3cc">
                                                    <div class="date">30</div>
                                                </td>
                                                <td class="day">
                                                    <div class="date">1</div>
                                                </td>
                                                <td class="day">
                                                    <div class="date">2</div>
                                                </td>
                                                <td class="day">
                                                    <div class="date">3</div>
                                                </td>
                                                <td class="day">
                                                    <div class="date">4</div>
                                                </td>
                                                <td class="day">
                                                    <div class="date">5</div>
                                                    </tr>
                                                <tr>
                                                    <td class="day">
                                                        <div class="date">6</div>
                                                    </td>
                                                    <td class="day">
                                                        <div class="date">7</div>
                                                    </td>
                                                    <td class="day" style="background-color: #ffd9b3">
                                                        <div class="date">8</div>
                                                    </td>
                                                    <td class="day" style="background-color: #ffd9b3">
                                                        <div class="date">9</div>
                                                    </td>
                                                    <td class="day" style="background-color: #ffd9b3">
                                                        <div class="date">10</div>
                                                    </td>
                                                    <td class="day" style="background-color: #ffd9b3">
                                                        <div class="date">11</div>
                                                    </td>
                                                    <td class="day">
                                                        <div class="date">12</div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="day">
                                                        <div class="date">13</div>
                                                    </td>
                                                    <td class="day" style="background-color: #ffd9b3">
                                                        <div class="date">14</div>
                                                    </td>
                                                    <td class="day" style="background-color: #ffd9b3">
                                                        <div class="date">15</div>
                                                    </td>
                                                    <td class="day" style="background-color: #ffd9b3">
                                                        <div class="date">16</div>
                                                    </td>
                                                    <td class="day">
                                                        <div class="date">17</div>
                                                    </td>
                                                    <td class="day">
                                                        <div class="date">18</div>
                                                    </td>
                                                    <td class="day">
                                                        <div class="date">19</div>
                                                    </td>
                                                </tr>
                                                <tr>

                                                    <td class="day">
                                                        <div class="date">20</div>
                                                    </td>
                                                    <td class="day">
                                                        <div class="date">21</div>
                                                    </td>
                                                    <td class="day">
                                                        <div class="date">22</div>
                                                    </td>
                                                    <td class="day">
                                                        <div class="date">23</div>
                                                    </td>
                                                    <td class="day">
                                                        <div class="date">24</div>
                                                        </div>
                                                    </td>
                                                    <td class="day" style="background-color: #ffd9b3">
                                                        <div class="date">25</div>
                                                        </div>
                                                    </td>
                                                    <td class="day">
                                                        <div class="date">26</div>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="day">
                                                        <div class="date">27</div>
                                                    </td>
                                                    <td class="day">
                                                        <div class="date">28</div>
                                                    </td>
                                                    <td class="day">
                                                        <div class="date">29</div>
                                                    </td>
                                                    <td class="day">
                                                        <div class="date">30</div>
                                                    </td>
                                                    <td class="day" style="background-color: #ffd9b3">
                                                        <div class="date">31</div>
                                                    </td>
                                                    <td class="day other-month" style="background-color: #b3b3cc">
                                                        <div class="date">1</div>
                                                    </td>
                                                    <td class="day other-month" style="background-color: #b3b3cc">
                                                        <div class="date">2</div>
                                                    </td>
                                                </tr>
                                                </td>
                                            </table>
                                        </div>

                                        <div class="col-sm-4" style="display: inline-block; font-size: 20px; font-style: normal;">
                                            ● 8일 : 수업 보강일 (개교기념일)<br />
                                            ○ 9~11, 14~15일 : 기말시험<br />
                                            ● 16일 : 동계방학 시작일<br />
                                            ○ 25일 : 성탄절<br />
                                            ● 31일 : 종무식<br />
                                        </div>


                                    </div>
                                </div>

                                <br/><br/>

                                <div class="card">
                                    <center><h2>개발자 공지사항</h2></center>
                                    <hr />
                                    <center><p id="open" onclick="openModal()" style=" font-size: 20px"><U>과제 모아보기 기능이 추가되었습니다!</U></p></center>
                                    <div class="modal hidden">
                                        <div class="md_overlay"></div>
                                        <div class="md_content" style=" display: inline">
                                            <h3>공지사항</h3>
                                            <div class="modal_text" style=" font-size: 15px">
                                                <center>- 사용법 -</center><br />
                                                1. 우측 상단 Login 버튼 클릭<br />
                                                2. 자신의 DOOR 계정으로 로그인<br />
                                                3. 과제 모아보기 탭 클릭<br />
                                            </div><br/><br/><br/><br/><br/><br/>
                                            <button class="btn btn-secondary my-2 my-sm-0">닫기</button>
                                        </div>
                                    </div>

                                    <script type="text/javascript">
                                        <!--
                //필요한 엘리먼트들을 선택한다.
                                        const openButton = document.getElementById("open");
                                        const modal = document.querySelector(".modal");
                                        const overlay = modal.querySelector(".md_overlay");
                                        const closeButton = modal.querySelector("button");
                                        //동작함수
                                        const openModal = () => {
                                            modal.classList.remove("hidden");
                                        }
                                        const closeModal = () => {
                                            modal.classList.add("hidden");
                                        }
                                        //클릭 이벤트
                                        openButton.addEventListener("click", openModal);
                                        closeButton.addEventListener("click", closeModal);
                                        //-->
                                    </script>



                                </div>
                                <br/><br/>



                                <footer class="card-footer" style=" font-size: 50px">
                                    <center>HomeWork Calendar</center>
                                    <center style=" font-size: 15px">Copyright(C) 2020.웹 개발 활용 1조.All rights reserved</center>

                                </footer>

                                </body>
                                </html>
