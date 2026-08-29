<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">
<title>Get Hostel</title>

<link rel="stylesheet"
      href="${pageContext.request.contextPath}/css/style.css">

</head>

<body>

<!-- ================= HEADER ================= -->

<header>

    <div class="logo">
        <img src="${pageContext.request.contextPath}/images/logo.png" alt="Logo">
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
<!-- ================= POPULAR CITIES ================= -->

<section class="cities">

    <h2>Popular Cities</h2>

    <div class="city-container">

        <!-- Hyderabad -->
        <div class="city">

            <button class="city-btn">Hyderabad</button>

            <div class="dropdown">

                <a href="#">Madhapur</a>
                <a href="#">Gachibowli</a>
                <a href="#">Kukatpally</a>
                <a href="#">Ameerpet</a>
                <a href="#">Kondapur</a>
                <a href="#">Miyapur</a>
                <a href="#">Hitech City</a>
                <a href="#">See More...</a>

            </div>

        </div>

        <!-- Bangalore -->

        <div class="city">

            <button class="city-btn">Bangalore</button>

            <div class="dropdown">

                <a href="#">Whitefield</a>
                <a href="#">Marathahalli</a>
                <a href="#">Electronic City</a>
                <a href="#">Koramangala</a>
                <a href="#">HSR Layout</a>
                <a href="#">BTM Layout</a>
                <a href="#">See More...</a>

            </div>

        </div>

        <!-- Chennai -->

        <div class="city">

            <button class="city-btn">Chennai</button>

            <div class="dropdown">

                <a href="#">T Nagar</a>
                <a href="#">Velachery</a>
                <a href="#">Guindy</a>
                <a href="#">Anna Nagar</a>
                <a href="#">Tambaram</a>
                <a href="#">See More...</a>

            </div>

        </div>

        <div class="city"><button class="city-btn">Mumbai</button></div>

        <div class="city"><button class="city-btn">Delhi</button></div>

        <div class="city"><button class="city-btn">Kolkata</button></div>

        <div class="city"><button class="city-btn">Pune</button></div>

        <div class="city"><button class="city-btn">Kochi</button></div>

        <div class="city"><button class="city-btn">Ahmedabad</button></div>

        <div class="city"><button class="city-btn">Bhubaneswar</button></div>

    </div>

</section>

<!-- ================= HERO ================= -->

<section class="hero-section">

    <h2>Find Your Perfect Hostel</h2>

    <p>
        Verified Hostels • Affordable PGs • Safe Accommodation Across India
    </p>

    <div class="search-box">

        <input type="text" placeholder="Enter City">

        <button>Search</button>

    </div>

    <div class="hero-points">

        ✔ 5000+ Verified Hostels
        &nbsp;&nbsp;
        ✔ 120+ Cities
        &nbsp;&nbsp;
        ✔ Trusted by Students

    </div>

</section>
<!-- ================================================= -->
<!-- ALL ACTIVE HOSTELS -->
<!-- ================================================= -->

