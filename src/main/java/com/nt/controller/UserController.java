package com.nt.controller;

import java.util.Comparator;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.nt.entity.HostelEntity;
import com.nt.service.IHostelMgmtService;
import com.nt.util.DistanceUtil;
import java.util.HashMap;
import java.util.Map;

@Controller
public class UserController {

    @Autowired
    private IHostelMgmtService hostelService;

    // =====================================================
    // HOME PAGE
    // URL: /
    // =====================================================

    @GetMapping("/")
    public String homePage(
            @RequestParam(required = false) Double latitude,
            @RequestParam(required = false) Double longitude,
            Model model) {

        // Get all active hostels
        List<HostelEntity> hostels =
                hostelService.getAllActiveHostels();

        // Map to store:
        // Hostel ID -> Distance in KM
        Map<Long, Double> hostelDistances =
                new HashMap<>();

        // =====================================================
        // USER LOCATION AVAILABLE
        // =====================================================

        if (latitude != null && longitude != null) {

            System.out.println(
                    "======================================");

            System.out.println(
                    "User Latitude  : " + latitude);

            System.out.println(
                    "User Longitude : " + longitude);

            // Calculate distance for every hostel
            for (HostelEntity hostel : hostels) {

                if (hostel.getLatitude() != null
                        && hostel.getLongitude() != null) {

                    double distance =
                            DistanceUtil.calculateDistance(
                                    latitude,
                                    longitude,
                                    hostel.getLatitude(),
                                    hostel.getLongitude());

                    hostelDistances.put(
                            hostel.getHostelId(),
                            distance);

                    System.out.println(
                            hostel.getHostelName()
                            + " -> "
                            + distance
                            + " KM");
                }
            }

            // =================================================
            // SORT HOSTELS BY DISTANCE
            // =================================================

            hostels.sort(
                    Comparator.comparingDouble(
                            hostel ->
                                    hostelDistances.getOrDefault(
                                            hostel.getHostelId(),
                                            Double.MAX_VALUE)
                    )
            );

            System.out.println(
                    "========== SORTED HOSTELS ==========");

            for (HostelEntity hostel : hostels) {

                Double distance =
                        hostelDistances.get(
                                hostel.getHostelId());

                if (distance != null) {

                    System.out.println(
                            hostel.getHostelName()
                            + " -> "
                            + distance
                            + " KM");
                }
            }

            System.out.println(
                    "====================================");
        }

        // =====================================================
        // SEND DATA TO JSP
        // =====================================================

        // Existing JSP continues using:
        // ${hostel.hostelName}
        // ${hostel.coverImage}
        // ${hostel.city}
        // etc.
        model.addAttribute(
                "hostels",
                hostels);

        // Separate distance map
        model.addAttribute(
                "hostelDistances",
                hostelDistances);

        return "index";
    }

    // =====================================================
    // BOYS HOSTELS
    // =====================================================

    @GetMapping("/boys")
    public String boysHostels(Model model) {

        List<HostelEntity> hostels =
                hostelService.getAllActiveHostels();

        List<HostelEntity> boysHostels =
                hostels.stream()
                       .filter(hostel ->
                               hostel.getHostelType() != null &&
                               hostel.getHostelType()
                                     .toLowerCase()
                                     .contains("boys"))
                       .toList();

        model.addAttribute(
                "hostels",
                boysHostels);

        return "boys_hostels";
    }


    // =====================================================
    // GIRLS HOSTELS
    // =====================================================

    @GetMapping("/girls")
    public String girlsHostels(Model model) {

        List<HostelEntity> hostels =
                hostelService.getAllActiveHostels();

        List<HostelEntity> girlsHostels =
                hostels.stream()
                       .filter(hostel ->
                               hostel.getHostelType() != null &&
                               hostel.getHostelType()
                                     .toLowerCase()
                                     .contains("girls"))
                       .toList();

        model.addAttribute(
                "hostels",
                girlsHostels);

        return "girls_hostels";
    }


    // =====================================================
    // CO-LIVE HOSTELS
    // =====================================================

    @GetMapping("/colive")
    public String coLiveHostels(Model model) {

        List<HostelEntity> hostels =
                hostelService.getAllActiveHostels();

        List<HostelEntity> coLiveHostels =
                hostels.stream()
                       .filter(hostel ->
                               hostel.getHostelType() != null &&
                               hostel.getHostelType()
                                     .toLowerCase()
                                     .contains("co"))
                       .toList();

        model.addAttribute(
                "hostels",
                coLiveHostels);

        return "colive_hostels";
    }


    // =====================================================
    // ABOUT
    // =====================================================

    @GetMapping("/about")
    public String aboutPage() {

        return "about";
    }


    // =====================================================
    // CONTACT
    // =====================================================

    @GetMapping("/contact")
    public String contactPage() {

        return "contact";
    }
}