package com.nt.entity;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Table(name = "hostel_room")
@Data
public class HostelRoomEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "room_id")
    private Long roomId;

    @ManyToOne
    @JoinColumn(name = "floor_id", nullable = false)
    private HostelFloorEntity floor;

    @Column(name = "room_number", nullable = false)
    private Integer roomNumber;

    @Column(name = "sharing_type", nullable = false)
    private Integer sharingType;
}