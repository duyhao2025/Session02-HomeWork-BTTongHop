CREATE DATABASE library_management;
CREATE SCHEMA library;
CREATE TABLE library.members (
    member_id SERIAL PRIMARY KEY,

    full_name VARCHAR(100)
        NOT NULL,

    email VARCHAR(100)
        UNIQUE NOT NULL,

    phone VARCHAR(15),

    birth_date DATE,

    address TEXT,

    status VARCHAR(20)
        DEFAULT 'active'
        CHECK (status IN ('active', 'inactive')),

    join_date DATE
        DEFAULT CURRENT_DATE
);
CREATE TABLE library.categories (
    category_id SERIAL PRIMARY KEY,

    category_name VARCHAR(100)
        UNIQUE NOT NULL,

    description TEXT
);
CREATE TABLE library.authors (
    author_id SERIAL PRIMARY KEY,

    author_name VARCHAR(100)
        NOT NULL,

    biography TEXT
);
CREATE TABLE library.books (
    book_id SERIAL PRIMARY KEY,

    isbn VARCHAR(20)
        UNIQUE NOT NULL,

    title VARCHAR(255)
        NOT NULL,

    published_year INT,

    publisher VARCHAR(150),

    total_copies INTEGER
        CHECK (total_copies >= 0),

    available_copies INTEGER
        CHECK (
            available_copies >= 0
            AND available_copies <= total_copies
        ),

    category_id INT,

    CONSTRAINT fk_book_category
        FOREIGN KEY (category_id)
        REFERENCES library.categories(category_id)
);
CREATE TABLE library.book_authors (
    book_id INT,
    author_id INT,

    PRIMARY KEY (book_id, author_id),

    CONSTRAINT fk_ba_book
        FOREIGN KEY (book_id)
        REFERENCES library.books(book_id),

    CONSTRAINT fk_ba_author
        FOREIGN KEY (author_id)
        REFERENCES library.authors(author_id)
);
CREATE TABLE library.borrowings (
    borrowing_id SERIAL PRIMARY KEY,

    member_id INT,

    borrow_date DATE
        DEFAULT CURRENT_DATE,

    due_date DATE
        NOT NULL,

    return_date DATE,

    CONSTRAINT fk_borrow_member
        FOREIGN KEY (member_id)
        REFERENCES library.members(member_id),

    CONSTRAINT chk_due_date
        CHECK (due_date > borrow_date)
);
CREATE TABLE library.borrowing_details (
    borrowing_id INT,
    book_id INT,
    quantity INTEGER
        DEFAULT 1
        CHECK (quantity > 0),

    PRIMARY KEY (borrowing_id, book_id),

    CONSTRAINT fk_bd_borrowing
        FOREIGN KEY (borrowing_id)
        REFERENCES library.borrowings(borrowing_id),

    CONSTRAINT fk_bd_book
        FOREIGN KEY (book_id)
        REFERENCES library.books(book_id)
);
