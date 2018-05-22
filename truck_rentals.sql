-- MySQL dump 10.13  Distrib 5.6.23, for Win64 (x86_64)
--
-- Host: localhost    Database: truck_rentals
-- ------------------------------------------------------
-- Server version	5.7.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address`
--

DROP TABLE IF EXISTS `address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address` (
  `user_id` int(10) NOT NULL,
  `house_details` varchar(45) NOT NULL,
  `street` varchar(45) DEFAULT NULL,
  `barangay` varchar(45) DEFAULT NULL,
  `municipality` varchar(45) DEFAULT NULL,
  `city` varchar(45) DEFAULT NULL,
  `province` varchar(45) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_id_UNIQUE` (`user_id`),
  CONSTRAINT `user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `address`
--

LOCK TABLES `address` WRITE;
/*!40000 ALTER TABLE `address` DISABLE KEYS */;
INSERT INTO `address` VALUES (1,'82',NULL,'Ilog Baliwag','Quezon',NULL,'Nueva Ecija'),(2,'83',NULL,'Salt',NULL,NULL,'Benguet'),(3,'Phase 1',NULL,'Bakakeng',NULL,'Baguio City','Benguet'),(4,'Phase 2',NULL,'Bakakeng',NULL,'Baguio City','Benguet');
/*!40000 ALTER TABLE `address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin` (
  `admin_id` int(10) NOT NULL,
  `type` enum('regular','super') DEFAULT NULL,
  PRIMARY KEY (`admin_id`),
  UNIQUE KEY `user_id_UNIQUE` (`admin_id`),
  CONSTRAINT `admin_id` FOREIGN KEY (`admin_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES (4,'super');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `client`
--

