-- MySQL Administrator dump 1.4
--
-- ------------------------------------------------------
-- Server version	5.1.52-community


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


--
-- Create schema myperfume
--

CREATE DATABASE IF NOT EXISTS myperfume;
USE myperfume;

--
-- Definition of table `address`
--

DROP TABLE IF EXISTS `address`;
CREATE TABLE `address` (
  `idAddress` int(11) NOT NULL AUTO_INCREMENT,
  `idUser` int(11) NOT NULL,
  `name` varchar(45) DEFAULT NULL,
  `contactNo` varchar(45) DEFAULT NULL,
  `line1` varchar(45) DEFAULT NULL,
  `line2` varchar(45) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `zipCode` int(11) DEFAULT NULL,
  PRIMARY KEY (`idAddress`),
  KEY `fk_Address_User1_idx` (`idUser`),
  CONSTRAINT `fk_Address_User1` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `address`
--

/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` (`idAddress`,`idUser`,`name`,`contactNo`,`line1`,`line2`,`city`,`zipCode`) VALUES 
 (1,1000,'dasdad','423424','dasdsd','sdadas','asdad',3213123),
 (2,1002,'SASINDU','0776199378','24/67G PEBIAN MAWATHA,, PRIMELANDS,NAGODA,','1','KANDANA',11320);
/*!40000 ALTER TABLE `address` ENABLE KEYS */;


--
-- Definition of table `grn`
--

DROP TABLE IF EXISTS `grn`;
CREATE TABLE `grn` (
  `idGRN` int(11) NOT NULL AUTO_INCREMENT,
  `idSupplier` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `ItemCount` int(11) DEFAULT NULL,
  `nettotal` double DEFAULT NULL,
  PRIMARY KEY (`idGRN`),
  KEY `fk_GRN_Supplier_idx` (`idSupplier`),
  CONSTRAINT `fk_GRN_Supplier` FOREIGN KEY (`idSupplier`) REFERENCES `supplier` (`idSupplier`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1001 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `grn`
--

/*!40000 ALTER TABLE `grn` DISABLE KEYS */;
INSERT INTO `grn` (`idGRN`,`idSupplier`,`date`,`time`,`ItemCount`,`nettotal`) VALUES 
 (1000,1001,'2020-12-07','15:09:59',8,71500);
/*!40000 ALTER TABLE `grn` ENABLE KEYS */;


--
-- Definition of table `grncartsession`
--

DROP TABLE IF EXISTS `grncartsession`;
CREATE TABLE `grncartsession` (
  `idGRNCartSession` int(11) NOT NULL AUTO_INCREMENT,
  `idUser` int(11) NOT NULL,
  `idProduct` int(11) NOT NULL,
  `price` double DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  PRIMARY KEY (`idGRNCartSession`),
  KEY `fk_GRNCartSession_User1_idx` (`idUser`),
  KEY `fk_GRNCartSession_Product1_idx` (`idProduct`),
  CONSTRAINT `fk_GRNCartSession_Product1` FOREIGN KEY (`idProduct`) REFERENCES `product` (`idProduct`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_GRNCartSession_User1` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `grncartsession`
--

/*!40000 ALTER TABLE `grncartsession` DISABLE KEYS */;
/*!40000 ALTER TABLE `grncartsession` ENABLE KEYS */;


--
-- Definition of table `grnitem`
--

DROP TABLE IF EXISTS `grnitem`;
CREATE TABLE `grnitem` (
  `idGRNItem` int(11) NOT NULL AUTO_INCREMENT,
  `idUser` int(11) NOT NULL,
  `idGRN` int(11) NOT NULL,
  `idProduct` int(11) NOT NULL,
  `price` double DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  PRIMARY KEY (`idGRNItem`),
  KEY `fk_GRNItem_GRN1_idx` (`idGRN`),
  KEY `fk_GRNItem_Product1_idx` (`idProduct`),
  KEY `fk_GRNItem_User1_idx` (`idUser`),
  CONSTRAINT `fk_GRNItem_GRN1` FOREIGN KEY (`idGRN`) REFERENCES `grn` (`idGRN`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_GRNItem_Product1` FOREIGN KEY (`idProduct`) REFERENCES `product` (`idProduct`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_GRNItem_User1` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1008 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `grnitem`
--

/*!40000 ALTER TABLE `grnitem` DISABLE KEYS */;
INSERT INTO `grnitem` (`idGRNItem`,`idUser`,`idGRN`,`idProduct`,`price`,`qty`) VALUES 
 (1000,1000,1000,1000,70,100),
 (1001,1000,1000,1001,75,100),
 (1002,1000,1000,1002,80,100),
 (1003,1000,1000,1003,85,100),
 (1004,1000,1000,1004,90,100),
 (1005,1000,1000,1005,95,100),
 (1006,1000,1000,1006,100,100),
 (1007,1000,1000,1007,120,100);
/*!40000 ALTER TABLE `grnitem` ENABLE KEYS */;


--
-- Definition of table `invocartsession`
--

DROP TABLE IF EXISTS `invocartsession`;
CREATE TABLE `invocartsession` (
  `idInvoCartSession` int(11) NOT NULL AUTO_INCREMENT,
  `idStock` int(11) NOT NULL,
  `idUser` int(11) NOT NULL,
  `qty` int(11) DEFAULT NULL,
  PRIMARY KEY (`idInvoCartSession`),
  KEY `fk_InvoCartSession_User1_idx` (`idUser`),
  KEY `fk_InvoCartSession_Stock1_idx` (`idStock`),
  CONSTRAINT `fk_InvoCartSession_Stock1` FOREIGN KEY (`idStock`) REFERENCES `stock` (`idStock`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_InvoCartSession_User1` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `invocartsession`
--

/*!40000 ALTER TABLE `invocartsession` DISABLE KEYS */;
/*!40000 ALTER TABLE `invocartsession` ENABLE KEYS */;


--
-- Definition of table `invoice`
--

DROP TABLE IF EXISTS `invoice`;
CREATE TABLE `invoice` (
  `idInvoice` int(11) NOT NULL AUTO_INCREMENT,
  `idUser` int(11) NOT NULL,
  `idAddress` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `time` time DEFAULT NULL,
  `itemCount` int(11) DEFAULT NULL,
  `nettotal` double DEFAULT NULL,
  PRIMARY KEY (`idInvoice`),
  KEY `fk_Invoice_User1_idx` (`idUser`),
  KEY `fk_Invoice_Address1_idx` (`idAddress`),
  CONSTRAINT `fk_Invoice_Address1` FOREIGN KEY (`idAddress`) REFERENCES `address` (`idAddress`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Invoice_User1` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1002 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `invoice`
--

/*!40000 ALTER TABLE `invoice` DISABLE KEYS */;
INSERT INTO `invoice` (`idInvoice`,`idUser`,`idAddress`,`date`,`time`,`itemCount`,`nettotal`) VALUES 
 (1000,1000,1,'2020-12-07','15:14:00',1,150),
 (1001,1002,2,'2020-12-14','17:49:44',2,645);
/*!40000 ALTER TABLE `invoice` ENABLE KEYS */;


--
-- Definition of table `invoiceitem`
--

DROP TABLE IF EXISTS `invoiceitem`;
CREATE TABLE `invoiceitem` (
  `idInvoiceItem` int(11) NOT NULL AUTO_INCREMENT,
  `idProduct` int(11) NOT NULL,
  `idStock` int(11) NOT NULL,
  `idInvoice` int(11) NOT NULL,
  `price` double DEFAULT NULL,
  `qty` int(11) DEFAULT NULL,
  PRIMARY KEY (`idInvoiceItem`),
  KEY `fk_InvoiceItem_Invoice1_idx` (`idInvoice`),
  KEY `fk_InvoiceItem_Product1_idx` (`idProduct`),
  KEY `fk_InvoiceItem_Stock1_idx` (`idStock`),
  CONSTRAINT `fk_InvoiceItem_Invoice1` FOREIGN KEY (`idInvoice`) REFERENCES `invoice` (`idInvoice`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_InvoiceItem_Product1` FOREIGN KEY (`idProduct`) REFERENCES `product` (`idProduct`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_InvoiceItem_Stock1` FOREIGN KEY (`idStock`) REFERENCES `stock` (`idStock`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1003 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `invoiceitem`
--

/*!40000 ALTER TABLE `invoiceitem` DISABLE KEYS */;
INSERT INTO `invoiceitem` (`idInvoiceItem`,`idProduct`,`idStock`,`idInvoice`,`price`,`qty`) VALUES 
 (1000,1000,1,1000,75,2),
 (1001,1001,2,1001,85,5),
 (1002,1005,6,1001,110,2);
/*!40000 ALTER TABLE `invoiceitem` ENABLE KEYS */;


--
-- Definition of table `paymentdetails`
--

DROP TABLE IF EXISTS `paymentdetails`;
CREATE TABLE `paymentdetails` (
  `idpaymentDetails` int(11) NOT NULL AUTO_INCREMENT,
  `idUser` int(11) NOT NULL,
  `idInvoice` int(11) NOT NULL,
  `idTransaction` text,
  `idPayer` text,
  `payerEmail` text,
  `processStatus` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idpaymentDetails`),
  KEY `fk_paymentDetails_User1_idx` (`idUser`),
  KEY `fk_paymentDetails_Invoice1_idx` (`idInvoice`),
  CONSTRAINT `fk_paymentDetails_Invoice1` FOREIGN KEY (`idInvoice`) REFERENCES `invoice` (`idInvoice`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_paymentDetails_User1` FOREIGN KEY (`idUser`) REFERENCES `user` (`idUser`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=1002 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `paymentdetails`
--

/*!40000 ALTER TABLE `paymentdetails` DISABLE KEYS */;
INSERT INTO `paymentdetails` (`idpaymentDetails`,`idUser`,`idInvoice`,`idTransaction`,`idPayer`,`payerEmail`,`processStatus`) VALUES 
 (1000,1000,1000,'8W151012UN357920G','RQ6Y35SZUMMW2','saziarajapaksha-buyer@gmail.com','Ordered'),
 (1001,1002,1001,'1MJ6398406399501B','RQ6Y35SZUMMW2','saziarajapaksha-buyer@gmail.com','Working');
/*!40000 ALTER TABLE `paymentdetails` ENABLE KEYS */;


--
-- Definition of table `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE `product` (
  `idProduct` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `minumumQty` int(11) DEFAULT NULL,
  `description` text,
  `volume` varchar(45) DEFAULT NULL,
  `category` varchar(45) DEFAULT NULL,
  `gender` tinyint(4) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  `imageurl` text,
  PRIMARY KEY (`idProduct`)
) ENGINE=InnoDB AUTO_INCREMENT=1009 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `product`
--

/*!40000 ALTER TABLE `product` DISABLE KEYS */;
INSERT INTO `product` (`idProduct`,`name`,`minumumQty`,`description`,`volume`,`category`,`gender`,`status`,`imageurl`) VALUES 
 (1000,'Mr. Burberry Element',30,'Mr. Burberry Element by Burberry is a Oriental Fougere fragrance for men. This is a new fragrance. Mr. Burberry Element was launched in 2020. The nose behind this fragrance is Jerome Di Marino. Top note is green almond; middle note is juniper; base notes are mineral notes, oakmoss and ambergris.','6.7 oz ','Eau de Toilette',0,1,'1607332755237MR-BURBERRY-ELEMENT-min.png'),
 (1001,'BRIT RHYTHM INTENSE',30,'Brit Rhythm for Him Intense is announced as a more masculine edition with reinforced leather accents. It opens with accords of sage, pepper, wormwood, peppermint and caraway. The heart includes intense notes of patchouli, amber and leather, placed on the woody base of guaiac wood, tonka and cashmere.','2.5 oz','Eau de Toilette',1,1,'1607332844692BRIT-RHYTHM-INTENSE-EDT.jpg'),
 (1002,'WEEKEND FOR MEN',20,'During weekends you can indulge yourself with the comfortable, casual and relaxing character of Burberry Weekend for Men. The composition starts with a real citrusy explosion: bergamot, mandarin orange, lemon, grapefruit, followed by juicy pineapple and melon. Ivy leaves, sandalwood and oak moss are in the heart. The base is surprisingly sweet, made of amber and honey.','6.6 oz','Eau de Toilette',1,1,'1607332886141BUEBERRY-WEEKEND-FOR-MEN.png'),
 (1003,'DAVIDOFF CHAMPION EDT',20,'Davidoff Champion EDT by Davidoff, Davidhoff champion came onto the scene in 2010 and has been popular ever since . The bottle that this eau de toilette is packaged in is very unique. It is shaped like a dumbbell Ã¢?? a symbol of strength and masculinity. The perfume itself is strong too and has a personality of its own. Wearers will notice the use of citrusy accords as well as woodsy notes. The top notes are lemon and bergamot. The middle notes are clary sage and galbanum. Lastly, the bottom notes are cedar and oak moss. The overall tone of the perfume is sporty. One can expect a lot of athletic men to be enticed by this product.','3.7','Eau de Toilette',1,1,'1607333484267davidoff-champion.jpg'),
 (1004,'DAVIDOFF THE GAME',30,'Live life to the fullest. Inspire admiration with confidence and elegance. Outplay any opponent ; win any womanâ??s heart.  Top : Unique aromatic accord of Gin Fizz for a dazzling touch of style. Heart : Rich note of iris artfully faceted with vibrant spices. Base : Masculine woods & elegant vetiver.','20','Eau de Toilette',1,1,'1607333605162davidoff-the-game-men.jpg'),
 (1005,'DAVIDOFF COOL WATER',30,'DavidoffCool Water is fresh and sharp, simple and very masculine. Top notes include mint and green nuances, lavender, coriander and rosemary. The heart notes include geranium, neroli, jasmine and sandalwood. The base is composed of cedarwood, musk, amber and tobacco. It was created by Pierre Bourdon in 1988','20','Eau de Toilette',1,1,'1607333641609d-cool-water-600.jpg'),
 (1006,'212 SEXY MEN',30,'212 Sexy men perfume by Carolina Herrera, Launched in 2004 this is another great addition to the collection . Itâ??s a very seductive scent with top notes of bergamont and mandarin, middle notes of gardenia and cardamom and base notes of sandalwood and vanilla. Great for evening wear.','20','Eau de Toilette',1,1,'1607333761443212-SEXY-MEN-600.jpg'),
 (1007,'GIORGIO ARMANI ACQUA DI GIO PERFUME',30,'Profumo by Giorgio Armani is the depth and intensity of the Mediterranean Sea. It is sophisticated and intensely masculine, an ode to freshness as sea meets rock. It combines mineral marine notes with the intensity of frankincense and the seductiveness of patchouli. Elegant and impassioned, Profumo awakens the senses as it reflects desire. Creating simplicity from complexity. Finding harmony in the contrast of hot and cold, freshness and opacity, the blackest stone and the crystalline blue of the sea.  All products are original,authentic name brands,we do not sell imitations.','20','Eau de Perfume',1,1,'1607333887837giorgio-armani-acqua-di-gio-perfume-75-ml.jpg'),
 (1008,'D & G Light Blue',30,'Frolic in the essence of springtime when you wear this Light Blue eau de toilette spray for women. Released in 2001 by Dolce & Gabbana, this scintillating scent takes you on an olfactory sojourn with fruity hints of apple and Sicilian lemon that collide with fragrant cedar and romantic white rose and bellflower to leave you feeling beautiful and feminine. This scent is light enough for everyday wear yet memorable enough to save for date night and other special occasions.','2.5 oz','Eau de Toilette',0,1,'1607536365092122232.jpg');
/*!40000 ALTER TABLE `product` ENABLE KEYS */;


--
-- Definition of table `stock`
--

DROP TABLE IF EXISTS `stock`;
CREATE TABLE `stock` (
  `idStock` int(11) NOT NULL AUTO_INCREMENT,
  `idProduct` int(11) NOT NULL,
  `idGRN` int(11) NOT NULL,
  `qty` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `sellingPrice` double DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`idStock`),
  KEY `fk_Stock_Product1_idx` (`idProduct`),
  KEY `fk_Stock_GRN1_idx` (`idGRN`),
  CONSTRAINT `fk_Stock_GRN1` FOREIGN KEY (`idGRN`) REFERENCES `grn` (`idGRN`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Stock_Product1` FOREIGN KEY (`idProduct`) REFERENCES `product` (`idProduct`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `stock`
--

/*!40000 ALTER TABLE `stock` DISABLE KEYS */;
INSERT INTO `stock` (`idStock`,`idProduct`,`idGRN`,`qty`,`price`,`sellingPrice`,`status`) VALUES 
 (1,1000,1000,98,70,75,1),
 (2,1001,1000,95,75,85,1),
 (3,1002,1000,100,80,90,1),
 (4,1003,1000,100,85,90,1),
 (5,1004,1000,100,90,100,1),
 (6,1005,1000,98,95,110,1),
 (7,1006,1000,100,100,120,1),
 (8,1007,1000,100,120,150,1);
/*!40000 ALTER TABLE `stock` ENABLE KEYS */;


--
-- Definition of table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
CREATE TABLE `supplier` (
  `idSupplier` int(11) NOT NULL AUTO_INCREMENT,
  `companyName` varchar(45) DEFAULT NULL,
  `businessAddress` text,
  `email` varchar(45) DEFAULT NULL,
  `tel` varchar(45) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`idSupplier`)
) ENGINE=InnoDB AUTO_INCREMENT=1003 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `supplier`
--

/*!40000 ALTER TABLE `supplier` DISABLE KEYS */;
INSERT INTO `supplier` (`idSupplier`,`companyName`,`businessAddress`,`email`,`tel`,`status`) VALUES 
 (1000,'Devidoff','dfsf','Devidoff@marketing.com','34343434',1),
 (1001,'channel','43434343','channel@matketing.com','343434',1),
 (1002,'Mr. Burberry Element','dsadasd','Mr.BurberryElement@gmail.com','4324234',1);
/*!40000 ALTER TABLE `supplier` ENABLE KEYS */;


--
-- Definition of table `user`
--

DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `idUser` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) DEFAULT NULL,
  `dob` varchar(45) DEFAULT NULL,
  `mobileNumber` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `accountType` varchar(45) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`idUser`)
) ENGINE=InnoDB AUTO_INCREMENT=1003 DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`idUser`,`name`,`dob`,`mobileNumber`,`email`,`password`,`accountType`,`status`) VALUES 
 (1000,'sasindu','2020-12-10','546546546','c2Fzc3NhQGdtYWlsLmNvbQ==','MTIz','Admin',1),
 (1001,'admin','1996-06-15','7761999999','YWRtaW5AZ21haWwuY29t','MTIz','Admin',1),
 (1002,'user','1996-06-15','0776199378','dXNlckBnbWFpbC5jb20=','MTIz','User',1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;




/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
