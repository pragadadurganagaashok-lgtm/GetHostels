package com.nt.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.nt.entity.OwnerEntity;
import com.nt.repository.IOwnerRepository;

@Service
public class OwnerMgmtServiceImpl implements IOwnerMgmtService {

    @Autowired
    private IOwnerRepository ownerRepo;

    @Override
    public String registerOwner(OwnerEntity owner) {

        if(ownerRepo.existsByEmail(owner.getEmail()))
            return "Email already registered";

        if(ownerRepo.existsByPhone(owner.getPhone()))
            return "Phone number already registered";

        owner.setStatus("ACTIVE");

        ownerRepo.save(owner);

        return "SUCCESS";
    }

    @Override
    public OwnerEntity loginOwner(String email, String password) {

        return ownerRepo.findByEmailAndPassword(email, password)
                        .orElse(null);
    }

}