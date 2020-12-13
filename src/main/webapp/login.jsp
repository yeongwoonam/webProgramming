<%--
  Created by IntelliJ IDEA.
  User: NAMYEONGWOO
  Date: 2020-12-06
  Time: 오후 2:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<link rel="stylesheet" href="./css/bootstrap.css">
<html>
<head>
    <title>로그인</title>
    <script src="https://code.jquery.com/jquery-3.5.1.js"
            integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
    <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js"></script>

    <script>

        function checkID(obj) {
            var chk = /^[0-9]{8}$/g;
            if (chk.test(obj.value)) {
                console.log('테스트');
            } else {

                alert('8자리의 학번을 입력해 주세요!');
                obj.value = "";
                return false;
            }
        }

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
                            $.cookie(cookies[i]["key"], cookies[i]["value"], {expires: 7, path: '/'});
                        }
                        window.location = "/WebProjecct/index.jsp"
                    } else {
                        //로그인 실패
                        alert("로그인에 실패했습니다. 아이디와 비밀번호를 확인해주세요.")
                    }
                }
            })
        }

        function init() {
            let passwordField = document.getElementById("password");
            passwordField.onkeydown = function (event) {
                if (event.keyCode === 13) {//엔터키 누르면
                    submit();
                }
            }
        }
    </script>
</head>
<body onload="init()">
<center><p style=" font-size: 50px">- Home Calendar -</p></center>
<br/>
<center><img src="images/turtle.png"></center>
<center><h2>id&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; : <input type="text" id="id"
                                                                               onchange="checkID(this)"></h2></center>
<br>
<center><h2>password : <input type="password" id="password"></h2></center>
<br>
<center>
    <button class="btn btn-secondary my-2 my-sm-0" onclick="submit()">로그인</button>
</center>
</body>
</html>
