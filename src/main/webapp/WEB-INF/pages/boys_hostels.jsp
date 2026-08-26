<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>

<html>

<head>


<meta charset="UTF-8">

<title>Boys Hostels - Get Hostel</title>

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/style.css">


</head>

<body>

<header>


<div class="logo">

    <img src="${pageContext.request.contextPath}/images/logo.png"
         alt="Get Hostel Logo">

    <h1>Get Hostel</h1>

</div>

<nav>

    <a href="${pageContext.request.contextPath}/">
        Home
    </a>

    <a href="${pageContext.request.contextPath}/boys">
        Boys Hostels
    </a>

    <a href="${pageContext.request.contextPath}/girls">
        Girls Hostels
    </a>

    <a href="${pageContext.request.contextPath}/colive">
        Co-Live
    </a>

    <a href="${pageContext.request.contextPath}/about">
        About
    </a>

    <a href="${pageContext.request.contextPath}/contact">
        Contact
    </a>

    <a href="${pageContext.request.contextPath}/owner/login">
        Owner Login
    </a>

</nav>


</header>

<section class="hostel-section">


<div class="hostel-section-title">

    <h2>👨‍🎓 Boys Hostels</h2>

    <p>
        Find the best boys hostels and PGs available near you.
    </p>

</div>


<div class="hostel-list">

    <c:choose>

        <c:when test="${empty hostels}">

            <div class="empty-box">

                <h2>No Boys Hostels Available</h2>

                <p>
                    Currently there are no active boys hostels available.
                </p>

            </div>

        </c:when>

        <c:otherwise>

            <c:forEach items="${hostels}" var="hostel">

                <div class="user-hostel-card">


                    <div class="user-hostel-image">

                        <c:choose>

                            <c:when test="${not empty hostel.coverImage}">

                                <img src="${hostel.coverImage}"
                                     alt="${hostel.hostelName}">

                            </c:when>

                            <c:otherwise>

                                <img src="${pageContext.request.contextPath}/images/no-image.png"
                                     alt="No Image">

                            </c:otherwise>

                        </c:choose>

                    </div>


                    <div class="user-hostel-details">


                        <div class="user-hostel-header">

                            <div>

                                <h2>
                                    ${hostel.hostelName}
                                </h2>

                                <div class="hostel-type">
                                    🏠 ${hostel.hostelType}
                                </div>

                            </div>

                            <span class="active-badge">
                                ${hostel.status}
                            </span>

                        </div>


                        <div class="user-location">

                            📍

                            ${hostel.area},
                            ${hostel.city},
                            ${hostel.state}

                        </div>
                        <c:if test="${not empty hostel.distance}">
                                        <div class="hostel-distance">
                                        📍 <fmt:formatNumber value="${hostel.distance}" maxFractionDigits="3"/>
                                         km away
                                        </div>
                         </c:if>
                        
                        <!-- ADDRESS -->

                            <div class="user-location">

                                🏡 ${hostel.address}

                            </div>


                        <div class="user-phone">

                            📞 ${hostel.ownerPhone}

                        </div>


                        <div class="card-divider"></div>


                        <div class="bed-details">

                            <span>
                                Total Beds:
                                <b>${hostel.totalBeds}</b>
                            </span>

                            <span>
                                Available:
                                <b>${hostel.availableBeds}</b>
                            </span>

                        </div>


                        <div class="amount-details">

                            <span>
                                Advance
                                <b>₹${hostel.advanceAmount}</b>
                            </span>

                            <span>
                                Return
                                <b>₹${hostel.returnAmount}</b>
                            </span>

                            <c:if test="${not empty hostel.dayStayPrice}">

                                <span>
                                    Day Stay
                                    <b>₹${hostel.dayStayPrice}</b>
                                </span>

                            </c:if>

                        </div>


                        <div class="card-divider"></div>


                        <div class="sharing-prices">

                            <c:if test="${not empty hostel.oneSharingPrice}">

                                <div>
                                    <span>1 Sharing</span>
                                    ₹${hostel.oneSharingPrice}
                                </div>

                            </c:if>

                            <c:if test="${not empty hostel.twoSharingPrice}">

                                <div>
                                    <span>2 Sharing</span>
                                    ₹${hostel.twoSharingPrice}
                                </div>

                            </c:if>

                            <c:if test="${not empty hostel.threeSharingPrice}">

                                <div>
                                    <span>3 Sharing</span>
                                    ₹${hostel.threeSharingPrice}
                                </div>

                            </c:if>

                            <c:if test="${not empty hostel.fourSharingPrice}">

                                <div>
                                    <span>4 Sharing</span>
                                    ₹${hostel.fourSharingPrice}
                                </div>

                            </c:if>

                            <c:if test="${not empty hostel.fiveSharingPrice}">

                                <div>
                                    <span>5 Sharing</span>
                                    ₹${hostel.fiveSharingPrice}
                                </div>

                            </c:if>

                            <c:if test="${not empty hostel.sixSharingPrice}">

                                <div>
                                    <span>6 Sharing</span>
                                    ₹${hostel.sixSharingPrice}
                                </div>

                            </c:if>

                        </div>


                        <div class="card-divider"></div>


                        <div class="facilities">

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


                        <div class="user-card-buttons">

                            <a class="view-beds-btn"
                               href="#">
                                🛏 View Beds
                            </a>

                            <c:if test="${not empty hostel.googleMapLink}">

                                <a class="map-btn"
                                   href="${hostel.googleMapLink}"
                                   target="_blank">
                                    🗺 View Map
                                </a>

                            </c:if>

                        </div>


                    </div>

                </div>

            </c:forEach>

        </c:otherwise>

    </c:choose>

</div>


</section>

<footer>


<p>
    © 2026 Get Hostel. All Rights Reserved.
</p>


</footer>

</body>

</html>
