package com.melissacheng.bookclub.controllers;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;

import com.melissacheng.bookclub.models.Book;
import com.melissacheng.bookclub.models.LoginUser;
import com.melissacheng.bookclub.models.User;
import com.melissacheng.bookclub.services.BookService;
import com.melissacheng.bookclub.services.UserService;

@Controller
public class BookController {

	@Autowired
	private UserService userService;
	
	@Autowired
	private BookService bookService;
	
    @GetMapping("/books")
    public String dashboard(
    		Model model,
    		HttpSession session) {
    	
    	if (session.getAttribute("user_id") == null) {
            model.addAttribute("newUser", new User());
            model.addAttribute("newLogin", new LoginUser());
    		return "redirect:/";
    		
    	} else {
    		
    		Long user_id = (Long) session.getAttribute("user_id");
    		User user = userService.findUser(user_id);
    		model.addAttribute("books", bookService.allBooks());
    		model.addAttribute("user", user);
    		model.addAttribute("borrowed_books", bookService.retreiveBorrowedBooks(user_id));
    		return "dashboard.jsp";    		
    	}
    }
    
    @GetMapping("/books/new")
    public String newBook(
    		Model model,
    		@ModelAttribute("book") Book book,
    		HttpSession session) {
    	if (session.getAttribute("user_id") == null) {
            model.addAttribute("newUser", new User());
            model.addAttribute("newLogin", new LoginUser());
    		return "redirect:/";
    	} else {
    		session.getAttribute("user_id");
    		return "add_book.jsp";
    	}
    }
    
    @PostMapping("/books")
    public String addBook(
    		@Valid @ModelAttribute("book") Book book,
    		BindingResult result,
    		HttpSession session) {
    	if (result.hasErrors()) {
    		return "add_book.jsp";
    	} else {
    		Long user_id = (Long) session.getAttribute("user_id");
    		bookService.addBook(user_id, book);
    	}
    	return "redirect:/books";
    }
    
    @GetMapping("/books/{id}")
    public String viewBook(
    		Model model,
    		@PathVariable Long id,
    		HttpSession session) 
    {
    	if (session.getAttribute("user_id") == null) {
            model.addAttribute("newUser", new User());
            model.addAttribute("newLogin", new LoginUser());
    		return "redirect:/";
    	} else {
    		session.getAttribute("user_id");
    		model.addAttribute("book", bookService.findBook(id));
    		return "show_book.jsp";
    	}
    }
    
    @GetMapping("/books/{id}/edit")
    public String editBook(
    		Model model,
    		@PathVariable Long id,
    		HttpSession session) {
    	if (session.getAttribute("user_id") == null) {
            model.addAttribute("newUser", new User());
            model.addAttribute("newLogin", new LoginUser());
    		return "redirect:/";
    	} else {
    		session.getAttribute("user_id");
    		model.addAttribute("book", bookService.findBook(id));
    		return "edit_book.jsp";
    	}
    	
    }
    
    @PutMapping("/books/{id}")
    public String updateBook(
    		Model model,
    		@Valid @ModelAttribute("book") Book book,
    		BindingResult result,
    		@PathVariable Long id,
    		HttpSession session) {
    	
    	
    	if (session.getAttribute("user_id") == null) {
            model.addAttribute("newUser", new User());
            model.addAttribute("newLogin", new LoginUser());
    		return "redirect:/";
    	} else if (result.hasErrors()) {
    		return "edit_book.jsp";
    	} else {
    		
    		Long user_id = (Long) session.getAttribute("user_id");
    		bookService.addBook(user_id, book);
    		return String.format("redirect:/books/%d", id);    		
    	}
    }
    
    @GetMapping("/books/{id}/delete")
    public String deleteBook(
    			@PathVariable Long id) {
    	bookService.deleteBook(id);
    	return ("redirect:/books");
    }
    
    @GetMapping("/books/{id}/borrow")
    public String borrowBook(
	    		HttpSession session, 
	    		@PathVariable Long id) {
		
    	Long borrower_id = (Long) session.getAttribute("user_id");
    	Book borrowedBook = bookService.findBook(id);
    	User borrower = userService.findUser(borrower_id);
    	borrowedBook.setBorrower(borrower);
    	
    	bookService.updateBook(borrowedBook);
    	
    	return "redirect:/books";
    }
    
    @GetMapping("/books/{id}/return")
    public String returnBook(
    			Model model,
    			HttpSession session,
    			@PathVariable Long id) {
    	
    	if (session.getAttribute("user_id") == null) {
            model.addAttribute("newUser", new User());
            model.addAttribute("newLogin", new LoginUser());
    		return "redirect:/";
    	} else {
    		Book returnedBook = bookService.findBook(id);
    		returnedBook.setBorrower(null);
    		
    		bookService.updateBook(returnedBook);
    		
    		return "redirect:/books";
    		
    	}
    	
    }
}
