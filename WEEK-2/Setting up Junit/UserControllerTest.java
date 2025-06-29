package com.example.demo.controller;

import com.example.demo.entity.User;
import com.example.demo.service.UserService;
import com.example.demo.controller.UserController;

import org.junit.jupiter.api.Test;
import org.mockito.Mockito;
import static org.mockito.Mockito.when;

import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.web.servlet.MockMvc;

import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.result.MockMvcResultMatchers;

@WebMvcTest(UserController.class) 
public class UserControllerTest {
	@Autowired
    private MockMvc mockMvc;

    @MockBean  // Mocks the UserService and injects it into the controller
    private UserService userService;

    @Test
    public void testGetUserById() throws Exception {
        // Arrange: create a mock User object
        User mockUser = new User();
        mockUser.setId(1L);
        mockUser.setName("John Doe");

        // Mock the service call
        when(userService.getUserById(1L)).thenReturn(mockUser);

        // Act & Assert: perform the request and validate the response
        mockMvc.perform(MockMvcRequestBuilders.get("/users/1")
                .accept(MediaType.APPLICATION_JSON))
                .andExpect(MockMvcResultMatchers.status().isOk())
                .andExpect(MockMvcResultMatchers.jsonPath("$.id").value(1L))
                .andExpect(MockMvcResultMatchers.jsonPath("$.name").value("John Doe"));
    }


}
