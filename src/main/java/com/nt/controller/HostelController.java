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

    @GetMapping("/addHostel")
    public String showAddHostelPage(HttpSession session) {

        if (session.getAttribute("owner") == null) {
            return "redirect:/owner/login";
        }

        return "add_hostel";
    }

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

            if (image != null && !image.isEmpty()) {

                System.out.println("========== IMAGE UPLOAD START ==========");
                System.out.println("Original File : " + image.getOriginalFilename());
                System.out.println("File Size     : " + image.getSize());

                String imageUrl = cloudinaryService.uploadImage(image);

                System.out.println("Cloudinary URL : " + imageUrl);

                hostel.setCoverImage(imageUrl);

                System.out.println("Hostel Cover Image : " + hostel.getCoverImage());

                System.out.println("========== IMAGE UPLOAD END ==========");
            } else {

                System.out.println("NO IMAGE SELECTED");
            }

            HostelEntity saved = hostelService.saveHostel(hostel);

            System.out.println("Hostel Saved Successfully");
            System.out.println("Saved CoverImage in DB : " + saved.getCoverImage());

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "redirect:/owner/myHostels";
    }

    @GetMapping("/myHostels")
    public String showMyHostels(HttpSession session, Model model) {

        OwnerEntity owner = (OwnerEntity) session.getAttribute("owner");

        if (owner == null) {
            return "redirect:/owner/login";
        }

        List<HostelEntity> hostelList =
                hostelService.getHostelsByOwner(owner);

        for (HostelEntity h : hostelList) {
            System.out.println("-------------------------------");
            System.out.println("Hostel : " + h.getHostelName());
            System.out.println("CoverImage : " + h.getCoverImage());
            System.out.println("-------------------------------");
        }

        model.addAttribute("hostels", hostelList);

        return "my_hostels";
    }

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

            hostel.setCoverImage(existingHostel.getCoverImage());

            if (image != null && !image.isEmpty()) {

                System.out.println("Updating image...");

                String imageUrl = cloudinaryService.uploadImage(image);

                System.out.println("New Cloudinary URL : " + imageUrl);

                hostel.setCoverImage(imageUrl);
            }

            hostelService.updateHostel(hostel);

            System.out.println("Hostel Updated Successfully");
            System.out.println("Updated Cover Image : " + hostel.getCoverImage());

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "redirect:/owner/myHostels";
    }

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