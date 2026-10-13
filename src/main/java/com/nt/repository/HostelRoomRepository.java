package com.nt.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.nt.entity.HostelFloorEntity;
import com.nt.entity.HostelRoomEntity;

public interface HostelRoomRepository
        extends JpaRepository<HostelRoomEntity, Long> {

    List<HostelRoomEntity> findByFloor(HostelFloorEntity floor);
}