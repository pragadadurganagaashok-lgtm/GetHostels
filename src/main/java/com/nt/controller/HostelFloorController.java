package com.nt.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nt.entity.HostelEntity;
import com.nt.entity.HostelFloorEntity;
import com.nt.service.HostelFloorService;
import com.nt.service.IHostelMgmtService;
import java.util.List;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import jakarta.servlet.http.HttpSession;

@Controller
public class HostelFloorController {

    private final HostelFloorService floorService;
    private final IHostelMgmtService hostelService;

    public HostelFloorController(
            HostelFloorService floorService,
            IHostelMgmtService hostelService) {

        this.floorService = floorService;
        this.hostelService = hostelService;
    }

    @PostMapping("/owner/addFloor")
    public String addFloor(
            @RequestParam Long hostelId,
            @RequestParam Integer floorNumber,
            @RequestParam(required = false) String floorName,
            HttpSession session) {

        if (session.getAttribute("owner") == null) {
            return "redirect:/owner/login";
        }

        HostelEntity hostel =
                hostelService.getHostelById(hostelId);

        if (hostel == null) {
            return "redirect:/owner/myHostels";
        }

        HostelFloorEntity floor = new HostelFloorEntity();

        floor.setHostel(hostel);
        floor.setFloorNumber(floorNumber);
        floor.setFloorName(floorName);

        floorService.saveFloor(floor);

        return "redirect:/owner/editHostel/" + hostelId;
    }
 // =====================================================
 // UPDATE FLOOR
 // =====================================================

 @PostMapping("/owner/updateFloor")
 public String updateFloor(
         @RequestParam Long floorId,
         @RequestParam Integer floorNumber,
         @RequestParam(required = false) String floorName,
         HttpSession session) {

     if (session.getAttribute("owner") == null) {
         return "redirect:/owner/login";
     }

     HostelFloorEntity floor =
             floorService.getFloorById(floorId);

     if (floor == null) {
         return "redirect:/owner/myHostels";
     }

     Long hostelId =
             floor.getHostel()
                  .getHostelId();

     floorService.updateFloor(
             floorId,
             floorNumber,
             floorName);

     return "redirect:/owner/editHostel/"
             + hostelId;
 }


 // =====================================================
 // DELETE FLOOR
 // =====================================================

 @GetMapping("/owner/deleteFloor/{id}")
 public String deleteFloor(
         @PathVariable Long id,
         HttpSession session) {

     if (session.getAttribute("owner") == null) {
         return "redirect:/owner/login";
     }

     HostelFloorEntity floor =
             floorService.getFloorById(id);

     if (floor == null) {
         return "redirect:/owner/myHostels";
     }

     Long hostelId =
             floor.getHostel()
                  .getHostelId();

     floorService.deleteFloor(id);

     return "redirect:/owner/editHostel/"
             + hostelId;
 }
 @PostMapping("/owner/addFloorAjax")
 @ResponseBody
 public String addFloorAjax(
         @RequestParam Long hostelId,
         @RequestParam Integer floorNumber,
         @RequestParam(required = false) String floorName,
         HttpSession session) {

     if (session.getAttribute("owner") == null) {
         return "UNAUTHORIZED";
     }

     HostelEntity hostel =
             hostelService.getHostelById(hostelId);

     if (hostel == null) {
         return "HOSTEL_NOT_FOUND";
     }

     HostelFloorEntity floor =
             new HostelFloorEntity();

     floor.setHostel(hostel);
     floor.setFloorNumber(floorNumber);
     floor.setFloorName(floorName);

     floorService.saveFloor(floor);

     return String.valueOf(floor.getFloorId());
 }
    
}