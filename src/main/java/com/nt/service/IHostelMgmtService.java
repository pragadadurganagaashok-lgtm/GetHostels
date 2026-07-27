package com.nt.service;

import java.util.List;

import com.nt.entity.HostelEntity;
import com.nt.entity.OwnerEntity;

public interface IHostelMgmtService {

	 HostelEntity saveHostel(HostelEntity hostel);

    List<HostelEntity> getHostelsByOwner(OwnerEntity owner);
    List<HostelEntity> getAllActiveHostels();

    HostelEntity getHostelById(Long id);

    void deleteHostel(Long id);
    void updateHostel(HostelEntity hostel);
    

}