package com.nt.service;

import com.nt.entity.OwnerEntity;

public interface IOwnerMgmtService {

    String registerOwner(OwnerEntity owner);

    OwnerEntity loginOwner(String email,String password);

}