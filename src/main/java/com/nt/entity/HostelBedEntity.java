package com.nt.entity;

import java.time.LocalDate;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "hostel_bed")
@Data
public class HostelBedEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "bed_id")
    private Long bedId;

    @ManyToOne
    @JoinColumn(name = "room_id", nullable = false)
    private HostelRoomEntity room;

    @Column(name = "bed_number", nullable = false)
    private Integer bedNumber;

    @Column(name = "status", nullable = false)
    private String status;

    @Column(name = "available_from")
    private LocalDate availableFrom;
}