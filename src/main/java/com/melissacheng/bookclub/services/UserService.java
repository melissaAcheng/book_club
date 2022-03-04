package com.melissacheng.bookclub.services;

import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.melissacheng.bookclub.models.LoginUser;
import com.melissacheng.bookclub.models.User;
import com.melissacheng.bookclub.repositories.UserRepository;


@Service
public class UserService {
	
	@Autowired
	private UserRepository userRepository;
	
	// Register and login methods
    public User register(User newUser, BindingResult result) {
    	
    	// Reject values or register if no errors:
    	Optional<User> potentialUser = userRepository.findByEmail(newUser.getEmail());
    	
    	if (potentialUser.isPresent()) {
    		result.rejectValue("email", "Matches", "Email already registered. Please log in with email");
    	} else if (!newUser.getPassword().equals((newUser.getConfirm()))) {
    		result.rejectValue("password", "Matches", "Passwords do not match");
    	} else if (result.hasErrors()) {
    		return null;
    	} else {
    		String hashed = BCrypt.hashpw(newUser.getPassword(), BCrypt.gensalt());
    		newUser.setPassword(hashed);
    		return userRepository.save(newUser);
    	}
    	
        return null;
    }
    
    
    public User login(LoginUser newLogin, BindingResult result) {
        
    	Optional<User> potentialUser = userRepository.findByEmail(newLogin.getEmail());
    	
    	if (!potentialUser.isPresent()) {
    		result.rejectValue("email", "Matches", "Email not found. Please register with email.");
    	} else if (!BCrypt.checkpw(newLogin.getPassword(), potentialUser.get().getPassword())) {
    	    result.rejectValue("password", "Matches", "Invalid Password");
    	} else if (result.hasErrors()) {
    		return null;
    	} else {
    		return potentialUser.get();
    	}

        return null;
    }
    

    
//    CRUD


 	// Add an User
 	public User addUser(User User) {
 		return userRepository.save(User);
 	}

    // Get one user
    public User findUser(Long id) {
    	Optional<User> optionalUser = userRepository.findById(id);
		if (optionalUser.isPresent()) {
			return optionalUser.get();
		} else {
			return null;
		}
    }

 	// Update User
 	public User updateUser(User User) {
 		return userRepository.save(User);
 	}

 	// Delete User
 	public User deleteUser(Long id) {
 		userRepository.deleteById(id);
 		return null;
 	}

}
