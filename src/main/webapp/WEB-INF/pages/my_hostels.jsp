<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>My Hostels</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/css/my_hostels.css">

</head>

<body>

<!-- ================= HEADER ================= -->

<header>

    <div class="logo">

        <img src="${pageContext.request.contextPath}/images/logo.png">

        <h1>Get Hostel</h1>

    </div>

    <nav>

        <a href="${pageContext.request.contextPath}/owner/dashboard">Dashboard</a>

        <a href="${pageContext.request.contextPath}/owner/addHostel">Add Hostel</a>

        <a href="${pageContext.request.contextPath}/">Home</a>

        <a href="${pageContext.request.contextPath}/owner/logout">Logout</a>

    </nav>

</header>

<!-- ================= TITLE ================= -->

<div class="page-title">

    <h2>🏨 My Hostels</h2>

    <p>

        Manage all your hostels from one place.

    </p>

</div>

<!-- ================= HOSTEL LIST ================= -->

<div class="hostel-container">

<c:choose>

<c:when test="${empty hostels}">

<div class="empty-box">

<h2>No Hostels Added Yet</h2>

<p>

Click below to register your first hostel.

</p>

<a class="add-btn"
href="${pageContext.request.contextPath}/owner/addHostel">

➕ Add Hostel

</a>

</div>

</c:when>

<c:otherwise>

<c:forEach items="${hostels}" var="hostel">

<div class="hostel-card">

    <!-- ================= IMAGE ================= -->

    <div class="hostel-image">

        <c:choose>

            <c:when test="${not empty hostel.coverImage}">

                <img src="${pageContext.request.contextPath}/uploads/${hostel.coverImage}"
                     alt="Hostel Image">

            </c:when>

            <c:otherwise>

                <img src="${pageContext.request.contextPath}/images/no-image.png"
                     alt="No Image">

            </c:otherwise>

        </c:choose>

        <span class="status">

            ${hostel.status}

        </span>

    </div>


    <!-- ================= DETAILS ================= -->

    <div class="hostel-details">

        <!-- HEADER -->

        <div class="hostel-header">

            <div>

                <h2>${hostel.hostelName}</h2>

                <span class="hostel-type">

                    🏠 ${hostel.hostelType}

                </span>

            </div>

        </div>


        <!-- LOCATION -->

        <div class="location">

            <p>

                📍

                <b>${hostel.area}</b>,

                ${hostel.city},

                ${hostel.state}

            </p>

            <p>

                🏡

                ${hostel.address}

            </p>

            <c:if test="${not empty hostel.landmark}">

                <p>

                    📌

                    ${hostel.landmark}

                </p>

            </c:if>

        </div>


        <!-- CONTACT -->

        <div class="contact-row">

            <span>

                📞 ${hostel.ownerPhone}

            </span>

            <c:if test="${not empty hostel.alternatePhone}">

                <span>

                    ☎ ${hostel.alternatePhone}

                </span>

            </c:if>

        </div>


        <!-- BED DETAILS -->

        <div class="bed-summary">

            <div class="bed-box">

                <h4>Total Beds</h4>

                <span>${hostel.totalBeds}</span>

            </div>

            <div class="bed-box">

                <h4>Available</h4>

                <span>${hostel.availableBeds}</span>

            </div>

            <div class="bed-box">

                <h4>Advance</h4>

                <span>

                    ₹${hostel.advanceAmount}

                </span>

            </div>

            <div class="bed-box">

                <h4>Return</h4>

                <span>

                    ₹${hostel.returnAmount}

                </span>

            </div>

            <div class="bed-box">

                <h4>Day Stay</h4>

                <span>

                    ₹${hostel.dayStayPrice}

                </span>

            </div>

        </div>


        <!-- SHARING PRICES -->

        <h3 class="section-title">

            Sharing Prices

        </h3>

        <div class="sharing-grid">

            <div class="share-card">

                <h5>1 Sharing</h5>

                <span>

                    ₹${hostel.oneSharingPrice}

                </span>

            </div>

            <div class="share-card">

                <h5>2 Sharing</h5>

                <span>

                    ₹${hostel.twoSharingPrice}

                </span>

            </div>

            <div class="share-card">

                <h5>3 Sharing</h5>

                <span>

                    ₹${hostel.threeSharingPrice}

                </span>

            </div>

            <div class="share-card">

                <h5>4 Sharing</h5>

                <span>

                    ₹${hostel.fourSharingPrice}

                </span>

            </div>

            <div class="share-card">

                <h5>5 Sharing</h5>

                <span>

                    ₹${hostel.fiveSharingPrice}

                </span>

            </div>

            <div class="share-card">

                <h5>6 Sharing</h5>

                <span>

                    ₹${hostel.sixSharingPrice}

                </span>

            </div>

        </div>

        <!-- CONTINUE IN PART 2 -->
                <!-- ================= FACILITIES ================= -->

        <h3 class="section-title">

            Facilities

        </h3>

        <div class="facility-list">

            <c:if test="${hostel.wifi}">
                <span>📶 WiFi</span>
            </c:if>

            <c:if test="${hostel.food}">
                <span>🍛 Food</span>
            </c:if>

            <c:if test="${hostel.ac}">
                <span>❄ AC</span>
            </c:if>

            <c:if test="${hostel.laundry}">
                <span>🧺 Laundry</span>
            </c:if>

            <c:if test="${hostel.parking}">
                <span>🚗 Parking</span>
            </c:if>

            <c:if test="${hostel.cctv}">
                <span>📹 CCTV</span>
            </c:if>

            <c:if test="${hostel.lift}">
                <span>🛗 Lift</span>
            </c:if>

            <c:if test="${hostel.gym}">
                <span>🏋 Gym</span>
            </c:if>

            <c:if test="${hostel.powerBackup}">
                <span>🔋 Power Backup</span>
            </c:if>

            <c:if test="${hostel.hotWater}">
                <span>🚿 Hot Water</span>
            </c:if>

            <c:if test="${hostel.washingMachine}">
                <span>🧺 Washing Machine</span>
            </c:if>

            <c:if test="${hostel.refrigerator}">
                <span>🧊 Refrigerator</span>
            </c:if>

            <c:if test="${hostel.housekeeping}">
                <span>🧹 Housekeeping</span>
            </c:if>

            <c:if test="${hostel.studyRoom}">
                <span>📚 Study Room</span>
            </c:if>

            <c:if test="${hostel.balcony}">
                <span>🌅 Balcony</span>
            </c:if>

            <c:if test="${hostel.attachedBathroom}">
                <span>🚿 Attached Bathroom</span>
            </c:if>

        </div>

        <!-- ================= BUTTONS ================= -->

        <div class="button-row">

            <a class="bed-btn"
               href="#">
                🛏 View Beds
            </a>

            <a class="map-btn"
               href="${hostel.googleMapLink}"
               target="_blank">
               🗺 View Map
            </a>
            <a class="edit-btn"
               href="${pageContext.request.contextPath}/owner/editHostel/${hostel.hostelId}">
                ✏ Edit Hostel
            </a>

            <a class="delete-btn"
               onclick="return confirm('Delete this hostel?')"
               href="${pageContext.request.contextPath}/owner/deleteHostel/${hostel.hostelId}">
                🗑 Delete Hostel
            </a>

        </div>

    </div>

</div>

</c:forEach>

</c:otherwise>

</c:choose>

</div>

</body>

</html>