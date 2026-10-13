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
      
      <input type="hidden" name="latitude" id="latitude">

    <input type="hidden" name="longitude" id="longitude">

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
<c:if test="${not empty hostel.hostelId}">

    <!-- ================================================= -->
    <!-- FLOOR MANAGEMENT -->
    <!-- ================================================= -->

    <div class="card">

        <h2>🏢 Floor Management</h2>

        <form onsubmit="return saveFloorAjax(event, this);">

            <input type="hidden"
                   name="hostelId"
                   value="${hostel.hostelId}">

            <div class="grid">

                <div>
                    <label>Floor Number *</label>

                    <input type="number"
                           name="floorNumber"
                           min="1"
                           placeholder="Example: 1"
                           required>
                </div>

                <div>
                    <label>Floor Name</label>

                    <input type="text"
                           name="floorName"
                           placeholder="Example: Ground Floor">
                </div>

            </div>

            <div class="save-section">

                <button type="submit"
                        class="save-btn">
                    ➕ ADD FLOOR
                </button>

            </div>

        </form>

    </div>

</c:if>
<c:if test="${not empty hostel.hostelId}">

    <div class="card">

        <h2>🏢 Existing Floors</h2>

        <c:choose>

            <c:when test="${not empty floors}">

                <div class="floor-list" id="floorList">

                    <c:forEach var="floor" items="${floors}">

                        <div class="floor-item">

                            <div style="
    padding:15px;
    margin-top:10px;
    border-bottom:1px solid #ddd;
    display:flex;
    align-items:center;
    justify-content:space-between;
    gap:15px;">

    <!-- FLOOR DETAILS -->

    <div>

        <strong style="font-size:18px;">
            Floor ${floor.floorNumber}
        </strong>

        

    </div>


    <!-- FLOOR ACTIONS -->

    <div style="display:flex; gap:8px;">

        <!-- EDIT -->

        <button type="button"
                onclick="editFloor(
                    '${floor.floorId}',
                    '${floor.floorNumber}',
                    '${floor.floorName}'
                )"
                style="
                    padding:8px 15px;
                    border:none;
                    border-radius:6px;
                    background:#4caf50;
                    color:white;
                    cursor:pointer;">
            ✏️ Edit
        </button>


        <!-- DELETE -->

        <a href="${pageContext.request.contextPath}/owner/deleteFloor/${floor.floorId}"
           onclick="return confirm('Are you sure you want to delete Floor ${floor.floorNumber}?');"
           style="
                padding:8px 15px;
                border-radius:6px;
                text-decoration:none;
                background:#e53935;
                color:white;">
            🗑️ Delete
        </a>

    </div>

</div>

                            <c:if test="${not empty floor.floorName}">
                                 ${floor.floorName}
                            </c:if>
                            
                            <!-- ============================= -->
<!-- ROOMS FOR THIS FLOOR -->
<!-- ============================= -->

<div style="margin-top:20px; padding:15px; border-top:1px solid #ddd;">

    <h3>🚪 Rooms</h3>

    <!-- ADD ROOM -->

    <form action="${pageContext.request.contextPath}/owner/addRoom"
          method="post">

        <input type="hidden"
               name="floorId"
               value="${floor.floorId}">

        <div class="grid">

            <div>
                <label>Room Number *</label>

                <input type="number"
                       name="roomNumber"
                       min="1"
                       placeholder="Example: 101"
                       required>
            </div>

            <div>
                <label>Sharing Type *</label>

                <select name="sharingType" required>

                    <option value="">
                        Select Sharing
                    </option>

                    <option value="1">
                        1 Sharing
                    </option>

                    <option value="2">
                        2 Sharing
                    </option>

                    <option value="3">
                        3 Sharing
                    </option>

                    <option value="4">
                        4 Sharing
                    </option>

                    <option value="5">
                        5 Sharing
                    </option>

                    <option value="6">
                        6 Sharing
                    </option>

                </select>
            </div>

        </div>

        <button type="submit"
                class="save-btn"
                style="margin-top:10px;">
            ➕ ADD ROOM
        </button>

    </form>


    <!-- EXISTING ROOMS -->

    <div style="margin-top:20px;">

        <c:choose>

            <c:when test="${not empty roomsByFloor[floor.floorId]}">

                <c:forEach
                        var="room"
                        items="${roomsByFloor[floor.floorId]}">

                    <div style="
    padding:15px;
    margin-top:8px;
    border:1px solid #ddd;
    border-radius:8px;
    background:#fafafa;
    display:flex;
    align-items:center;
    justify-content:space-between;
    gap:15px;">

    <!-- ROOM DETAILS -->

    <div>

        <strong>
            Room ${room.roomNumber}
        </strong>

        <span style="margin-left:15px;">
            ${room.sharingType} Sharing
        </span>

    </div>
    <!-- ============================= -->
