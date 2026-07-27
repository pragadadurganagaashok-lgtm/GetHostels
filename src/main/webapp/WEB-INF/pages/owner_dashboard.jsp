<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.nt.entity.OwnerEntity"%>

<%
OwnerEntity owner=(OwnerEntity)session.getAttribute("owner");

if(owner==null){
    response.sendRedirect(request.getContextPath()+"/login");
    return;
}
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Owner Dashboard</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/css/owner-style.css">

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:Arial,Helvetica,sans-serif;
}

body{
background:#f5f7fb;
}

/*================ HEADER =================*/

header{
display:flex;
justify-content:space-between;
align-items:center;
padding:18px 60px;
background:#fff;
box-shadow:0 3px 12px rgba(0,0,0,.08);
}

.logo{
display:flex;
align-items:center;
gap:15px;
}

.logo img{
width:60px;
height:60px;
}

.logo h1{
font-size:50px;
color:#2340f0;
}

nav{
display:flex;
gap:35px;
}

nav a{
text-decoration:none;
font-size:19px;
font-weight:bold;
color:#2340f0;
transition:.3s;
}

nav a:hover{
color:#ff6b00;
}

/*================ DASHBOARD =================*/

.dashboard-container{
width:1100px;
margin:50px auto;
}

.dashboard-card{
background:white;
border-radius:20px;
overflow:hidden;
box-shadow:0 12px 30px rgba(0,0,0,.10);
}

.dashboard-header{
background:linear-gradient(90deg,#2340f0,#4d6bff);
padding:35px;
color:white;
text-align:center;
}

.dashboard-header h2{
font-size:36px;
margin-bottom:10px;
}

.dashboard-header p{
font-size:18px;
}

.dashboard-grid{
display:grid;
grid-template-columns:repeat(auto-fit,minmax(230px,1fr));
gap:25px;
padding:40px;
}

.dashboard-box{
background:#f8faff;
border-radius:18px;
padding:30px;
text-align:center;
text-decoration:none;
color:#222;
transition:.3s;
border:2px solid transparent;
}

.dashboard-box:hover{
transform:translateY(-6px);
border-color:#2340f0;
box-shadow:0 12px 25px rgba(35,64,240,.18);
}

.icon{
font-size:55px;
margin-bottom:18px;
}

.dashboard-box h3{
color:#2340f0;
margin-bottom:10px;
}

.dashboard-box p{
font-size:15px;
color:#666;
line-height:24px;
}

/*================ RESPONSIVE =================*/

@media(max-width:1100px){

.dashboard-container{
width:95%;
}

header{
flex-direction:column;
padding:20px;
}

nav{
margin-top:15px;
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

<a href="${pageContext.request.contextPath}/">Home</a>

<a href="${pageContext.request.contextPath}/owner/logout">Logout</a>

</nav>

</header>

<div class="dashboard-container">

<div class="dashboard-card">

<div class="dashboard-header">

<h2>

Welcome, <%=owner.getName()%> 🎉

</h2>

<p>

Manage your hostels from one place.

</p>

</div>

<div class="dashboard-grid">

<a href="${pageContext.request.contextPath}/owner/addHostel"
class="dashboard-box">

<div class="icon">🏨</div>

<h3>Add Hostel</h3>

<p>

Register a new hostel with rooms, rent, facilities and photos.

</p>

</a>

<a href="${pageContext.request.contextPath}/owner/myHostels"
class="dashboard-box">

<div class="icon">📋</div>

<h3>My Hostels</h3>

<p>

View, edit and manage all your listed hostels.

</p>

</a>

<a href="#"
class="dashboard-box">

<div class="icon">👤</div>

<h3>My Profile</h3>

<p>

Update your profile information and password.

</p>

</a>

<a href="${pageContext.request.contextPath}/owner/logout"
class="dashboard-box">

<div class="icon">🚪</div>

<h3>Logout</h3>

<p>

Securely sign out from your account.

</p>

</a>

</div>

</div>

</div>

</body>

</html>