package com.nt.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.nt.entity.OwnerEntity;
import com.nt.service.IOwnerMgmtService;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/owner")
public class OwnerController {

    @Autowired
    private IOwnerMgmtService ownerService;


    // ==========================
    // Open Register Page
    // URL : /owner/register
    // ==========================
    @GetMapping("/register")
    public String showRegisterPage() {

        return "owner_register";
    }


    // ==========================
    // Register Owner
    // URL : /owner/register
    // ==========================
    @PostMapping("/register")
    public String registerOwner(@ModelAttribute OwnerEntity owner,
                                Model model) {

        String result =
                ownerService.registerOwner(owner);

        if (result.equals("SUCCESS")) {

            model.addAttribute(
                    "success",
                    "Registration Successful. Please Login."
            );

            return "owner_login";
        }

        model.addAttribute("error", result);

        return "owner_register";
    }


    // ==========================
    // Open Login Page
    // URL : /owner/login
    // ==========================
    @GetMapping("/login")
    public String showLoginPage() {

        return "owner_login";
    }


    // ==========================
    // Owner Login
    // URL : /owner/login
    // ==========================
    @PostMapping("/login")
    public String loginOwner(@RequestParam String email,
                             @RequestParam String password,
                             HttpSession session,
                             Model model) {

        OwnerEntity owner =
                ownerService.loginOwner(email, password);

        if (owner != null) {

            session.setAttribute("owner", owner);

            return "redirect:/owner/dashboard";
        }

        model.addAttribute(
                "error",
                "Invalid Email or Password"
        );

        return "owner_login";
    }


    // ==========================
    // Owner Dashboard
    // URL : /owner/dashboard
    // ==========================
    @GetMapping("/dashboard")
    public String ownerDashboard(HttpSession session) {

        if (session.getAttribute("owner") == null) {

            return "redirect:/owner/login";
        }

        return "owner_dashboard";
    }


    // ==========================
    // Logout
    // URL : /owner/logout
    // ==========================
    @GetMapping("/logout")
    public String logout(HttpSession session) {

        session.invalidate();

        return "redirect:/";
    }

}