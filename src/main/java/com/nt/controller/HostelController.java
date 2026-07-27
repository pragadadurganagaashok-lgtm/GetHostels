package com.nt.controller;

import java.io.File;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.multipart.MultipartFile;

import com.nt.entity.HostelEntity;
import com.nt.entity.OwnerEntity;
import com.nt.service.IHostelMgmtService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/owner")
public class HostelController {

    @Autowired
    private IHostelMgmtService hostelService;


    // ==========================
    // Add Hostel Page
    // URL : /owner/addHostel
    // ==========================
    @GetMapping("/addHostel")
    public String showAddHostelPage(HttpSession session) {

        if (session.getAttribute("owner") == null) {

            return "redirect:/owner/login";
        }

        return "add_hostel";
    }


    // ==========================
    // Save Hostel
    // URL : /owner/saveHostel
    // ==========================
    @PostMapping("/saveHostel")
    public String saveHostel(
            @ModelAttribute HostelEntity hostel,
            @RequestParam("image") MultipartFile image,
            HttpSession session) {

        try {

            OwnerEntity owner =
                    (OwnerEntity) session.getAttribute("owner");

            if (owner == null) {

                return "redirect:/owner/login";
            }

            hostel.setOwner(owner);


            // ==========================
            // Upload Image
            // ==========================
            if (!image.isEmpty()) {

                String fileName =
                        System.currentTimeMillis()
                        + "_"
                        + image.getOriginalFilename();

                String uploadDir =
                        "C:/GetHostelUploads/";

                File dir =
                        new File(uploadDir);

                if (!dir.exists()) {

                    dir.mkdirs();
                }

                image.transferTo(
                        new File(uploadDir + fileName)
                );

                hostel.setCoverImage(fileName);
            }


            // ==========================
            // Save Hostel
            // ==========================
            hostelService.saveHostel(hostel);

        }
        catch (Exception e) {

            e.printStackTrace();
        }

        return "redirect:/owner/myHostels";
    }


    // ==========================
    // My Hostels
    // URL : /owner/myHostels
    // ==========================
    @GetMapping("/myHostels")
    public String showMyHostels(
            HttpSession session,
            Model model) {

        OwnerEntity owner =
                (OwnerEntity)
                session.getAttribute("owner");

        if (owner == null) {

            return "redirect:/owner/login";
        }

        List<HostelEntity> hostelList =
                hostelService.getHostelsByOwner(owner);

        model.addAttribute(
                "hostels",
                hostelList
        );

        return "my_hostels";
    }


    // ==========================
    // Edit Hostel
    // URL : /owner/editHostel/{id}
    // ==========================
    @GetMapping("/editHostel/{id}")
    public String showEditHostelPage(
            @PathVariable("id") Long id,
            HttpSession session,
            Model model) {

        OwnerEntity owner =
                (OwnerEntity)
                session.getAttribute("owner");

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
                hostel
        );

        return "add_hostel";
    }
 // ==========================
 // Update Hostel
 // URL : /owner/updateHostel
 // ==========================
    @PostMapping("/updateHostel")
    public String updateHostel(@ModelAttribute HostelEntity hostel,
                               @RequestParam("image") MultipartFile image,
                               HttpSession session) {

        System.out.println("UPDATE HOSTEL METHOD CALLED");

        System.out.println("Hostel ID = "
                + hostel.getHostelId());

        System.out.println("Hostel Name = "
                + hostel.getHostelName());

        try {

            OwnerEntity owner =
                    (OwnerEntity) session.getAttribute("owner");

            if (owner == null) {
                return "redirect:/owner/login";
            }

            // Get existing hostel from database
            HostelEntity existingHostel =
                    hostelService.getHostelById(hostel.getHostelId());

            if (existingHostel == null) {
                return "redirect:/owner/myHostels";
            }

            // Set owner
            hostel.setOwner(owner);

            // Keep old image by default
            hostel.setCoverImage(existingHostel.getCoverImage());

            // Replace only if a new image is selected
            if (!image.isEmpty()) {

                String fileName =
                        System.currentTimeMillis()
                        + "_"
                        + image.getOriginalFilename();

                String uploadDir =
                        "C:/GetHostelUploads/";

                File dir = new File(uploadDir);

                if (!dir.exists()) {
                    dir.mkdirs();
                }

                image.transferTo(new File(uploadDir + fileName));

                hostel.setCoverImage(fileName);
            }

            hostelService.updateHostel(hostel);

        } catch (Exception e) {

            e.printStackTrace();
        }

        return "redirect:/owner/myHostels";
    }
 // ==========================
 // Delete Hostel
 // URL : /owner/deleteHostel/{id}
 // ==========================
 @GetMapping("/deleteHostel/{id}")
 public String deleteHostel(@PathVariable("id") Long id,
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