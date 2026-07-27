<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>

<c:choose>

<c:when test="${not empty hostel.hostelId}">
Edit Hostel
</c:when>

<c:otherwise>
Add Hostel
</c:otherwise>

</c:choose>

</title>

<link rel="stylesheet"
href="${pageContext.request.contextPath}/css/add_hostel.css">

</head>

<body>

<header>

    <div class="logo">

        <img src="${pageContext.request.contextPath}/images/logo.png">

        <h1>Get Hostel</h1>

    </div>

    <nav>

        <a href="${pageContext.request.contextPath}/owner/dashboard">
            Dashboard
        </a>

        <a href="${pageContext.request.contextPath}/owner/myHostels">
            My Hostels
        </a>

        <a href="${pageContext.request.contextPath}/owner/logout">
            Logout
        </a>

    </nav>

</header>

<div class="page-container">

<h1>

<c:choose>

<c:when test="${not empty hostel.hostelId}">
✏ Edit Hostel
</c:when>

<c:otherwise>
🏨 Add New Hostel
</c:otherwise>

</c:choose>

</h1>

<form action="${pageContext.request.contextPath}${empty hostel.hostelId
        ? '/owner/saveHostel'
        : '/owner/updateHostel'}"
      method="post"
      enctype="multipart/form-data">

    <input type="hidden"
           name="hostelId"
           value="${hostel.hostelId}">

<!-- ================================================= -->
<!-- BASIC INFORMATION -->
<!-- ================================================= -->

<div class="card">

<h2>🏨 Basic Information</h2>

<div class="grid">

<div>

<label>Hostel Name *</label>

<input type="text"
       name="hostelName"
       value="${hostel.hostelName}"
       required>

</div>

<div>

<label>Hostel Type *</label>

<select name="hostelType">

    <option value="Boys Hostel"
        ${hostel.hostelType=='Boys Hostel' ? 'selected' : ''}>
        Boys Hostel
    </option>

    <option value="Girls Hostel"
        ${hostel.hostelType=='Girls Hostel' ? 'selected' : ''}>
        Girls Hostel
    </option>

    <option value="Co-Live Hostel"
        ${hostel.hostelType=='Co-Live Hostel' ? 'selected' : ''}>
        Co-Live Hostel
    </option>

</select>

</div>

</div>

<label>Description</label>

<textarea
name="description"
rows="5"
placeholder="Describe your hostel, facilities, surroundings, food, etc.">${hostel.description}</textarea>

</div>

<!-- ================================================= -->
<!-- LOCATION -->
<!-- ================================================= -->

<div class="card">

<h2>📍 Location Details</h2>

<div class="grid">

<!-- ================= STATE ================= -->

<div>

<label>State *</label>

<select name="state" required>

    <option value="">Select State</option>

    <option value="Andhra Pradesh"
        ${hostel.state=='Andhra Pradesh' ? 'selected' : ''}>
        Andhra Pradesh
    </option>

    <option value="Telangana"
        ${hostel.state=='Telangana' ? 'selected' : ''}>
        Telangana
    </option>

    <option value="Karnataka"
        ${hostel.state=='Karnataka' ? 'selected' : ''}>
        Karnataka
    </option>

    <option value="Tamil Nadu"
        ${hostel.state=='Tamil Nadu' ? 'selected' : ''}>
        Tamil Nadu
    </option>

</select>

</div>

<!-- ================= CITY ================= -->

<div>

<label>City *</label>

<select id="city"
        name="city"
        onchange="loadAreas()"
        required>

    <option value="">-- Select City --</option>

    <option value="Hyderabad"
        ${hostel.city=='Hyderabad' ? 'selected' : ''}>
        Hyderabad
    </option>

    <option value="Bengaluru"
        ${hostel.city=='Bengaluru' ? 'selected' : ''}>
        Bengaluru
    </option>

    <option value="Chennai"
        ${hostel.city=='Chennai' ? 'selected' : ''}>
        Chennai
    </option>

    <option value="Visakhapatnam"
        ${hostel.city=='Visakhapatnam' ? 'selected' : ''}>
        Visakhapatnam
    </option>

</select>

</div>

<!-- ================= AREA ================= -->

<div>

<label>Area *</label>

<select id="area"
        name="area"
        required>

    <option value="">-- Select Area --</option>

</select>

</div>

<!-- ================= PINCODE ================= -->

<div>

<label>Pincode *</label>

