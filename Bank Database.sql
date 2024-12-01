CREATE TABLE Clients (
       client_id VARCHAR(10),
       first_name VARCHAR(30),
       last_name VARCHAR(30),
       city VARCHAR(15),
       mobile_number VARCHAR(10),
       occupation VARCHAR(10),

     PRIMARY KEY(client_id)   
   );

INSERT INTO Clients(client_id,first_name,last_name,city,mobile_number,occupation)
VALUES 
 (1,'Stojan','Stojanov','Skopje','075675899','programer'),
 (2,'Ivana','Angelova','Strumica','075675545','profesor'),
 (3,'Andrej','Naunov','Stip','075644345','zemjodelec'),
 (4,'Ljupco','Petrovski','Bitola','075634565','menadzer'),
 (5,'Angela','Stojkovska','Prilep','071232678','inzinjer'),
 (6,'Ruza','Antovska','Ohrid','071674545','doktor'),
 (7,'Martin','Popov','Radovis','070332544','arhitekt');







CREATE TABLE Accounts (
  account_number VARCHAR(20),
  client_id VARCHAR(10),
  balance bigint,
  account_status VARCHAR(50),
  account_type VARCHAR (30),
  currency VARCHAR(3),

    PRIMARY KEY(account_number),
    FOREIGN KEY(client_id) REFERENCES Clients(client_id),
  
);

INSERT INTO Accounts(client_id,account_number,balance,account_status,account_type,currency)
VALUES 

(1,'210123456789000',2500000,'Active','Transactional','EUR'),
(2,'210112244561000',500000,'Active','Saving','MKD'),
(3,'210455227789000',15000,'Active','Transactional','EUR'),
(4,'210436789121879', 0,'Terminated','Saving','EUR'),
(5,'210437598126799', 10000000 ,'Active','Transactional','MKD'),
(6,'210988445678293',30000,'Active','Transactional','EUR'),
(7,'210125475639823',2500000,'Terminated','Saving','EUR')
;




CREATE TABLE Savings (
  saving_acc_number VARCHAR(20),
  client_id VARCHAR(10),
  deposit_balance bigint,
  account_status VARCHAR(50),
  account_type VARCHAR (30),
  currency VARCHAR(3),

    PRIMARY KEY(saving_acc_number),
    FOREIGN KEY(client_id) REFERENCES Clients(client_id),
  
);

INSERT INTO Savings(saving_acc_number,client_id,deposit_balance,account_status,account_type,currency)
VALUES 

('211222333444555',1,120000335,'Active','Saving','EUR'),
('211345767839375',2,70000000,'Active','Saving','MKD'),
('211234655738397',3,280000000,'Active','Saving','EUR'),
('211956538676452',4, 0,'Terminated','Saving','EUR'),
('211546832648693',5, 0,'Terminated','Saving','MKD'),
('211867345725437',6,20,'Terminated','Saving','EUR'),
('211254750639823',7,100,'Terminated','Saving','EUR')
;








CREATE TABLE Debit_cards (
  debit_card_number	VARCHAR(20),
  account_number VARCHAR (20),
  transaction_type VARCHAR(20),
  date_issued VARCHAR(10),
  amount int,

 PRIMARY KEY(debit_card_number),
 FOREIGN KEY(account_number) REFERENCES Accounts(account_number)  
    );

	
INSERT INTO Debit_cards(debit_card_number,account_number,transaction_type,date_issued,amount)
VALUES 

('212222444555678','210123456789000','cash','21.12.2023',10000),
('212546576869607','210112244561000','cash','02.01.2020',600000),
('212435465766586','210455227789000','cash','12.11.2024',25000),
('212645576868663','210436789121879','cash','01.03.2024',1000),
('212647656565764','210437598126799','banktransfer','08.07.2023',500),
('212746575842219','210988445678293','banktransfer','05.10.2024',13200),
('212646565765876','210125475639823','cash','11.11.2021',190000)
;







CREATE TABLE Credits(

    credit_id INT,
    client_id VARCHAR(10),
	account_number VARCHAR(20),
    credit_amount INT,
	starting_date VARCHAR(10),
    PRIMARY KEY(credit_id),
    FOREIGN KEY(client_id) REFERENCES  Clients(client_id),
    FOREIGN KEY(account_number) REFERENCES  Accounts(account_number)
   );
 
 INSERT INTO Credits(credit_id,client_id,account_number,credit_amount,starting_date)
VALUES 

(10,1,'210123456789000',60000,'01.01.2019'),
(11,2,'210112244561000',200000,'15.02.2021'),
(12,3,'210455227789000',15000,'13.10.2023'),
(13,4,'210436789121879',3000000,'08.07.2022'),
(14,5,'210437598126799',28000000,'09.05.2023'),
(15,6,'210988445678293',100000,'15.09.2024'),
(16,7,'210125475639823',10000,'11.11.2022')
;

--Query 1: List all clients who have more than a specific amount in their savings account (e.g., $10,000).


SELECT c.first_name,c.last_name,c.city,s.saving_acc_number,s.deposit_balance,s.currency FROM Clients as c
INNER JOIN
Savings as s
ON s.client_id = c.client_id
WHERE
s.deposit_balance > 10000;

--Query 2: Retrieve all debit cards issued within a specific date range.

SELECT * FROM Debit_cards;

SELECT  *
FROM    Debit_cards
WHERE   date_issued >= '02.01.2020' AND
        date_issued  <= '05.10.2024'

-- List all clients who have taken credit, along with the credit amount and start date, 
-- filtering for credits issued after a specific date (e.g., after 2023).

SELECT c.first_name,c.last_name,c.city,cr.credit_amount,cr.starting_date FROM Clients as c
INNER JOIN 
Credits as cr
ON c.client_id = cr.client_id
WHERE
cr.starting_date > '01.01.2019'
;


