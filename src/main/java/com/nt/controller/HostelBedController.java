package com.nt.controller;

import java.time.LocalDate;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.nt.entity.HostelBedEntity;
import com.nt.entity.HostelRoomEntity;
import com.nt.service.HostelBedService;
import com.nt.service.HostelRoomService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class HostelBedController {

    private final HostelBedService bedService;

    private final HostelRoomService roomService;


    // ==========================================
    // ADD BED
    // ==========================================

    @PostMapping("/owner/addBed")
    public String addBed(
            @RequestParam Long roomId,
            @RequestParam Integer bedNumber,
            HttpSession session) {

        // Owner login check
        if (session.getAttribute("owner") == null) {
            return "redirect:/owner/login";
        }

        // Find room
        HostelRoomEntity room =
                roomService.getRoomById(roomId);

        if (room == null) {
            return "redirect:/owner/myHostels";
        }

        // Create bed
        HostelBedEntity bed =
                new HostelBedEntity();

        bed.setRoom(room);

        bed.setBedNumber(bedNumber);

        // Initially every new bed is available
        bed.setStatus("AVAILABLE");

        // No available-from date initially
        bed.setAvailableFrom(null);

        // Save
        bedService.saveBed(bed);

        // Return to hostel edit page
        return "redirect:/owner/editHostel/"
                + room.getFloor()
                      .getHostel()
                      .getHostelId();
    }
 // ==========================================
 // UPDATE BED
 // ==========================================

 @PostMapping("/owner/updateBed")
 public String updateBed(
         @RequestParam Long bedId,
         @RequestParam Integer bedNumber,
         HttpSession session) {

     if (session.getAttribute("owner") == null) {
         return "redirect:/owner/login";
     }

     HostelBedEntity bed =
             bedService.getBedById(bedId);

     if (bed == null) {
         return "redirect:/owner/myHostels";
     }

     Long hostelId =
             bed.getRoom()
                .getFloor()
                .getHostel()
                .getHostelId();

     bedService.updateBed(
             bedId,
             bedNumber);

     return "redirect:/owner/editHostel/"
             + hostelId;
 }


 // ==========================================
 // DELETE BED
 // ==========================================

 @GetMapping("/owner/deleteBed/{id}")
 public String deleteBed(
         @PathVariable Long id,
         HttpSession session) {

     if (session.getAttribute("owner") == null) {
         return "redirect:/owner/login";
     }

     HostelBedEntity bed =
             bedService.getBedById(id);

     if (bed == null) {
         return "redirect:/owner/myHostels";
     }

     Long hostelId =
             bed.getRoom()
                .getFloor()
                .getHostel()
                .getHostelId();

     bedService.deleteBed(id);

     return "redirect:/owner/editHostel/"
             + hostelId;
 }
//==========================================
//UPDATE BED STATUS
//==========================================

@PostMapping("/owner/updateBedStatus")
public String updateBedStatus(
      @RequestParam Long bedId,
      @RequestParam String status,
      @RequestParam(required = false) LocalDate availableFrom,
      HttpSession session) {

  if (session.getAttribute("owner") == null) {
      return "redirect:/owner/login";
  }

  HostelBedEntity bed =
          bedService.getBedById(bedId);

  if (bed == null) {
      return "redirect:/owner/myHostels";
  }

  Long hostelId =
          bed.getRoom()
             .getFloor()
             .getHostel()
             .getHostelId();

  bedService.updateBedStatus(
          bedId,
          status,
          availableFrom);

  return "redirect:/owner/editHostel/"
          + hostelId;
}

@PostMapping("/owner/updateBedStatusAjax")
@ResponseBody
public String updateBedStatusAjax(
        @RequestParam Long bedId,
        @RequestParam String status,
        @RequestParam(required = false) String availableFrom,
        HttpSession session) {

    if (session.getAttribute("owner") == null) {
        return "UNAUTHORIZED";
    }

    HostelBedEntity bed =
            bedService.getBedById(bedId);

    if (bed == null) {
        return "BED_NOT_FOUND";
    }

    LocalDate date = null;

    if (availableFrom != null && !availableFrom.isBlank()) {
        date = LocalDate.parse(availableFrom);
    }

    bedService.updateBedStatus(
            bedId,
            status,
            date);

    return "SUCCESS";
}
}