<input
type="text"
name="pincode"
maxlength="6"
placeholder="500081"
value="${hostel.pincode}"
required>

</div>

</div>

<!-- ================= ADDRESS ================= -->

<label>Complete Address *</label>

<textarea
name="address"
rows="3"
placeholder="Flat No, Street, Colony..."
required>${hostel.address}</textarea>

<div class="grid">

<!-- ================= LANDMARK ================= -->

<div>

<label>Nearest Landmark</label>

<input
type="text"
name="landmark"
placeholder="Near Metro Station"
value="${hostel.landmark}">

</div>

<!-- ================= GOOGLE MAP ================= -->

<div>

<label>Google Map Link</label>

<input
type="text"
name="googleMapLink"
value="${hostel.googleMapLink}"
placeholder="Paste Google Maps Link">

</div>

</div>

</div>
<!-- ================================================= -->
<!-- CONTACT DETAILS -->
<!-- ================================================= -->

<div class="card">

<h2>📞 Contact Details</h2>

<div class="grid">

<div>

<label>Owner Phone *</label>

<input
type="text"
name="ownerPhone"
maxlength="10"
placeholder="9876543210"
value="${hostel.ownerPhone}"
required>

</div>

<div>

<label>Alternate Phone</label>

<input
type="text"
name="alternatePhone"
maxlength="10"
placeholder="9876543210"
value="${hostel.alternatePhone}">

</div>

</div>

</div>

<!-- ================================================= -->
<!-- BED DETAILS -->
<!-- ================================================= -->

<div class="card">

<h2>🛏 Bed Details</h2>

<div class="grid">

<div>

<label>Total Beds *</label>

<input
type="number"
name="totalBeds"
min="1"
value="${hostel.totalBeds}"
required>

</div>

<div>

<label>Available Beds *</label>

<input
type="number"
name="availableBeds"
min="0"
value="${hostel.availableBeds}"
required>

</div>

</div>

</div>

<!-- ================================================= -->
<!-- PRICING -->
<!-- ================================================= -->

<div class="card">

<h2>💰 Pricing Details</h2>

<div class="grid">

<div>

<label>Advance Amount (₹)</label>

<input
type="number"
name="advanceAmount"
min="0"
value="${hostel.advanceAmount}">

</div>

<div>

<label>Return Amount (₹)</label>

<input
type="number"
name="returnAmount"
min="0"
value="${hostel.returnAmount}">

</div>

<div>

<label>Day Stay Price (₹)</label>

<input
type="number"
name="dayStayPrice"
min="0"
value="${hostel.dayStayPrice}">

</div>

<div>

<label>1 Sharing Price (₹)</label>

<input
type="number"
name="oneSharingPrice"
min="0"
value="${hostel.oneSharingPrice}">

</div>

<div>

<label>2 Sharing Price (₹)</label>

<input
type="number"
name="twoSharingPrice"
min="0"
value="${hostel.twoSharingPrice}">

</div>

<div>

<label>3 Sharing Price (₹)</label>

<input
type="number"
name="threeSharingPrice"
min="0"
value="${hostel.threeSharingPrice}">

</div>

<div>

<label>4 Sharing Price (₹)</label>

<input
type="number"
name="fourSharingPrice"
min="0"
value="${hostel.fourSharingPrice}">

</div>

<div>

<label>5 Sharing Price (₹)</label>

<input
type="number"
name="fiveSharingPrice"
min="0"
value="${hostel.fiveSharingPrice}">

</div>

<div>

<label>6 Sharing Price (₹)</label>

<input
type="number"
name="sixSharingPrice"
min="0"
value="${hostel.sixSharingPrice}">

</div>

</div>

</div>
<!-- ================================================= -->
<!-- FACILITIES -->
<!-- ================================================= -->

<div class="card">

<h2>⭐ Facilities</h2>

<div class="facility-grid">

<label><input type="checkbox" name="wifi"
${hostel.wifi ? 'checked' : ''}> WiFi</label>

<label><input type="checkbox" name="food"
${hostel.food ? 'checked' : ''}> Food</label>

<label><input type="checkbox" name="ac"
${hostel.ac ? 'checked' : ''}> AC</label>

<label><input type="checkbox" name="laundry"
${hostel.laundry ? 'checked' : ''}> Laundry</label>

<label><input type="checkbox" name="parking"
${hostel.parking ? 'checked' : ''}> Parking</label>

