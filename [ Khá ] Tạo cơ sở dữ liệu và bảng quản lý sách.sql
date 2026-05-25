-- 2. Tạo Schema
CREATE SCHEMA library;
CREATE TABLE library.books (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    author VARCHAR(50) NOT NULL,
    published_year INT,
    price REAL
);
ALTER TABLE library.books
ADD COLUMN created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP;
DROP TABLE library.books;