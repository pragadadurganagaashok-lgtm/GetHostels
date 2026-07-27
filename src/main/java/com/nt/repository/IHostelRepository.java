package com.nt.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.nt.entity.HostelEntity;
import com.nt.entity.OwnerEntity;

public interface IHostelRepository extends JpaRepository<HostelEntity, Long> {

    // Display all hostels of a particular owner
    List<HostelEntity> findByOwner(OwnerEntity owner);
    List<HostelEntity> findByStatus(String status);

}