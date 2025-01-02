CREATE DATABASE  IF NOT EXISTS `railwaysystem` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `railwaysystem`;
-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: railwaysystem
-- ------------------------------------------------------
-- Server version	9.1.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `admin` (
  `SSN` varchar(11) NOT NULL,
  PRIMARY KEY (`SSN`),
  CONSTRAINT `admin_ibfk_1` FOREIGN KEY (`SSN`) REFERENCES `employee` (`SSN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer` (
  `username` varchar(30) NOT NULL,
  `pswd` varchar(30) NOT NULL,
  `email` varchar(30) NOT NULL,
  `FirstName` varchar(20) NOT NULL,
  `LastName` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer`
--

LOCK TABLES `customer` WRITE;
/*!40000 ALTER TABLE `customer` DISABLE KEYS */;
INSERT INTO `customer` VALUES ('customer1','c1pass','customer1@gmail.com','Charlotte','Winslow'),('customer10','c10pass','customer10@gmail.com','Isabella','Reed'),('customer11','c11pass','customer11@gmail.com','Amelia','Roberts'),('customer12','c12pass','customer12@gmail.com','Jackson','Hughes'),('customer13','c13pass','customer13@gmail.com','Victoria','Green'),('customer14','c14pass','customer14@gmail.com','Elijah','Harris'),('customer15','c15pass','customer15@gmail.com','Abigail','Wright'),('customer2','c2pass','customer1@gmail.com','Henry','Caldwell'),('customer3','c3pass','customer1@gmail.com','Grace','Thornton'),('customer4','c4pass','customer1@gmail.com','Sarah','Merritt'),('customer5','c5pass','customer1@gmail.com','Jeremy','Langston'),('customer6','c6pass','customer6@gmail.com','Nathan','Turner'),('customer7','c7pass','customer7@gmail.com','Sophia','Mitchell'),('customer8','c8pass','customer8@gmail.com','Oliver','Scott'),('customer9','c9pass','customer9@gmail.com','Evelyn','Adams'),('root','abc123','root@gmail.com','root','root'),('test','test','test@gmail.com','test','test');
/*!40000 ALTER TABLE `customer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `customer_representative`
--

DROP TABLE IF EXISTS `customer_representative`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `customer_representative` (
  `SSN` varchar(11) NOT NULL,
  PRIMARY KEY (`SSN`),
  CONSTRAINT `customer_representative_ibfk_1` FOREIGN KEY (`SSN`) REFERENCES `employee` (`SSN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `customer_representative`
--

LOCK TABLES `customer_representative` WRITE;
/*!40000 ALTER TABLE `customer_representative` DISABLE KEYS */;
INSERT INTO `customer_representative` VALUES ('111-11-1102'),('111-11-1103'),('111-11-1104'),('111-11-1105'),('111-11-1110'),('111-11-1112'),('111-11-1113'),('111-11-1114'),('111-11-1115'),('111-11-1116'),('111-11-1117'),('111-11-1118'),('111-11-1119');
/*!40000 ALTER TABLE `customer_representative` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `SSN` varchar(11) NOT NULL,
  `username` varchar(30) NOT NULL,
  `pswd` varchar(30) NOT NULL,
  `FirstName` varchar(20) NOT NULL,
  `LastName` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`SSN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES ('111-11-1101','manager11','m11pass','Charlotte','Hayes'),('111-11-1102','manager12','m12pass','Henry','Parker'),('111-11-1103','manager13','m13pass','Ava',' Collins'),('111-11-1104','manager14','m14pass','Samuel','Brooks'),('111-11-1105','manager15','m15pass','Emily','Reed'),('111-11-1110','manager10','m10pass','Jack','Morgan'),('111-11-1111','manager1','m1pass','Chase','Whitaker'),('111-11-1112','manager2','m2pass','Bob','Preston'),('111-11-1113','manager3','m3pass','Adam','White'),('111-11-1114','manager4','m4pass','Amelia','Beaumont'),('111-11-1115','manager5','m5pass','Ben','Sutton'),('111-11-1116','manager6','m6pass','Grace','Harper'),('111-11-1117','manager7','m7pass','Claire','Ellison'),('111-11-1118','manager8','m8pass','Lily',' Foster'),('111-11-1119','manager9','m9pass','Ethan','Blake');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `manager_admin`
--

DROP TABLE IF EXISTS `manager_admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `manager_admin` (
  `SSN` varchar(11) NOT NULL,
  PRIMARY KEY (`SSN`),
  CONSTRAINT `manager_admin_ibfk_1` FOREIGN KEY (`SSN`) REFERENCES `employee` (`SSN`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `manager_admin`
--

LOCK TABLES `manager_admin` WRITE;
/*!40000 ALTER TABLE `manager_admin` DISABLE KEYS */;
INSERT INTO `manager_admin` VALUES ('111-11-1111');
/*!40000 ALTER TABLE `manager_admin` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `questions`
--

DROP TABLE IF EXISTS `questions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `questions` (
  `question_id` int NOT NULL AUTO_INCREMENT,
  `customer_username` varchar(30) NOT NULL,
  `question` varchar(500) NOT NULL,
  `cust_rep_username` varchar(30) DEFAULT NULL,
  `reply` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`question_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `questions`
--

LOCK TABLES `questions` WRITE;
/*!40000 ALTER TABLE `questions` DISABLE KEYS */;
INSERT INTO `questions` VALUES (1,'customer1','test','manager2','test'),(2,'customer1','Can I cancel my Reservation?','manager2','Yes you can! Please go to the Reservations page and click View Reservations where you\'ll find an option to cancel your reservation!'),(3,'customer1','test1','manager2','test1'),(4,'customer1','test2',NULL,NULL);
/*!40000 ALTER TABLE `questions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservations`
--

DROP TABLE IF EXISTS `reservations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservations` (
  `Reservation_No` varchar(10) NOT NULL,
  `Date` date DEFAULT NULL,
  `Total_Fare` float DEFAULT NULL,
  `Passenger` varchar(50) DEFAULT NULL,
  `One_Way` tinyint(1) DEFAULT NULL,
  `Round_Trip` tinyint(1) DEFAULT NULL,
  `No_of_Tickets` int DEFAULT NULL,
  PRIMARY KEY (`Reservation_No`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservations`
--

LOCK TABLES `reservations` WRITE;
/*!40000 ALTER TABLE `reservations` DISABLE KEYS */;
INSERT INTO `reservations` VALUES ('RES1001','2024-10-05',50,'Charlotte Winslow',1,0,2),('RES1002','2024-11-12',50,'Charlotte Winslow',1,0,2),('RES1003','2024-11-28',100,'Charlotte Winslow',0,1,2),('RES1004','2024-12-01',25,'Charlotte Winslow',1,0,1),('RES1006','2024-10-08',60,'Henry Caldwell',1,0,3),('RES1007','2024-11-16',40,'Henry Caldwell',1,0,2),('RES1008','2024-12-05',20,'Henry Caldwell',1,0,1),('RES1009','2024-12-14',80,'Henry Caldwell',0,1,2),('RES1010','2024-12-24',100,'Henry Caldwell',0,1,2),('RES1011','2024-10-06',60,'Grace Thornton',1,0,2),('RES1012','2024-11-14',90,'Grace Thornton',1,0,3),('RES1013','2024-12-02',180,'Grace Thornton',0,1,3),('RES1014','2024-12-12',90,'Grace Thornton',1,0,3),('RES1015','2024-12-22',60,'Grace Thornton',0,1,1),('RES1016','2024-10-07',40,'Sarah Merritt',1,0,2),('RES1017','2024-11-15',20,'Sarah Merritt',1,0,1),('RES1018','2024-12-06',40,'Sarah Merritt',0,1,1),('RES1019','2024-12-13',40,'Sarah Merritt',0,1,1),('RES1020','2024-12-23',80,'Sarah Merritt',0,1,2),('RES1021','2024-10-09',52,'Jeremy Langston',1,0,2),('RES1022','2024-11-17',78,'Jeremy Langston',1,0,3),('RES1023','2024-12-07',52,'Jeremy Langston',1,0,2),('RES1024','2024-12-15',104,'Jeremy Langston',0,1,2),('RES1025','2024-12-25',26,'Jeremy Langston',1,0,1),('RES1026','2024-10-10',84,'Nathan Turner',1,0,3),('RES1027','2024-11-18',56,'Nathan Turner',1,0,2),('RES1028','2024-12-05',28,'Nathan Turner',1,0,1),('RES1029','2024-12-16',112,'Nathan Turner',0,1,2),('RES1030','2024-12-26',84,'Nathan Turner',1,0,3),('RES1031','2024-10-11',70,'Sophia Mitchell',1,0,2),('RES1032','2024-11-19',105,'Sophia Mitchell',1,0,3),('RES1033','2024-12-01',105,'Sophia Mitchell',0,1,3),('RES1034','2024-12-17',140,'Sophia Mitchell',0,1,4),('RES1035','2024-12-27',35,'Sophia Mitchell',1,0,1),('RES1036','2024-10-12',37,'Oliver Scott',1,0,2),('RES1037','2024-11-20',55.5,'Oliver Scott',1,0,3),('RES1038','2024-12-04',74,'Oliver Scott',0,1,2),('RES1039','2024-12-18',37,'Oliver Scott',1,0,2),('RES1040','2024-12-28',18.5,'Oliver Scott',1,0,1),('RES1041','2024-10-13',60,'Evelyn Adams',1,0,2),('RES1042','2024-11-21',120,'Evelyn Adams',1,0,4),('RES1043','2024-12-03',90,'Evelyn Adams',0,1,1),('RES1044','2024-12-19',60,'Evelyn Adams',0,1,1),('RES1045','2024-12-29',90,'Evelyn Adams',0,1,1),('RES1046','2024-10-05',50,'Isabella Reed',1,0,2),('RES1047','2024-11-12',75,'Isabella Reed',0,1,3),('RES1048','2024-11-28',25,'Isabella Reed',1,0,1),('RES1049','2024-12-01',50,'Isabella Reed',0,1,2),('RES1050','2024-12-10',75,'Isabella Reed',0,1,3),('RES1051','2024-10-06',60,'Amelia Roberts',1,0,2),('RES1052','2024-11-14',90,'Amelia Roberts',1,0,3),('RES1053','2024-12-02',120,'Amelia Roberts',0,1,2),('RES1054','2024-12-12',30,'Amelia Roberts',1,0,1),('RES1055','2024-12-22',90,'Amelia Roberts',0,1,3),('RES1056','2024-10-07',40,'Jackson Hughes',1,0,2),('RES1057','2024-11-15',60,'Jackson Hughes',0,1,3),('RES1058','2024-12-06',20,'Jackson Hughes',1,0,1),('RES1059','2024-12-13',40,'Jackson Hughes',0,1,2),('RES1060','2024-12-23',20,'Jackson Hughes',1,0,1),('RES1061','2024-10-09',52,'Victoria Green',1,0,2),('RES1062','2024-11-17',26,'Victoria Green',1,0,1),('RES1063','2024-12-07',104,'Victoria Green',0,1,4),('RES1064','2024-12-15',78,'Victoria Green',1,0,3),('RES1065','2024-12-25',52,'Victoria Green',1,0,2),('RES1066','2024-10-10',84,'Elijah Harris',1,0,3),('RES1067','2024-11-18',56,'Elijah Harris',1,0,2),('RES1068','2024-12-05',28,'Elijah Harris',1,0,1),('RES1069','2024-12-16',112,'Elijah Harris',0,1,2),('RES1070','2024-12-26',84,'Elijah Harris',0,1,3),('RES1071','2024-10-11',105,'Abigail Wright',0,1,3),('RES1072','2024-11-19',35,'Abigail Wright',1,0,1),('RES1073','2024-12-01',70,'Abigail Wright',1,0,2),('RES1074','2024-12-17',140,'Abigail Wright',0,1,4),('RES1075','2024-12-27',35,'Abigail Wright',1,0,1),('RES1076','2024-10-05',25,'root root',1,0,1),('RES1077','2024-11-12',50,'root root',1,0,2),('RES1078','2024-11-28',75,'root root',0,1,3),('RES1079','2024-12-01',50,'root root',0,1,2),('RES1080','2024-12-10',25,'root root',1,0,1);
/*!40000 ALTER TABLE `reservations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `station`
--

DROP TABLE IF EXISTS `station`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `station` (
  `Station_ID` char(10) NOT NULL,
  `Name` varchar(30) DEFAULT NULL,
  `City` varchar(28) DEFAULT NULL,
  `State` varchar(25) DEFAULT NULL,
  PRIMARY KEY (`Station_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `station`
--

LOCK TABLES `station` WRITE;
/*!40000 ALTER TABLE `station` DISABLE KEYS */;
INSERT INTO `station` VALUES ('ST001','New York Penn','New York','New York'),('ST002','Newark Penn','Newark','New Jersey'),('ST003','Trenton','Trenton','New Jersey'),('ST004','Princeton Junction','Princeton','New Jersey'),('ST005','New Brunswick','New Brunswick','New Jersey'),('ST006','Edison','Edison','New Jersey'),('ST007','Metropark','Iselin','New Jersey'),('ST008','Philadelphia 30th Street','Philadelphia','Pennsylvania'),('ST009','Secaucus Junction','Secaucus','New Jersey'),('ST010','Hoboken Terminal','Hoboken','New Jersey'),('ST011','Stamford Station','Stamford','Connecticut'),('ST012','Summit','Summit','New Jersey'),('ST013','Jamaica Station','Queens','New York'),('ST014','Rutherford','Rutherford','New Jersey'),('ST015','Bay Head','Bay Head','New Jersey'),('ST016','Red Bank','Red Bank','New Jersey'),('ST017','Long Branch','Long Branch','New Jersey'),('ST018','Dover','Dover','New Jersey'),('ST019','Hackettstown','Hackettstown','New Jersey'),('ST020','Atlantic City','Atlantic City','New Jersey');
/*!40000 ALTER TABLE `station` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `train`
--

DROP TABLE IF EXISTS `train`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `train` (
  `Train_no` int NOT NULL,
  PRIMARY KEY (`Train_no`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `train`
--

LOCK TABLES `train` WRITE;
/*!40000 ALTER TABLE `train` DISABLE KEYS */;
INSERT INTO `train` VALUES (1001),(1002),(1003),(1004),(1005),(1006),(1007),(1008),(1009),(1010),(1011),(1012),(1013),(1014),(1015),(1016),(1017),(1018),(1019),(1020);
/*!40000 ALTER TABLE `train` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `train_schedule`
--

DROP TABLE IF EXISTS `train_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `train_schedule` (
  `Train_No` char(4) NOT NULL,
  `Transit_Line_Name` varchar(30) DEFAULT NULL,
  `Origin` varchar(30) DEFAULT NULL,
  `Departure_Datetime` datetime NOT NULL,
  `Arrival_Datetime` datetime DEFAULT NULL,
  `Stops` varchar(30) DEFAULT NULL,
  `Travel_Time` time DEFAULT NULL,
  `Destination` varchar(30) DEFAULT NULL,
  `Fare` float DEFAULT NULL,
  PRIMARY KEY (`Train_No`,`Departure_Datetime`),
  KEY `Transit_Line_Name` (`Transit_Line_Name`),
  CONSTRAINT `train_schedule_ibfk_1` FOREIGN KEY (`Transit_Line_Name`) REFERENCES `transit_line` (`Transit_Line_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `train_schedule`
--

LOCK TABLES `train_schedule` WRITE;
/*!40000 ALTER TABLE `train_schedule` DISABLE KEYS */;
INSERT INTO `train_schedule` VALUES ('1001','Northeast Corridor','New York Penn','2024-10-02 06:00:00','2024-10-02 08:30:00','ST001,ST002,ST003,ST004','02:30:00','Trenton',25),('1001','Northeast Corridor','New York Penn','2024-10-05 06:00:00','2024-10-05 08:30:00','ST001,ST002,ST003,ST004','02:30:00','Trenton',25),('1001','Northeast Corridor','New York Penn','2024-10-05 10:00:00','2024-10-05 12:30:00','ST001,ST002,ST003,ST004','02:30:00','Trenton',25),('1001','Northeast Corridor','New York Penn','2024-10-05 14:00:00','2024-10-05 16:30:00','ST001,ST002,ST003,ST004','02:30:00','Trenton',25),('1001','Northeast Corridor','New York Penn','2024-11-12 06:15:00','2024-11-12 08:45:00','ST001,ST002,ST003,ST004','02:30:00','Trenton',25),('1001','Northeast Corridor','New York Penn','2024-11-28 07:00:00','2024-11-28 09:30:00','ST001,ST002,ST003,ST004','02:30:00','Trenton',25),('1001','Northeast Corridor','New York Penn','2024-12-01 06:00:00','2024-12-01 08:30:00','ST001,ST002,ST003,ST004','02:30:00','Trenton',25),('1001','Northeast Corridor','New York Penn','2024-12-10 06:30:00','2024-12-10 09:00:00','ST001,ST002,ST003,ST004','02:30:00','Trenton',25),('1001','Northeast Corridor','New York Penn','2024-12-12 10:30:00','2024-12-12 13:00:00','ST001,ST002,ST003,ST004','02:30:00','Trenton',25),('1001','Northeast Corridor','New York Penn','2024-12-13 08:30:00','2024-12-13 11:00:00','ST001,ST002,ST003,ST004','02:30:00','Trenton',25),('1002','Northeast Corridor','Trenton','2024-10-05 09:00:00','2024-10-05 11:30:00','ST003,ST004,ST005,ST001','02:30:00','New York Penn',25),('1002','Northeast Corridor','Trenton','2024-10-05 11:00:00','2024-10-05 13:30:00','ST003,ST004,ST005,ST001','02:30:00','New York Penn',25),('1002','Northeast Corridor','Trenton','2024-10-05 15:00:00','2024-10-05 17:30:00','ST003,ST004,ST005,ST001','02:30:00','New York Penn',25),('1002','Northeast Corridor','Trenton','2024-11-13 09:15:00','2024-11-13 11:45:00','ST003,ST004,ST005,ST001','02:30:00','New York Penn',25),('1002','Northeast Corridor','Trenton','2024-12-01 09:00:00','2024-12-01 11:30:00','ST003,ST004,ST005,ST001','02:30:00','New York Penn',25),('1002','Northeast Corridor','Trenton','2024-12-11 09:30:00','2024-12-11 12:00:00','ST003,ST004,ST005,ST001','02:30:00','New York Penn',25),('1002','Northeast Corridor','Trenton','2024-12-20 10:00:00','2024-12-20 12:30:00','ST003,ST004,ST005,ST001','02:30:00','New York Penn',25),('1003','North Jersey Coast Line','Secaucus Junction','2024-10-06 09:30:00','2024-10-06 12:00:00','ST009,ST016,ST015,ST017','02:30:00','Bay Head',30),('1003','North Jersey Coast Line','Secaucus Junction','2024-10-06 11:30:00','2024-10-06 14:00:00','ST009,ST016,ST015,ST017','02:30:00','Bay Head',30),('1003','North Jersey Coast Line','Secaucus Junction','2024-10-06 13:30:00','2024-10-06 16:00:00','ST009,ST016,ST015,ST017','02:30:00','Bay Head',30),('1003','North Jersey Coast Line','Secaucus Junction','2024-11-14 09:45:00','2024-11-14 12:15:00','ST009,ST016,ST015,ST017','02:30:00','Bay Head',30),('1003','North Jersey Coast Line','Secaucus Junction','2024-12-02 09:30:00','2024-12-02 12:00:00','ST009,ST016,ST015,ST017','02:30:00','Bay Head',30),('1003','North Jersey Coast Line','Secaucus Junction','2024-12-12 10:00:00','2024-12-12 12:30:00','ST009,ST016,ST015,ST017','02:30:00','Bay Head',30),('1003','North Jersey Coast Line','Secaucus Junction','2024-12-13 07:00:00','2024-12-13 09:30:00','ST009,ST016,ST015,ST017','02:30:00','Bay Head',30),('1003','North Jersey Coast Line','Secaucus Junction','2024-12-14 12:00:00','2024-12-14 14:30:00','ST009,ST016,ST015,ST017','02:30:00','Bay Head',30),('1003','North Jersey Coast Line','Secaucus Junction','2024-12-22 10:15:00','2024-12-22 12:45:00','ST009,ST016,ST015,ST017','02:30:00','Bay Head',30),('1004','North Jersey Coast Line','Bay Head','2024-10-06 05:45:00','2024-10-06 08:15:00','ST015,ST016,ST017,ST009','02:30:00','Secaucus Junction',30),('1004','North Jersey Coast Line','Bay Head','2024-10-06 07:15:00','2024-10-06 09:45:00','ST015,ST016,ST017,ST009','02:30:00','Secaucus Junction',30),('1004','North Jersey Coast Line','Bay Head','2024-10-06 09:15:00','2024-10-06 11:45:00','ST015,ST016,ST017,ST009','02:30:00','Secaucus Junction',30),('1004','North Jersey Coast Line','Bay Head','2024-11-14 06:00:00','2024-11-14 08:30:00','ST015,ST016,ST017,ST009','02:30:00','Secaucus Junction',30),('1004','North Jersey Coast Line','Bay Head','2024-12-02 05:45:00','2024-12-02 08:15:00','ST015,ST016,ST017,ST009','02:30:00','Secaucus Junction',30),('1004','North Jersey Coast Line','Bay Head','2024-12-12 06:15:00','2024-12-12 08:45:00','ST015,ST016,ST017,ST009','02:30:00','Secaucus Junction',30),('1004','North Jersey Coast Line','Bay Head','2024-12-22 06:30:00','2024-12-22 09:00:00','ST015,ST016,ST017,ST009','02:30:00','Secaucus Junction',30),('1005','Main/Bergen County Line','Rutherford','2024-10-07 05:30:00','2024-10-07 07:15:00','ST014,ST009,ST002','01:45:00','Newark Penn',20),('1005','Main/Bergen County Line','Rutherford','2024-10-07 07:45:00','2024-10-07 09:30:00','ST014,ST009,ST002','01:45:00','Newark Penn',20),('1005','Main/Bergen County Line','Rutherford','2024-10-07 09:15:00','2024-10-07 11:00:00','ST014,ST009,ST002','01:45:00','Newark Penn',20),('1005','Main/Bergen County Line','Rutherford','2024-11-15 05:45:00','2024-11-15 07:30:00','ST014,ST009,ST002','01:45:00','Newark Penn',20),('1005','Main/Bergen County Line','Rutherford','2024-12-06 05:30:00','2024-12-06 07:15:00','ST014,ST009,ST002','01:45:00','Newark Penn',20),('1005','Main/Bergen County Line','Rutherford','2024-12-13 06:00:00','2024-12-13 07:45:00','ST014,ST009,ST002','01:45:00','Newark Penn',20),('1005','Main/Bergen County Line','Rutherford','2024-12-14 06:45:00','2024-12-14 08:30:00','ST014,ST009,ST002','01:45:00','Newark Penn',20),('1005','Main/Bergen County Line','Rutherford','2024-12-16 09:00:00','2024-12-16 10:45:00','ST014,ST009,ST002','01:45:00','Newark Penn',20),('1005','Main/Bergen County Line','Rutherford','2024-12-23 06:15:00','2024-12-23 08:00:00','ST014,ST009,ST002','01:45:00','Newark Penn',20),('1006','Main/Bergen County Line','Newark Penn','2024-10-07 08:00:00','2024-10-07 09:45:00','ST002,ST009,ST014','01:45:00','Rutherford',20),('1006','Main/Bergen County Line','Newark Penn','2024-10-07 10:00:00','2024-10-07 11:45:00','ST002,ST009,ST014','01:45:00','Rutherford',20),('1006','Main/Bergen County Line','Newark Penn','2024-10-07 12:00:00','2024-10-07 13:45:00','ST002,ST009,ST014','01:45:00','Rutherford',20),('1006','Main/Bergen County Line','Newark Penn','2024-11-15 08:15:00','2024-11-15 10:00:00','ST002,ST009,ST014','01:45:00','Rutherford',20),('1006','Main/Bergen County Line','Newark Penn','2024-12-06 08:00:00','2024-12-06 09:45:00','ST002,ST009,ST014','01:45:00','Rutherford',20),('1006','Main/Bergen County Line','Newark Penn','2024-12-13 08:30:00','2024-12-13 10:15:00','ST002,ST009,ST014','01:45:00','Rutherford',20),('1006','Main/Bergen County Line','Newark Penn','2024-12-23 08:15:00','2024-12-23 10:00:00','ST002,ST009,ST014','01:45:00','Rutherford',20),('1006','Main/Bergen County Line','Newark Penn','2024-12-23 08:45:00','2024-12-23 10:30:00','ST002,ST009,ST014','01:45:00','Rutherford',20),('1006','Main/Bergen County Line','Newark Penn','2024-12-24 11:00:00','2024-12-24 12:45:00','ST002,ST009,ST014','01:45:00','Rutherford',20),('1007','Raritan Valley Line','Summit','2024-10-08 06:30:00','2024-10-08 08:30:00','ST012,ST002','02:00:00','Newark Penn',20),('1007','Raritan Valley Line','Summit','2024-10-08 08:30:00','2024-10-08 10:30:00','ST012,ST002','02:00:00','Newark Penn',20),('1007','Raritan Valley Line','Summit','2024-10-08 10:30:00','2024-10-08 12:30:00','ST012,ST002','02:00:00','Newark Penn',20),('1007','Raritan Valley Line','Summit','2024-11-16 06:45:00','2024-11-16 08:45:00','ST012,ST002','02:00:00','Newark Penn',20),('1007','Raritan Valley Line','Summit','2024-12-05 06:30:00','2024-12-05 08:30:00','ST012,ST002','02:00:00','Newark Penn',20),('1007','Raritan Valley Line','Summit','2024-12-14 07:00:00','2024-12-14 09:00:00','ST012,ST002','02:00:00','Newark Penn',20),('1007','Raritan Valley Line','Summit','2024-12-15 08:00:00','2024-12-15 10:00:00','ST012,ST002','02:00:00','Newark Penn',20),('1007','Raritan Valley Line','Summit','2024-12-16 11:30:00','2024-12-16 13:30:00','ST012,ST002','02:00:00','Newark Penn',20),('1007','Raritan Valley Line','Summit','2024-12-21 06:15:00','2024-12-21 08:15:00','ST012,ST002','02:00:00','Newark Penn',20),('1007','Raritan Valley Line','Summit','2024-12-22 11:00:00','2024-12-22 13:00:00','ST012,ST002','02:00:00','Newark Penn',20),('1007','Raritan Valley Line','Summit','2024-12-24 07:15:00','2024-12-24 09:15:00','ST012,ST002','02:00:00','Newark Penn',20),('1008','Raritan Valley Line','Newark Penn','2024-10-08 09:00:00','2024-10-08 11:00:00','ST002,ST012','02:00:00','Summit',20),('1008','Raritan Valley Line','Newark Penn','2024-10-08 11:30:00','2024-10-08 13:30:00','ST002,ST012','02:00:00','Summit',20),('1008','Raritan Valley Line','Newark Penn','2024-10-08 13:30:00','2024-10-08 15:30:00','ST002,ST012','02:00:00','Summit',20),('1008','Raritan Valley Line','Newark Penn','2024-11-16 09:15:00','2024-11-16 11:15:00','ST002,ST012','02:00:00','Summit',20),('1008','Raritan Valley Line','Newark Penn','2024-12-06 09:00:00','2024-12-06 11:00:00','ST002,ST012','02:00:00','Summit',20),('1008','Raritan Valley Line','Newark Penn','2024-12-14 09:30:00','2024-12-14 11:30:00','ST002,ST012','02:00:00','Summit',20),('1008','Raritan Valley Line','Newark Penn','2024-12-24 09:45:00','2024-12-24 11:45:00','ST002,ST012','02:00:00','Summit',20),('1009','Montclair-Boonton Line','Secaucus Junction','2024-10-09 09:30:00','2024-10-09 12:00:00','ST009,ST011,ST013','02:30:00','Jamaica Station',26),('1009','Montclair-Boonton Line','Secaucus Junction','2024-10-09 12:30:00','2024-10-09 15:00:00','ST009,ST011,ST013','02:30:00','Jamaica Station',26),('1009','Montclair-Boonton Line','Secaucus Junction','2024-10-09 14:30:00','2024-10-09 17:00:00','ST009,ST011,ST013','02:30:00','Jamaica Station',26),('1009','Montclair-Boonton Line','Secaucus Junction','2024-11-17 09:45:00','2024-11-17 12:15:00','ST009,ST011,ST013','02:30:00','Jamaica Station',26),('1009','Montclair-Boonton Line','Secaucus Junction','2024-12-07 09:30:00','2024-12-07 12:00:00','ST009,ST011,ST013','02:30:00','Jamaica Station',26),('1009','Montclair-Boonton Line','Secaucus Junction','2024-12-13 11:00:00','2024-12-13 13:30:00','ST009,ST011,ST013','02:30:00','Jamaica Station',26),('1009','Montclair-Boonton Line','Secaucus Junction','2024-12-14 14:00:00','2024-12-14 16:30:00','ST009,ST011,ST013','02:30:00','Jamaica Station',26),('1009','Montclair-Boonton Line','Secaucus Junction','2024-12-15 10:00:00','2024-12-15 12:30:00','ST009,ST011,ST013','02:30:00','Jamaica Station',26),('1009','Montclair-Boonton Line','Secaucus Junction','2024-12-25 10:15:00','2024-12-25 12:45:00','ST009,ST011,ST013','02:30:00','Jamaica Station',26),('1010','Montclair-Boonton Line','Jamaica Station','2024-10-09 06:15:00','2024-10-09 08:45:00','ST013,ST011,ST009','02:30:00','Secaucus Junction',26),('1010','Montclair-Boonton Line','Jamaica Station','2024-10-09 08:45:00','2024-10-09 11:15:00','ST013,ST011,ST009','02:30:00','Secaucus Junction',26),('1010','Montclair-Boonton Line','Jamaica Station','2024-10-09 10:45:00','2024-10-09 13:15:00','ST013,ST011,ST009','02:30:00','Secaucus Junction',26),('1010','Montclair-Boonton Line','Jamaica Station','2024-11-17 06:30:00','2024-11-17 09:00:00','ST013,ST011,ST009','02:30:00','Secaucus Junction',26),('1010','Montclair-Boonton Line','Jamaica Station','2024-12-07 06:15:00','2024-12-07 08:45:00','ST013,ST011,ST009','02:30:00','Secaucus Junction',26),('1010','Montclair-Boonton Line','Jamaica Station','2024-12-15 06:45:00','2024-12-15 09:15:00','ST013,ST011,ST009','02:30:00','Secaucus Junction',26),('1010','Montclair-Boonton Line','Jamaica Station','2024-12-25 07:00:00','2024-12-25 09:30:00','ST013,ST011,ST009','02:30:00','Secaucus Junction',26),('1011','Atlantic City Line','Atlantic City','2024-10-10 07:30:00','2024-10-10 10:00:00','ST020,ST008','02:30:00','Philadelphia 30th Street',28),('1011','Atlantic City Line','Atlantic City','2024-10-10 10:15:00','2024-10-10 12:45:00','ST020,ST008','02:30:00','Philadelphia 30th Street',28),('1011','Atlantic City Line','Atlantic City','2024-10-10 12:15:00','2024-10-10 14:45:00','ST020,ST008','02:30:00','Philadelphia 30th Street',28),('1011','Atlantic City Line','Atlantic City','2024-11-18 07:45:00','2024-11-18 10:15:00','ST020,ST008','02:30:00','Philadelphia 30th Street',28),('1011','Atlantic City Line','Atlantic City','2024-12-05 07:30:00','2024-12-05 10:00:00','ST020,ST008','02:30:00','Philadelphia 30th Street',28),('1011','Atlantic City Line','Atlantic City','2024-12-13 10:30:00','2024-12-13 13:00:00','ST020,ST008','02:30:00','Philadelphia 30th Street',28),('1011','Atlantic City Line','Atlantic City','2024-12-14 15:00:00','2024-12-14 17:30:00','ST020,ST008','02:30:00','Philadelphia 30th Street',28),('1011','Atlantic City Line','Atlantic City','2024-12-16 08:00:00','2024-12-16 10:30:00','ST020,ST008','02:30:00','Philadelphia 30th Street',28),('1011','Atlantic City Line','Philadelphia 30th Street','2024-12-18 08:15:00','2024-12-18 10:45:00','ST008,ST020','02:30:00','Atlantic City',28),('1011','Atlantic City Line','Philadelphia 30th Street','2024-12-19 12:00:00','2024-12-19 14:30:00','ST008,ST020','02:30:00','Atlantic City',28),('1011','Atlantic City Line','Atlantic City','2024-12-26 08:15:00','2024-12-26 10:45:00','ST020,ST008','02:30:00','Philadelphia 30th Street',28),('1012','Atlantic City Line','Philadelphia 30th Street','2024-10-10 11:30:00','2024-10-10 14:00:00','ST008,ST020','02:30:00','Atlantic City',28),('1012','Atlantic City Line','Philadelphia 30th Street','2024-10-10 14:30:00','2024-10-10 17:00:00','ST008,ST020','02:30:00','Atlantic City',28),('1012','Atlantic City Line','Philadelphia 30th Street','2024-10-10 16:30:00','2024-10-10 19:00:00','ST008,ST020','02:30:00','Atlantic City',28),('1012','Atlantic City Line','Philadelphia 30th Street','2024-11-18 11:45:00','2024-11-18 14:15:00','ST008,ST020','02:30:00','Atlantic City',28),('1012','Atlantic City Line','Philadelphia 30th Street','2024-12-05 11:30:00','2024-12-05 14:00:00','ST008,ST020','02:30:00','Atlantic City',28),('1012','Atlantic City Line','Philadelphia 30th Street','2024-12-16 12:00:00','2024-12-16 14:30:00','ST008,ST020','02:30:00','Atlantic City',28),('1012','Atlantic City Line','Philadelphia 30th Street','2024-12-26 12:15:00','2024-12-26 14:45:00','ST008,ST020','02:30:00','Atlantic City',28),('1013','Northeast Corridor','Stamford Station','2024-10-11 06:30:00','2024-10-11 08:45:00','ST011,ST002,ST001','02:15:00','New York Penn',35),('1013','Northeast Corridor','Stamford Station','2024-10-11 09:30:00','2024-10-11 11:45:00','ST011,ST002,ST001','02:15:00','New York Penn',35),('1013','Northeast Corridor','Stamford Station','2024-10-11 12:00:00','2024-10-11 14:15:00','ST011,ST002,ST001','02:15:00','New York Penn',35),('1013','Northeast Corridor','Stamford Station','2024-11-19 06:45:00','2024-11-19 09:00:00','ST011,ST002,ST001','02:15:00','New York Penn',35),('1013','Northeast Corridor','Stamford Station','2024-12-01 06:30:00','2024-12-01 08:45:00','ST011,ST002,ST001','02:15:00','New York Penn',35),('1013','Northeast Corridor','Stamford Station','2024-12-17 07:00:00','2024-12-17 09:15:00','ST011,ST002,ST001','02:15:00','New York Penn',35),('1013','Northeast Corridor','Stamford Station','2024-12-19 09:15:00','2024-12-19 11:30:00','ST011,ST002,ST001','02:15:00','New York Penn',35),('1013','Northeast Corridor','Stamford Station','2024-12-20 14:00:00','2024-12-20 16:15:00','ST011,ST002,ST001','02:15:00','New York Penn',35),('1013','Northeast Corridor','Stamford Station','2024-12-27 07:15:00','2024-12-27 09:30:00','ST011,ST002,ST001','02:15:00','New York Penn',35),('1014','Northeast Corridor','New York Penn','2024-10-11 09:00:00','2024-10-11 11:15:00','ST001,ST002,ST011','02:15:00','Stamford Station',35),('1014','Northeast Corridor','New York Penn','2024-10-11 12:30:00','2024-10-11 14:45:00','ST001,ST002,ST011','02:15:00','Stamford Station',35),('1014','Northeast Corridor','New York Penn','2024-10-11 15:00:00','2024-10-11 17:15:00','ST001,ST002,ST011','02:15:00','Stamford Station',35),('1014','Northeast Corridor','New York Penn','2024-11-19 09:15:00','2024-11-19 11:30:00','ST001,ST002,ST011','02:15:00','Stamford Station',35),('1014','Northeast Corridor','New York Penn','2024-12-02 09:00:00','2024-12-02 11:15:00','ST001,ST002,ST011','02:15:00','Stamford Station',35),('1014','Northeast Corridor','New York Penn','2024-12-17 09:30:00','2024-12-17 11:45:00','ST001,ST002,ST011','02:15:00','Stamford Station',35),('1014','Northeast Corridor','New York Penn','2024-12-27 09:45:00','2024-12-27 12:00:00','ST001,ST002,ST011','02:15:00','Stamford Station',35),('1015','Morris & Essex Line','Dover','2024-10-12 06:45:00','2024-10-12 08:30:00','ST018,ST014,ST008','01:45:00','Hoboken Terminal',18.5),('1015','Morris & Essex Line','Dover','2024-10-12 09:15:00','2024-10-12 11:00:00','ST018,ST014,ST008','01:45:00','Hoboken Terminal',18.5),('1015','Morris & Essex Line','Dover','2024-10-12 11:30:00','2024-10-12 13:15:00','ST018,ST014,ST008','01:45:00','Hoboken Terminal',18.5),('1015','Morris & Essex Line','Dover','2024-11-20 07:00:00','2024-11-20 08:45:00','ST018,ST014,ST008','01:45:00','Hoboken Terminal',18.5),('1015','Morris & Essex Line','Dover','2024-12-04 06:45:00','2024-12-04 08:30:00','ST018,ST014,ST008','01:45:00','Hoboken Terminal',18.5),('1015','Morris & Essex Line','Dover','2024-12-14 07:15:00','2024-12-14 09:00:00','ST018,ST014,ST008','01:45:00','Hoboken Terminal',18.5),('1015','Morris & Essex Line','Dover','2024-12-16 10:15:00','2024-12-16 12:00:00','ST018,ST014,ST008','01:45:00','Hoboken Terminal',18.5),('1015','Morris & Essex Line','Dover','2024-12-18 07:15:00','2024-12-18 09:00:00','ST018,ST014,ST008','01:45:00','Hoboken Terminal',18.5),('1015','Morris & Essex Line','Dover','2024-12-22 09:00:00','2024-12-22 10:45:00','ST018,ST014,ST008','01:45:00','Hoboken Terminal',18.5),('1015','Morris & Essex Line','Dover','2024-12-23 13:00:00','2024-12-23 14:45:00','ST018,ST014,ST008','01:45:00','Hoboken Terminal',18.5),('1015','Morris & Essex Line','Dover','2024-12-28 07:30:00','2024-12-28 09:15:00','ST018,ST014,ST008','01:45:00','Hoboken Terminal',18.5),('1016','Morris & Essex Line','Hoboken Terminal','2024-10-12 09:15:00','2024-10-12 11:00:00','ST008,ST014,ST018','01:45:00','Dover',18.5),('1016','Morris & Essex Line','Hoboken Terminal','2024-10-12 12:00:00','2024-10-12 13:45:00','ST008,ST014,ST018','01:45:00','Dover',18.5),('1016','Morris & Essex Line','Hoboken Terminal','2024-10-12 14:15:00','2024-10-12 16:00:00','ST008,ST014,ST018','01:45:00','Dover',18.5),('1016','Morris & Essex Line','Hoboken Terminal','2024-11-20 09:30:00','2024-11-20 11:15:00','ST008,ST014,ST018','01:45:00','Dover',18.5),('1016','Morris & Essex Line','Hoboken Terminal','2024-12-04 09:15:00','2024-12-04 11:00:00','ST008,ST014,ST018','01:45:00','Dover',18.5),('1016','Morris & Essex Line','Hoboken Terminal','2024-12-18 09:45:00','2024-12-18 11:30:00','ST008,ST014,ST018','01:45:00','Dover',18.5),('1016','Morris & Essex Line','Hoboken Terminal','2024-12-28 10:00:00','2024-12-28 11:45:00','ST008,ST014,ST018','01:45:00','Dover',18.5),('1017','North Jersey Coast Line','Long Branch','2024-10-13 07:00:00','2024-10-13 09:30:00','ST016,ST015,ST009','02:30:00','Hoboken Terminal',30),('1017','North Jersey Coast Line','Long Branch','2024-10-13 09:15:00','2024-10-13 11:45:00','ST016,ST015,ST009','02:30:00','Hoboken Terminal',30),('1017','North Jersey Coast Line','Long Branch','2024-10-13 12:00:00','2024-10-13 14:30:00','ST016,ST015,ST009','02:30:00','Hoboken Terminal',30),('1017','North Jersey Coast Line','Long Branch','2024-11-21 07:15:00','2024-11-21 09:45:00','ST016,ST015,ST009','02:30:00','Hoboken Terminal',30),('1017','North Jersey Coast Line','Long Branch','2024-12-03 07:00:00','2024-12-03 09:30:00','ST016,ST015,ST009','02:30:00','Hoboken Terminal',30),('1017','North Jersey Coast Line','Long Branch','2024-12-17 08:00:00','2024-12-17 10:30:00','ST016,ST015,ST009','02:30:00','Hoboken Terminal',30),('1017','North Jersey Coast Line','Long Branch','2024-12-18 11:30:00','2024-12-18 14:00:00','ST016,ST015,ST009','02:30:00','Hoboken Terminal',30),('1017','North Jersey Coast Line','Long Branch','2024-12-19 07:30:00','2024-12-19 10:00:00','ST016,ST015,ST009','02:30:00','Hoboken Terminal',30),('1017','North Jersey Coast Line','Long Branch','2024-12-29 07:45:00','2024-12-29 10:15:00','ST016,ST015,ST009','02:30:00','Hoboken Terminal',30),('1018','North Jersey Coast Line','Hoboken Terminal','2024-10-13 10:00:00','2024-10-13 12:30:00','ST009,ST015,ST016','02:30:00','Long Branch',30),('1018','North Jersey Coast Line','Hoboken Terminal','2024-10-13 13:00:00','2024-10-13 15:30:00','ST009,ST015,ST016','02:30:00','Long Branch',30),('1018','North Jersey Coast Line','Hoboken Terminal','2024-10-13 15:45:00','2024-10-13 18:15:00','ST009,ST015,ST016','02:30:00','Long Branch',30),('1018','North Jersey Coast Line','Hoboken Terminal','2024-11-21 10:15:00','2024-11-21 12:45:00','ST009,ST015,ST016','02:30:00','Long Branch',30),('1018','North Jersey Coast Line','Hoboken Terminal','2024-12-04 10:00:00','2024-12-04 12:30:00','ST009,ST015,ST016','02:30:00','Long Branch',30),('1018','North Jersey Coast Line','Hoboken Terminal','2024-12-19 10:30:00','2024-12-19 13:00:00','ST009,ST015,ST016','02:30:00','Long Branch',30),('1018','North Jersey Coast Line','Hoboken Terminal','2024-12-20 07:30:00','2024-12-20 10:00:00','ST009,ST015,ST016','02:30:00','Long Branch',30),('1018','North Jersey Coast Line','Hoboken Terminal','2024-12-21 13:00:00','2024-12-21 15:30:00','ST009,ST015,ST016','02:30:00','Long Branch',30),('1018','North Jersey Coast Line','Hoboken Terminal','2024-12-29 10:45:00','2024-12-29 13:15:00','ST009,ST015,ST016','02:30:00','Long Branch',30),('1019','Raritan Valley Line','Hackettstown','2024-10-14 07:15:00','2024-10-14 09:45:00','ST019,ST012,ST005,ST002','02:30:00','Newark Penn',22),('1019','Raritan Valley Line','Hackettstown','2024-10-14 09:45:00','2024-10-14 12:15:00','ST019,ST012,ST005,ST002','02:30:00','Newark Penn',22),('1019','Raritan Valley Line','Hackettstown','2024-10-14 12:30:00','2024-10-14 15:00:00','ST019,ST012,ST005,ST002','02:30:00','Newark Penn',22),('1019','Raritan Valley Line','Hackettstown','2024-11-22 07:30:00','2024-11-22 10:00:00','ST019,ST012,ST005,ST002','02:30:00','Newark Penn',22),('1019','Raritan Valley Line','Hackettstown','2024-12-03 07:15:00','2024-12-03 09:45:00','ST019,ST012,ST005,ST002','02:30:00','Newark Penn',22),('1019','Raritan Valley Line','Hackettstown','2024-12-18 09:15:00','2024-12-18 11:45:00','ST019,ST012,ST005,ST002','02:30:00','Newark Penn',22),('1019','Raritan Valley Line','Hackettstown','2024-12-19 13:00:00','2024-12-19 15:30:00','ST019,ST012,ST005,ST002','02:30:00','Newark Penn',22),('1019','Raritan Valley Line','Hackettstown','2024-12-20 07:45:00','2024-12-20 10:15:00','ST019,ST012,ST005,ST002','02:30:00','Newark Penn',22),('1019','Raritan Valley Line','Hackettstown','2024-12-30 08:00:00','2024-12-30 10:30:00','ST019,ST012,ST005,ST002','02:30:00','Newark Penn',22),('1020','Raritan Valley Line','Newark Penn','2024-10-14 10:30:00','2024-10-14 13:00:00','ST002,ST005,ST012,ST019','02:30:00','Hackettstown',22),('1020','Raritan Valley Line','Newark Penn','2024-10-14 14:00:00','2024-10-14 16:30:00','ST002,ST005,ST012,ST019','02:30:00','Hackettstown',22),('1020','Raritan Valley Line','Newark Penn','2024-10-14 16:45:00','2024-10-14 19:15:00','ST002,ST005,ST012,ST019','02:30:00','Hackettstown',22),('1020','Raritan Valley Line','Newark Penn','2024-11-22 10:45:00','2024-11-22 13:15:00','ST002,ST005,ST012,ST019','02:30:00','Hackettstown',22),('1020','Raritan Valley Line','Newark Penn','2024-12-03 10:30:00','2024-12-03 13:00:00','ST002,ST005,ST012,ST019','02:30:00','Hackettstown',22),('1020','Raritan Valley Line','Newark Penn','2024-12-20 11:00:00','2024-12-20 13:30:00','ST002,ST005,ST012,ST019','02:30:00','Hackettstown',22),('1020','Raritan Valley Line','Newark Penn','2024-12-30 11:15:00','2024-12-30 13:45:00','ST002,ST005,ST012,ST019','02:30:00','Hackettstown',22);
/*!40000 ALTER TABLE `train_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transit_line`
--

DROP TABLE IF EXISTS `transit_line`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transit_line` (
  `Transit_Line_Name` varchar(30) NOT NULL,
  PRIMARY KEY (`Transit_Line_Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transit_line`
--

LOCK TABLES `transit_line` WRITE;
/*!40000 ALTER TABLE `transit_line` DISABLE KEYS */;
INSERT INTO `transit_line` VALUES ('Atlantic City Line'),('Main/Bergen County Line'),('Montclair-Boonton Line'),('Morris & Essex Line'),('North Jersey Coast Line'),('Northeast Corridor'),('Pascack Valley Line'),('Raritan Valley Line');
/*!40000 ALTER TABLE `transit_line` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'railwaysystem'
--

--
-- Dumping routines for database 'railwaysystem'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-12-11 20:08:05
