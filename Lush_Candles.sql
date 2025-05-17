-- Create Database
CREATE DATABASE IF NOT EXISTS Lush_Candles;
USE Lush_Candles;

-- Location Table
CREATE TABLE IF NOT EXISTS `Location` (   
  `Location_ID` INT AUTO_INCREMENT NOT NULL,
  `Street_Address` VARCHAR(45) NOT NULL,
  `City` VARCHAR(45) NOT NULL,
  `Zip_Code` VARCHAR(15) DEFAULT NULL,
  `Country` VARCHAR(25) NOT NULL,
  PRIMARY KEY (`Location_ID`)
);

-- Customer Table 
CREATE TABLE IF NOT EXISTS `Customer` (
  `Customer_ID` INT AUTO_INCREMENT,
  `Nif` VARCHAR(45) NOT NULL,
  `First_Name` VARCHAR(45) NOT NULL,
  `Last_Name` VARCHAR(45) DEFAULT NULL,
  `Email` VARCHAR(100) DEFAULT NULL,
  `Phone_Number` VARCHAR(15) DEFAULT NULL,
  `Location_ID` INT DEFAULT NULL,
  PRIMARY KEY (`Customer_ID`)
);

-- Items Table
CREATE TABLE IF NOT EXISTS `Items` (
  `Items_ID` INT AUTO_INCREMENT NOT NULL,
  `Items_Name` VARCHAR(45) NOT NULL,
  `Items_Type` VARCHAR(45) NOT NULL,
  `Items_Price` DECIMAL(10,2) NOT NULL, 
  `Items_Description` VARCHAR(200) DEFAULT NULL,
  `Stock_Quantity` INT NOT NULL DEFAULT 100, 
  `Storage_ID` INT DEFAULT NULL, 
  PRIMARY KEY (`Items_ID`)
);


-- Orders Table
CREATE TABLE IF NOT EXISTS `Orders` (
  `Order_ID` INT AUTO_INCREMENT NOT NULL,
  `Customer_ID` INT NOT NULL,
  `Order_Date` DATETIME DEFAULT NOW(),
  PRIMARY KEY (`Order_ID`)
);

-- Ordered_Items Table
CREATE TABLE IF NOT EXISTS `Ordered_Items` (
  `Ordered_Quantity` INT NOT NULL,
  `Purchase_Date` DATETIME DEFAULT NOW(),
  `TAX` DECIMAL(2,2) NOT NULL,
  `Discount` DECIMAL(2,2) NOT NULL,
  `Items_ID` INT NOT NULL,
  `Order_ID` INT NOT NULL,
  PRIMARY KEY (`Order_ID`, `Items_ID`)
);


-- Rating Table
CREATE TABLE IF NOT EXISTS `Rating` (
  `Rating_ID` INT AUTO_INCREMENT NOT NULL,
  `Feedback` VARCHAR(200) DEFAULT NULL,
  `Rating_Date` DATETIME DEFAULT NOW(), 
  `Items_ID` INT NOT NULL,
  `Customer_ID` INT NOT NULL,
  `Rating` INT DEFAULT NULL,
  PRIMARY KEY (`Rating_ID`)
);

