package com.nt.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.nt.entity.HostelEntity;
import com.nt.service.IHostelMgmtService;

@Controller
public class UserController {

    @Autowired
    private IHostelMgmtService hostelService;

    @GetMapping("/")
    public String homePage(Model model) {

        List<HostelEntity> hostels =
                hostelService.getAllActiveHostels();

        model.addAttribute("hostels", hostels);

        return "index";
    }

}