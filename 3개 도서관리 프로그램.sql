use hrdb2019;
select database();

-- 테이블 3개 생성, book_tj, book_yes24, book_aladin
-- bid : pk('B001',트리거생성), title, author, price, isbn(랜덤 정수4자리생성), bdate

CREATE TABLE book_tj (
    bid CHAR(4) PRIMARY KEY,
    title VARCHAR(50) NOT NULL,
    author VARCHAR(10),
    price INT,
    isbn INT,
    bdate datetime
);

CREATE TABLE book_yes24 LIKE book_tj;
CREATE TABLE book_aladin LIKE book_tj;

DELIMITER $$

CREATE TRIGGER trg_book_tj_bid
BEFORE INSERT ON book_tj
FOR EACH ROW
BEGIN
  DECLARE max_id INT;

  -- 현재 저장된 최대 번호 추출 (없으면 0)
  SELECT IFNULL(MAX(CAST(SUBSTRING(bid, 2) AS UNSIGNED)), 0)
  INTO max_id
  FROM book_tj;

  -- 새로운 bid 값 생성 (B001, B002 ...)
  SET NEW.bid = CONCAT('B', LPAD(max_id + 1, 3, '0'));
END$$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER trg_book_tj_isbn
BEFORE INSERT ON book_tj
FOR EACH ROW
BEGIN
  SET NEW.isbn = FLOOR(1000 + (RAND() * 9000));  
END$$

DELIMITER ;


DELIMITER $$
CREATE TRIGGER trg_book_aladin_bid
BEFORE INSERT ON book_aladin
FOR EACH ROW
BEGIN
  DECLARE max_id INT;
  SELECT IFNULL(MAX(CAST(SUBSTRING(bid, 2) AS UNSIGNED)), 0) INTO max_id FROM book_aladin;
  SET NEW.bid = CONCAT('B', LPAD(max_id + 1, 3, '0'));
END$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER trg_book_yes24_bid
BEFORE INSERT ON book_yes24
FOR EACH ROW
BEGIN
  DECLARE max_id INT;
  SELECT IFNULL(MAX(CAST(SUBSTRING(bid, 2) AS UNSIGNED)), 0) INTO max_id FROM book_yes24;
  SET NEW.bid = CONCAT('B', LPAD(max_id + 1, 3, '0'));
END$$
DELIMITER ;


show status like 'Threads+connected'; -- 접속 커넥션 수
show processlist; 					 -- 활성중인 커넥션	
show variables like 'max_connections';	-- 최대 접속 가능 커넥션 수

select * from book_tj;