-- Storages Table
CREATE TABLE IF NOT EXISTS `Storages` (
  `Storage_ID` INT AUTO_INCREMENT NOT NULL,
  `Email` VARCHAR(50) NOT NULL UNIQUE,
  `Phone_Number` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Storage_ID`)
);

-- Deliveries Table 
CREATE TABLE IF NOT EXISTS `Deliveries` (
   `Deliveries_ID` INT AUTO_INCREMENT NOT NULL,    
   `Deliveries_Date` DATETIME DEFAULT NULL,
   `Order_ID` INT NOT NULL,
   `Delivery_Status` ENUM('Pending', 'Shipped', 'Delivered') NOT NULL DEFAULT 'Pending',
   PRIMARY KEY (`Deliveries_ID`)
);



-- ✅ Foreign Keys Constraints

-- Customer → Location
ALTER TABLE `Customer`
ADD CONSTRAINT `fk_Customer_Location`
  FOREIGN KEY (`Location_ID`)
  REFERENCES `Location`(`Location_ID`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;

-- Orders → Customer
ALTER TABLE `Orders`
ADD CONSTRAINT `fk_Orders_Customer`
  FOREIGN KEY (`Customer_ID`)
  REFERENCES `Customer`(`Customer_ID`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;

-- Ordered_Items → Orders & Items
ALTER TABLE `Ordered_Items`
ADD CONSTRAINT `fk_Ordered_Items_Order`
  FOREIGN KEY (`Order_ID`)
  REFERENCES `Orders`(`Order_ID`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE,
ADD CONSTRAINT `fk_Ordered_Items_Item`
  FOREIGN KEY (`Items_ID`)
  REFERENCES `Items`(`Items_ID`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;


-- Rating 
ALTER TABLE `Rating`
ADD CONSTRAINT `fk_Rating_Customer`
  FOREIGN KEY (`Customer_ID`)
  REFERENCES `Customer`(`Customer_ID`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE,
ADD CONSTRAINT `fk_Rating_Item`
  FOREIGN KEY (`Items_ID`)
  REFERENCES `Items`(`Items_ID`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;


-- Deliveries 
ALTER TABLE `Deliveries`
ADD CONSTRAINT `fk_Deliveries_Order`
  FOREIGN KEY (`Order_ID`)
  REFERENCES `Orders`(`Order_ID`)
  ON DELETE RESTRICT
  ON UPDATE CASCADE;
  
ALTER TABLE `Items`
ADD CONSTRAINT `fk_Items_Storages`
  FOREIGN KEY (`Storage_ID`)
  REFERENCES `Storages`(`Storage_ID`)
  ON DELETE SET NULL
  ON UPDATE CASCADE;



INSERT INTO Location (Location_ID, Street_Address, City, Zip_Code, Country) VALUES
(1, '4 Sutteridge Place', 'Qiashui', NULL, 'China'),
(2, '128 Dunning Way', 'Zhoutou', NULL, 'China'),
(3, '0 Hanover Place', 'Čortanovci', NULL, 'Serbia'),
(4, '6765 Leroy Terrace', 'Manggis', NULL, 'Indonesia'),
(5, '62 Dwight Road', 'Lolayan', NULL, 'Indonesia'),
(6, '3550 2nd Trail', 'Shediac', 'E4P', 'Canada'),
(7, '5 Lerdahl Crossing', 'Rozhniv', NULL, 'Ukraine'),
(8, '77 Old Gate Avenue', 'Phuthaditjhaba', '9869', 'South Africa'),
(9, '08 Goodland Court', 'Seixas do Douro', '5155-749', 'Portugal'),
(10, '4911 Wayridge Road', 'Dumalneg', '2921', 'Philippines'),
(11, '9 Veith Trail', 'Dubreuil', NULL, 'Mauritius'),
(12, '5324 Johnson Way', 'Magtangol', '1114', 'Philippines'),
(13, '31274 Hoepker Circle', 'Għaxaq', 'GXQ', 'Malta'),
(14, '5 Linden Way', 'Koło', '62-602', 'Poland'),
(15, '50892 Dayton Place', 'Qelëz', NULL, 'Albania'),
(16, '81 Fordem Lane', 'Costa Nova do Prado', '3830-455', 'Portugal'),
(17, '17 Crownhardt Plaza', 'Kíti', NULL, 'Cyprus'),
(18, '82 Ludington Road', 'Moriki', NULL, 'Nigeria'),
(19, '59804 Mariners Cove Pass', 'Damnica', '76-231', 'Poland'),
(20, '606 Eliot Way', 'Tongxing', NULL, 'China'),
(21, '621 Paget Point', 'Paltamo', '88300', 'Finland'),
(22, '04272 Lighthouse Bay Plaza', 'Jose Maria Morelos', '94453', 'Mexico'),
(23, '145 Waubesa Alley', 'Osveya', NULL, 'Belarus'),
(24, '6792 Crownhardt Circle', 'Altunemil', NULL, 'China'),
(25, '2370 Beilfuss Way', 'Taoyuan', NULL, 'China'),
(26, '99 Meadow Ridge Parkway', 'Itaporanga', '18480-000', 'Brazil'),
(27, '1347 Spohn Road', 'Yanaoca', NULL, 'Peru'),
(28, '5 Lotheville Park', 'Caspisapa', NULL, 'Peru'),
(29, '2921 Paget Point', 'Vesoul', '70004 CEDEX', 'France');


INSERT INTO Customer (Customer_ID, NIF, First_Name, Last_Name, Email, Phone_Number, Location_ID) VALUES
(10001, '341-43-7908', 'Frayda', 'Sterley', 'fsterley0@domainmarket.com', '920-374-146', 29),
(10002, '788-67-2746', 'Kaitlyn', 'McArdle', 'kmcardle1@t-online.de', '244-192-2409', 25),
(10003, '498-46-9773', 'Cally', 'Whittock', 'cwhittock2@domainmarket.com', '450-699-3031', 26),
(10004, '522-55-0009', 'Lethia', 'Weatherhead', 'lweatherhead3@surveymonkey.com', '254-619-6272', 27),
(10005, '700-01-3378', 'Garwin', 'Hazzard', 'ghazzard4@sina.com.cn', '134-284-6349', 28),
(10006, '339-67-2689', 'Kerrill', 'Corns', 'kcorns5@chronoengine.com', '110-363-094', 29),
(10007, '297-33-6404', 'Gweneth', 'Theaker', 'gtheaker6@fastcompany.com', '163-178-0167', 24),
(10008, '505-04-5594', 'Ginevra', 'Virgoe', 'gvirgoe7@telegraph.co.uk', '873-107-1947', 23),
(10009, '543-28-0437', 'Maxwell', 'Setterthwait', 'msetterthwait8@moonfruit.com', '806-492-2894', 21),
(10010, '802-34-8356', 'Brooke', 'Wix', 'bwix9@amazon.co.jp', '769-593-3649', 20),
(10011, '206-17-7091', 'Winny', 'McOmish', 'wmcomisha@moonfruit.com', '429-324-4631', 19),
(10012, '739-86-5641', 'Charmaine', 'Klauber', 'cklauberb@hexun.com', '155-601-1117', 18),
(10013, '278-23-8287', 'Sergeant', 'Metherell', 'smetherellc@washingtonpost.com', '743-272-8419', 17),
(10014, '511-27-3827', 'Cull', 'Tailour', 'ctailourd@springer.com', '447-405-0431', 16),
(10015, '316-86-1200', 'Herculie', 'Foxten', 'hfoxtene@nature.com', '667-672-2856', 15),
(10016, '771-87-4502', 'Dulcine', 'Forseith', 'dforseithf@furl.net', '168-450-2056', 12),
(10017, '403-36-8881', 'Georges', 'Size', 'gsize1b@seesaa.net', '997-166-2625', 13),
(10018, '250-16-2220', 'Athene', 'Bradneck', 'abradneckg@webeden.co.uk', '216-976-5857', 14),
(10019, '477-28-2673', 'Marlee', 'Mapowder', 'mmapowderh@amazon.de', '219-340-8061', 11),
(10020, '811-11-4260', 'Jefferey', 'Clara', 'jclarai@gnu.org', '979-876-5188', 10),
(10021, '221-49-1090', 'Ellie', 'Twigge', 'etwiggej@gmpg.org', '612-987-4374', 9),
(10022, '467-17-9188', 'Lea', 'Daughtrey', 'ldaughtreyk@paginegialle.it', '586-393-9405', 8),
(10023, '810-31-7838', 'Reggie', 'Kentwell', 'rkentwelll@posterous.com', '649-327-8677', 7),
(10024, '223-85-1267', 'Anna-diane', 'Shepherdson', 'ashepherdsonm@netlog.com', '176-644-3351', 6),
(10025, '649-47-3520', 'Jeri', 'Martineau', 'jmartineaun@scribd.com', '726-718-1605', 5),
(10026, '826-69-2144', 'Moreen', 'McNab', 'mmcnabo@japanpost.jp', '574-725-3880', 3),
(10027, '566-14-6932', 'Shanda', 'Alldis', 'salldisp@dailymotion.com', '676-613-0955', 2),
(10028, '303-49-3418', 'Ivory', 'Grafom', 'igrafomq@addtoany.com', '587-983-3109', 1);



INSERT INTO Storages (Storage_ID, Email, Phone_Number) VALUES
(1, 'wblacklidge0@alibaba.com', '(804) 4402102'),
(2, 'ahardware1@baidu.com', '(401) 8201153'),
(3, 'mbiesterfeld2@paypal.com', '(908) 4416924'),
(4, 'rstrathearn3@hugedomains.com', '(228) 5552141'),
(5, 'azanni4@usatoday.com', '(245) 4939685'),
(6, 'ltattersill5@howstuffworks.com', '(678) 9514765'),
(7, 'gswafield6@virginia.edu', '(675) 2283187'),
(8, 'ofawks7@ameblo.jp', '(722) 7533122'),
(9, 'mwisniewski8@mediafire.com', '(367) 3674880'),
(10, 'lmacfie9@exblog.jp', '(471) 7009261'),
(11, 'dshowlera@dagondesign.com', '(562) 1124339'),
(12, 'jmeneob@webeden.co.uk', '(471) 9633278'),
(13, 'pswatonc@va.gov', '(920) 9486705'),
(14, 'llarkinsd@spotify.com', '(617) 7051444'),
(15, 'fwindsore@webs.com', '(323) 6079142'),
(16, 'cdomanskif@huffingtonpost.com', '(321) 9036116'),
(17, 'galentyevg@cloudflare.com', '(701) 3946344'),
(18, 'mleadbetterh@yellowbook.com', '(995) 8646098'),
(19, 'fbullcocki@oakley.com', '(287) 7549093'),
(20, 'mpettsj@oaic.gov.au', '(393) 5665660'),
(21, 'bpristnork@chronoengine.com', '(472) 5924147'),
(22, 'gmcilwraithl@nationalgeographic.com', '(842) 7661666'),
(23, 'etyresm@webmd.com', '(260) 1577642'),
(24, 'jharroldn@ezinearticles.com', '(931) 2094464'),
(25, 'faspeyo@typepad.com', '(508) 2017758'),
(26, 'xshermarp@1688.com', '(604) 8768556'),
(27, 'fmaccarraneq@homestead.com', '(498) 2551838'),
(28, 'pnorthidger@apple.com', '(651) 3859958'),
(29, 'spratleys@admin.ch', '(207) 5888560'),
(30, 'giveaght@google.cn', '(969) 2154615'),
(31, 'smcneau@miitbeian.gov.cn', '(868) 8908812'),
(32, 'wshearmev@chicagotribune.com', '(944) 7262378'),
(33, 'bscandredw@jugem.jp', '(893) 2347828'),
(34, 'kfranckx@washington.edu', '(808) 5380031'),
(35, 'rmcgeaghy@about.me', '(583) 7962899'),
(36, 'dhonischz@globo.com', '(536) 8549892'),
(37, 'jyurkevich10@usda.gov', '(640) 1015989'),
(38, 'eloughton11@jiathis.com', '(226) 1782847'),
(39, 'abuie12@wikimedia.org', '(632) 4105277'),
(40, 'wwicklin13@mysql.com', '(934) 4556534'),
(41, 'cocorrane14@google.es', '(623) 8246413'),
(42, 'kpreuvost15@wufoo.com', '(555) 3528247'),
(43, 'dhamel16@cnet.com', '(873) 3795662'),
(44, 'npuckham17@skype.com', '(504) 4682679'),
(45, 'sjoul18@tiny.cc', '(542) 7561129'),
(46, 'achess19@bbb.org', '(440) 3313395'),
(47, 'fmobbs1a@cmu.edu', '(505) 1059425'),
(48, 'gsidebotton1b@tumblr.com', '(438) 5111173'),
(49, 'pmacanellye1c@1und1.de', '(389) 2407371'),
(50, 'afreeman1d@lulu.com', '(436) 9501970');

INSERT INTO Items (Items_ID, Items_Name, Items_Type, Items_Price, Items_Description, Stock_Quantity, Storage_ID) VALUES
(1, 'Candle', 'Festive candle', 3.72, 'Fresh', 100, 1),
(2, 'Soap', 'Body wash', 7.14, 'Breeze', 120, 1),
(3, 'Candle', 'Small candle', 2.50, 'Rose', 150, 2),
(4, 'Candle', 'Fragrances', 1.62, 'Calm', 130, 2),
(5, 'Stick', 'Scented stick', 0.11, 'Lavander', 90, 3),
(6, 'Soap', 'Bubble bath', 1.06, 'Feelings', 200, 3),
(7, 'Soap', 'Bath bomb', 0.14, 'Dream', 80, 4),
(8, 'Luxury', 'Air freshener', 1.30, 'Romance', 110, 4),
(9, 'Luxury', 'Body mist', 4.06, 'Snow white', 95, 5),
(10, 'Candle', 'Melted candle', 8.79, 'Deep dark', 75, 5);


INSERT INTO Orders (Order_ID, Customer_ID, Order_Date) VALUES
(10001, 10001, '2022-06-01'),
(10002, 10002, '2022-06-05'),
(10003, 10003, '2022-06-07'),
(10004, 10004, '2022-06-08'),
(10005, 10005, '2022-06-10'),
(10006, 10006, '2022-06-12'),
(10007, 10007, '2022-06-15'),
(10008, 10008, '2022-06-18'),
(10009, 10009, '2022-06-20'),
(10010, 10010, '2022-06-22'),
(10011, 10011, '2022-06-25'),
(10012, 10012, '2022-06-27'),
(10013, 10013, '2022-06-30'),
(10014, 10014, '2022-07-02'),
(10015, 10015, '2022-07-05'),
(10016, 10016, '2022-07-07'),
(10017, 10017, '2022-07-09'),
(10018, 10018, '2022-07-11'),
(10019, 10019, '2022-07-13'),
(10020, 10020, '2022-07-15'),
(10021, 10021, '2022-07-17'),
(10022, 10022, '2022-07-19'),
(10023, 10023, '2022-07-21'),
(10024, 10024, '2022-07-23'),
(10025, 10025, '2022-07-25'),
(10026, 10026, '2022-07-27'),
(10027, 10027, '2022-07-29'),
(10028, 10028, '2022-07-31');


INSERT INTO Ordered_Items (Ordered_Quantity, Purchase_Date, TAX, Discount, Items_ID, Order_ID) VALUES
(6, '2022-03-12', 0.23, 0.50, 1, 10012),
(1, '2021-08-08', 0.23, 0.20, 3, 10026),
(7, '2021-07-31', 0.23, 0.00, 7, 10016),
(6, '2022-04-20', 0.23, 0.10, 6, 10007),
(12, '2021-06-08', 0.23, 0.15, 9, 10020),
(3, '2022-07-10', 0.23, 0.10, 2, 10006),
(4, '2021-09-04', 0.23, 0.00, 7, 10010),
(15, '2021-12-25', 0.23, 0.00, 5, 10007),
(5, '2021-12-28', 0.23, 0.00, 6, 10010),
(9, '2021-11-23', 0.23, 0.15, 9, 10012),
(17, '2022-07-12', 0.23, 0.10, 6, 10003),
(13, '2022-08-13', 0.23, 0.50, 5, 10010),
(4, '2022-06-23', 0.23, 0.30, 7, 10018),
(3, '2021-02-18', 0.23, 0.00, 4, 10024),
(13, '2022-01-26', 0.23, 0.20, 1, 10007),
(2, '2022-03-15', 0.23, 0.00, 1, 10022),
(16, '2021-12-18', 0.23, 0.50, 2, 10016),
(2, '2022-04-26', 0.23, 0.00, 5, 10014),
(7, '2022-08-28', 0.23, 0.20, 1, 10005),
(16, '2022-04-30', 0.23, 0.00, 1, 10003),
(10, '2021-09-24', 0.23, 0.09, 6, 10013),
(12, '2021-10-29', 0.23, 0.00, 6, 10015),
(4, '2022-04-26', 0.23, 0.15, 9, 10015),
(15, '2022-11-18', 0.23, 0.00, 10, 10002),
(3, '2021-05-02', 0.23, 0.00, 9, 10009),
(10, '2021-08-23', 0.23, 0.30, 4, 10010),
(3, '2021-12-13', 0.23, 0.00, 10, 10013),
(5, '2021-07-04', 0.23, 0.10, 6, 10019),
(8, '2021-12-26', 0.23, 0.15, 3, 10016);

INSERT INTO Deliveries (Order_ID, Deliveries_Date, Delivery_Status) VALUES
(10001, '2022-06-19', 'Shipped'),
(10002, '2022-06-18', 'Delivered'),
(10003, '2022-06-12', 'Delivered'),
(10004, '2022-07-03', 'Shipped'),
(10005, '2022-06-11', 'Delivered'),
(10006, NULL, 'Pending'),
(10007, '2022-06-25', 'Delivered'),
(10008, '2022-06-22', 'Shipped'),
(10009, NULL, 'Pending'),
(10010, '2022-06-27', 'Delivered'),
(10011, '2022-06-29', 'Shipped'),
(10012, NULL, 'Pending'),
(10013, '2022-07-05', 'Delivered'),
(10014, '2022-07-08', 'Shipped'),
(10015, '2022-07-06', 'Delivered'),
(10016, NULL, 'Pending'),
(10017, '2022-07-10', 'Shipped'),
(10018, '2022-07-13', 'Delivered'),
(10019, '2022-07-15', 'Delivered'),
(10020, NULL, 'Pending'),
(10021, '2022-07-17', 'Shipped'),
(10022, NULL, 'Pending'),
(10023, '2022-07-21', 'Delivered'),
(10024, '2022-07-23', 'Shipped'),
(10025, NULL, 'Pending'),
(10026, '2022-07-28', 'Delivered'),
(10027, '2022-07-30', 'Shipped'),
(10028, NULL, 'Pending');

INSERT INTO Rating (Rating_ID, Feedback, Rating_Date, Items_ID, Customer_ID, Rating) VALUES
(2222201, 'The most amazing candle ever', '2021-01-26', 1, 10001, 5),
(2222202, 'Very expensive', '2021-11-05', 2, 10002, 1),
(2222203, 'Rude employees', '2021-03-25', 1, 10003, 1),
(2222204, 'Never coming back', '2021-05-27', 3, 10004, 1),
(2222205, 'My kids also loved the smell, but way too expensive', '2021-11-07', 4, 10005, 3),
(2222206, 'Perfect. Love the store', '2021-07-17', 5, 10006, 5),
(2222207, 'Could be better', '2021-07-29', 5, 10007, 2),
(2222208, 'So many natural products. Highly recommend', '2021-10-23', 6, 10008, 4),
(2222209, 'Lush, as always, a pleasure for the mind and body', '2021-03-13', 6, 10009, 5),
(2222210, 'the store is pretty small', '2021-04-24', 1, 10010, 3),
(2222211, NULL, '2021-06-02', 7, 10011, 2),
(2222212, 'Very bad experience. Wont be coming soon there', '2021-10-05', 3, 10012, 1),
(2222213, 'Vey expensive. Waist of time', '2021-01-04', 8, 10013, 3),
(2222214, 'Loved the experience in the store; all very nice', '2021-07-27', 4, 10014, 4),
(2222215, 'Very expensive candles', '2021-04-19', 9, 10015, 2),
(2222216, 'Could be better, but the stores smell so nice', '2021-05-03', 5, 10016, 2),
(2222217, 'One of my favourite stores', '2021-10-02', 4, 10017, 5),
(2222218, 'This one employee treated me very poorly', '2021-04-27', 2, 10018, 2),
(2222219, 'I dont dislike it, but wouldnt buy again', '2021-07-30', 10, 10019, 3),
(2222220, 'The most amazing candle ever', '2021-05-31', 3, 10020, 4),
(2222221, 'Perfect. Love this store', '2021-12-01', 10, 10021, 5),
(2222222, 'Very bad experience', '2021-03-28', 3, 10022, 2),
(2222223, 'Never again', '2021-05-03', 6, 10023, 1),
(2222224, NULL, '2021-03-07', 5, 10024, 4),
(2222225, 'Amazing experience. Always a pleasure to go', '2021-04-12', 4, 10025, 5),
(2222226, 'Expensive and fake scents', '2021-10-17', 8, 10026, 3),
(2222227, 'Waist of time', '2021-08-13', 8, 10027, 3),
(2222228, 'Really liked', '2021-04-03', 4, 10028, 3);


/* Create two triggers: (1) one for updates (you can choose any updating process, for example, if a
product is sold, the trigger may update the available stock of products). And (2) a trigger that inserts
a row in a “log” table (your ERD should include a log table). For defence, you should have ready the
scripts to demonstrate that the trigger works. */

USE lush_candles;

-- 1. Create Log Table
CREATE TABLE IF NOT EXISTS log (
  ID INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  TS DATETIME NOT NULL DEFAULT NOW(),
  USR VARCHAR(63),
  Event_Type VARCHAR(15),
  MSG VARCHAR(255)
);


-- 2. Trigger for Logging Customer Insertions
DELIMITER $$

CREATE TRIGGER customer_insert_log
AFTER INSERT
ON Customer
FOR EACH ROW
BEGIN
  INSERT INTO log (TS, USR, Event_Type, MSG)
  VALUES (NOW(), USER(), "INSERT", CONCAT("New customer added: ", NEW.First_Name, ' ', NEW.Last_Name));
END $$

DELIMITER ;

-- INSERT INTO Customer (Customer_ID, NIF, First_Name, Last_Name, Email, Phone_Number, Location_ID) VALUES
-- (10029, '304-49-3418', 'Ivory', 'Gram', 'igramq@addtoany.com', '587-983-3119', 1);

--  select * 
-- from log


DELIMITER $$

CREATE TRIGGER update_stock_after_order
AFTER INSERT
ON Ordered_Items
FOR EACH ROW
BEGIN
  DECLARE new_stock INT; -- Variable to store updated stock quantity
  
  -- Reduce the stock based on the ordered quantity
  UPDATE Items
  SET Stock_Quantity = Stock_Quantity - NEW.Ordered_Quantity
  WHERE Items_ID = NEW.Items_ID;
  
  -- Retrieve the updated stock value
  SELECT Stock_Quantity INTO new_stock FROM Items WHERE Items_ID = NEW.Items_ID;

  -- Log this event
  INSERT INTO log (TS, USR, EV, MSG)
  VALUES (NOW(), USER(), "STOCK_UPDATE", CONCAT("Stock updated for Item ID: ", NEW.Items_ID, ", New Stock: ", new_stock));

END $$

DELIMITER ;

-- INSERT INTO Ordered_Items (Ordered_Quantity, Purchase_Date, TAX, Discount, Items_ID, Order_ID) 
-- VALUES (2, NOW(), 0.23, 0.10, 1, 10001);
--  select * 
-- from log

CREATE VIEW customer_invoices AS
SELECT 
    o.Purchase_Date AS Purchase_Date,
    CONCAT(c.First_Name, ' ', c.Last_Name) AS Client_Name,
    CONCAT(l.Street_Address, ' ', l.City, ' ', COALESCE(l.Zip_Code, ''), ' ', l.Country) AS Address,
    ((i.Items_Price * o.Ordered_Quantity) - o.Discount) AS Amount
FROM Customer c
JOIN Location l ON c.Location_ID = l.Location_ID
JOIN Orders ord ON ord.Customer_ID = c.Customer_ID
JOIN Ordered_Items o ON o.Order_ID = ord.Order_ID
JOIN Items i ON i.Items_ID = o.Items_ID
WHERE c.Customer_ID = 10018;


##view 2

CREATE VIEW customer_invoices_description AS
SELECT 
    i.items_description AS Description,
    i.items_price AS Unit_Cost,
    o.ordered_quantity AS Quantity,
    o.discount AS Discount,
    ((i.items_price * o.ordered_quantity) - o.discount) AS Subtotal,
    (((i.items_price * o.ordered_quantity) - o.discount) * (o.tax / 100)) AS Tax,
    (((i.items_price * o.ordered_quantity) - o.discount) + 
     (((i.items_price * o.ordered_quantity) - o.discount) * (o.tax / 100))) AS Total
FROM customer c
JOIN orders ord ON ord.customer_ID = c.customer_ID  -- Connect customer to orders
JOIN ordered_items o ON o.order_ID = ord.order_ID   -- Connect orders to ordered_items
JOIN items i ON i.items_ID = o.items_ID             -- Connect ordered_items to items
WHERE c.customer_id = 10018;

