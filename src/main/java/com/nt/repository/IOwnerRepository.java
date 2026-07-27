package com.nt.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import com.nt.entity.OwnerEntity;

public interface IOwnerRepository extends JpaRepository<OwnerEntity, Long> {

    Optional<OwnerEntity> findByEmail(String email);

    Optional<OwnerEntity> findByPhone(String phone);

    Optional<OwnerEntity> findByEmailAndPassword(String email, String password);

    boolean existsByEmail(String email);

    boolean existsByPhone(String phone);

}