<!-- BEDS FOR THIS ROOM -->
<!-- ============================= -->

<div style="
    margin-top:15px;
    padding:12px;
    border-top:1px solid #ddd;">

    <h4>🛏️ Beds</h4>


    <!-- ADD BED -->

    <form action="${pageContext.request.contextPath}/owner/addBed"
          method="post">

        <input type="hidden"
               name="roomId"
               value="${room.roomId}">

        <div style="
            display:flex;
            gap:10px;
            align-items:end;">

            <div>

                <label>Bed Number</label>

                <input type="number"
                       name="bedNumber"
                       min="1"
                       placeholder="Example: 1"
                       required>

            </div>


            <button type="submit"
                    class="save-btn">
                ➕ Add Bed
            </button>

        </div>

    </form>


    <!-- EXISTING BEDS -->

    <div style="margin-top:15px;">

        <c:choose>

            <c:when test="${not empty bedsByRoom[room.roomId]}">

                <c:forEach
                        var="bed"
                        items="${bedsByRoom[room.roomId]}">

<div style="
    display:inline-flex;
    align-items:center;
    gap:10px;
    margin:5px;
    padding:12px 15px;
    border:1px solid #ddd;
    border-radius:8px;
    background:#f8f8f8;">

    <!-- BED -->

    <span>
        🛏️ Bed ${bed.bedNumber}
    </span>


 <!-- STATUS -->

<strong>
    ${bed.status}
</strong>


<!-- UPDATE STATUS -->

<form onsubmit="return saveBedStatus(event, this);"
      style="display:inline-flex; align-items:center; gap:8px;">

    <input type="hidden"
           name="bedId"
           value="${bed.bedId}">

    <select name="status"
            onchange="toggleAvailableDate(this, '${bed.bedId}')"
            required>

        <option value="AVAILABLE"
                ${bed.status == 'AVAILABLE' ? 'selected' : ''}>
            Available
        </option>

        <option value="OCCUPIED"
                ${bed.status == 'OCCUPIED' ? 'selected' : ''}>
            Occupied
        </option>

        <option value="AVAILABLE_FROM"
                ${bed.status == 'AVAILABLE_FROM' ? 'selected' : ''}>
            Available From
        </option>

    </select>


    <input type="date"
           id="availableDate_${bed.bedId}"
           name="availableFrom"
           value="${bed.availableFrom}"
           style="${bed.status == 'AVAILABLE_FROM'
                    ? ''
                    : 'display:none;'}">


    <button type="submit"
            style="
                padding:6px 10px;
                border:none;
                border-radius:5px;
                background:#2451ff;
                color:white;
                cursor:pointer;">
        Save
    </button>
    
    <!-- Shows only after AJAX save succeeds -->
<span class="bed-save-message"
      style="
          display:none;
          color:#2e7d32;
          font-weight:bold;">
    ✓ Saved
</span>

</form>


<!-- EDIT -->

    <button type="button"
            onclick="editBed(
                '${bed.bedId}',
                '${bed.bedNumber}'
            )"
            style="
                padding:6px 10px;
                border:none;
                border-radius:5px;
                background:#4caf50;
                color:white;
                cursor:pointer;">
        ✏️
    </button>


    <!-- DELETE -->

    <a href="${pageContext.request.contextPath}/owner/deleteBed/${bed.bedId}"
       onclick="return confirm('Are you sure you want to delete Bed ${bed.bedNumber}?');"
       style="
            padding:6px 10px;
            border-radius:5px;
            text-decoration:none;
            background:#e53935;
            color:white;">
        🗑️
    </a>

