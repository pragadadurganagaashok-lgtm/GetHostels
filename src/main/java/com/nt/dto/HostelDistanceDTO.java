package com.nt.dto;

import com.nt.entity.HostelEntity;

public class HostelDistanceDTO {

    private HostelEntity hostel;

    private double distance;

    public HostelDistanceDTO(
            HostelEntity hostel,
            double distance) {

        this.hostel = hostel;
        this.distance = distance;
    }

    public HostelEntity getHostel() {
        return hostel;
    }

    public void setHostel(HostelEntity hostel) {
        this.hostel = hostel;
    }

    public double getDistance() {
        return distance;
    }

    public void setDistance(double distance) {
        this.distance = distance;
    }
}