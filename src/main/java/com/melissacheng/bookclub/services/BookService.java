package com.melissacheng.bookclub.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.melissacheng.bookclub.models.Book;
import com.melissacheng.bookclub.models.User;
import com.melissacheng.bookclub.repositories.BookRepository;

@Service
public class BookService {

	@Autowired
	private BookRepository bookRepository;
	
	@Autowired
	private UserService userService;

	// Method that calls the query to return all Books
	public List<Book> allBooks() {
		return bookRepository.findAll();
	}
	

	// Add a Book
	public Book addBook(Long userId, Book Book) {
		User user = userService.findUser(userId);
		
		if (user == null) return null;
		
		Book.setUser(user);
		
		return bookRepository.save(Book);
	}
	

	// Retrieve one Book
	public Book findBook(Long id) {
		Optional<Book> optionalBook = bookRepository.findById(id);
		if (optionalBook.isPresent()) {
			return optionalBook.get();
		} else {
			return null;
		}
	}
	
	// Retrieve all books with specific borrower_id
	public List<Book> retreiveBorrowedBooks(Long borrower_id) {
		return bookRepository.findByBorrowerId(borrower_id);
	}

	// Update Book
	public Book updateBook(Book Book) {
		return bookRepository.save(Book);
	}

	// Delete Book
	public Book deleteBook(Long id) {
		bookRepository.deleteById(id);
		return null;
	}

	

}