</div>

                </c:forEach>

            </c:when>

            <c:otherwise>

                <p style="color:#777;">
                    No beds added yet.
                </p>

            </c:otherwise>

        </c:choose>

    </div>

</div>


    <!-- ACTIONS -->

    <div style="display:flex; gap:8px;">

        <!-- EDIT -->

        <button type="button"
                onclick="editRoom(
                    '${room.roomId}',
                    '${room.roomNumber}',
                    '${room.sharingType}'
                )"
                style="
                    padding:8px 15px;
                    border:none;
                    border-radius:6px;
                    cursor:pointer;
                    background:#4caf50;
                    color:white;">
            ✏️ Edit
        </button>


        <!-- DELETE -->

        <a href="${pageContext.request.contextPath}/owner/deleteRoom/${room.roomId}"
           onclick="return confirm('Are you sure you want to delete Room ${room.roomNumber}?');"
           style="
                padding:8px 15px;
                border-radius:6px;
                text-decoration:none;
                background:#e53935;
                color:white;">
            🗑️ Delete
        </a>

    </div>

</div>

                </c:forEach>

            </c:when>

            <c:otherwise>

                <p style="color:#777;">
                    No rooms added yet.
                </p>

            </c:otherwise>

        </c:choose>

    </div>

</div>

                        </div>

                    </c:forEach>

                </div>

            </c:when>

            <c:otherwise>

                <p>No floors added yet.</p>

            </c:otherwise>

        </c:choose>

    </div>

</c:if>
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

<script>

document.addEventListener("DOMContentLoaded", function () {

    if (!navigator.geolocation) {

        alert("Your browser does not support location services.");

        return;
    }

    navigator.geolocation.getCurrentPosition(

        function (position) {

            const latitude = position.coords.latitude;
            const longitude = position.coords.longitude;

            document.getElementById("latitude").value = latitude;
            document.getElementById("longitude").value = longitude;

            console.log("Latitude  :", latitude);
            console.log("Longitude :", longitude);

        },

        function (error) {

            console.log("Location Error:", error);

            alert(
                "Please allow location access so we can save the hostel location."
            );

        },

        {
            enableHighAccuracy: true,
            timeout: 10000,
            maximumAge: 0
        }

    );

});

</script>

<div id="editRoomModal"
     style="
        display:none;
        position:fixed;
        top:0;
        left:0;
        width:100%;
        height:100%;
        background:rgba(0,0,0,0.5);
        z-index:9999;
        align-items:center;
        justify-content:center;">

    <div style="
        background:white;
        padding:30px;
        border-radius:12px;
        width:400px;
        max-width:90%;">

        <h2>✏️ Edit Room</h2>

        <form action="${pageContext.request.contextPath}/owner/updateRoom"
              method="post">

            <input type="hidden"
                   id="editRoomId"
                   name="roomId">

            <label>Room Number</label>

            <input type="number"
                   id="editRoomNumber"
                   name="roomNumber"
                   required
                   style="width:100%; margin:8px 0 15px; padding:10px;">


            <label>Sharing Type</label>

            <select id="editSharingType"
                    name="sharingType"
                    required
                    style="width:100%; margin:8px 0 20px; padding:10px;">

                <option value="1">1 Sharing</option>
                <option value="2">2 Sharing</option>
                <option value="3">3 Sharing</option>
                <option value="4">4 Sharing</option>
                <option value="5">5 Sharing</option>
                <option value="6">6 Sharing</option>

            </select>


            <button type="submit"
                    style="
                        padding:10px 20px;
                        border:none;
                        border-radius:6px;
                        background:#2451ff;
                        color:white;
                        cursor:pointer;">
                💾 Save
            </button>


            <button type="button"
                    onclick="closeRoomEdit()"
                    style="
                        padding:10px 20px;
                        border:none;
                        border-radius:6px;
                        background:#777;
                        color:white;
                        cursor:pointer;">
                Cancel
            </button>

        </form>

    </div>

</div>

<script>

function editRoom(roomId, roomNumber, sharingType) {

    document.getElementById("editRoomId").value =
        roomId;

    document.getElementById("editRoomNumber").value =
        roomNumber;

    document.getElementById("editSharingType").value =
        sharingType;

    document.getElementById("editRoomModal").style.display =
        "flex";
}


