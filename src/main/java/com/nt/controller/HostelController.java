package com.nt.controller;

import java.io.File;
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
import com.nt.service.IHostelMgmtService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/owner")
public class HostelController {

    @Autowired
    private IHostelMgmtService hostelService;


    // =====================================================
    // IMAGE UPLOAD DIRECTORY
    // =====================================================

    private String getUploadDirectory() {

        String uploadDir =
                System.getProperty("java.io.tmpdir")
                + File.separator
                + "GetHostelUploads"
                + File.separator;

        File directory = new File(uploadDir);

        if (!directory.exists()) {
            directory.mkdirs();
        }

        return uploadDir;
    }


    // =====================================================
    // ADD HOSTEL PAGE
    // URL: /owner/addHostel
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
    // URL: /owner/saveHostel
    // =====================================================

    @PostMapping("/saveHostel")
    public String saveHostel(
            @ModelAttribute HostelEntity hostel,
            @RequestParam(value = "image", required = false)
            MultipartFile image,
            HttpSession session) {

        try {

            // Get logged-in owner
            OwnerEntity owner =
                    (OwnerEntity)
                    session.getAttribute("owner");

            if (owner == null) {

                return "redirect:/owner/login";
            }


            // Set owner
            hostel.setOwner(owner);


            // =====================================================
            // IMAGE UPLOAD
            // =====================================================

            if (image != null && !image.isEmpty()) {

                String originalFileName =
                        image.getOriginalFilename();

                String fileName =
                        System.currentTimeMillis()
                        + "_"
                        + originalFileName;


                String uploadDir =
                        getUploadDirectory();


                File file =
                        new File(uploadDir + fileName);


                image.transferTo(file);


                // Save only file name in database
                hostel.setCoverImage(fileName);


                System.out.println(
                        "Image uploaded successfully: "
                        + file.getAbsolutePath()
                );
            }


            // =====================================================
            // SAVE HOSTEL
            // =====================================================

            hostelService.saveHostel(hostel);


            System.out.println(
                    "Hostel saved successfully"
            );

        }
        catch (Exception e) {

            e.printStackTrace();
        }


        return "redirect:/owner/myHostels";
    }


    // =====================================================
    // SHOW MY HOSTELS
    // URL: /owner/myHostels
    // =====================================================

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


    // =====================================================
    // EDIT HOSTEL PAGE
    // URL: /owner/editHostel/{id}
    // =====================================================

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


    // =====================================================
    // UPDATE HOSTEL
    // URL: /owner/updateHostel
    // =====================================================

    @PostMapping("/updateHostel")
    public String updateHostel(
            @ModelAttribute HostelEntity hostel,
            @RequestParam(value = "image", required = false)
            MultipartFile image,
            HttpSession session) {


        System.out.println(
                "UPDATE HOSTEL METHOD CALLED"
        );


        System.out.println(
                "Hostel ID = "
                + hostel.getHostelId()
        );


        try {


            // Get logged-in owner
            OwnerEntity owner =
                    (OwnerEntity)
                    session.getAttribute("owner");


            if (owner == null) {

                return "redirect:/owner/login";
            }


            // Get existing hostel
            HostelEntity existingHostel =
                    hostelService.getHostelById(
                            hostel.getHostelId()
                    );


            if (existingHostel == null) {

                return "redirect:/owner/myHostels";
            }


            // Set owner
            hostel.setOwner(owner);


            // Keep old image
            hostel.setCoverImage(
                    existingHostel.getCoverImage()
            );


            // =====================================================
            // REPLACE IMAGE ONLY IF NEW IMAGE SELECTED
            // =====================================================

            if (image != null && !image.isEmpty()) {


                String originalFileName =
                        image.getOriginalFilename();


                String fileName =
                        System.currentTimeMillis()
                        + "_"
                        + originalFileName;


                String uploadDir =
                        getUploadDirectory();


                File file =
                        new File(uploadDir + fileName);


                image.transferTo(file);


                hostel.setCoverImage(
                        fileName
                );


                System.out.println(
                        "New image uploaded: "
                        + file.getAbsolutePath()
                );
            }


            // =====================================================
            // UPDATE HOSTEL
            // =====================================================

            hostelService.updateHostel(hostel);


            System.out.println(
                    "Hostel updated successfully"
            );


        }
        catch (Exception e) {

            e.printStackTrace();
        }


        return "redirect:/owner/myHostels";
    }


    // =====================================================
    // DELETE HOSTEL
    // URL: /owner/deleteHostel/{id}
    // =====================================================

    @GetMapping("/deleteHostel/{id}")
    public String deleteHostel(
            @PathVariable("id") Long id,
            HttpSession session) {


        OwnerEntity owner =
                (OwnerEntity)
                session.getAttribute("owner");


        if (owner == null) {

            return "redirect:/owner/login";
        }


        hostelService.deleteHostel(id);


        return "redirect:/owner/myHostels";
    }

}