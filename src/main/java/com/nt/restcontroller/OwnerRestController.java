package com.nt.restcontroller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.nt.entity.OwnerEntity;
import com.nt.service.IOwnerMgmtService;

@RestController
@RequestMapping("/owner-api")
public class OwnerRestController {

    @Autowired
    private IOwnerMgmtService ownerService;

    // Register Owner
    @PostMapping("/register")
    public String registerOwner(@ModelAttribute OwnerEntity owner,
                                Model model) {

        String result = ownerService.registerOwner(owner);

        if(result.equals("SUCCESS")) {

            model.addAttribute("success",
                    "Registration Successful. Please Login.");

            return "owner_login";
        }

        model.addAttribute("error", result);

        return "owner_register";

    }

    // Login Owner
    @PostMapping("/login")
    public ResponseEntity<?> loginOwner(@RequestParam String email,
                                        @RequestParam String password) {

        OwnerEntity owner = ownerService.loginOwner(email, password);

        return new ResponseEntity<>(owner, HttpStatus.OK);
    }

    

}