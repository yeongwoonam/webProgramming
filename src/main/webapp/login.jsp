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

            function checkCookie() {
                var checkEvent = getCookie("saveid");
                if (checkEvent !== null && checkEvent !== "") {
                    document.getElementById("check").checked = true;
                    document.getElementById('id').value = checkEvent;
                    console.log("위에드감");

                } else {
                    document.getElementById("check").checked = false;
                    console.log("여기 드감");
                }
                console.log(checkEvent);

            }

            function deleteCookie(name) {
                document.cookie = name + '=; expires=Thu, 01 Jan 1970 00:00:01 GMT;';
            }

            function setCookie(cName, cValue, cDay) {
                var expire = new Date();
                expire.setDate(expire.getDate() + cDay);
                cookies = cName + '=' + escape(cValue) + '; path=/ '; // 한글 깨짐을 막기위해 escape(cValue)를 합니다.
                if (typeof cDay != 'undefined')
                    cookies += ';expires=' + expire.toGMTString() + ';';
                document.cookie = cookies;
            }

            function getCookie(cName) {
                cName = cName + '=';
                var cookieData = document.cookie;
                var start = cookieData.indexOf(cName);
                var cValue = '';
                if (start != -1) {
                    start += cName.length;
                    var end = cookieData.indexOf(';', start);
                    if (end == -1)
                        end = cookieData.length;
                    cValue = cookieData.substring(start, end);
                }
                return unescape(cValue);
            }

            function checkSaveID() {
                if (document.getElementById("check").checked == true) {
                    var input = document.getElementById("id").value;
                    setCookie("saveid", input, "7");

                    console.log("쿠키 저장됨 : " + input);
                } else {
                    setCookie('saveid', '', '-1');
                    console.log("체크안됨");
                }
            }

            function checkID(obj) {
                var chk = /^[0-9]{8}$/g;
                if (chk.test(obj.value)) {
                    console.log('테스트');
                    return true;
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
                            sessionStorage.setItem("isLogin", true ); // 저장
                            
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
    <body onload="init(); checkCookie();">
    <center><p style=" font-size: 50px" onclick="location.href = 'index.jsp';">- Home Calendar -</p></center>
    <br/>
    <center><img src="images/turtle.png"></center>
    <center><h5><input type="checkbox" id="check" style=" display:  inline-block" onchange="checkSaveID()">아이디 저장하기&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</h5></center>
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

