package com.nt.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nt.entity.HostelEntity;
import com.nt.entity.OwnerEntity;
import com.nt.repository.IHostelRepository;

@Service
public class HostelMgmtServiceImpl implements IHostelMgmtService {

    @Autowired
    private IHostelRepository hostelRepo;


    @Override
    public HostelEntity saveHostel(HostelEntity hostel) {

        return hostelRepo.save(hostel);

    }

    @Override
    public List<HostelEntity> getHostelsByOwner(OwnerEntity owner) {

        return hostelRepo.findByOwner(owner);

    }

    @Override
    public HostelEntity getHostelById(Long id) {

        return hostelRepo.findById(id).orElse(null);

    }

    @Override
    public void deleteHostel(Long id) {

        hostelRepo.deleteById(id);

    }
    @Override
    public List<HostelEntity> getAllActiveHostels() {

        return hostelRepo.findByStatus("ACTIVE");

    }
    @Override
    public void updateHostel(HostelEntity updatedHostel) {

        HostelEntity existingHostel =
                hostelRepo.findById(updatedHostel.getHostelId())
                           .orElseThrow();

        existingHostel.setHostelName(updatedHostel.getHostelName());
        existingHostel.setHostelType(updatedHostel.getHostelType());
        existingHostel.setDescription(updatedHostel.getDescription());

        existingHostel.setState(updatedHostel.getState());
        existingHostel.setCity(updatedHostel.getCity());
        existingHostel.setArea(updatedHostel.getArea());
        existingHostel.setAddress(updatedHostel.getAddress());
        existingHostel.setLandmark(updatedHostel.getLandmark());
        existingHostel.setPincode(updatedHostel.getPincode());
        existingHostel.setGoogleMapLink(updatedHostel.getGoogleMapLink());
        existingHostel.setLatitude(updatedHostel.getLatitude());
        existingHostel.setLongitude(updatedHostel.getLongitude());

        existingHostel.setOwnerPhone(updatedHostel.getOwnerPhone());
        existingHostel.setAlternatePhone(updatedHostel.getAlternatePhone());

        existingHostel.setTotalBeds(updatedHostel.getTotalBeds());
        existingHostel.setAvailableBeds(updatedHostel.getAvailableBeds());

        existingHostel.setAdvanceAmount(updatedHostel.getAdvanceAmount());
        existingHostel.setReturnAmount(updatedHostel.getReturnAmount());
        existingHostel.setDayStayPrice(updatedHostel.getDayStayPrice());

        existingHostel.setOneSharingPrice(updatedHostel.getOneSharingPrice());
        existingHostel.setTwoSharingPrice(updatedHostel.getTwoSharingPrice());
        existingHostel.setThreeSharingPrice(updatedHostel.getThreeSharingPrice());
        existingHostel.setFourSharingPrice(updatedHostel.getFourSharingPrice());
        existingHostel.setFiveSharingPrice(updatedHostel.getFiveSharingPrice());
        existingHostel.setSixSharingPrice(updatedHostel.getSixSharingPrice());

        existingHostel.setWifi(updatedHostel.getWifi());
        existingHostel.setFood(updatedHostel.getFood());
        existingHostel.setAc(updatedHostel.getAc());
        existingHostel.setLaundry(updatedHostel.getLaundry());
        existingHostel.setParking(updatedHostel.getParking());
        existingHostel.setCctv(updatedHostel.getCctv());
        existingHostel.setLift(updatedHostel.getLift());
        existingHostel.setGym(updatedHostel.getGym());
        existingHostel.setPowerBackup(updatedHostel.getPowerBackup());
        existingHostel.setHotWater(updatedHostel.getHotWater());
        existingHostel.setWashingMachine(updatedHostel.getWashingMachine());
        existingHostel.setRefrigerator(updatedHostel.getRefrigerator());
        existingHostel.setHousekeeping(updatedHostel.getHousekeeping());
        existingHostel.setStudyRoom(updatedHostel.getStudyRoom());
        existingHostel.setBalcony(updatedHostel.getBalcony());
        existingHostel.setAttachedBathroom(updatedHostel.getAttachedBathroom());

        // Keep image
        existingHostel.setCoverImage(updatedHostel.getCoverImage());

        hostelRepo.save(existingHostel);
    }

}