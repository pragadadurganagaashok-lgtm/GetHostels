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

            OwnerEntity owner = (OwnerEntity) session.getAttribute("owner");

            if (owner == null) {
                return "redirect:/owner/login";
            }

            hostel.setOwner(owner);

            // Upload image to Cloudinary
            if (image != null && !image.isEmpty()) {

                String imageUrl = cloudinaryService.uploadImage(image);

                hostel.setCoverImage(imageUrl);
            }

            hostelService.saveHostel(hostel);

            System.out.println("Hostel Saved Successfully");

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "redirect:/owner/myHostels";
    }

    // =====================================================
    // MY HOSTELS
    // =====================================================

    @GetMapping("/myHostels")
    public String showMyHostels(HttpSession session, Model model) {

        OwnerEntity owner = (OwnerEntity) session.getAttribute("owner");

        if (owner == null) {
            return "redirect:/owner/login";
        }

        List<HostelEntity> hostelList =
                hostelService.getHostelsByOwner(owner);

        model.addAttribute("hostels", hostelList);

        return "my_hostels";
    }

    // =====================================================
    // EDIT HOSTEL PAGE
    // =====================================================

    @GetMapping("/editHostel/{id}")
    public String showEditHostelPage(
            @PathVariable("id") Long id,
            HttpSession session,
            Model model) {

        OwnerEntity owner = (OwnerEntity) session.getAttribute("owner");

        if (owner == null) {
            return "redirect:/owner/login";
        }

        HostelEntity hostel = hostelService.getHostelById(id);

        if (hostel == null) {
            return "redirect:/owner/myHostels";
        }

        model.addAttribute("hostel", hostel);

        return "add_hostel";
    }

    // =====================================================
    // UPDATE HOSTEL
    // =====================================================

    @PostMapping("/updateHostel")
    public String updateHostel(
            @ModelAttribute HostelEntity hostel,
            @RequestParam(value = "image", required = false) MultipartFile image,
            HttpSession session) {

        try {

            OwnerEntity owner = (OwnerEntity) session.getAttribute("owner");

            if (owner == null) {
                return "redirect:/owner/login";
            }

            HostelEntity existingHostel =
                    hostelService.getHostelById(hostel.getHostelId());

            if (existingHostel == null) {
                return "redirect:/owner/myHostels";
            }

            hostel.setOwner(owner);

            // Keep existing image
            hostel.setCoverImage(existingHostel.getCoverImage());

            // Replace image only if a new one is selected
            if (image != null && !image.isEmpty()) {

                String imageUrl = cloudinaryService.uploadImage(image);

                hostel.setCoverImage(imageUrl);
            }

            hostelService.updateHostel(hostel);

            System.out.println("Hostel Updated Successfully");

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

        OwnerEntity owner = (OwnerEntity) session.getAttribute("owner");

        if (owner == null) {
            return "redirect:/owner/login";
        }

        hostelService.deleteHostel(id);

        return "redirect:/owner/myHostels";
    }

}