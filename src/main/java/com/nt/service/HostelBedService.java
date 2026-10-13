package com.nt.service;

import java.time.LocalDate;
import java.util.List;

import org.springframework.stereotype.Service;

import com.nt.entity.HostelBedEntity;
import com.nt.entity.HostelRoomEntity;
import com.nt.repository.HostelBedRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class HostelBedService {

    private final HostelBedRepository bedRepository;


    // ==========================================
    // SAVE
    // ==========================================

    public HostelBedEntity saveBed(HostelBedEntity bed) {

        return bedRepository.save(bed);
    }


    // ==========================================
    // GET ALL
    // ==========================================

    public List<HostelBedEntity> getAllBeds() {

        return bedRepository.findAll();
    }


    // ==========================================
    // GET BY ID
    // ==========================================

    public HostelBedEntity getBedById(Long id) {

        return bedRepository.findById(id)
                .orElse(null);
    }


    // ==========================================
    // GET BY ROOM
    // ==========================================

    public List<HostelBedEntity> getBedsByRoom(
            HostelRoomEntity room) {

        return bedRepository.findByRoom(room);
    }


    // ==========================================
    // UPDATE BED
    // ==========================================

    public void updateBed(
            Long bedId,
            Integer bedNumber) {

        HostelBedEntity existingBed =
                bedRepository.findById(bedId)
                        .orElseThrow();

        existingBed.setBedNumber(bedNumber);

        bedRepository.save(existingBed);
    }
    
 // ==========================================
 // UPDATE BED STATUS
 // ==========================================

 public void updateBedStatus(
         Long bedId,
         String status,
         LocalDate availableFrom) {

     HostelBedEntity bed =
             bedRepository.findById(bedId)
                     .orElseThrow();

     bed.setStatus(status);

     if ("AVAILABLE_FROM".equals(status)) {
         bed.setAvailableFrom(availableFrom);
     } else {
         bed.setAvailableFrom(null);
     }

     bedRepository.save(bed);
 }


    // ==========================================
    // DELETE BED
    // ==========================================

    public void deleteBed(Long id) {

        bedRepository.deleteById(id);
    }
    public void deleteBedsByRoom(HostelRoomEntity room) {
        List<HostelBedEntity> beds = bedRepository.findByRoom(room);
        bedRepository.deleteAll(beds);
    }
}