DROP TABLE IF EXISTS `client`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `client` (
  `client_id` int(10) NOT NULL,
  `card_number` varchar(16) NOT NULL,
  `card_type` varchar(45) NOT NULL,
  `card_expiration_date` date NOT NULL,
  `card_cvv2` int(4) NOT NULL,
  PRIMARY KEY (`client_id`),
  UNIQUE KEY `card_number_UNIQUE` (`card_number`),
  UNIQUE KEY `user_id_UNIQUE` (`client_id`),
  CONSTRAINT `client_id` FOREIGN KEY (`client_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `client`
--

LOCK TABLES `client` WRITE;
/*!40000 ALTER TABLE `client` DISABLE KEYS */;
INSERT INTO `client` VALUES (1,'123456789','paymaya','2018-05-15',123),(3,'12458','debit','2018-01-08',2451);
/*!40000 ALTER TABLE `client` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `provider`
--

DROP TABLE IF EXISTS `provider`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `provider` (
  `provider_id` int(10) NOT NULL,
  `bank_type` varchar(45) NOT NULL,
  `bank_account_number` varchar(45) NOT NULL,
  `rating` decimal(1,1) DEFAULT NULL,
  PRIMARY KEY (`provider_id`),
  UNIQUE KEY `bank_account_number_UNIQUE` (`bank_account_number`),
  UNIQUE KEY `provider_id_UNIQUE` (`provider_id`),
  CONSTRAINT `provider_id` FOREIGN KEY (`provider_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `provider`
--

LOCK TABLES `provider` WRITE;
/*!40000 ALTER TABLE `provider` DISABLE KEYS */;
INSERT INTO `provider` VALUES (2,'BPI','123456789',NULL);
/*!40000 ALTER TABLE `provider` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactions` (
  `transaction_id` int(10) NOT NULL AUTO_INCREMENT,
  `truck_id` int(10) NOT NULL,
  `provider_id` int(10) NOT NULL,
  `client_id` int(10) NOT NULL,
  `request_status` enum('accepted','denied','pending') NOT NULL,
  `date_accepted` date DEFAULT NULL,
  `number_of_days` int(11) NOT NULL,
  `rent_start_day` date NOT NULL,
  `rent_end_day` date NOT NULL,
  PRIMARY KEY (`transaction_id`),
  UNIQUE KEY `transaction_id_UNIQUE` (`transaction_id`),
  KEY `truck_id_idx` (`truck_id`),
  KEY `client_id_idx` (`client_id`),
  KEY `provider_id_idx` (`provider_id`),
  KEY `truck_idx` (`truck_id`),
  KEY `client_idx` (`client_id`),
  KEY `provider_idx` (`provider_id`),
  CONSTRAINT `client` FOREIGN KEY (`client_id`) REFERENCES `client` (`client_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `provider` FOREIGN KEY (`provider_id`) REFERENCES `provider` (`provider_id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `truck` FOREIGN KEY (`truck_id`) REFERENCES `trucks` (`truck_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
INSERT INTO `transactions` VALUES (1,1,2,1,'pending',NULL,8,'2018-05-12','2018-05-20'),(2,2,2,1,'accepted','2018-05-13',5,'2018-05-15','2018-05-20'),(3,1,2,3,'pending',NULL,6,'2018-01-08','2018-01-14'),(4,2,2,3,'pending',NULL,3,'2018-01-08','2018-01-11');
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trucks`
--

DROP TABLE IF EXISTS `trucks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `trucks` (
  `truck_id` int(10) NOT NULL,
  `provider_id` int(10) NOT NULL,
  `name` varchar(45) NOT NULL,
  `description` varchar(100) DEFAULT NULL,
  `capacity` varchar(30) NOT NULL,
  `cost` decimal(30,2) NOT NULL,
  `category` varchar(20) NOT NULL,
  `image` longblob,
  `status` enum('available','unavailable') NOT NULL,
  `number_of_wheels` int(2) NOT NULL,
  `license_number` varchar(15) NOT NULL,
  `model` varchar(45) DEFAULT NULL,
  `color` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`truck_id`,`provider_id`),
  UNIQUE KEY `truck_id_UNIQUE` (`truck_id`),
  UNIQUE KEY `license_number_UNIQUE` (`license_number`),
  KEY `service_provider_idx` (`provider_id`),
  CONSTRAINT `service_provider` FOREIGN KEY (`provider_id`) REFERENCES `provider` (`provider_id`) ON DELETE NO ACTION ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trucks`
--

LOCK TABLES `trucks` WRITE;
/*!40000 ALTER TABLE `trucks` DISABLE KEYS */;
INSERT INTO `trucks` VALUES (1,2,'Mega Truck',NULL,'200 kg',200.00,'mega',NULL,'available',10,'ABL 7015',NULL,NULL),(2,2,'Ultra Truck',NULL,'2000 kg',2000.00,'ultra',NULL,'available',6,'ACL 7015',NULL,NULL);
/*!40000 ALTER TABLE `trucks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `user_id` int(10) NOT NULL AUTO_INCREMENT,
  `fname` varchar(45) NOT NULL,
  `mname` varchar(45) DEFAULT NULL,
  `lname` varchar(45) NOT NULL,
  `email` varchar(45) NOT NULL,
  `phone_number` varchar(16) NOT NULL,
  `date_registered` varchar(45) NOT NULL,
  `username` varchar(15) NOT NULL,
  `password` varchar(20) NOT NULL,
  `user_type` enum('client','admin','provider') NOT NULL,
  `status` enum('enabled','disabled') NOT NULL DEFAULT 'disabled',
  `request_status` enum('accepted','denied','pending') NOT NULL DEFAULT 'pending',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `user_id_UNIQUE` (`user_id`),
  UNIQUE KEY `email_UNIQUE` (`email`),
  UNIQUE KEY `phone_number_UNIQUE` (`phone_number`),
  UNIQUE KEY `username_UNIQUE` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Louel',NULL,'Lagasca','2166253@slu.edu.ph','+63 915 205 7397','2018-05-13','Oswell','lmdl.8298','client','disabled','pending'),(2,'Nikki',NULL,'Marinas','nikki@gmail.com','+63 905 205 7397','2018-05-14','Nikki','nikkipass','provider','enabled','pending'),(3,'Blessly',NULL,'Carbonell','blessly@gmail.com','+69 472 584 6311','2018-05-16','blehli','blehli','client','enabled','pending'),(4,'Kasima',NULL,'Mendoza','kasima@gmail.com','+69 731 684 2357','2018-05-17','Kasima','kasimamendoza','admin','enabled','accepted');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-05-23  0:50:45
