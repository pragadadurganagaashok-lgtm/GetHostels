
package com.nt.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.nt.entity.HostelEntity;
import com.nt.entity.HostelFloorEntity;
import com.nt.entity.HostelRoomEntity;
import com.nt.entity.HostelBedEntity;

import com.nt.service.IHostelMgmtService;
import com.nt.service.HostelFloorService;
import com.nt.service.HostelRoomService;
import com.nt.service.HostelBedService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class PublicHostelController {

    private final IHostelMgmtService hostelService;
    private final HostelFloorService floorService;
    private final HostelRoomService roomService;
    private final HostelBedService bedService;

    @GetMapping("/hostel/{hostelId}/beds")
    public String showHostelBeds(
            @PathVariable Long hostelId,
            Model model) {

        HostelEntity hostel =
                hostelService.getHostelById(hostelId);

        if (hostel == null) {
            return "redirect:/";
        }

        List<HostelFloorEntity> floors =
                floorService.getFloorsByHostel(hostel);

        Map<Long, List<HostelRoomEntity>> roomsByFloor =
                new HashMap<>();

        Map<Long, List<HostelBedEntity>> bedsByRoom =
                new HashMap<>();

        for (HostelFloorEntity floor : floors) {

            List<HostelRoomEntity> rooms =
                    roomService.getRoomsByFloor(floor);

            roomsByFloor.put(floor.getFloorId(), rooms);

            for (HostelRoomEntity room : rooms) {

                List<HostelBedEntity> beds =
                        bedService.getBedsByRoom(room);

                bedsByRoom.put(room.getRoomId(), beds);
            }
        }

        model.addAttribute("hostel", hostel);
        model.addAttribute("floors", floors);
        model.addAttribute("roomsByFloor", roomsByFloor);
        model.addAttribute("bedsByRoom", bedsByRoom);

        return "hostel_beds";
    }
}