function closeRoomEdit() {

    document.getElementById("editRoomModal").style.display =
        "none";
}

</script>

<div id="editFloorModal"
     style="
        display:none;
        position:fixed;
        top:0;
        left:0;
        width:100%;
        height:100%;
        background:rgba(0,0,0,0.5);
        z-index:9999;
        align-items:center;
        justify-content:center;">

    <div style="
        background:white;
        padding:30px;
        border-radius:12px;
        width:400px;
        max-width:90%;">

        <h2>✏️ Edit Floor</h2>

        <form action="${pageContext.request.contextPath}/owner/updateFloor"
              method="post">

            <input type="hidden"
                   id="editFloorId"
                   name="floorId">

            <label>Floor Number</label>

            <input type="number"
                   id="editFloorNumber"
                   name="floorNumber"
                   min="0"
                   required
                   style="
                        width:100%;
                        margin:8px 0 15px;
                        padding:10px;">


            <label>Floor Name</label>

            <input type="text"
                   id="editFloorName"
                   name="floorName"
                   placeholder="Example: Ground Floor"
                   style="
                        width:100%;
                        margin:8px 0 20px;
                        padding:10px;">


            <button type="submit"
                    style="
                        padding:10px 20px;
                        border:none;
                        border-radius:6px;
                        background:#2451ff;
                        color:white;
                        cursor:pointer;">
                💾 Save
            </button>


            <button type="button"
                    onclick="closeFloorEdit()"
                    style="
                        padding:10px 20px;
                        border:none;
                        border-radius:6px;
                        background:#777;
                        color:white;
                        cursor:pointer;">
                Cancel
            </button>

        </form>

    </div>

</div>

<script>

function editFloor(floorId, floorNumber, floorName) {

    document.getElementById("editFloorId").value =
        floorId;

    document.getElementById("editFloorNumber").value =
        floorNumber;

    document.getElementById("editFloorName").value =
        floorName || "";

    document.getElementById("editFloorModal").style.display =
        "flex";
}


function closeFloorEdit() {

    document.getElementById("editFloorModal").style.display =
        "none";
}

</script>
<div id="editBedModal"
     style="
        display:none;
        position:fixed;
        top:0;
        left:0;
        width:100%;
        height:100%;
        background:rgba(0,0,0,0.5);
        z-index:9999;
        align-items:center;
        justify-content:center;">

    <div style="
        background:white;
        padding:30px;
        border-radius:12px;
        width:350px;
        max-width:90%;">

        <h2>✏️ Edit Bed</h2>

        <form action="${pageContext.request.contextPath}/owner/updateBed"
              method="post">

            <input type="hidden"
                   id="editBedId"
                   name="bedId">

            <label>Bed Number</label>

            <input type="number"
                   id="editBedNumber"
                   name="bedNumber"
                   min="1"
                   required
                   style="
                        width:100%;
                        margin:8px 0 20px;
                        padding:10px;">

            <button type="submit"
                    style="
                        padding:10px 20px;
                        border:none;
                        border-radius:6px;
                        background:#2451ff;
                        color:white;">
                💾 Save
            </button>

            <button type="button"
                    onclick="closeBedEdit()"
                    style="
                        padding:10px 20px;
                        border:none;
                        border-radius:6px;
                        background:#777;
                        color:white;">
                Cancel
            </button>

        </form>

    </div>

</div>
<script>

function editBed(bedId, bedNumber) {

    document.getElementById("editBedId").value =
        bedId;

    document.getElementById("editBedNumber").value =
        bedNumber;

    document.getElementById("editBedModal").style.display =
        "flex";
}


function closeBedEdit() {

    document.getElementById("editBedModal").style.display =
        "none";
}

</script>

<script>

function toggleAvailableDate(select, bedId) {

    const dateField =
        document.getElementById(
            "availableDate_" + bedId
        );

    if (select.value === "AVAILABLE_FROM") {

        dateField.style.display = "inline-block";
        dateField.required = true;

    } else {

        dateField.style.display = "none";
        dateField.required = false;
        dateField.value = "";
    }
}

</script>

<script>

