<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>${hostel.hostelName} - Available Beds</title>

<link rel="stylesheet"
    href="${pageContext.request.contextPath}/css/style.css">

<style>
.beds-page {
    max-width: 1100px;
    margin: 30px auto;
    padding: 20px;
}
.beds-header {
    background: #f0f6ff;
    padding: 24px;
    border-radius: 12px;
    margin-bottom: 25px;
}
.floor-card {
    border: 1px solid #ddd;
    border-radius: 12px;
    padding: 20px;
    margin-bottom: 24px;
}
.room-card {
    background: #fafafa;
    border: 1px solid #e5e5e5;
    border-radius: 10px;
    padding: 16px;
    margin: 16px 0;
}
.bed-list {
    display: flex;
    flex-wrap: wrap;
    gap: 12px;
    margin-top: 14px;
}
.bed-item {
    min-width: 110px;
    padding: 14px;
    border-radius: 9px;
    text-align: center;
    border: 1px solid #ddd;
}
.available {
    background: #e6f8ec;
    border-color: #36a563;
}
.occupied {
    background: #ffe8e8;
    border-color: #df6464;
}
.future {
    background: #fff3d6;
    border-color: #e6b94f;
}
.empty-message {
    color: #666;
    padding: 12px 0;
}
.back-link {
    display: inline-block;
    margin-bottom: 18px;
}
</style>
</head>

<body>

<div class="beds-page">

    <a class="back-link"
       href="${pageContext.request.contextPath}/">
        ← Back to hostels
    </a>

    <div class="beds-header">
        <h1>${hostel.hostelName}</h1>
        <p>📍 ${hostel.area}, ${hostel.city}</p>
        <p>Explore floors, rooms and individual bed availability.</p>
    </div>

    <h2>Floors and Rooms</h2>

    <c:choose>
        <c:when test="${empty floors}">
            <p class="empty-message">
                No floors have been added to this hostel yet.
            </p>
        </c:when>

        <c:otherwise>
            <c:forEach items="${floors}" var="floor">

                <section class="floor-card">
                    <h2>
                        ${empty floor.floorName
                            ? 'Floor '.concat(floor.floorNumber)
                            : floor.floorName}
                    </h2>

                    <c:set var="rooms"
                        value="${roomsByFloor[floor.floorId]}" />

                    <c:choose>
                        <c:when test="${empty rooms}">
                            <p class="empty-message">
                                No rooms on this floor yet.
                            </p>
                        </c:when>

                        <c:otherwise>
                            <c:forEach items="${rooms}" var="room">

                                <div class="room-card">
                                    <h3>
                                        Room ${room.roomNumber}
                                        · ${room.sharingType}-sharing
                                    </h3>

                                    <c:set var="beds"
                                        value="${bedsByRoom[room.roomId]}" />

                                    <c:choose>
                                        <c:when test="${empty beds}">
                                            <p class="empty-message">
                                                No beds added to this room yet.
                                            </p>
                                        </c:when>

                                        <c:otherwise>
                                            <div class="bed-list">

                                                <c:forEach items="${beds}"
                                                    var="bed">

                                                    <div class="bed-item
                                                        ${bed.status eq 'AVAILABLE'
                                                            ? 'available'
                                                            : bed.status eq 'OCCUPIED'
                                                                ? 'occupied'
                                                                : 'future'}">

                                                        <strong>
                                                            Bed ${bed.bedNumber}
                                                        </strong>

                                                        <p>${bed.status}</p>

                                                        <c:if test="${bed.status eq 'AVAILABLE_FROM'
                                                            and not empty bed.availableFrom}">
                                                            <small>
                                                                From ${bed.availableFrom}
                                                            </small>
                                                        </c:if>

                                                    </div>

                                                </c:forEach>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>

                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </section>

            </c:forEach>
        </c:otherwise>
    </c:choose>

</div>

</body>
</html>