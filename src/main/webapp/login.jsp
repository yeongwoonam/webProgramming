<%--
  Created by IntelliJ IDEA.
  User: NAMYEONGWOO
  Date: 2020-12-06
  Time: 오후 2:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>로그인</title>
    <script src="https://code.jquery.com/jquery-3.5.1.js"
            integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

    <script>
        function submit() {
            $.ajax({
                url: "/WebProjecct/login.do",
                method: "POST",
                data: {id: $("#id").val(), password: $("#password").val()},
                success: function (data) {
                    let parsedData = JSON.parse(data)["result"];
                    if (parsedData == "success") {
                        //로그인 성공
                        alert("로그인 성공!");
                        let cookies = JSON.parse(data)["cookies"];
                        for (let i = 0; i < cookies.length; i++) {
                            $.cookie(cookies[i]["key"],cookies[i]["value"],{ expires: 7, path: '/' });
                        }
                        window.location = "/WebProjecct/main.jsp"
                    } else {
                        //로그인 실패
                        alert("로그인에 실패했습니다. 아이디와 비밀번호를 확인해주세요.")
                    }
                }
            })
        }
    </script>
</head>
<body>
id : <input type="text" id="id"><br>
password : <input type="password" id="password"><br>
<button onclick="submit()">로그인</button>
</body>
</html>