function saveBedStatus(event, form) {

    event.preventDefault();

    const formData = new FormData(form);

    const message =
        form.querySelector(".bed-save-message");

    fetch(
        "${pageContext.request.contextPath}/owner/updateBedStatusAjax",
        {
            method: "POST",
            body: formData
        }
    )
    .then(response => response.text())
    .then(result => {

        if (result === "SUCCESS") {

            message.style.display = "inline";

            setTimeout(() => {
                message.style.display = "none";
            }, 2000);

        } else {

            alert("Unable to update bed status.");

        }

    })
    .catch(error => {

        console.error(error);

        alert("Something went wrong.");

    });

    return false;
}

</script>
<script>

function saveFloorAjax(event, form) {

    event.preventDefault();

    const formData = new FormData(form);

    const message =
        form.querySelector(".floor-save-message");

    fetch(
        "${pageContext.request.contextPath}/owner/addFloorAjax",
        {
            method: "POST",
            body: formData
        }
    )
    .then(function(response) {
        return response.text();
    })
    .then(function(result) {

        result = result.trim();

        console.log("Floor response:", result);

        if (result === "UNAUTHORIZED") {

            alert("Please login again.");
            return;
        }

        if (result === "HOSTEL_NOT_FOUND") {

            alert("Hostel not found.");
            return;
        }

        if (result === "") {

            alert("Floor was not created.");
            return;
        }

        // The controller returns the new floor ID
        const floorId = result;

        // Get values BEFORE clearing the form
        const floorNumber =
            form.querySelector(
                '[name="floorNumber"]'
            ).value;

        const floorName =
            form.querySelector(
                '[name="floorName"]'
            ).value;

        // Add new floor to the page
        addNewFloorToPage(
            floorId,
            floorNumber,
            floorName
        );

        // Clear form
        form.querySelector(
            '[name="floorNumber"]'
        ).value = "";

        form.querySelector(
            '[name="floorName"]'
        ).value = "";

        // Show saved message
        if (message) {

            message.textContent = "✓ Saved";
            message.style.display = "inline";

            setTimeout(function() {

                message.style.display = "none";

            }, 2000);
        }

    })
    .catch(function(error) {

        console.error(
            "Floor AJAX error:",
            error
        );

        alert(
            "Something went wrong while adding the floor."
        );

    });

    return false;
}


