package com.nt.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.nt.entity.HostelEntity;
import com.nt.entity.HostelFloorEntity;
import com.nt.repository.HostelFloorRepository;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class HostelFloorService {

    private final HostelFloorRepository floorRepository;
    
    private final HostelRoomService roomService;


    public HostelFloorEntity saveFloor(HostelFloorEntity floor) {
        return floorRepository.save(floor);
    }

    public List<HostelFloorEntity> getAllFloors() {
        return floorRepository.findAll();
    }

    public HostelFloorEntity getFloorById(Long id) {
        return floorRepository.findById(id).orElse(null);
    }

   
    public List<HostelFloorEntity> getFloorsByHostel(HostelEntity hostel) {
        return floorRepository.findByHostel(hostel);
    }
 // =====================================================
 // UPDATE FLOOR
 // =====================================================

 public void updateFloor(
         Long floorId,
         Integer floorNumber,
         String floorName) {

     HostelFloorEntity existingFloor =
             floorRepository.findById(floorId)
                     .orElseThrow();

     existingFloor.setFloorNumber(floorNumber);
     existingFloor.setFloorName(floorName);

     floorRepository.save(existingFloor);
 }


 // =====================================================
 // DELETE FLOOR
 // =====================================================

 @Transactional
 public void deleteFloor(Long id) {
     HostelFloorEntity floor = floorRepository.findById(id)
             .orElse(null);

     if (floor == null) {
         return;
     }

     roomService.deleteRoomsByFloor(floor);
     floorRepository.delete(floor);
 }
}