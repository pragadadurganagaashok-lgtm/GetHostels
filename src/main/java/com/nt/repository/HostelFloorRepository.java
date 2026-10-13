package com.nt.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.nt.entity.HostelEntity;
import com.nt.entity.HostelFloorEntity;

public interface HostelFloorRepository
        extends JpaRepository<HostelFloorEntity, Long> {

    List<HostelFloorEntity> findByHostel(HostelEntity hostel);
}