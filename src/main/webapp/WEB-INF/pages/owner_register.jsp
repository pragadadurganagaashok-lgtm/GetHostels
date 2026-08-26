<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">
<title>Owner Registration</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/css/style.css">

<style>

body{
    background:#eef3ff;
}

/* Registration Card */

.register-box{

    width:520px;

    margin:50px auto;

    padding:40px;

    border-radius:20px;

    background:linear-gradient(180deg,#ffffff,#f8fbff);

    border-top:6px solid #2340f0;

    box-shadow:0 15px 40px rgba(35,64,240,.18);

}

.register-box:hover{

    box-shadow:0 20px 45px rgba(35,64,240,.25);

}

.register-box h2{

    text-align:center;

    color:#2340f0;

    margin-bottom:30px;

    font-size:36px;

}

/* Form */

.form-group{

    margin-bottom:18px;

}

.form-group label{

    display:block;

    font-size:18px;

    font-weight:bold;

    margin-bottom:8px;

}

.form-group input{

    width:100%;

    padding:14px;

    border:2px solid #d8e2ff;

    border-radius:10px;

    font-size:17px;

    transition:.3s;

    background:white;

}

.form-group input:focus{

    outline:none;

    border-color:#2340f0;

    box-shadow:0 0 10px rgba(35,64,240,.20);

}

/* Button */

.register-btn{

    width:100%;

    padding:15px;

    border:none;

    border-radius:10px;

    background:linear-gradient(90deg,#2340f0,#4d6bff);

    color:white;

    font-size:22px;

    cursor:pointer;

    transition:.3s;

    margin-top:10px;

}

.register-btn:hover{

    transform:scale(1.02);

    background:linear-gradient(90deg,#1632d7,#2340f0);

}

/* Error */

.error-msg{

    background:#ffe7e7;

    color:#d60000;

    padding:12px;

    border-radius:8px;

    text-align:center;

    margin-bottom:20px;

    font-weight:bold;

}

/* Success */

.success-msg{

    background:#e7ffe8;

    color:#0a8b21;

    padding:12px;

    border-radius:8px;

    text-align:center;

    margin-bottom:20px;

    font-weight:bold;

}

.login-link{

    margin-top:22px;

    text-align:center;

    font-size:18px;

}

.login-link a{

    color:#2340f0;

    font-weight:bold;

    text-decoration:none;

}

.login-link a:hover{

    color:#ff6b00;

}

/* Responsive */

@media(max-width:700px){

.register-box{

    width:92%;

    padding:25px;

}

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

        <a href="${pageContext.request.contextPath}/owner/login">Login</a>

    </nav>

</header>

<div class="register-box">

<h2>Create Owner Account</h2>

<%
String error=(String)request.getAttribute("error");

if(error!=null){
%>

<div class="error-msg">

<%=error%>

</div>

<%
}

String success=(String)request.getAttribute("success");

if(success!=null){
%>

<div class="success-msg">

<%=success%>

</div>

<%
}
%>

<form action="register" method="post">

<div class="form-group">

<label>Full Name</label>

<input
type="text"
name="name"
placeholder="Enter Full Name"
required>

</div>

<div class="form-group">

<label>Email</label>

<input
type="email"
name="email"
placeholder="Enter Email"
required>

</div>

<div class="form-group">

<label>Phone Number</label>

<input
type="text"
name="phone"
maxlength="10"
placeholder="Enter Mobile Number"
required>

</div>

<div class="form-group">

<label>Password</label>

<input
type="password"
name="password"
placeholder="Enter Password"
required>

</div>

<div class="form-group">

<label>Confirm Password</label>

<input
type="password"
name="confirmPassword"
placeholder="Re-enter Password"
required>

</div>

<button
type="submit"
class="register-btn">

Create Account

</button>

</form>

<div class="login-link">

Already have an account?

 <a href="${pageContext.request.contextPath}/owner/login">Login</a>


</div>

</div>

</body>

</html>