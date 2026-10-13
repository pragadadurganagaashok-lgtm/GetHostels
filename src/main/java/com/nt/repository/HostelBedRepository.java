package com.nt.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.nt.entity.HostelBedEntity;
import com.nt.entity.HostelRoomEntity;

public interface HostelBedRepository
        extends JpaRepository<HostelBedEntity, Long> {

    List<HostelBedEntity> findByRoom(
            HostelRoomEntity room);
}