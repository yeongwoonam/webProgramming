<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <title>나의 남은 과제 보기</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link type="text/css" rel="stylesheet" href="css/main_style.css"/>
    <script src="https://code.jquery.com/jquery-3.5.1.min.js"
            integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
</head>
<body>
<%
    Cookie[] cookies = request.getCookies();
    String id = null;
    String password = null;
    int i = 0;
    if (cookies != null) {
        for (Cookie tempCookie : cookies) {
            if (tempCookie.getName().equals("userId")) {
                id = tempCookie.getValue();
                i++;
            } else if (tempCookie.getName().equals("password")) {
                password = tempCookie.getValue();
                i++;
            }
        }
    }
    if (i == 2) {
        response.sendRedirect("crawl.jsp?userId=" + URLEncoder.encode(id, StandardCharsets.UTF_8) + "&password=" + URLEncoder.encode(password, StandardCharsets.UTF_8) + "&loginChk=true");
    }

%>
<div id="login_form">
    <h1>출석 인정 과제 몇개나 더 해야 해!!! 짜증나!!!</h1>
    <form method="POST" action="crawl.jsp">
        사용자: <input type="text" name="userId" size="20"> <br/>
        암&nbsp;&nbsp;&nbsp;호: <input type="password" name="password" size="20"> <br/> <br/>
        <input type="submit" id="sendButton" value="몇개 남았나...">
        <input type="reset" value="다시 입력"><br>
        <input type="checkbox" name="loginChk" value="true">자동로그인<br>
    </form>
    <strong>로딩이 조금 오래 걸립니다.. 기다려주세요... 추후 해결하겠습니다...</strong><br>
    <strong>AES 암호화를 적용하여 보안성을 조금 더 강화했습니다.</strong>
</div>
<%@include file="footer.jspf" %>
</body>
</html>
