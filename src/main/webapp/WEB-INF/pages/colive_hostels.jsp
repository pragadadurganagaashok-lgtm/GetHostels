<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Co-Live Hostels - Get Hostel</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">

</head>

<body>

<!-- =====================================================
     HEADER
===================================================== -->

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


<!-- =====================================================
     PAGE TITLE
===================================================== -->

<section class="hostel-section">

    <div class="hostel-section-title">

        <h2>🏠 Co-Live Hostels</h2>

        <p>
            Find comfortable co-living hostels near you.
        </p>

    </div>


<!-- =====================================================
     HOSTEL LIST
===================================================== -->

    <div class="hostel-list">

        <c:choose>

            <c:when test="${empty hostels}">

                <div class="empty-box">

                    <h2>No Co-Live Hostels Available</h2>

                    <p>
                        Currently there are no active co-live hostels.
                    </p>

                </div>

            </c:when>


            <c:otherwise>

                <c:forEach items="${hostels}" var="hostel">

                    <div class="user-hostel-card">


                        <!-- =================================================
                             IMAGE
                        ================================================= -->

                        <div class="user-hostel-image">

                            <c:choose>

                                <c:when test="${not empty hostel.coverImage}">

                                    <img src="${hostel.coverImage}"
                                         alt="${hostel.hostelName}">

                                </c:when>

                                <c:otherwise>

                                    <img src="${pageContext.request.contextPath}/images/no-image.png"
                                         alt="No Hostel Image">

                                </c:otherwise>

                            </c:choose>

                        </div>


                        <!-- =================================================
                             DETAILS
                        ================================================= -->

                        <div class="user-hostel-details">


                            <!-- HEADER -->

                            <div class="user-hostel-header">

                                <h2>
                                    ${hostel.hostelName}
                                </h2>
                                 

                                <span class="active-badge">
                                    ${hostel.status}
                                </span>

                            </div>


                            <!-- HOSTEL TYPE -->

                            <div class="hostel-type">

                                🏠 ${hostel.hostelType}

                            </div>


                            <!-- LOCATION -->

                            <div class="user-location">

                                📍

                                ${hostel.area},
                                ${hostel.city},
                                ${hostel.state}

                            </div>


                            <!-- ADDRESS -->

                            <div class="user-location">

                                🏡 ${hostel.address}

                            </div>


                            <!-- PHONE -->

                            <div class="user-phone">

                                📞 ${hostel.ownerPhone}

                                <c:if test="${not empty hostel.alternatePhone}">

                                    &nbsp;&nbsp;

                                    ☎ ${hostel.alternatePhone}

                                </c:if>

                            </div>


                            <div class="card-divider"></div>


                            <!-- =================================================
                                 BED DETAILS
                            ================================================= -->

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


                            <!-- =================================================
                                 AMOUNTS
                            ================================================= -->

                            <div class="amount-details">

                                <span>
                                    Advance
                                    <b>₹${hostel.advanceAmount}</b>
                                </span>

                                <span>
                                    Return
                                    <b>₹${hostel.returnAmount}</b>
                                </span>

                                <span>
                                    Day Stay
                                    <b>₹${hostel.dayStayPrice}</b>
                                </span>

                            </div>


                            <div class="card-divider"></div>


                            <!-- =================================================
                                 SHARING PRICES
                            ================================================= -->

                            <div class="sharing-prices">

                                <div>
                                    <span>1 Sharing</span>
                                    ₹${hostel.oneSharingPrice}
                                </div>

                                <div>
                                    <span>2 Sharing</span>
                                    ₹${hostel.twoSharingPrice}
                                </div>

                                <div>
                                    <span>3 Sharing</span>
                                    ₹${hostel.threeSharingPrice}
                                </div>

                                <div>
                                    <span>4 Sharing</span>
                                    ₹${hostel.fourSharingPrice}
                                </div>

                                <div>
                                    <span>5 Sharing</span>
                                    ₹${hostel.fiveSharingPrice}
                                </div>

                                <div>
                                    <span>6 Sharing</span>
                                    ₹${hostel.sixSharingPrice}
                                </div>

                            </div>


                            <div class="card-divider"></div>


                            <!-- =================================================
                                 FACILITIES
                            ================================================= -->

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


                            <div class="card-divider"></div>


                            <!-- =================================================
                                 BUTTONS
                            ================================================= -->

                            <div class="user-card-buttons">

                                <a href="#"
                                   class="view-beds-btn">

                                    🛏 View Beds

                                </a>


                                <c:if test="${not empty hostel.googleMapLink}">

                                    <a href="${hostel.googleMapLink}"
                                       target="_blank"
                                       class="map-btn">

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


<!-- =====================================================
     FOOTER
===================================================== -->

<footer>

    © 2026 Get Hostel. All Rights Reserved.

</footer>


</body>

</html>