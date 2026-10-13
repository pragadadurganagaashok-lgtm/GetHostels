package com.nt.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "hostel_floor")
@Data
public class HostelFloorEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "floor_id")
    private Long floorId;

    @ManyToOne
    @JoinColumn(name = "hostel_id", nullable = false)
    private HostelEntity hostel;

    @Column(name = "floor_number", nullable = false)
    private Integer floorNumber;

    @Column(name = "floor_name")
    private String floorName;
}