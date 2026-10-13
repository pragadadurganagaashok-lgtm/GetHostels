
package com.nt.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.nt.entity.HostelFloorEntity;
import com.nt.entity.HostelRoomEntity;
import com.nt.repository.HostelFloorRepository;
import com.nt.repository.HostelRoomRepository;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class HostelRoomService {

    private final HostelRoomRepository roomRepository;
    private final HostelFloorRepository floorRepository;
    private final HostelBedService bedService;

    public HostelRoomEntity saveRoom(HostelRoomEntity room) {
        return roomRepository.save(room);
    }

    public List<HostelRoomEntity> getAllRooms() {
        return roomRepository.findAll();
    }

    public HostelRoomEntity getRoomById(Long id) {
        return roomRepository.findById(id).orElse(null);
    }

    public void deleteRoom(Long id) {
        HostelRoomEntity room = roomRepository.findById(id).orElse(null);

        if (room != null) {
            bedService.deleteBedsByRoom(room);
            roomRepository.delete(room);
        }
    }

    public List<HostelRoomEntity> getRoomsByFloor(
            HostelFloorEntity floor) {
        return roomRepository.findByFloor(floor);
    }

    public List<HostelRoomEntity> getRoomsByFloorId(Long floorId) {
        HostelFloorEntity floor =
                floorRepository.findById(floorId).orElse(null);

        if (floor == null) {
            return List.of();
        }

        return roomRepository.findByFloor(floor);
    }

    public void deleteRoomsByFloor(HostelFloorEntity floor) {
        List<HostelRoomEntity> rooms = roomRepository.findByFloor(floor);

        for (HostelRoomEntity room : rooms) {
            bedService.deleteBedsByRoom(room);
            roomRepository.delete(room);
        }
    }

    public void updateRoom(
            Long roomId,
            Integer roomNumber,
            Integer sharingType) {

        HostelRoomEntity existingRoom =
                roomRepository.findById(roomId).orElseThrow();

        existingRoom.setRoomNumber(roomNumber);
        existingRoom.setSharingType(sharingType);

        roomRepository.save(existingRoom);
    }
}