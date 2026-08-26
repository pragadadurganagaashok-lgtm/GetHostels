package com.nt.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.nt.util.GoogleMapUtil;

@RestController
public class GoogleMapTestController {

    @GetMapping("/test-google-map")
    public String testGoogleMap() {

        System.out.println("===== GOOGLE MAP TEST STARTED =====");

        String googleMapUrl =
                "https://maps.app.goo.gl/SwJNKzgCnRbBSmXy8";

        System.out.println("URL : " + googleMapUrl);

        double[] coordinates =
                GoogleMapUtil.extractCoordinates(googleMapUrl);

        if (coordinates != null) {

            System.out.println("Latitude  : " + coordinates[0]);
            System.out.println("Longitude : " + coordinates[1]);

            return "Latitude: " + coordinates[0]
                    + " | Longitude: " + coordinates[1];

        } else {

            System.out.println("Coordinates NOT FOUND");

            return "Coordinates NOT FOUND";
        }
    }
}