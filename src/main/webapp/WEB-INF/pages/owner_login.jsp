<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Owner Login</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/css/style.css">

<style>

.login-box{

    width:420px;
    margin:70px auto;
    padding:45px;
    border-radius:20px;
    background:linear-gradient(180deg,#ffffff,#f5f9ff);
    border-top:6px solid #2340f0;
    box-shadow:0 15px 35px rgba(35,64,240,.18);
    transition:.3s;

}

.login-box:hover{

    transform:translateY(-3px);
    box-shadow:0 20px 45px rgba(35,64,240,.25);

}

.login-box h2{

    text-align:center;
    margin-bottom:10px;
    color:#2340f0;

}

.subtitle{

    text-align:center;
    color:#777;
    margin-bottom:30px;

}

.form-group{

    margin-bottom:20px;

}

.form-group label{

    display:block;
    font-weight:bold;
    margin-bottom:8px;

}

.form-group input{

    width:100%;
    padding:14px;
    border:2px solid #d9e2ff;
    border-radius:10px;
    font-size:17px;
    background:#fcfdff;
    transition:.3s;

}

.form-group input:focus{

    outline:none;
    border-color:#2340f0;
    box-shadow:0 0 10px rgba(35,64,240,.20);

}

.login-btn{

    width:100%;
    padding:15px;
    border:none;
    border-radius:10px;
    background:linear-gradient(90deg,#2340f0,#4d6bff);
    color:white;
    font-size:20px;
    cursor:pointer;
    transition:.3s;

}

.login-btn:hover{

    background:linear-gradient(90deg,#1732d9,#2340f0);
    transform:scale(1.02);

}

.register-link{

    margin-top:20px;
    text-align:center;

}

.error{

    color:red;
    text-align:center;
    margin-bottom:20px;
    font-weight:bold;

}

.success{

    color:green;
    text-align:center;
    margin-bottom:20px;
    font-weight:bold;

}

</style>

</head>

<body>

<header>

<div class="logo">

<img src="${pageContext.request.contextPath}/images/logo.png">

<h1>Get Hostel</h1>

</div>

<nav>

<a href="${pageContext.request.contextPath}/./">Home</a>

    <a href="${pageContext.request.contextPath}/owner/register">
        Register Here
    </a>


</nav>

</header>

<div class="login-box">

<h2>🏨 Owner Login</h2>

<p class="subtitle">

Welcome Back! Login to manage your hostels.

</p>

<%
String error=(String)request.getAttribute("error");
String success=(String)request.getAttribute("success");

if(error!=null){
%>

<div class="error">

<%=error%>

</div>

<%
}

if(success!=null){
%>

<div class="success">

<%=success%>

</div>

<%
}
%>

<!-- IMPORTANT CHANGE -->
<form action="${pageContext.request.contextPath}/owner/login" method="post">

<div class="form-group">

<label>Email</label>

<input
type="email"
name="email"
placeholder="Enter your email"
required>

</div>

<div class="form-group">

<label>Password</label>

<input
type="password"
name="password"
placeholder="Enter your password"
required>

</div>

<input
type="submit"
value="Login"
class="login-btn">

</form>

<div class="register-link">

    Don't have an account?

    <a href="${pageContext.request.contextPath}/owner/register">

        Register Here

    </a>

</div>

</div>

</body>

</html>