<label><input type="checkbox" name="cctv"
${hostel.cctv ? 'checked' : ''}> CCTV</label>

<label><input type="checkbox" name="lift"
${hostel.lift ? 'checked' : ''}> Lift</label>

<label><input type="checkbox" name="gym"
${hostel.gym ? 'checked' : ''}> Gym</label>

<label><input type="checkbox" name="powerBackup"
${hostel.powerBackup ? 'checked' : ''}> Power Backup</label>

<label><input type="checkbox" name="hotWater"
${hostel.hotWater ? 'checked' : ''}> Hot Water</label>

<label><input type="checkbox" name="washingMachine"
${hostel.washingMachine ? 'checked' : ''}> Washing Machine</label>

<label><input type="checkbox" name="refrigerator"
${hostel.refrigerator ? 'checked' : ''}> Refrigerator</label>

<label><input type="checkbox" name="housekeeping"
${hostel.housekeeping ? 'checked' : ''}> Housekeeping</label>

<label><input type="checkbox" name="studyRoom"
${hostel.studyRoom ? 'checked' : ''}> Study Room</label>

<label><input type="checkbox" name="balcony"
${hostel.balcony ? 'checked' : ''}> Balcony</label>

<label><input type="checkbox" name="attachedBathroom"
${hostel.attachedBathroom ? 'checked' : ''}> Attached Bathroom</label>

</div>

</div>

<!-- ================================================= -->
<!-- COVER IMAGE -->
<!-- ================================================= -->

<div class="card">

<h2>📷 Hostel Cover Image</h2>

<p class="upload-info">

Upload one clear front image of your hostel.

This image will be displayed on the Home Page,

Search Results and Hostel Cards.

</p>

<div class="image-upload">

<label class="upload-label">

📸 Choose Cover Image

<input
type="file"
name="image"
accept=".jpg,.jpeg,.png">
<c:if test="${not empty hostel.coverImage}">

<br><br>

<img
src="${pageContext.request.contextPath}/uploads/${hostel.coverImage}"
width="250"
style="border-radius:10px;">

</c:if>
</label>

<p class="upload-note">

Supported Formats :
JPG, JPEG, PNG

<br>

Maximum Recommended Size :
5 MB

</p>

</div>

</div>

<!-- ================================================= -->
<!-- SAVE BUTTON -->
<!-- ================================================= -->

<div class="save-section">

<button
type="submit"
class="save-btn">

<c:choose>

    <c:when test="${not empty hostel.hostelId}">
        ✏ UPDATE HOSTEL
    </c:when>

    <c:otherwise>
        💾 SAVE HOSTEL
    </c:otherwise>

</c:choose>

</button>

</div>

</form>

</div>
<script>

const areas = {

Hyderabad : [
"Ameerpet",
"Madhura Nagar",
"Kukatpally",
"KPHB",
"Gachibowli",
"Hitech City",
"Dilsukhnagar",
"SR Nagar",
"Begumpet",
"Mehdipatnam"
],

Bengaluru : [
"Electronic City",
"Whitefield",
"Marathahalli",
"Koramangala",
"BTM Layout",
"Indiranagar",
"Yelahanka",
"Hebbal",
"Jayanagar",
"Malleshwaram"
],

Chennai : [
"T. Nagar",
"Velachery",
"Guindy",
"Tambaram",
"Anna Nagar",
"Adyar",
"Porur",
"OMR",
"Perungudi",
"Sholinganallur"
],

Visakhapatnam : [
"MVP Colony",
"Dwaraka Nagar",
"Maddilapalem",
"Gajuwaka",
"NAD Junction",
"Gopalapatnam",
"Seethammadhara",
"Akkayyapalem",
"Beach Road",
"Rushikonda"
]

};

function loadAreas() {

    const city = document.getElementById("city").value;

    const area = document.getElementById("area");

    area.innerHTML =
        "<option value=''>-- Select Area --</option>";

    if (city != "" && areas[city]) {

        areas[city].forEach(function(a) {

            let option = document.createElement("option");

            option.value = a;

            option.text = a;

            // Select existing area while editing
            if (a === "${hostel.area}") {
                option.selected = true;
            }

            area.appendChild(option);

        });

    }

}


</script>
<c:if test="${not empty hostel.hostelId}">
<script>
    window.onload = function() {
        loadAreas();
    };
</script>
</c:if>

</body>

</html>