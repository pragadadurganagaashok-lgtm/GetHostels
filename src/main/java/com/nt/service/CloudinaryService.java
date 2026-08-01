package com.nt.service;

import java.io.IOException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.cloudinary.Cloudinary;

@Service
public class CloudinaryService {

    @Autowired
    private Cloudinary cloudinary;

    public String uploadImage(MultipartFile file) throws IOException {

        System.out.println("======================================");
        System.out.println("CLOUDINARY IMAGE UPLOAD START");
        System.out.println("File Name : " + file.getOriginalFilename());
        System.out.println("File Size : " + file.getSize());
        System.out.println("Content Type : " + file.getContentType());

        Map<?, ?> uploadResult =
                cloudinary.uploader().upload(file.getBytes(), Map.of());

        System.out.println("Cloudinary Response:");
        System.out.println(uploadResult);

        String secureUrl = uploadResult.get("secure_url").toString();

        System.out.println("Image Uploaded Successfully");
        System.out.println("Secure URL : " + secureUrl);
        System.out.println("======================================");

        return secureUrl;
    }
}