function addNewFloorToPage(
        floorId,
        floorNumber,
        floorName) {

    const floorList =
        document.getElementById(
            "floorList"
        );

    if (!floorList) {

        console.error(
            "floorList not found"
        );

        return;
    }


    // Create floor container
    const floorItem =
        document.createElement("div");

    floorItem.className =
        "floor-item";

    floorItem.setAttribute(
        "data-floor-id",
        floorId
    );


    // Main floor row
    const floorRow =
        document.createElement("div");

    floorRow.style.padding = "15px";
    floorRow.style.marginTop = "10px";
    floorRow.style.borderBottom =
        "1px solid #ddd";
    floorRow.style.display = "flex";
    floorRow.style.alignItems = "center";
    floorRow.style.justifyContent =
        "space-between";
    floorRow.style.gap = "15px";


    // Floor details
    const floorDetails =
        document.createElement("div");


    const floorTitle =
        document.createElement("strong");

    floorTitle.style.fontSize = "18px";

    floorTitle.textContent =
        "Floor " + floorNumber;


    floorDetails.appendChild(
        floorTitle
    );


    // Floor name
    if (floorName &&
        floorName.trim() !== "") {

        const nameDiv =
            document.createElement("div");

        nameDiv.style.marginTop = "5px";

        nameDiv.textContent =
            floorName;

        floorDetails.appendChild(
            nameDiv
        );
    }
    
    function saveRoomAjax(event, form) {

        event.preventDefault();

        const formData = new FormData(form);

        const message =
            form.querySelector(".room-save-message");

        fetch(
            "${pageContext.request.contextPath}/owner/addRoomAjax",
            {
                method: "POST",
                body: formData
            }
        )
        .then(function(response) {
            return response.text();
        })
        .then(function(result) {

            result = result.trim();

            console.log("Room response:", result);

            if (result === "UNAUTHORIZED") {

                alert("Please login again.");
                return;
            }

            if (result === "FLOOR_NOT_FOUND") {

                alert("Floor not found.");
                return;
            }

            if (result === "") {

                alert("Room was not created.");
                return;
            }

            // Backend returns newly generated room ID
            const roomId = result;

            // Get values before clearing form
            const roomNumber =
                form.querySelector(
                    '[name="roomNumber"]'
                ).value;

            const sharingType =
                form.querySelector(
                    '[name="sharingType"]'
                ).value;


            // Find the rooms container
            const floorItem =
                form.closest(".floor-item");

            const roomsContainer =
                floorItem.querySelector(
                    ".dynamic-rooms"
                );


            // Remove "No rooms added yet."
            const noRooms =
                roomsContainer.querySelector("p");

            if (noRooms) {
                noRooms.remove();
            }


            // Create room
            addNewRoomToPage(
                roomsContainer,
                roomId,
                roomNumber,
                sharingType
            );


            // Clear form
            form.querySelector(
                '[name="roomNumber"]'
            ).value = "";

            form.querySelector(
                '[name="sharingType"]'
            ).value = "";


            // Show saved message
            if (message) {

                message.style.display =
                    "inline";

                setTimeout(function() {

                    message.style.display =
                        "none";

                }, 2000);
            }

        })
        .catch(function(error) {

            console.error(
                "Room AJAX error:",
                error
            );

            alert(
                "Something went wrong while adding the room."
            );

        });

        return false;
    }
    
    function addNewRoomToPage(
            roomsContainer,
            roomId,
            roomNumber,
            sharingType) {


        // =============================
        // ROOM CONTAINER
        // =============================

        const roomDiv =
            document.createElement("div");

        roomDiv.setAttribute(
            "data-room-id",
            roomId
        );

        roomDiv.style.padding =
            "15px";

        roomDiv.style.marginTop =
            "8px";

        roomDiv.style.border =
            "1px solid #ddd";

        roomDiv.style.borderRadius =
            "8px";

        roomDiv.style.background =
            "#fafafa";


        // =============================
        // ROOM HEADER
        // =============================

        const roomHeader =
            document.createElement("div");

        roomHeader.style.display =
            "flex";

        roomHeader.style.alignItems =
            "center";

        roomHeader.style.justifyContent =
            "space-between";

        roomHeader.style.gap =
            "15px";


        // Room details
        const roomDetails =
            document.createElement("div");


        const roomTitle =
            document.createElement("strong");

        roomTitle.textContent =
            "Room " + roomNumber;


        const sharingText =
            document.createElement("span");

        sharingText.style.marginLeft =
            "15px";

        sharingText.textContent =
            sharingType + " Sharing";


        roomDetails.appendChild(
            roomTitle
        );

        roomDetails.appendChild(
            sharingText
        );


        // =============================
        // ROOM ACTIONS
        // =============================

        const actions =
            document.createElement("div");

        actions.style.display =
            "flex";

        actions.style.gap =
            "8px";


        // Edit
        const editButton =
            document.createElement("button");

        editButton.type =
            "button";

        editButton.textContent =
            "✏️ Edit";

        editButton.style.padding =
            "8px 15px";

        editButton.style.border =
            "none";

        editButton.style.borderRadius =
            "6px";

        editButton.style.background =
            "#4caf50";

        editButton.style.color =
            "white";

        editButton.style.cursor =
            "pointer";


        editButton.onclick =
            function() {

                editRoom(
                    roomId,
                    roomNumber,
                    sharingType
                );

            };


        // Delete
        const deleteLink =
            document.createElement("a");

        deleteLink.textContent =
            "🗑️ Delete";

        deleteLink.href =
            "${pageContext.request.contextPath}"
            + "/owner/deleteRoom/"
            + roomId;

        deleteLink.style.padding =
            "8px 15px";

        deleteLink.style.borderRadius =
            "6px";

        deleteLink.style.textDecoration =
            "none";

        deleteLink.style.background =
            "#e53935";

        deleteLink.style.color =
            "white";


        deleteLink.onclick =
            function() {

                return confirm(
                    "Are you sure you want to delete Room "
                    + roomNumber
                    + "?"
                );

            };


        actions.appendChild(
            editButton
        );

        actions.appendChild(
            deleteLink
        );


        roomHeader.appendChild(
            roomDetails
        );

        roomHeader.appendChild(
            actions
        );


        // =============================
        // BEDS SECTION
        // =============================

        const bedsSection =
            document.createElement("div");

        bedsSection.style.marginTop =
            "15px";

        bedsSection.style.padding =
            "12px";

        bedsSection.style.borderTop =
            "1px solid #ddd";


        const bedsHeading =
            document.createElement("h4");

        bedsHeading.textContent =
            "🛏️ Beds";


        // =============================
        // ADD BED FORM
        // =============================

        const bedForm =
            document.createElement("form");

        bedForm.onsubmit =
            function(event) {

                return saveBedAjax(
                    event,
                    bedForm
                );

            };


        const roomIdInput =
            document.createElement("input");

        roomIdInput.type =
            "hidden";

        roomIdInput.name =
            "roomId";

        roomIdInput.value =
            roomId;


        const bedNumberInput =
            document.createElement("input");

        bedNumberInput.type =
            "number";

        bedNumberInput.name =
            "bedNumber";

        bedNumberInput.min =
            "1";

        bedNumberInput.placeholder =
            "Example: 1";

        bedNumberInput.required =
            true;


        const bedButton =
            document.createElement("button");

        bedButton.type =
            "submit";

        bedButton.className =
            "save-btn";

        bedButton.textContent =
            "➕ Add Bed";


        const bedMessage =
            document.createElement("span");

        bedMessage.className =
            "bed-save-message";

        bedMessage.style.display =
            "none";

        bedMessage.style.color =
            "#2e7d32";

        bedMessage.style.fontWeight =
            "bold";

        bedMessage.style.marginLeft =
            "10px";

        bedMessage.textContent =
            "✓ Saved";


        bedForm.appendChild(
            roomIdInput
        );

        bedForm.appendChild(
            bedNumberInput
        );

        bedForm.appendChild(
            bedButton
        );

        bedForm.appendChild(
            bedMessage
        );


        // =============================
        // EXISTING BEDS CONTAINER
        // =============================

        const bedsContainer =
            document.createElement("div");

        bedsContainer.className =
            "dynamic-beds";

        bedsContainer.style.marginTop =
            "15px";


        const noBeds =
            document.createElement("p");

        noBeds.style.color =
            "#777";

        noBeds.textContent =
            "No beds added yet.";


        bedsContainer.appendChild(
            noBeds
        );


        bedsSection.appendChild(
            bedsHeading
        );

        bedsSection.appendChild(
            bedForm
        );

        bedsSection.appendChild(
            bedsContainer
        );


        // =============================
        // BUILD ROOM
        // =============================

        roomDiv.appendChild(
            roomHeader
        );

        roomDiv.appendChild(
            bedsSection
        );


        roomsContainer.appendChild(
            roomDiv
        );
    }


    // Actions
    const actions =
        document.createElement("div");

    actions.style.display = "flex";
    actions.style.gap = "8px";


    // EDIT BUTTON
    const editButton =
        document.createElement("button");

    editButton.type = "button";

    editButton.textContent =
        "✏️ Edit";

    editButton.style.padding =
        "8px 15px";

    editButton.style.border =
        "none";

    editButton.style.borderRadius =
        "6px";

    editButton.style.background =
        "#4caf50";

    editButton.style.color =
        "white";

    editButton.style.cursor =
        "pointer";


    editButton.onclick =
        function() {

            editFloor(
                floorId,
                floorNumber,
                floorName
            );

        };


    // DELETE LINK
    const deleteLink =
        document.createElement("a");

    deleteLink.textContent =
        "🗑️ Delete";

    deleteLink.href =
        "${pageContext.request.contextPath}"
        + "/owner/deleteFloor/"
        + floorId;

    deleteLink.style.padding =
        "8px 15px";

    deleteLink.style.borderRadius =
        "6px";

    deleteLink.style.textDecoration =
        "none";

    deleteLink.style.background =
        "#e53935";

    deleteLink.style.color =
        "white";


    deleteLink.onclick =
        function() {

            return confirm(
                "Are you sure you want to delete Floor "
                + floorNumber
                + "?"
            );

        };


    actions.appendChild(
        editButton
    );

    actions.appendChild(
        deleteLink
    );


    floorRow.appendChild(
        floorDetails
    );

    floorRow.appendChild(
        actions
    );


    // Rooms section
    const roomsSection =
        document.createElement("div");

    roomsSection.style.marginTop =
        "20px";

    roomsSection.style.padding =
        "15px";

    roomsSection.style.borderTop =
        "1px solid #ddd";


    // =============================
    // ROOMS HEADING
    // =============================

    const roomsHeading =
        document.createElement("h3");

    roomsHeading.textContent =
        "🚪 Rooms";

    roomsSection.appendChild(
        roomsHeading
    );


    // =============================
    // ADD ROOM FORM
    // =============================

    const roomForm =
        document.createElement("form");

    roomForm.onsubmit =
        function(event) {

            return saveRoomAjax(
                event,
                roomForm
            );

        };


    // Hidden floor ID
    const floorIdInput =
        document.createElement("input");

    floorIdInput.type = "hidden";

    floorIdInput.name =
        "floorId";

    floorIdInput.value =
        floorId;

    roomForm.appendChild(
        floorIdInput
    );


    // Form grid
    const roomGrid =
        document.createElement("div");

    roomGrid.className =
        "grid";


    // =============================
    // ROOM NUMBER
    // =============================

    const roomNumberDiv =
        document.createElement("div");

    const roomNumberLabel =
        document.createElement("label");

    roomNumberLabel.textContent =
        "Room Number *";


    const roomNumberInput =
        document.createElement("input");

    roomNumberInput.type =
        "number";

    roomNumberInput.name =
        "roomNumber";

    roomNumberInput.min =
        "1";

    roomNumberInput.placeholder =
        "Example: 101";

    roomNumberInput.required =
        true;


    roomNumberDiv.appendChild(
        roomNumberLabel
    );

    roomNumberDiv.appendChild(
        roomNumberInput
    );


    // =============================
    // SHARING TYPE
    // =============================

    const sharingDiv =
        document.createElement("div");

    const sharingLabel =
        document.createElement("label");

    sharingLabel.textContent =
        "Sharing Type *";


    const sharingSelect =
        document.createElement("select");

    sharingSelect.name =
        "sharingType";

    sharingSelect.required =
        true;


    const defaultOption =
        document.createElement("option");

    defaultOption.value = "";

    defaultOption.textContent =
        "Select Sharing";

    sharingSelect.appendChild(
        defaultOption
    );


    // Sharing options
    for (
        let i = 1;
        i <= 6;
        i++
    ) {

        const option =
            document.createElement("option");

        option.value = i;

        option.textContent =
            i + " Sharing";

        sharingSelect.appendChild(
            option
        );
    }


    sharingDiv.appendChild(
        sharingLabel
    );

    sharingDiv.appendChild(
        sharingSelect
    );


    // Add fields to grid
    roomGrid.appendChild(
        roomNumberDiv
    );

    roomGrid.appendChild(
        sharingDiv
    );

    roomForm.appendChild(
        roomGrid
    );


    // =============================
    // ADD ROOM BUTTON
    // =============================

    const roomButton =
        document.createElement("button");

    roomButton.type =
        "submit";

    roomButton.className =
        "save-btn";

    roomButton.style.marginTop =
        "10px";

    roomButton.textContent =
        "➕ ADD ROOM";

    roomForm.appendChild(
        roomButton
    );


    // =============================
    // SAVE MESSAGE
    // =============================

    const roomMessage =
        document.createElement("span");

    roomMessage.className =
        "room-save-message";

    roomMessage.style.display =
        "none";

    roomMessage.style.color =
        "#2e7d32";

    roomMessage.style.fontWeight =
        "bold";

    roomMessage.style.marginLeft =
        "10px";

    roomMessage.textContent =
        "✓ Saved";

    roomForm.appendChild(
        roomMessage
    );


    roomsSection.appendChild(
        roomForm
    );


    // =============================
    // EXISTING ROOMS CONTAINER
    // =============================

    const roomsContainer =
        document.createElement("div");

    roomsContainer.className =
        "dynamic-rooms";

    roomsContainer.style.marginTop =
        "20px";


    const noRooms =
        document.createElement("p");

    noRooms.style.color =
        "#777";

    noRooms.textContent =
        "No rooms added yet.";

    roomsContainer.appendChild(
        noRooms
    );

    roomsSection.appendChild(
        roomsContainer
    );
}

</script>

</body>

</html>