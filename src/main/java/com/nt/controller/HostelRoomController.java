package com.nt.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nt.entity.HostelFloorEntity;
import com.nt.entity.HostelRoomEntity;
import com.nt.service.HostelFloorService;
import com.nt.service.HostelRoomService;

import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class HostelRoomController {

    private final HostelRoomService roomService;
    private final HostelFloorService floorService;

    @PostMapping("/owner/addRoom")
    public String addRoom(
            @RequestParam Long floorId,
            @RequestParam Integer roomNumber,
            @RequestParam Integer sharingType,
            HttpSession session) {

        // Owner login check
        if (session.getAttribute("owner") == null) {
            return "redirect:/owner/login";
        }

        // Find floor
        HostelFloorEntity floor =
                floorService.getFloorById(floorId);

        if (floor == null) {
            return "redirect:/owner/myHostels";
        }

        // Create room
        HostelRoomEntity room =
                new HostelRoomEntity();

        room.setFloor(floor);
        room.setRoomNumber(roomNumber);
        room.setSharingType(sharingType);

        // Save room
        roomService.saveRoom(room);

        // Return to hostel edit page
        return "redirect:/owner/editHostel/"
                + floor.getHostel().getHostelId();
    }
 // =====================================================
 // EDIT ROOM
 // =====================================================

 @PostMapping("/owner/updateRoom")
 public String updateRoom(
         @RequestParam Long roomId,
         @RequestParam Integer roomNumber,
         @RequestParam Integer sharingType,
         HttpSession session) {

     if (session.getAttribute("owner") == null) {
         return "redirect:/owner/login";
     }

     HostelRoomEntity room =
             roomService.getRoomById(roomId);

     if (room == null) {
         return "redirect:/owner/myHostels";
     }

     roomService.updateRoom(
             roomId,
             roomNumber,
             sharingType);

     return "redirect:/owner/editHostel/"
             + room.getFloor()
                   .getHostel()
                   .getHostelId();
 }


 // =====================================================
 // DELETE ROOM
 // =====================================================

 @GetMapping("/owner/deleteRoom/{id}")
 public String deleteRoom(
         @PathVariable Long id,
         HttpSession session) {

     if (session.getAttribute("owner") == null) {
         return "redirect:/owner/login";
     }

     HostelRoomEntity room =
             roomService.getRoomById(id);

     if (room == null) {
         return "redirect:/owner/myHostels";
     }

     Long hostelId =
             room.getFloor()
                 .getHostel()
                 .getHostelId();

     roomService.deleteRoom(id);

     return "redirect:/owner/editHostel/"
             + hostelId;
 }
 @PostMapping("/owner/addRoomAjax")
 @ResponseBody
 public String addRoomAjax(
         @RequestParam Long floorId,
         @RequestParam Integer roomNumber,
         @RequestParam Integer sharingType,
         HttpSession session) {

     if (session.getAttribute("owner") == null) {
         return "UNAUTHORIZED";
     }

     HostelFloorEntity floor =
             floorService.getFloorById(floorId);

     if (floor == null) {
         return "FLOOR_NOT_FOUND";
     }

     HostelRoomEntity room =
             new HostelRoomEntity();

     room.setFloor(floor);
     room.setRoomNumber(roomNumber);
     room.setSharingType(sharingType);

     roomService.saveRoom(room);

     // Return newly generated room ID
     return String.valueOf(room.getRoomId());
 }
 
}