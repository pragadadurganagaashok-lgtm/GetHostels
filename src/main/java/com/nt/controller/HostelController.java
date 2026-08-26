package com.nt.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.nt.entity.HostelEntity;
import com.nt.entity.OwnerEntity;
import com.nt.service.CloudinaryService;
import com.nt.service.IHostelMgmtService;
import com.nt.util.GoogleMapUtil;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/owner")
public class HostelController {

    @Autowired
    private IHostelMgmtService hostelService;

    @Autowired
    private CloudinaryService cloudinaryService;

    // =====================================================
    // ADD HOSTEL PAGE
    // =====================================================

    @GetMapping("/addHostel")
    public String showAddHostelPage(HttpSession session) {

        if (session.getAttribute("owner") == null) {
            return "redirect:/owner/login";
        }

        return "add_hostel";
    }

    // =====================================================
    // SAVE HOSTEL
    // =====================================================

    @PostMapping("/saveHostel")
    public String saveHostel(
            @ModelAttribute HostelEntity hostel,
            @RequestParam(value = "image", required = false) MultipartFile image,
            HttpSession session) {

        try {

            // -------------------------------------------------
            // CHECK OWNER LOGIN
            // -------------------------------------------------

            OwnerEntity owner =
                    (OwnerEntity) session.getAttribute("owner");

            if (owner == null) {
                return "redirect:/owner/login";
            }

            hostel.setOwner(owner);

            // =================================================
            // GOOGLE MAP LOCATION
            // =================================================

            if (hostel.getGoogleMapLink() != null
                    && !hostel.getGoogleMapLink().isBlank()) {

                System.out.println(
                        "========== GOOGLE MAP LOCATION ==========");

                System.out.println(
                        "Google Map URL : "
                        + hostel.getGoogleMapLink());

                double[] coordinates =
                        GoogleMapUtil.extractCoordinates(
                                hostel.getGoogleMapLink());

                if (coordinates != null) {

                    hostel.setLatitude(coordinates[0]);

                    hostel.setLongitude(coordinates[1]);

                    System.out.println(
                            "Latitude  : "
                            + hostel.getLatitude());

                    System.out.println(
                            "Longitude : "
                            + hostel.getLongitude());

                } else {

                    System.out.println(
                            "Could not extract latitude/longitude from Google Map URL.");
                }

                System.out.println(
                        "==========================================");
            }

            // =================================================
            // CLOUDINARY IMAGE UPLOAD
            // =================================================

            if (image != null && !image.isEmpty()) {

                System.out.println(
                        "========== IMAGE UPLOAD START ==========");

                System.out.println(
                        "Original File : "
                        + image.getOriginalFilename());

                System.out.println(
                        "File Size     : "
                        + image.getSize());

                String imageUrl =
                        cloudinaryService.uploadImage(image);

                System.out.println(
                        "Cloudinary URL : "
                        + imageUrl);

                hostel.setCoverImage(imageUrl);

                System.out.println(
                        "Hostel Cover Image : "
                        + hostel.getCoverImage());

                System.out.println(
                        "========== IMAGE UPLOAD END ==========");

            } else {

                System.out.println(
                        "NO IMAGE SELECTED");
            }

            // =================================================
            // SAVE HOSTEL
            // =================================================

            HostelEntity saved =
                    hostelService.saveHostel(hostel);

            System.out.println(
                    "========== HOSTEL SAVED ==========");

            System.out.println(
                    "Hostel Name : "
                    + saved.getHostelName());

            System.out.println(
                    "Latitude   : "
                    + saved.getLatitude());

            System.out.println(
                    "Longitude  : "
                    + saved.getLongitude());

            System.out.println(
                    "CoverImage : "
                    + saved.getCoverImage());

            System.out.println(
                    "===================================");

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "redirect:/owner/myHostels";
    }

    // =====================================================
    // MY HOSTELS
    // =====================================================

    @GetMapping("/myHostels")
    public String showMyHostels(
            HttpSession session,
            Model model) {

        OwnerEntity owner =
                (OwnerEntity) session.getAttribute("owner");

        if (owner == null) {
            return "redirect:/owner/login";
        }

        List<HostelEntity> hostelList =
                hostelService.getHostelsByOwner(owner);

        for (HostelEntity h : hostelList) {

            System.out.println(
                    "-------------------------------");

            System.out.println(
                    "Hostel : "
                    + h.getHostelName());

            System.out.println(
                    "CoverImage : "
                    + h.getCoverImage());

            System.out.println(
                    "Latitude : "
                    + h.getLatitude());

            System.out.println(
                    "Longitude : "
                    + h.getLongitude());

            System.out.println(
                    "Google Map : "
                    + h.getGoogleMapLink());

            System.out.println(
                    "-------------------------------");
        }

        model.addAttribute(
                "hostels",
                hostelList);

        return "my_hostels";
    }

    // =====================================================
    // EDIT HOSTEL
    // =====================================================

    @GetMapping("/editHostel/{id}")
    public String showEditHostelPage(
            @PathVariable("id") Long id,
            HttpSession session,
            Model model) {

        OwnerEntity owner =
                (OwnerEntity) session.getAttribute("owner");

        if (owner == null) {
            return "redirect:/owner/login";
        }

        HostelEntity hostel =
                hostelService.getHostelById(id);

        if (hostel == null) {
            return "redirect:/owner/myHostels";
        }

        model.addAttribute(
                "hostel",
                hostel);

        return "add_hostel";
    }

    // =====================================================
    // UPDATE HOSTEL
    // =====================================================

    @PostMapping("/updateHostel")
    public String updateHostel(
            @ModelAttribute HostelEntity hostel,
            @RequestParam(value = "image", required = false)
            MultipartFile image,
            HttpSession session) {

        try {

            OwnerEntity owner =
                    (OwnerEntity) session.getAttribute("owner");

            if (owner == null) {
                return "redirect:/owner/login";
            }

            HostelEntity existingHostel =
                    hostelService.getHostelById(
                            hostel.getHostelId());

            if (existingHostel == null) {
                return "redirect:/owner/myHostels";
            }

            // -------------------------------------------------
            // OWNER
            // -------------------------------------------------

            hostel.setOwner(owner);

            // -------------------------------------------------
            // KEEP OLD IMAGE
            // -------------------------------------------------

            hostel.setCoverImage(
                    existingHostel.getCoverImage());

            // =================================================
            // GOOGLE MAP LOCATION
            // =================================================

            if (hostel.getGoogleMapLink() != null
                    && !hostel.getGoogleMapLink().isBlank()) {

                System.out.println(
                        "========== UPDATING LOCATION ==========");

                System.out.println(
                        "Google Map URL : "
                        + hostel.getGoogleMapLink());

                double[] coordinates =
                        GoogleMapUtil.extractCoordinates(
                                hostel.getGoogleMapLink());

                if (coordinates != null) {

                    hostel.setLatitude(
                            coordinates[0]);

                    hostel.setLongitude(
                            coordinates[1]);

                    System.out.println(
                            "New Latitude : "
                            + hostel.getLatitude());

                    System.out.println(
                            "New Longitude : "
                            + hostel.getLongitude());

                } else {

                    // Keep existing coordinates if
                    // the new URL cannot be processed.

                    hostel.setLatitude(
                            existingHostel.getLatitude());

                    hostel.setLongitude(
                            existingHostel.getLongitude());

                    System.out.println(
                            "Could not extract new coordinates.");
                    System.out.println(
                            "Keeping existing coordinates.");
                }

                System.out.println(
                        "=======================================");
            } else {

                // No new Google Maps URL supplied.
                // Keep existing location.

                hostel.setLatitude(
                        existingHostel.getLatitude());

                hostel.setLongitude(
                        existingHostel.getLongitude());
            }

            // =================================================
            // NEW CLOUDINARY IMAGE
            // =================================================

            if (image != null && !image.isEmpty()) {

                System.out.println(
                        "Updating image...");

                String imageUrl =
                        cloudinaryService.uploadImage(image);

                System.out.println(
                        "New Cloudinary URL : "
                        + imageUrl);

                hostel.setCoverImage(
                        imageUrl);
            }

            // =================================================
            // UPDATE DATABASE
            // =================================================

            hostelService.updateHostel(hostel);

            System.out.println(
                    "Hostel Updated Successfully");

            System.out.println(
                    "Updated Cover Image : "
                    + hostel.getCoverImage());

            System.out.println(
                    "Updated Latitude : "
                    + hostel.getLatitude());

            System.out.println(
                    "Updated Longitude : "
                    + hostel.getLongitude());

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "redirect:/owner/myHostels";
    }

    // =====================================================
    // DELETE HOSTEL
    // =====================================================

    @GetMapping("/deleteHostel/{id}")
    public String deleteHostel(
            @PathVariable("id") Long id,
            HttpSession session) {

        OwnerEntity owner =
                (OwnerEntity) session.getAttribute("owner");

        if (owner == null) {
            return "redirect:/owner/login";
        }

        hostelService.deleteHostel(id);

        return "redirect:/owner/myHostels";
    }
}