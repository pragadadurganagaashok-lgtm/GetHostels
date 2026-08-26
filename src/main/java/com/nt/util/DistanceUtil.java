package com.nt.util;

public class DistanceUtil {

    private static final double EARTH_RADIUS_KM = 6371.0;

    public static double calculateDistance(
            double userLatitude,
            double userLongitude,
            double hostelLatitude,
            double hostelLongitude) {

        double latDistance =
                Math.toRadians(hostelLatitude - userLatitude);

        double lonDistance =
                Math.toRadians(hostelLongitude - userLongitude);

        double a =
                Math.sin(latDistance / 2) * Math.sin(latDistance / 2)
                +
                Math.cos(Math.toRadians(userLatitude))
                * Math.cos(Math.toRadians(hostelLatitude))
                * Math.sin(lonDistance / 2)
                * Math.sin(lonDistance / 2);

        double c =
                2 * Math.atan2(
                        Math.sqrt(a),
                        Math.sqrt(1 - a)
                );

        return EARTH_RADIUS_KM * c;
    }
}