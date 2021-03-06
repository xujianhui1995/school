<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>登陆</title>
<link href="css/css.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="style/jquery.1.10.1.min.js"></script>
<script type="text/javascript" charset="utf-8" language="JavaScript">
	var code;
	function createCode() {

		code = "";
		var codeLength = 6; //验证码的长度
		var checkCode = document.getElementById("checkCode");
		var codeChars = new Array(0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 'a', 'b', 'c',
				'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
				'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'A',
				'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
				'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'); //所有候选组成验证码的字符，当然也可以用中文的
		for ( var i = 0; i < codeLength; i++) {
			var charNum = Math.floor(Math.random() * 52);
			code += codeChars[charNum];
		}
		if (checkCode) {
			checkCode.className = "code";
			checkCode.innerHTML = code;
		}
	}
	function validateCode() {
		var inputCode = document.getElementById("inputCode").value;
		var username = document.getElementById("studentid").value;
		var password = document.getElementById("password").value;
		if (inputCode.length <= 0) {
			alert("请输入验证码！");
		} else if (inputCode.toUpperCase() != code.toUpperCase()) {
			alert("验证码输入有误！");
			//createCode();
		} else {
			if (username.length <= 0 || password.lenght <= 0) {
				alert("请输入用户名跟密码！！");
				return;
			} else {
				document.login.submit();
			}
		}
	}
	function getpassword() {
		var user = document.getElementById("studentid").value;
		var url = "StudentServlet?method=4&state=" + user;
		if (window.XMLHttpRequest) {//火狐谷歌等浏览器的
			req = new XMLHttpRequest();
		} else if (window.ActiveXObject) {//ie浏览器使用
			req = new ActiveXObject("Microsoft.XMLHttp");
		}
		//alert(req);
		if (req) {
			req.open("post", url, true, "charset=utf-8");
			req.onreadystatechange = completec;//接收返回的数据
			req.send(null);
		}
	}

	function completec() {//获取到返回值
		if (req.readyState == 4) {
			if (req.status == 200) {//200代表返回数据成功
				var password = req.responseText;
				document.getElementById("password").value = password;
			}

		}
	}
	function checkbox() {
		var check = document.getElementById("check").checked;
		//alert(check);
		if (!check) {
			document.getElementById("check").checked = false;
			return;
		}
		var flg = confirm("你点击了记住密码，请确定!!");

		if (flg) {
			document.getElementById("check").checked = true;
		} else {
			document.getElementById("check").checked = false;
			return;
		}
	}

	$(function() {
		$("input:text:first").focus();//默认第一个text获取到焦点
		$("#studentid:text").bind("keydown", function(e) {//点击第一个text的enter 第二个输入框等到焦点
			if (e.keyCode == 13) {
				$("#password:password").focus();
			}
		});
		$("#password:password").bind("keydown", function(e) {//点击第二个text的enter 第三个输入框等到焦点
			if (e.keyCode == 13) {
				$("#inputCode:text").focus();
			}
		});
		$("#inputCode:text").bind("keydown", function(e) {
			if (e.keyCode == 13) {
				validateCode();
			}
		});
	});

	$(document).ready(function() {
		$("#checkCode").load(createCode());
	});
	
</script>
</head>

<body>
	<form action="student.do?to" method="post" id="login" name="login">
		<div class="login">
			<div class="top">
				<div class="logo">
					<img src="image/logo.png" width="192" height="64">
				</div>
				<div class="wenzi">登录界面</div>
			</div>
			<div class="center">
				<div class="username">
					学&nbsp;&nbsp;&nbsp;号：<input type="text" id="studentid"
						name="studentid" height="25px" width="190px" style=" padding:5px;"
						placeholder="  请输入你的学号" onMouseOut="getpassword()">
				</div>
				<div class="tp">
					<img src="image/center.jpg" width="450" height="210">
				</div>
				<div class="username">
					密&nbsp;&nbsp;&nbsp;码：<input type="password" id="password"
						name="password" height="25px" width="190px" style=" padding:5px;"
						placeholder="  请输入你的密码"><input name="check" id="check"
						type="checkbox" height="25px" value="y" onclick="checkbox()">记住
				</div>
				<div class="username">
					验证码：<input type="text" id="inputCode" height="25px" width="190px"
						style=" padding:5px;" placeholder="  请输入验证码">
				</div>
				<div class="code" id="checkCode" onclick="createCode()"></div>
				<div class="s">
					<a onclick="createCode()">换一张</a>
				</div>
				<div style="clear:both"></div>
				<div class="bt">
					<input type="button" value="登录" class="btn1"
						onclick="validateCode()">
				</div>
				<div class="bt">
					<input type="reset" value="重置" class="btn2">
				</div>
			</div>
		</div>
	</form>
</body>
</html>
