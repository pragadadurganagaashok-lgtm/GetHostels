package com.nt.entity;

import java.time.LocalDateTime;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@Table(name = "hostelGH")
@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class HostelEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "hostel_id")
    private Long hostelId;

    // ===========================
    // OWNER
    // ===========================

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "owner_id", nullable = false)
    private OwnerEntity owner;

    // ===========================
    // BASIC DETAILS
    // ===========================

    @Column(nullable = false, length = 150)
    private String hostelName;

    @Column(nullable = false, length = 20)
    private String hostelType;     // Boys, Girls, Co-Live

    @Column(length = 500)
    private String description;

    // ===========================
    // LOCATION
    // ===========================

    @Column(nullable = false, length = 50)
    private String state;

    @Column(nullable = false, length = 50)
    private String city;

    @Column(nullable = false, length = 80)
    private String area;

    @Column(nullable = false, length = 300)
    private String address;

    @Column(length = 150)
    private String landmark;

    @Column(length = 10)
    private String pincode;

    private Double latitude;

    private Double longitude;
    
    @Transient
    private Double distance;
    
    @Column(length = 1000)
    private String googleMapLink;

    // ===========================
    // CONTACT
    // ===========================

    @Column(nullable = false, length = 15)
    private String ownerPhone;

    @Column(length = 15)
    private String alternatePhone;

    // ===========================
    // BED DETAILS
    // ===========================

    private Integer totalBeds;

    private Integer availableBeds;

    // ===========================
    // PRICING
    // ===========================

    private Double advanceAmount;

    private Double returnAmount;

    private Double dayStayPrice;

    private Double oneSharingPrice;

    private Double twoSharingPrice;

    private Double threeSharingPrice;

    private Double fourSharingPrice;

    private Double fiveSharingPrice;

    private Double sixSharingPrice;

    // ===========================
    // FACILITIES
    // ===========================

    private Boolean wifi;

    private Boolean food;

    private Boolean ac;

    private Boolean laundry;

    private Boolean parking;

    private Boolean cctv;

    private Boolean lift;

    private Boolean gym;

    private Boolean powerBackup;

    private Boolean hotWater;

    private Boolean washingMachine;

    private Boolean refrigerator;

    private Boolean housekeeping;

    private Boolean studyRoom;

    private Boolean balcony;

    private Boolean attachedBathroom;
    
    // COVER image
    @Column(length = 300)
    private String coverImage;

    // ===========================
    // STATUS
    // ===========================

    @Column(length = 20)
    private String status = "ACTIVE";
    
    private String hostelGender;     // Boys, Girls, Co-Live
    //Ratings
    private Boolean verified;

    private Double rating;

    private Integer reviewCount;

    private Boolean availableToday;

    // ===========================
    // AUDIT
    // ===========================

    @CreationTimestamp
    @Column(updatable = false)
    private LocalDateTime createdAt;

    @UpdateTimestamp
    private LocalDateTime updatedAt;

    @Version
    private Integer version;

}