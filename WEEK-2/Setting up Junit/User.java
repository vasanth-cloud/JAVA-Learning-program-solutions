package com.example.demo.controller;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;

@Entity

public class User {
	
	@Id
    private Long id;
    private String name;

    // Getters & Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

}
