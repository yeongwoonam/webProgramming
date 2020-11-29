<%@ page import="cse.namyeongwoo.subjectproject.AES" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URLDecoder" %>
<%--
  Created by IntelliJ IDEA.
  User: Java
  Date: 2020-05-17
  Time: 오후 7:28
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE>
<html lang="ko">
<head>
    <title>나의 남은 과제는...</title>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"
            integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
    <script src="js/jquery.cookie.js"></script>
    <script>
        <%
        AES aes = new AES();
        request.setCharacterEncoding(StandardCharsets.UTF_8.name());
        //loginChk
        //"${param.userId}"
        //"${param.password}"
        String method = request.getMethod();
        String userId = null;
        String password= null;
        if(method.equals("POST")){
            userId = aes.encrypt(request.getParameter("userId"));
            password = aes.encrypt(request.getParameter("password"));
        }else if(method.equals("GET")){
            userId=request.getParameter("userId");
            password= request.getParameter("password");
        }
        %>
        $.ajax({
            type: "POST"
            ,
            url: "/SubjectProject/crawling.do"
            ,
            data: {
                userId: "<%=userId%>",
                password: "<%=password%>",
                loginChk: "${param.loginChk}"
            }
            ,
            success: function (res) {
                $(".container").append(res);
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
            }
        });

        function fn_spread(id) {
            var getID = document.getElementById(id);
            getID.style.display = (getID.style.display === 'block') ? 'none' : 'block';
        }

        $(document).ready(function () {
            $('#AutoLoginCancel').click(function () {
                document.cookie = 'password' + '=;Path=/; expires=Thu, 01 Jan 1970 00:00:01 GMT;';
                document.cookie = 'userId' + '=;Path=/; expires=Thu, 01 Jan 1970 00:00:01 GMT;';
                location.href = '/SubjectProject/index.jsp'
            });
        });
    </script>
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
과제, 공지사항, 강의자료 모아서 보자...
<button id="AutoLoginCancel">로그아웃</button>
<hr>
<div class="logo-area wrap-loading">
    <a href="https://heroesofthestorm.com/ko-kr/" target="_blank"><img src="img/heroes_of_the_storm.png" alt="로딩 화면"
                                                                       class="infinite_rotating_logo" rel="noopener noreferrer"></a>
</div>
<div class="container">

</div>
</body>
</html>
