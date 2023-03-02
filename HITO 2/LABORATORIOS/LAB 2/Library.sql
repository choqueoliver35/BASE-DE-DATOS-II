SHOW DATABASES;


CREATE DATABASE LIBRARY;
USE LIBRARY;


CREATE TABLE categories
(
    category_id INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE publishers
(
    publisher_id INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE books
(
    book_id INTEGER AUTO_INCREMENT PRIMARY KEY NOT NULL,
    title VARCHAR(100) NOT NULL,
    isbn VARCHAR(100) NOT NULL,
    published_date DATE NOT NULL,
    description VARCHAR(100) NOT NULL,
    category_id INTEGER NOT NULL,
    publisher_id INTEGER NOT NULL,

    FOREIGN KEY (category_id) REFERENCES categories(category_id),
    FOREIGN KEY (publisher_id) REFERENCES publishers(publisher_id)
);

