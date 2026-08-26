package com.nt.util;

import java.net.HttpURLConnection;
import java.net.URI;
import java.net.URL;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class GoogleMapUtil {

    private GoogleMapUtil() {
    }

    public static double[] extractCoordinates(String googleMapUrl) {

        if (googleMapUrl == null || googleMapUrl.isBlank()) {
            return null;
        }

        try {

            String finalUrl = resolveUrl(googleMapUrl);

            System.out.println("Original Google Maps URL : " + googleMapUrl);
            System.out.println("Resolved Google Maps URL : " + finalUrl);

            double[] coordinates =
                    extractFromUrl(finalUrl);

            if (coordinates != null) {

                System.out.println(
                        "Latitude  : " + coordinates[0]);

                System.out.println(
                        "Longitude : " + coordinates[1]);

                return coordinates;
            }

        } catch (Exception e) {

            System.out.println(
                    "Unable to extract Google Maps coordinates.");

            e.printStackTrace();
        }

        return null;
    }

    // =====================================================
    // RESOLVE SHORT GOOGLE MAPS URL
    // =====================================================

    private static String resolveUrl(String googleMapUrl)
            throws Exception {

        URL url = new URI(googleMapUrl).toURL();

        HttpURLConnection connection =
                (HttpURLConnection) url.openConnection();

        connection.setInstanceFollowRedirects(false);

        connection.setRequestMethod("GET");

        connection.setConnectTimeout(5000);

        connection.setReadTimeout(5000);

        connection.setRequestProperty(
                "User-Agent",
                "Mozilla/5.0");

        int responseCode =
                connection.getResponseCode();

        String location =
                connection.getHeaderField("Location");

        connection.disconnect();

        if (location != null && !location.isBlank()) {

            return location;
        }

        return googleMapUrl;
    }

    // =====================================================
    // EXTRACT COORDINATES
    // =====================================================

    private static double[] extractFromUrl(String url) {

        // -------------------------------------------------
        // Format:
        // @17.4341288,78.4403755,17z
        // -------------------------------------------------

        Pattern atPattern = Pattern.compile(
                "@(-?\\d+(?:\\.\\d+)?),(-?\\d+(?:\\.\\d+)?)"
        );

        Matcher atMatcher =
                atPattern.matcher(url);

        if (atMatcher.find()) {

            return validateCoordinates(
                    Double.parseDouble(atMatcher.group(1)),
                    Double.parseDouble(atMatcher.group(2))
            );
        }

        // -------------------------------------------------
        // Format:
        // !3d17.4341288!4d78.4403755
        // -------------------------------------------------

        Pattern dataPattern = Pattern.compile(
                "!3d(-?\\d+(?:\\.\\d+)?)!4d(-?\\d+(?:\\.\\d+)?)"
        );

        Matcher dataMatcher =
                dataPattern.matcher(url);

        if (dataMatcher.find()) {

            return validateCoordinates(
                    Double.parseDouble(dataMatcher.group(1)),
                    Double.parseDouble(dataMatcher.group(2))
            );
        }

        // -------------------------------------------------
        // Format:
        // ?query=17.4341288,78.4403755
        // -------------------------------------------------

        Pattern queryPattern = Pattern.compile(
                "[?&](?:query|q|center|destination|origin)=(-?\\d+(?:\\.\\d+)?)[,%2C]+(-?\\d+(?:\\.\\d+)?)",
                Pattern.CASE_INSENSITIVE
        );

        Matcher queryMatcher =
                queryPattern.matcher(url);

        if (queryMatcher.find()) {

            return validateCoordinates(
                    Double.parseDouble(queryMatcher.group(1)),
                    Double.parseDouble(queryMatcher.group(2))
            );
        }

        return null;
    }

    // =====================================================
    // VALIDATE
    // =====================================================

    private static double[] validateCoordinates(
            double latitude,
            double longitude) {

        if (latitude < -90 || latitude > 90) {
            return null;
        }

        if (longitude < -180 || longitude > 180) {
            return null;
        }

        return new double[] {
                latitude,
                longitude
        };
    }
}