<section class="hostel-section">

    <div class="hostel-section-title">

        <h2>🏨 Available Hostels</h2>

        <p>
            Find the best hostels with complete details
        </p>

    </div>


    <div class="hostel-list">

        <c:choose>

            <c:when test="${empty hostels}">

                <div class="no-hostels">

                    <h2>No Hostels Available</h2>

                    <p>
                        New hostels will appear here soon.
                    </p>

                </div>

            </c:when>


            <c:otherwise>

                <c:forEach items="${hostels}"
                           var="hostel">


                    <!-- ================= HOSTEL CARD ================= -->

                    <div class="user-hostel-card">


                        <!-- ================= IMAGE ================= -->

                        <div class="user-hostel-image">

                            <c:choose>

                                <c:when test="${not empty hostel.coverImage}">

                                          <img
                                             src="${hostel.coverImage}"
                                             alt="${hostel.hostelName}">
 
                                </c:when>

                                <c:otherwise>

                                    <img
                                    src="${pageContext.request.contextPath}/images/no-image.png"
                                    alt="No Image">

                                </c:otherwise>

                            </c:choose>

                        </div>


                        <!-- ================= DETAILS ================= -->

                        <div class="user-hostel-details">


                            <!-- NAME -->

                            <div class="user-hostel-header">

                                <h2>
                                    ${hostel.hostelName}
                                </h2>

                                <span class="active-badge">
                                    ${hostel.status}
                                </span>

                            </div>


                            <!-- LOCATION -->

                            <div class="user-location">

                                📍
                                ${hostel.area},
                                ${hostel.city}

                            </div>
                            
                           <c:if test="${not empty hostelDistances[hostel.hostelId]}">

                            <div class="hostel-distance">

                               📍
                               <fmt:formatNumber
                                value="${hostelDistances[hostel.hostelId]}"
                                   maxFractionDigits="2"/>

                                   km away

                            </div>

</c:if>
                                     <!-- ADDRESS -->

                            <div class="user-location">

                                🏡 ${hostel.address}

                            </div>


                            <!-- CONTACT -->

                            <div class="user-phone">

                                ☎
                                ${hostel.ownerPhone}
                                 <c:if test="${not empty hostel.alternatePhone}">

                                    &nbsp;&nbsp;

                                    ☎ ${hostel.alternatePhone}

                                </c:if>

                            </div>


                            <!-- DIVIDER -->

                            <div class="card-divider"></div>


                            <!-- BED DETAILS -->

                            <div class="bed-details">

                                <span>
                                    🛏
                                    <b>${hostel.totalBeds}</b>
                                    Beds
                                </span>

                                <span>
                                    ✅
                                    <b>${hostel.availableBeds}</b>
                                    Available
                                </span>

                            </div>


                            <!-- AMOUNT DETAILS -->

                            <div class="amount-details">

                                <span>
                                    💰 Advance
                                    <b>₹${hostel.advanceAmount}</b>
                                </span>

                                <span>
                                    💵 Return
                                    <b>₹${hostel.returnAmount}</b>
                                </span>

                                <span>
                                    🌙 Day Stay
                                    <b>₹${hostel.dayStayPrice}</b>
                                </span>

                            </div>


                            <div class="card-divider"></div>


                            <!-- SHARING PRICES -->

                            <div class="sharing-prices">

                                <div>
                                    <span>1Share</span>
                                    ₹${hostel.oneSharingPrice}
                                </div>

                                <div>
                                    <span>2Share</span>
                                    ₹${hostel.twoSharingPrice}
                                </div>

                                <div>
                                    <span>3Share</span>
                                    ₹${hostel.threeSharingPrice}
                                </div>

                                <div>
                                    <span>4Share</span>
                                    ₹${hostel.fourSharingPrice}
                                </div>

                                <div>
                                    <span>5Share</span>
                                    ₹${hostel.fiveSharingPrice}
                                </div>

                                <div>
                                    <span>6Share</span>
                                    ₹${hostel.sixSharingPrice}
                                </div>

                            </div>


                            <div class="card-divider"></div>


                            <!-- FACILITIES -->

                            <div class="facilities">


                                <c:if test="${hostel.wifi}">
                                    <span>📶 WiFi</span>
                                </c:if>


                                <c:if test="${hostel.food}">
                                    <span>🍽 Food</span>
                                </c:if>


                                <c:if test="${hostel.ac}">
                                    <span>❄ AC</span>
                                </c:if>


                                <c:if test="${hostel.attachedBathroom}">
                                    <span>🚿 Bathroom</span>
                                </c:if>


                                <c:if test="${hostel.cctv}">
                                    <span>📹 CCTV</span>
                                </c:if>


                                <c:if test="${hostel.parking}">
                                    <span>🅿 Parking</span>
                                </c:if>


                                <c:if test="${hostel.lift}">
                                    <span>🛗 Lift</span>
                                </c:if>


                                <c:if test="${hostel.gym}">
                                    <span>🏋 Gym</span>
                                </c:if>


                                <c:if test="${hostel.laundry}">
                                    <span>🧺 Laundry</span>
                                </c:if>


                                <c:if test="${hostel.hotWater}">
                                    <span>♨ Hot Water</span>
                                </c:if>


                                <c:if test="${hostel.powerBackup}">
                                    <span>🔋 Power Backup</span>
                                </c:if>


                                <c:if test="${hostel.housekeeping}">
                                    <span>🧹 Housekeeping</span>
                                </c:if>

                            </div>


                            <div class="card-divider"></div>


                            <!-- BUTTONS -->

                            <div class="user-card-buttons">


                                <a
                                class="view-beds-btn"
                                href="#">

                                    🛏 View Beds

                                </a>


                                <a
                                class="map-btn"
                                href="${hostel.googleMapLink}"
                                target="_blank">

                                    🗺 View Map

                                </a>

                            </div>


                        </div>

                    </div>


                </c:forEach>

            </c:otherwise>

        </c:choose>

    </div>

