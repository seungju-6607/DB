use hrdb2019;
select database();

/******************************************************
	book_market_books : 도서 리스트
    book_market_cart : 장바구니 테이블
    book_market_member : 회원
******************************************************/


CREATE TABLE book_market_books(
    book_id INT AUTO_INCREMENT PRIMARY KEY, 
    title VARCHAR(50) NOT NULL,            
    author VARCHAR(100) NOT NULL,           
    price DECIMAL(10, 2) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


CREATE TABLE book_market_cart(
    cart_id INT AUTO_INCREMENT PRIMARY KEY, 
    member_id INT NOT NULL,                 
    book_id INT NOT NULL,                 
    quantity INT DEFAULT 1,
    
    FOREIGN KEY (member_id) REFERENCES book_market_member(member_id),
    FOREIGN KEY (book_id) REFERENCES book_market_books(book_id)
);


CREATE TABLE book_market_member(
    member_id INT AUTO_INCREMENT PRIMARY KEY, 
    username VARCHAR(50) UNIQUE NOT NULL,     
    name VARCHAR(100) NOT NULL,              
    phone VARCHAR(20)
);
select * from book_market_cart;

INSERT INTO book_market_member (username, name, phone) VALUES
('hong1', '홍길동', '010-1234-5678'),
('hong2', '홍길동2', '010-2233-4455'),
('gil1', '홍길동이', '010-3344-5566'),
('gil2', '홍길순', '010-4455-6677');

INSERT INTO book_market_books (title, author, price) VALUES
('흥부와 놀부', '홍작가', 12000.00),
('길동전', '허균', 15000.00),
('홍길동의 모험', '길동출판', 18000.00),
('길순의 이야기', '순이작가', 13500.00);

INSERT INTO book_market_cart (member_id, book_id, quantity) VALUES
(1, 1, 2),  -- hong1이 '흥부와 놀부' 2권
(1, 3, 1),  -- hong1이 '홍길동의 모험' 1권
(2, 2, 1),  -- hong2가 '길동전' 1권
(3, 4, 3);  -- gil1이 '길순의 이야기' 3권