</section>

<!-- ================= CONTACT ================= -->

<div class="contact">

    Contact :
    support@gethostels.com |
    +91 9658662666

</div>



<!-- ================= ABOUT ================= -->

<section class="about">

    <h2>About Get Hostel</h2>

    <p>

        Get Hostel helps students and working professionals find verified hostels,
        compare prices, explore amenities and book accommodation easily across India.

    </p>

</section>

<!-- ================= FOOTER ================= -->

<footer>

    © 2026 AU Private Limited. All Rights Reserved.

</footer>

<script>

window.addEventListener("load", function () {

    const savedLatitude =
        sessionStorage.getItem("userLatitude");

    const savedLongitude =
        sessionStorage.getItem("userLongitude");


    // =====================================================
    // LOCATION ALREADY SAVED
    // =====================================================

    if (savedLatitude && savedLongitude) {

        console.log("Location already saved.");

        console.log(
            "User Latitude  : " + savedLatitude
        );

        console.log(
            "User Longitude : " + savedLongitude
        );


        // Check URL
        const urlParams =
            new URLSearchParams(window.location.search);

        const existingLatitude =
            urlParams.get("latitude");

        const existingLongitude =
            urlParams.get("longitude");


        // Add location to Home URL if missing
        if (!existingLatitude || !existingLongitude) {

            const currentUrl =
                new URL(window.location.href);

            currentUrl.searchParams.set(
                "latitude",
                savedLatitude
            );

            currentUrl.searchParams.set(
                "longitude",
                savedLongitude
            );

            window.location.href =
                currentUrl.toString();
        }

        return;
    }


    // =====================================================
    // GET LOCATION FOR FIRST TIME
    // =====================================================

    if (!navigator.geolocation) {

        console.log(
            "Geolocation is not supported."
        );

        return;
    }


    navigator.geolocation.getCurrentPosition(

        function (position) {

            const latitude =
                position.coords.latitude;

            const longitude =
                position.coords.longitude;


            console.log(
                "User Latitude  : " + latitude
            );

            console.log(
                "User Longitude : " + longitude
            );


            // Save in sessionStorage
            sessionStorage.setItem(
                "userLatitude",
                latitude
            );

            sessionStorage.setItem(
                "userLongitude",
                longitude
            );


            // Add to Home URL
            const currentUrl =
                new URL(window.location.href);

            currentUrl.searchParams.set(
                "latitude",
                latitude
            );

            currentUrl.searchParams.set(
                "longitude",
                longitude
            );


            window.location.href =
                currentUrl.toString();

        },

        function (error) {

            console.log(
                "Location permission/error:",
                error.message
            );

        }

    );

});

</script>

</body>

</html>