-- MySQL dump 10.13  Distrib 8.0.42, for Linux (x86_64)
--
-- Host: localhost    Database: TukCompass_DB
-- ------------------------------------------------------
-- Server version	8.0.42-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `LecturerUnits`
--

DROP TABLE IF EXISTS `LecturerUnits`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `LecturerUnits` (
  `lecturerUnitID` varchar(30) NOT NULL,
  `lecturerID` varchar(30) DEFAULT NULL,
  `unitID` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`lecturerUnitID`),
  KEY `lecturerID` (`lecturerID`),
  KEY `unitID` (`unitID`),
  CONSTRAINT `LecturerUnits_ibfk_11` FOREIGN KEY (`lecturerID`) REFERENCES `lecturers_tb` (`lecturerID`),
  CONSTRAINT `LecturerUnits_ibfk_12` FOREIGN KEY (`unitID`) REFERENCES `units_tb` (`unitID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LecturerUnits`
--

LOCK TABLES `LecturerUnits` WRITE;
/*!40000 ALTER TABLE `LecturerUnits` DISABLE KEYS */;
/*!40000 ALTER TABLE `LecturerUnits` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `announcment_tb`
--

DROP TABLE IF EXISTS `announcment_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `announcment_tb` (
  `announcmentID` varchar(40) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `message` text,
  `fileUrl` text,
  `targetGroup` enum('all','lecturers','students') DEFAULT NULL,
  `createdBy` varchar(20) DEFAULT NULL,
  `schoolID` varchar(20) DEFAULT NULL,
  `createdAt` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`announcmentID`),
  KEY `createdBy` (`createdBy`),
  KEY `schoolID` (`schoolID`),
  CONSTRAINT `announcment_tb_ibfk_7` FOREIGN KEY (`createdBy`) REFERENCES `user_tb` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `announcment_tb_ibfk_8` FOREIGN KEY (`schoolID`) REFERENCES `school_tb` (`schoolID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `announcment_tb`
--

LOCK TABLES `announcment_tb` WRITE;
/*!40000 ALTER TABLE `announcment_tb` DISABLE KEYS */;
INSERT INTO `announcment_tb` VALUES ('2991d573-9751-460f-b18c-09619f15b8ef','Revised SCIT exam timetable sem 2','kindly checkout for the upadated time table','https://res.cloudinary.com/dkc2oujm6/image/upload/v1751549297/annoncments/NOTICE_-Reschduling_of_Start_Date_of_Examinations.pdf','students','ACSI/001','SCIT_001','2025-07-03 18:37:26'),('83d5a10b-2c3b-481d-abd7-ddc4d5148ad8','exam date reschedule','The examinations will commence on tuesday 8/07/2025 instead of the previously scheduled Monday 7/07/2025','https://res.cloudinary.com/dkc2oujm6/image/upload/v1751549297/annoncments/NOTICE_-Reschduling_of_Start_Date_of_Examinations.pdf','all','ACSI/001',NULL,'2025-07-03 16:28:15');
/*!40000 ALTER TABLE `announcment_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `c&sMembers_tb`
--

DROP TABLE IF EXISTS `c&sMembers_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `c&sMembers_tb` (
  `csMemberID` varchar(40) NOT NULL,
  `clubSportID` varchar(40) DEFAULT NULL,
  `userID` varchar(30) DEFAULT NULL,
  `clubSportsID` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`csMemberID`),
  UNIQUE KEY `c&sMembers_tb_userID_clubSportsID_unique` (`userID`,`clubSportsID`),
  KEY `clubSportID` (`clubSportID`),
  KEY `clubSportsID` (`clubSportsID`),
  CONSTRAINT `c&sMembers_tb_ibfk_1` FOREIGN KEY (`clubSportID`) REFERENCES `c&s_tb` (`clubSportsID`),
  CONSTRAINT `c&sMembers_tb_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `user_tb` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `c&sMembers_tb_ibfk_3` FOREIGN KEY (`clubSportsID`) REFERENCES `c&s_tb` (`clubSportsID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `c&sMembers_tb`
--

LOCK TABLES `c&sMembers_tb` WRITE;
/*!40000 ALTER TABLE `c&sMembers_tb` DISABLE KEYS */;
/*!40000 ALTER TABLE `c&sMembers_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `c&s_tb`
--

DROP TABLE IF EXISTS `c&s_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `c&s_tb` (
  `clubSportsID` varchar(40) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `type` enum('clubs','sports') DEFAULT NULL,
  `profileURL` varchar(100) DEFAULT NULL,
  `coverURL` varchar(100) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `patron` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`clubSportsID`),
  KEY `patron` (`patron`),
  CONSTRAINT `c&s_tb_ibfk_1` FOREIGN KEY (`patron`) REFERENCES `user_tb` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `c&s_tb`
--

LOCK TABLES `c&s_tb` WRITE;
/*!40000 ALTER TABLE `c&s_tb` DISABLE KEYS */;
INSERT INTO `c&s_tb` VALUES ('BA-006','Basket Ball ','sports',NULL,NULL,'greate heights average skills','ACSI/016'),('CH-001','Chess Club','clubs',NULL,NULL,'be the master of your own mind','SCCI/03853P/2021'),('CON-001','connects','clubs','https://res.cloudinary.com/dkc2oujm6/image/upload/v1751389525/TukCompass/2022-05-01.jpg','https://res.cloudinary.com/dkc2oujm6/image/upload/v1751389527/TukCompass/20211231_123143.jpg','followers and following posts','SCCI/00573/2020'),('DR-002','Drama Club','clubs',NULL,NULL,'the coolest place to be','SCCI/00594/2021'),('FB-003','TUK football','sports',NULL,NULL,'the super strikers ','SCCI/00573/2020'),('MS-004','Music Club','clubs',NULL,NULL,'your body is master piece of an artwork','SCCI/00605/2021'),('SP/FB-002','TUK football','sports','https://res.cloudinary.com/dkc2oujm6/image/upload/v1751130390/TukCompass/p6.jpg','https://res.cloudinary.com/dkc2oujm6/image/upload/v1751130391/TukCompass/p3.jpg','the super strikers ','SCCI/00573/2020'),('TT-005','Table Tennis ','sports',NULL,NULL,'your body is master piece of an artwork','ACSI/016');
/*!40000 ALTER TABLE `c&s_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class_tb`
--

DROP TABLE IF EXISTS `class_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `class_tb` (
  `classID` varchar(30) NOT NULL,
  `courseID` varchar(30) DEFAULT NULL,
  `classRep` varchar(30) DEFAULT NULL,
  `currentYear` int DEFAULT NULL,
  `currentSem` int DEFAULT NULL,
  `enrolmentYear` int DEFAULT NULL,
  `academicYear` varchar(10) DEFAULT NULL,
  `completionYear` int DEFAULT NULL,
  PRIMARY KEY (`classID`),
  KEY `courseID` (`courseID`),
  KEY `classRep` (`classRep`),
  CONSTRAINT `class_tb_ibfk_93` FOREIGN KEY (`courseID`) REFERENCES `course_tb` (`courseID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `class_tb_ibfk_94` FOREIGN KEY (`classRep`) REFERENCES `user_tb` (`userID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `class_tb`
--

LOCK TABLES `class_tb` WRITE;
/*!40000 ALTER TABLE `class_tb` DISABLE KEYS */;
INSERT INTO `class_tb` VALUES ('SCCI/2021','SCCI_01',NULL,4,3,2021,'2024/2025',2025),('SCCI/2022','SCCI_01',NULL,3,3,2022,'2024/2025',2026),('SCCI/2023','SCCI_01',NULL,2,3,2023,'2024/2025',2027),('SCCI/2024','SCCI_01',NULL,1,3,2024,'2024/2025',2028),('SCII/2021','SCII_002',NULL,4,3,2021,'2024/2025',2025),('SCII/2022','SCII_002',NULL,3,3,2022,'2024/2025',2026),('SCII/2023','SCII_002',NULL,2,3,2023,'2024/2025',2027),('SCII/2024','SCII_002',NULL,1,3,2024,'2024/2025',2028),('SCNI/2021','SCNI_03',NULL,4,3,2021,'2024/2025',2025),('SCNI/2022','SCNI_03',NULL,3,3,2022,'2024/2025',2026),('SCNI/2023','SCNI_03',NULL,2,3,2023,'2024/2025',2027),('SCNI/2024','SCNI_03',NULL,1,3,2024,'2024/2025',2028);
/*!40000 ALTER TABLE `class_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments_tb`
--

DROP TABLE IF EXISTS `comments_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments_tb` (
  `commentID` varchar(40) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `postID` varchar(40) DEFAULT NULL,
  `userID` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`commentID`),
  KEY `postID` (`postID`),
  KEY `userID` (`userID`),
  CONSTRAINT `comments_tb_ibfk_27` FOREIGN KEY (`postID`) REFERENCES `posts_tb` (`postID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comments_tb_ibfk_28` FOREIGN KEY (`userID`) REFERENCES `user_tb` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments_tb`
--

LOCK TABLES `comments_tb` WRITE;
/*!40000 ALTER TABLE `comments_tb` DISABLE KEYS */;
/*!40000 ALTER TABLE `comments_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `connects_tb`
--

DROP TABLE IF EXISTS `connects_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `connects_tb` (
  `connectID` varchar(40) NOT NULL,
  `followingID` varchar(40) DEFAULT NULL,
  `followerID` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`connectID`),
  KEY `followingID` (`followingID`),
  KEY `followerID` (`followerID`),
  CONSTRAINT `connects_tb_ibfk_1` FOREIGN KEY (`followingID`) REFERENCES `user_tb` (`userID`) ON UPDATE CASCADE,
  CONSTRAINT `connects_tb_ibfk_2` FOREIGN KEY (`followerID`) REFERENCES `user_tb` (`userID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `connects_tb`
--

LOCK TABLES `connects_tb` WRITE;
/*!40000 ALTER TABLE `connects_tb` DISABLE KEYS */;
INSERT INTO `connects_tb` VALUES ('5d7ff655-1e4b-4509-a6aa-9b7ad986728f','SCCI/0624/2021','SCNI/01290/2021');
/*!40000 ALTER TABLE `connects_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_tb`
--

DROP TABLE IF EXISTS `course_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_tb` (
  `courseID` varchar(30) NOT NULL,
  `courseName` varchar(100) NOT NULL,
  `departmentID` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`courseID`),
  KEY `departmentID` (`departmentID`),
  CONSTRAINT `course_tb_ibfk_1` FOREIGN KEY (`departmentID`) REFERENCES `department_tb` (`departmentID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_tb`
--

LOCK TABLES `course_tb` WRITE;
/*!40000 ALTER TABLE `course_tb` DISABLE KEYS */;
INSERT INTO `course_tb` VALUES ('SCCI_01','Bachelor of Technology Computer Technology','DCSI_001'),('SCII_002','Bachelor of Technology Information Technology','DCSI_001'),('SCNI_03','Bachelor of Technology Communication and Computer Networks','DCCN_002');
/*!40000 ALTER TABLE `course_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `course_unit_tb`
--

DROP TABLE IF EXISTS `course_unit_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `course_unit_tb` (
  `courseUnitID` varchar(40) NOT NULL,
  `courseID` varchar(30) DEFAULT NULL,
  `unitID` varchar(30) DEFAULT NULL,
  `year` int NOT NULL,
  `sem` int NOT NULL,
  PRIMARY KEY (`courseUnitID`),
  UNIQUE KEY `course_unit_tb_courseID_unitID_unique` (`courseID`,`unitID`),
  KEY `unitID` (`unitID`),
  CONSTRAINT `course_unit_tb_ibfk_83` FOREIGN KEY (`courseID`) REFERENCES `course_tb` (`courseID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `course_unit_tb_ibfk_84` FOREIGN KEY (`unitID`) REFERENCES `units_tb` (`unitID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_unit_tb`
--

LOCK TABLES `course_unit_tb` WRITE;
/*!40000 ALTER TABLE `course_unit_tb` DISABLE KEYS */;
INSERT INTO `course_unit_tb` VALUES ('0552b425-c8a4-43b8-903c-b8f84b973da3','SCCI_01','ECSI4106',4,1),('15be8a81-f702-48e5-9ff9-b18b33ec4f47','SCII_002','ECSI4114',4,1),('1ab76107-38d3-4baa-9455-f1d99bf5c3a7','SCCI_01','ECSI4104',4,1),('1e05c082-4336-4502-923f-11057a28b1e1','SCCI_01','ECSI4202',4,2),('3681de95-8be5-48cc-91a6-bde7c60c595f','SCII_002','ECSI4101',4,1),('4259e3a9-3221-4b08-8ed5-ef3f4094f455','SCII_002','ECSI4104',4,1),('474abf69-4e8b-4562-b761-ebb30c31b6bc','SCCI_01','ECSI4201',4,2),('796c0e41-a92d-49d4-9683-e2439501188b','SCII_002','ECSI4204',4,2),('799a751c-0320-47b5-b35b-b41d57a6d1fa','SCII_002','ECSI4201',4,2),('79bfef6f-04f3-4b37-b8d5-33d6e26cc7ee','SCII_002','ECSI4107',4,1),('929f055f-2810-4d70-8dad-b9337952b53d','SCII_002','ECSI4210',4,2),('93e8fbdc-caed-4685-b6b7-6e6b36d89f06','SCII_002','ECSI4112',4,1),('9dac6f36-396e-4338-be02-671f4039a357','SCCI_01','EEEE3201',4,2),('a2f2ca48-77ff-4419-a977-91f511a1beba','SCCI_01','ECSI4107',4,1),('ae51cf19-4882-413d-8a78-4c1bbdc8b2fa','SCCI_01','ECSI4103',4,1),('b0ec672e-f227-4c84-aa9d-ad12e2d5609e','SCII_002','ECSI4202',4,2),('b9a925f8-cf1c-4ff1-b43b-2bd99516c7bf','SCCI_01','ECSI4105',4,1),('bbdc4a05-e8d3-4ab9-b2a0-095248197660','SCII_002','ECSI4113',4,1),('c004e1f6-7bda-4c7e-86cb-bab560e85594','SCCI_01','ECSI4204',4,2),('c331d471-e8d5-4bde-84fa-ad77f915b603','SCCI_01','ECSI4206',4,2),('c4820dda-312b-4c72-86c0-7f5ff009b4a6','SCCI_01','ECSI4101',4,1),('d03cf0f3-d056-41d1-aa37-2269d3a5daa6','SCII_002','ECSI4111',4,1),('d0c54370-085c-4321-9c85-4026e08b6413','SCII_002','ECSI4211',4,2),('dd566cde-a02e-4202-8046-c890beafe412','SCII_002','ECSI4203',4,2),('df76c4ce-49e0-41d9-a322-9b75764ae39f','SCII_002','ECSI4205',4,2),('e9cda2db-2631-4924-946b-a2d4d4446a0b','SCCI_01','ECSI4203',4,2),('eb8ae75c-07b5-4751-aeab-4d2d34d5857f','SCCI_01','ECSI4205',4,2),('f95a2434-95f4-49fe-9a77-a707da20fe86','SCCI_01','ECSI4102',4,1),('fc4698a6-0c85-4bfa-8cec-8f3ca50bd940','SCCI_01','ECSI4108',4,1);
/*!40000 ALTER TABLE `course_unit_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `csMembers_tb`
--

DROP TABLE IF EXISTS `csMembers_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `csMembers_tb` (
  `csMemberID` varchar(40) NOT NULL,
  `clubSportID` varchar(40) DEFAULT NULL,
  `userID` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`csMemberID`),
  UNIQUE KEY `csMembers_tb_userID_clubSportID_unique` (`clubSportID`,`userID`),
  KEY `userID` (`userID`),
  CONSTRAINT `csMembers_tb_ibfk_17` FOREIGN KEY (`clubSportID`) REFERENCES `c&s_tb` (`clubSportsID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `csMembers_tb_ibfk_18` FOREIGN KEY (`userID`) REFERENCES `user_tb` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `csMembers_tb`
--

LOCK TABLES `csMembers_tb` WRITE;
/*!40000 ALTER TABLE `csMembers_tb` DISABLE KEYS */;
INSERT INTO `csMembers_tb` VALUES ('b416edd1-0139-4e58-9930-1b841834be87','BA-006','SCCI/00594/2021'),('ff54e26f-506d-4b7a-bd86-c63ab199a06e','BA-006','SCCI/0624/2021'),('fa793cfc-dcab-4bda-ba99-f49fe20c1cc7','CH-001','SCCI/00594/2021'),('901c7a75-49d9-4c82-ad6d-8aac25a73981','CH-001','SCCI/0624/2021'),('0af83c39-93e0-452e-987d-aecccc044edf','CH-001','SCNI/01290/2021'),('751758f2-40dd-470c-9ecc-410a4ef14c65','DR-002','SCCI/00594/2021'),('11d16b06-1623-49a2-908c-ea0dbe96d11a','DR-002','SCCI/0624/2021'),('36b91e0b-72c1-4d72-9c25-79b5e8dd8714','DR-002','SCNI/01290/2021'),('2936a03c-d5fe-4cf3-b4d2-4c8d3b099465','FB-003','SCCI/00594/2021'),('78c104b6-37b1-4a66-b16a-b123ea7d353f','FB-003','SCCI/0624/2021'),('bc1d4d55-bb69-4012-baec-f1a0c03d242d','FB-003','SCNI/01290/2021');
/*!40000 ALTER TABLE `csMembers_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `csPosts_tb`
--

DROP TABLE IF EXISTS `csPosts_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `csPosts_tb` (
  `csPostID` varchar(40) NOT NULL,
  `clubSportID` varchar(40) DEFAULT NULL,
  `postID` varchar(40) DEFAULT NULL,
  PRIMARY KEY (`csPostID`),
  KEY `clubSportID` (`clubSportID`),
  KEY `postID` (`postID`),
  CONSTRAINT `csPosts_tb_ibfk_23` FOREIGN KEY (`clubSportID`) REFERENCES `c&s_tb` (`clubSportsID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `csPosts_tb_ibfk_24` FOREIGN KEY (`postID`) REFERENCES `posts_tb` (`postID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `csPosts_tb`
--

LOCK TABLES `csPosts_tb` WRITE;
/*!40000 ALTER TABLE `csPosts_tb` DISABLE KEYS */;
INSERT INTO `csPosts_tb` VALUES ('1067b359-0455-4604-a8a1-c007a93c2f9c','CH-001','a5d32ec5-5881-4114-96c8-6043f4ab1dac'),('9d1bcd70-c986-4d79-92be-4bcdb3087545','CH-001','76b50731-c883-4527-b73c-c9b34f0601cf');
/*!40000 ALTER TABLE `csPosts_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department_tb`
--

DROP TABLE IF EXISTS `department_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department_tb` (
  `departmentID` varchar(30) NOT NULL,
  `departmentName` varchar(100) NOT NULL,
  `schoolID` varchar(30) DEFAULT NULL,
  `departmentHeadID` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`departmentID`),
  KEY `schoolID` (`schoolID`),
  KEY `departmentHeadID` (`departmentHeadID`),
  CONSTRAINT `department_tb_ibfk_100` FOREIGN KEY (`departmentHeadID`) REFERENCES `user_tb` (`userID`) ON UPDATE CASCADE,
  CONSTRAINT `department_tb_ibfk_99` FOREIGN KEY (`schoolID`) REFERENCES `school_tb` (`schoolID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `department_tb`
--

LOCK TABLES `department_tb` WRITE;
/*!40000 ALTER TABLE `department_tb` DISABLE KEYS */;
INSERT INTO `department_tb` VALUES ('DCCN_002','Department of Communication and Computer Networks','SCIT_001',NULL),('DCRE_001','Department of Civil and Resource Engineering','SCRE_002',NULL),('DCSI_001','Department of Computer Science and Informatics','SCIT_001',NULL),('DEEE_001','Department of Electrical and Electronics Engineering','SEEE_001',NULL),('DHTE_002','Department of Highway and Transport Engineering','SCRE_002',NULL),('DIEM_002','Department of Industrial and Engineering Mathematics','SMAS_002',NULL),('DSCM_001','Department of Statistics and Computational Mathematics','SMAS_002',NULL),('DTIE_002','Department of Telecommunication and Information Engineering','SEEE_001',NULL);
/*!40000 ALTER TABLE `department_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events_tb`
--

DROP TABLE IF EXISTS `events_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `events_tb` (
  `eventID` varchar(40) NOT NULL,
  `title` varchar(40) DEFAULT NULL,
  `description` text,
  `location` varchar(30) DEFAULT NULL,
  `date` varchar(40) DEFAULT NULL,
  `expireyDate` varchar(40) DEFAULT NULL,
  `time` varchar(40) DEFAULT NULL,
  `targetGroup` enum('all','lecturers','students') DEFAULT NULL,
  `fileUrl` text,
  `createdBy` varchar(20) DEFAULT NULL,
  `createdAt` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`eventID`),
  KEY `createdBy` (`createdBy`),
  CONSTRAINT `events_tb_ibfk_1` FOREIGN KEY (`createdBy`) REFERENCES `user_tb` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events_tb`
--

LOCK TABLES `events_tb` WRITE;
/*!40000 ALTER TABLE `events_tb` DISABLE KEYS */;
INSERT INTO `events_tb` VALUES ('420977f9-b5d3-43f1-b77b-6be5c6bc24ef','Faculty Research Grant Briefing 2025','A mandatory session for all academic staff on applying for internal and external research funding in 2025.','Lecture Theater','13-07-2025','11-08-2025','10:00 AM','lecturers','https://res.cloudinary.com/dkc2oujm6/image/upload/v1751527686/events/images.jpg','ACSI/006','2025-07-03 17:05:53'),('e18cb89e-09c2-44ba-b855-b001c928c59b','cultural Week 2025 Opening Ceremony','Join us for the official launch of cultural Week 2025 featuring keynote speeches, demos, and innovation exhibitions.','Conference Hall,  Block L','31-07-2025','31-08-2025','10:00 AM','all','https://res.cloudinary.com/dkc2oujm6/image/upload/v1751528750/events/cultural.jpg','ACSI/006','2025-07-03 10:45:49');
/*!40000 ALTER TABLE `events_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faculty_tb`
--

DROP TABLE IF EXISTS `faculty_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faculty_tb` (
  `facultyID` varchar(30) NOT NULL,
  `facultyName` varchar(50) DEFAULT NULL,
  `deanID` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`facultyID`),
  KEY `deanID` (`deanID`),
  CONSTRAINT `faculty_tb_ibfk_1` FOREIGN KEY (`deanID`) REFERENCES `user_tb` (`userID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `faculty_tb`
--

LOCK TABLES `faculty_tb` WRITE;
/*!40000 ALTER TABLE `faculty_tb` DISABLE KEYS */;
INSERT INTO `faculty_tb` VALUES ('FAST002','Faculty of Applied Science and Technology',NULL),('FEBE001','Faculty of Engineering and Built Enviroment',NULL);
/*!40000 ALTER TABLE `faculty_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lecturers_tb`
--

DROP TABLE IF EXISTS `lecturers_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `lecturers_tb` (
  `lecturerID` varchar(30) NOT NULL,
  `departmentID` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`lecturerID`),
  KEY `departmentID` (`departmentID`),
  CONSTRAINT `lecturers_tb_ibfk_1` FOREIGN KEY (`lecturerID`) REFERENCES `user_tb` (`userID`) ON UPDATE CASCADE,
  CONSTRAINT `lecturers_tb_ibfk_2` FOREIGN KEY (`departmentID`) REFERENCES `department_tb` (`departmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lecturers_tb`
--

LOCK TABLES `lecturers_tb` WRITE;
/*!40000 ALTER TABLE `lecturers_tb` DISABLE KEYS */;
INSERT INTO `lecturers_tb` VALUES ('ACSI/001','DCSI_001'),('ACSI/003','DCSI_001'),('ACSI/005','DCSI_001'),('ACSI/006','DCSI_001'),('ACSI/007','DCSI_001'),('ACSI/014','DCSI_001'),('ACSI/016','DCSI_001');
/*!40000 ALTER TABLE `lecturers_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes_tb`
--

DROP TABLE IF EXISTS `likes_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes_tb` (
  `likeID` varchar(40) NOT NULL,
  `postID` varchar(40) DEFAULT NULL,
  `userID` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`likeID`),
  KEY `postID` (`postID`),
  KEY `userID` (`userID`),
  CONSTRAINT `likes_tb_ibfk_27` FOREIGN KEY (`postID`) REFERENCES `posts_tb` (`postID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `likes_tb_ibfk_28` FOREIGN KEY (`userID`) REFERENCES `user_tb` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `likes_tb`
--

LOCK TABLES `likes_tb` WRITE;
/*!40000 ALTER TABLE `likes_tb` DISABLE KEYS */;
INSERT INTO `likes_tb` VALUES ('ba8d9c7b-24dc-4373-ba93-393411fee7a7','76b50731-c883-4527-b73c-c9b34f0601cf','SCNI/01290/2021');
/*!40000 ALTER TABLE `likes_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `posts_tb`
--

DROP TABLE IF EXISTS `posts_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts_tb` (
  `postID` varchar(40) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `imageURL` varchar(100) DEFAULT NULL,
  `date` varchar(20) DEFAULT NULL,
  `userID` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`postID`),
  KEY `userID` (`userID`),
  CONSTRAINT `posts_tb_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user_tb` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts_tb`
--

LOCK TABLES `posts_tb` WRITE;
/*!40000 ALTER TABLE `posts_tb` DISABLE KEYS */;
INSERT INTO `posts_tb` VALUES ('76b50731-c883-4527-b73c-c9b34f0601cf','what about another round of trophies collections to our club','https://res.cloudinary.com/dkc2oujm6/image/upload/v1751460996/posts/download1.jpg','2025-07-02 15:57:52','SCCI/0624/2021'),('a5d32ec5-5881-4114-96c8-6043f4ab1dac','hey guys next week will be holding a chess tournament  .kindly lets prepare,great things are comming','https://res.cloudinary.com/dkc2oujm6/image/upload/v1751460248/posts/Document.jpg','2025-07-02 15:44:06','SCNI/01290/2021');
/*!40000 ALTER TABLE `posts_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduleCourse_tb`
--

DROP TABLE IF EXISTS `scheduleCourse_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scheduleCourse_tb` (
  `scheduleCourseID` varchar(100) NOT NULL,
  `courseID` varchar(30) NOT NULL,
  `scheduleID` varchar(100) NOT NULL,
  PRIMARY KEY (`scheduleCourseID`),
  UNIQUE KEY `scheduleCourse_tb_courseID_scheduleID_unique` (`courseID`,`scheduleID`),
  KEY `scheduleID` (`scheduleID`),
  CONSTRAINT `scheduleCourse_tb_ibfk_57` FOREIGN KEY (`courseID`) REFERENCES `course_tb` (`courseID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `scheduleCourse_tb_ibfk_58` FOREIGN KEY (`scheduleID`) REFERENCES `schedule_tb` (`scheduleID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduleCourse_tb`
--

LOCK TABLES `scheduleCourse_tb` WRITE;
/*!40000 ALTER TABLE `scheduleCourse_tb` DISABLE KEYS */;
INSERT INTO `scheduleCourse_tb` VALUES ('4eda52f9-e2e9-4a17-8bab-520f13ed94e2','SCCI_01','0d11cc64-354f-4d59-8c76-397c22f56900'),('718b5dc0-f93f-4cb3-a3c3-350a9d15ea88','SCCI_01','1d3a8b9d-9a9c-4b6b-b591-67fa7321a295'),('0d1cd9b9-cf20-4658-ac4e-90dec75bf266','SCCI_01','21bfb53c-88f9-4a6c-987e-b1e7e0de0b79'),('e030add7-d473-4220-b17c-d7b8c0b034a0','SCCI_01','4be1f925-d30e-4ac0-bb98-2407bd8ecf73'),('4432af52-3440-499d-a559-3822b48789f1','SCCI_01','51073cd6-1067-440b-87e7-ac9d29505c91'),('77a42b23-a0ba-4989-8064-71510a094285','SCCI_01','5e70cddc-bf5a-4e5c-9697-11888eec5b9c'),('81b1860c-f8a1-4d2a-ad2d-935b37e2b028','SCCI_01','68829d51-45d1-4a7c-a67b-d54cf3c9fdb4'),('70a1f744-7cd1-4b8d-ac0f-9efbcda7f705','SCCI_01','7dddf5ee-5dbf-4e92-a637-425393b93225'),('abe7d3a7-9453-44ce-a86b-a6de6945e704','SCCI_01','84830b56-bc0c-422a-83ef-a017a0b029d1'),('7666d6d8-758b-4966-a4a0-659270b41b04','SCCI_01','9dd73677-2830-421a-9073-a94b83c90f8a'),('fe8ff5e7-3be1-46e3-9fa2-367bae6f6c4a','SCCI_01','d3dbe7c8-06fe-4497-8395-a7acf8d63f86'),('91f94009-5ffa-4a0e-a322-28c84baa686e','SCCI_01','e3a38622-dab5-47cf-a1cb-ca7443500eaa'),('d3ea067f-0463-48ea-a8c6-6f8c3f3433b2','SCII_002','42eaf07b-f817-489e-a27d-0b56f3551fa0'),('7b104c66-e7aa-4d2c-bdc6-02fdd14ad463','SCII_002','58c68ff9-d589-4f1d-8d3b-83c08667f576'),('ae03cbb8-6d83-4ed5-a605-9be0ff2cdd07','SCII_002','5b75cf4c-610e-43ef-a0b1-3903bbf88faa'),('88a54d1c-897a-4975-998d-44d1738eb509','SCII_002','5bafe5b0-13b5-49b2-8d05-887380cfabff'),('95bac541-4212-40d9-9bb5-7d98dbae13ce','SCII_002','88aa7ce9-0f6d-4883-9264-4b0d803eb463'),('d807b017-49b6-44bc-9288-24f8f606066f','SCII_002','8f6cdb6d-7e0d-42bc-ad4c-9593d6b9abd8'),('f6420922-621a-4512-93d7-fead8091b3d9','SCII_002','a075cb80-02b2-447f-9bc3-129a37d5654c'),('5835cfee-621e-4c1a-a77b-d02ce9fbed50','SCII_002','ae8a41a6-1f9a-4ecb-adcd-8d74876a9632'),('6b85e775-3bd9-44e7-968a-8331f52974f9','SCII_002','f8fe3730-8e6b-405d-b812-1997bd02bb7f'),('e50abb8c-e402-4337-9818-50f5ac478290','SCNI_03','0d11cc64-354f-4d59-8c76-397c22f56900'),('5f0ba460-b973-461f-abf9-11142d3c6e2d','SCNI_03','1d3a8b9d-9a9c-4b6b-b591-67fa7321a295'),('92cd4863-01ac-4c2c-9ebe-407231d65d70','SCNI_03','21bfb53c-88f9-4a6c-987e-b1e7e0de0b79'),('572916bf-e961-4b14-8e3f-a6e70e8db990','SCNI_03','4be1f925-d30e-4ac0-bb98-2407bd8ecf73'),('f7f531f8-93f4-4123-87e6-2ec5bfec3f3c','SCNI_03','51073cd6-1067-440b-87e7-ac9d29505c91'),('030220c7-aa0c-44a7-b4f0-acf09ce7477a','SCNI_03','5e70cddc-bf5a-4e5c-9697-11888eec5b9c'),('f0e54710-38f9-4ea8-88e2-f050cba02d0c','SCNI_03','68829d51-45d1-4a7c-a67b-d54cf3c9fdb4'),('0fe596c2-a668-48e8-9949-59b3c5f0a515','SCNI_03','7dddf5ee-5dbf-4e92-a637-425393b93225'),('6403ec36-f7cf-44a0-a87b-e24548a9f7da','SCNI_03','84830b56-bc0c-422a-83ef-a017a0b029d1'),('4800d9c3-056f-490c-acf9-bf4384a51e86','SCNI_03','9dd73677-2830-421a-9073-a94b83c90f8a'),('86464fc7-d0f8-4d10-b13a-a3f98ebe66d8','SCNI_03','d3dbe7c8-06fe-4497-8395-a7acf8d63f86'),('f2adc7cb-d1b8-4b15-bb42-84834c12b1fa','SCNI_03','e3a38622-dab5-47cf-a1cb-ca7443500eaa');
/*!40000 ALTER TABLE `scheduleCourse_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule_tb`
--

DROP TABLE IF EXISTS `schedule_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schedule_tb` (
  `scheduleID` varchar(100) NOT NULL,
  `unitOfferingID` varchar(40) NOT NULL,
  `day` varchar(10) NOT NULL,
  `startTime` varchar(10) NOT NULL,
  `endTime` varchar(10) NOT NULL,
  `mode` varchar(10) DEFAULT 'online',
  PRIMARY KEY (`scheduleID`),
  KEY `unitOfferingID` (`unitOfferingID`),
  CONSTRAINT `schedule_tb_ibfk_1` FOREIGN KEY (`unitOfferingID`) REFERENCES `unitOffering_tb` (`unitOfferingID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule_tb`
--

LOCK TABLES `schedule_tb` WRITE;
/*!40000 ALTER TABLE `schedule_tb` DISABLE KEYS */;
INSERT INTO `schedule_tb` VALUES ('0d11cc64-354f-4d59-8c76-397c22f56900','fe9dfc6f-ca3e-4f6b-8cfb-019cb6127efb','monday','9:00','11:00','room D2'),('1d3a8b9d-9a9c-4b6b-b591-67fa7321a295','29f67d82-16c8-4cce-b82e-35b9974defcc','monday','07:00','09:00','Online'),('21bfb53c-88f9-4a6c-987e-b1e7e0de0b79','2146e11d-a71b-4a89-93fb-01df6f105990','friday','07:00','09:00','online'),('42eaf07b-f817-489e-a27d-0b56f3551fa0','2146e11d-a71b-4a89-93fb-01df6f105990','friday','14:00','16:00','online'),('4be1f925-d30e-4ac0-bb98-2407bd8ecf73','fe9dfc6f-ca3e-4f6b-8cfb-019cb6127efb','monday','07:00','09:00','Online'),('51073cd6-1067-440b-87e7-ac9d29505c91','2146e11d-a71b-4a89-93fb-01df6f105990','wednesday','09:00','11:00','online'),('58c68ff9-d589-4f1d-8d3b-83c08667f576','2c1f315d-7b20-41b1-8245-61719ea85f6f','tuesday','16:00','18:00','online'),('5b75cf4c-610e-43ef-a0b1-3903bbf88faa','fe9dfc6f-ca3e-4f6b-8cfb-019cb6127efb','tuesday','16:00','18:00','online'),('5bafe5b0-13b5-49b2-8d05-887380cfabff','2146e11d-a71b-4a89-93fb-01df6f105990','friday','14:00','16:00','online'),('5e70cddc-bf5a-4e5c-9697-11888eec5b9c','2146e11d-a71b-4a89-93fb-01df6f105990','friday','07:00','09:00','online'),('68829d51-45d1-4a7c-a67b-d54cf3c9fdb4','2146e11d-a71b-4a89-93fb-01df6f105990','wednesday','09:00','11:00','online'),('7dddf5ee-5dbf-4e92-a637-425393b93225','29f67d82-16c8-4cce-b82e-35b9974defcc','monday','9:00','11:00','room D2'),('84830b56-bc0c-422a-83ef-a017a0b029d1','2c1f315d-7b20-41b1-8245-61719ea85f6f','monday','9:00','11:00','room D2'),('88aa7ce9-0f6d-4883-9264-4b0d803eb463','29f67d82-16c8-4cce-b82e-35b9974defcc','tuesday','14:00','16:00','Online'),('8f6cdb6d-7e0d-42bc-ad4c-9593d6b9abd8','fe9dfc6f-ca3e-4f6b-8cfb-019cb6127efb','tuesday','14:00','16:00','Online'),('9dd73677-2830-421a-9073-a94b83c90f8a','2f7b8057-8857-43a8-a868-afdd3ab54387','Monday','16:00','18:00','online'),('a075cb80-02b2-447f-9bc3-129a37d5654c','29f67d82-16c8-4cce-b82e-35b9974defcc','tuesday','16:00','18:00','online'),('ae8a41a6-1f9a-4ecb-adcd-8d74876a9632','2c1f315d-7b20-41b1-8245-61719ea85f6f','tuesday','14:00','16:00','Online'),('d3dbe7c8-06fe-4497-8395-a7acf8d63f86','2c1f315d-7b20-41b1-8245-61719ea85f6f','monday','07:00','09:00','Online'),('e3a38622-dab5-47cf-a1cb-ca7443500eaa','2f7b8057-8857-43a8-a868-afdd3ab54387','Wednesday','11:00','13:00','online'),('f8fe3730-8e6b-405d-b812-1997bd02bb7f','2146e11d-a71b-4a89-93fb-01df6f105990','wednesday','11:00','13:00','online');
/*!40000 ALTER TABLE `schedule_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_tb`
--

DROP TABLE IF EXISTS `school_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `school_tb` (
  `schoolID` varchar(30) NOT NULL,
  `schoolName` varchar(100) NOT NULL,
  `facultyID` varchar(30) DEFAULT NULL,
  `schoolHeadID` varchar(30) DEFAULT NULL,
  ` facultyID` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`schoolID`),
  KEY `facultyID` (`facultyID`),
  KEY `schoolHeadID` (`schoolHeadID`),
  KEY ` facultyID` (` facultyID`),
  CONSTRAINT `school_tb_ibfk_47` FOREIGN KEY (`facultyID`) REFERENCES `faculty_tb` (`facultyID`) ON UPDATE CASCADE,
  CONSTRAINT `school_tb_ibfk_48` FOREIGN KEY (`schoolHeadID`) REFERENCES `user_tb` (`userID`) ON UPDATE CASCADE,
  CONSTRAINT `school_tb_ibfk_49` FOREIGN KEY (` facultyID`) REFERENCES `faculty_tb` (`facultyID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `school_tb`
--

LOCK TABLES `school_tb` WRITE;
/*!40000 ALTER TABLE `school_tb` DISABLE KEYS */;
INSERT INTO `school_tb` VALUES ('SCIT_001','School of Computing and Information Technology','FAST002',NULL,NULL),('SCRE_002','School of Civil and Resource Engineering','FEBE001',NULL,NULL),('SEEE_001','School of Electrical and Electronics Engineering','FEBE001',NULL,NULL),('SMAS_002','School of Mathematics and Acturial Science','FAST002',NULL,NULL);
/*!40000 ALTER TABLE `school_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students_tb`
--

DROP TABLE IF EXISTS `students_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students_tb` (
  `studentID` varchar(30) NOT NULL,
  `courseID` varchar(30) DEFAULT NULL,
  `classID` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`studentID`),
  KEY `courseID` (`courseID`),
  KEY `classID` (`classID`),
  CONSTRAINT `students_tb_ibfk_113` FOREIGN KEY (`courseID`) REFERENCES `course_tb` (`courseID`) ON UPDATE CASCADE,
  CONSTRAINT `students_tb_ibfk_114` FOREIGN KEY (`classID`) REFERENCES `class_tb` (`classID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students_tb`
--

LOCK TABLES `students_tb` WRITE;
/*!40000 ALTER TABLE `students_tb` DISABLE KEYS */;
INSERT INTO `students_tb` VALUES ('SCCI/00573/2020','SCCI_01','SCCI/2021'),('SCCI/00574/2021','SCCI_01','SCCI/2021'),('SCCI/00594/2021','SCCI_01','SCCI/2021'),('SCCI/00604/2021','SCCI_01','SCCI/2021'),('SCCI/00605/2021','SCCI_01','SCCI/2021'),('SCCI/03853P/2021','SCCI_01','SCCI/2021'),('SCCI/0624/2021','SCCI_01','SCCI/2021'),('SCII/00659/2021','SCII_002','SCII/2021'),('SCII/01060/2021','SCII_002','SCII/2021'),('SCNI/01290/2021','SCNI_03','SCNI/2021'),('SCNI/01298/2021','SCNI_03','SCNI/2021');
/*!40000 ALTER TABLE `students_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unitContent_tb`
--

DROP TABLE IF EXISTS `unitContent_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unitContent_tb` (
  `contentID` varchar(40) NOT NULL,
  `unitID` varchar(40) DEFAULT NULL,
  `pdfUrl` varchar(255) DEFAULT NULL,
  `fileName` varchar(100) DEFAULT NULL,
  `type` enum('assignment','unit_Outline','unnit_PDF') DEFAULT NULL,
  `uploadedBy` varchar(40) DEFAULT NULL,
  `uploadDate` datetime DEFAULT NULL,
  PRIMARY KEY (`contentID`),
  KEY `unitID` (`unitID`),
  CONSTRAINT `unitContent_tb_ibfk_1` FOREIGN KEY (`unitID`) REFERENCES `units_tb` (`unitID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unitContent_tb`
--

LOCK TABLES `unitContent_tb` WRITE;
/*!40000 ALTER TABLE `unitContent_tb` DISABLE KEYS */;
INSERT INTO `unitContent_tb` VALUES ('4d88f315-011d-41c4-ad2f-855cdd62ad8c','ECSI4206','https://res.cloudinary.com/dkc2oujm6/raw/upload/v1751125202/unit_pdfs/DECENTRALIZATION__DEPARTMENTATION.pdf','lecturer 2',NULL,'ACSI/014','2025-06-28 15:40:02'),('bce4f94a-da45-42ce-bf2a-bec9de7cc6d4','ECSI4206','https://res.cloudinary.com/dkc2oujm6/raw/upload/v1751122978/unit_pdfs/INFORMATION%20SYSTEMS%20INTRODUCTION.pptx','lecturer 1',NULL,'ACSI/014','2025-06-28 15:15:05');
/*!40000 ALTER TABLE `unitContent_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unitEnrollment_tb`
--

DROP TABLE IF EXISTS `unitEnrollment_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unitEnrollment_tb` (
  `unitEnrollmentID` varchar(100) NOT NULL,
  `studentID` varchar(30) NOT NULL,
  `unitOfferingID` varchar(100) NOT NULL,
  `enrollmentDate` int DEFAULT NULL,
  `status` enum('active','complited') DEFAULT 'active',
  PRIMARY KEY (`unitEnrollmentID`),
  UNIQUE KEY `unitEnrollment_tb_studentID_unitOfferingID_unique` (`studentID`,`unitOfferingID`),
  KEY `unitOfferingID` (`unitOfferingID`),
  CONSTRAINT `unitEnrollment_tb_ibfk_59` FOREIGN KEY (`studentID`) REFERENCES `students_tb` (`studentID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `unitEnrollment_tb_ibfk_60` FOREIGN KEY (`unitOfferingID`) REFERENCES `unitOffering_tb` (`unitOfferingID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unitEnrollment_tb`
--

LOCK TABLES `unitEnrollment_tb` WRITE;
/*!40000 ALTER TABLE `unitEnrollment_tb` DISABLE KEYS */;
INSERT INTO `unitEnrollment_tb` VALUES ('185bbeb7-6c21-4195-a94d-481e4004a221','SCCI/03853P/2021','2f7b8057-8857-43a8-a868-afdd3ab54387',NULL,'active'),('3eeb9b0f-532d-4067-8623-e9ec48098deb','SCCI/00573/2020','2f7b8057-8857-43a8-a868-afdd3ab54387',NULL,'active'),('bf36b4cc-7454-43d3-9c53-b58656030fc6','SCCI/0624/2021','2f7b8057-8857-43a8-a868-afdd3ab54387',NULL,'active');
/*!40000 ALTER TABLE `unitEnrollment_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unitOfferingContent_tb`
--

DROP TABLE IF EXISTS `unitOfferingContent_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unitOfferingContent_tb` (
  `offeringContentID` varchar(40) NOT NULL,
  `unitOfferingID` varchar(40) DEFAULT NULL,
  `videoUrl` varchar(255) DEFAULT NULL,
  `link` varchar(255) DEFAULT NULL,
  `type` enum('recording','link') DEFAULT NULL,
  `description` text,
  `uploadedAt` datetime DEFAULT NULL,
  PRIMARY KEY (`offeringContentID`),
  KEY `unitOfferingID` (`unitOfferingID`),
  CONSTRAINT `unitOfferingContent_tb_ibfk_1` FOREIGN KEY (`unitOfferingID`) REFERENCES `unitOffering_tb` (`unitOfferingID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unitOfferingContent_tb`
--

LOCK TABLES `unitOfferingContent_tb` WRITE;
/*!40000 ALTER TABLE `unitOfferingContent_tb` DISABLE KEYS */;
/*!40000 ALTER TABLE `unitOfferingContent_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unitOffering_tb`
--

DROP TABLE IF EXISTS `unitOffering_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unitOffering_tb` (
  `unitOfferingID` varchar(100) NOT NULL,
  `lecturerID` varchar(30) NOT NULL,
  `unitID` varchar(30) NOT NULL,
  `academicYear` varchar(10) NOT NULL,
  `year` int NOT NULL,
  `sem` int NOT NULL,
  PRIMARY KEY (`unitOfferingID`),
  UNIQUE KEY `unit_offering_tb_lecturer_i_d_unit_i_d_academic_year_year_sem` (`lecturerID`,`unitID`,`academicYear`,`year`,`sem`),
  KEY `unitID` (`unitID`),
  CONSTRAINT `unitOffering_tb_ibfk_59` FOREIGN KEY (`lecturerID`) REFERENCES `lecturers_tb` (`lecturerID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `unitOffering_tb_ibfk_60` FOREIGN KEY (`unitID`) REFERENCES `units_tb` (`unitID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unitOffering_tb`
--

LOCK TABLES `unitOffering_tb` WRITE;
/*!40000 ALTER TABLE `unitOffering_tb` DISABLE KEYS */;
INSERT INTO `unitOffering_tb` VALUES ('2146e11d-a71b-4a89-93fb-01df6f105990','ACSI/005','ECSI4204','2024/2025',4,2),('29f67d82-16c8-4cce-b82e-35b9974defcc','ACSI/007','ECSI4203','2022/2023',4,2),('2c1f315d-7b20-41b1-8245-61719ea85f6f','ACSI/007','ECSI4203','2023/2024',4,2),('fe9dfc6f-ca3e-4f6b-8cfb-019cb6127efb','ACSI/007','ECSI4203','2024/2025',4,2),('2f7b8057-8857-43a8-a868-afdd3ab54387','ACSI/014','ECSI4206','2024/2025',4,2);
/*!40000 ALTER TABLE `unitOffering_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `units_tb`
--

DROP TABLE IF EXISTS `units_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `units_tb` (
  `unitID` varchar(30) NOT NULL,
  `unitName` varchar(50) NOT NULL,
  `unitDescription` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`unitID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `units_tb`
--

LOCK TABLES `units_tb` WRITE;
/*!40000 ALTER TABLE `units_tb` DISABLE KEYS */;
INSERT INTO `units_tb` VALUES ('ECSI4101','Project Managment',NULL),('ECSI4102','Software Engineering & Development',NULL),('ECSI4103','Distributed Systems',NULL),('ECSI4104','Information System Audit & Control',NULL),('ECSI4105','Database Administration',NULL),('ECSI4106','Automata Theory and Languages',NULL),('ECSI4107','Compiler Design & Constraction',NULL),('ECSI4108','Computer Vision',NULL),('ECSI4111','Telecommunication System Managment',NULL),('ECSI4112','Cyber Security 2',NULL),('ECSI4113','Internet Technologies',NULL),('ECSI4114','Advanced Artificial Inteligence',NULL),('ECSI4201','Organization Managment',NULL),('ECSI4202','Enviroment Managment',NULL),('ECSI4203','Estimating Tendering & Computer Services Contracts',NULL),('ECSI4204','ICT Emerging Trends & Society',NULL),('ECSI4205','Legal & Ethical Issues In Computing',NULL),('ECSI4206','Managment Information System',NULL),('ECSI4210','ERP system Managment',NULL),('ECSI4211','Office Computing Managment',NULL),('EEEE3201','Microprocessors & Digital Design',NULL);
/*!40000 ALTER TABLE `units_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_tb`
--

DROP TABLE IF EXISTS `user_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_tb` (
  `userID` varchar(30) NOT NULL,
  `fname` varchar(15) NOT NULL,
  `sname` varchar(15) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(100) NOT NULL,
  `role` enum('student','lecturer','admin') DEFAULT 'student',
  `mobile` varchar(15) DEFAULT NULL,
  `profileUrl` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE KEY `email` (`email`),
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_tb`
--
 
LOCK TABLES `user_tb` WRITE;
/*!40000 ALTER TABLE `user_tb` DISABLE KEYS */;
INSERT INTO `user_tb` VALUES ('ACSI/001','Dr samson','Njuki','snjuki@tukenya.ac.ke','$2b$10$n3LUpsebOd4Zgt66mFtjhuLWmZmzSjIV3DmtDIkAuB1RoqAsy8Wj2','lecturer',NULL,NULL),('ACSI/003','Dr Edwin','Obare','obare@tukenya.ac.ke','$2b$10$61/YshEaWZSIyDR77Yj8xO.lMxOwc.kphAVEL4wIaZceg4xY0am9O','lecturer',NULL,NULL),('ACSI/005','Luke','Otieno','luke@tukenya.ac.ke','$2b$10$BdpJmgpVIeAp0Oq3giyMju7vl7PU2if0Oa1x0eG4iI7ySmb1EweNW','lecturer',NULL,NULL),('ACSI/006','peter','Mulei','muleiPeter@tukenya.ac.ke','$2b$10$CuiSpxBIhm/7BCj.pS7yUO8pE1EzBOacgF9oKF5OxnJ8sfglc3F9O','lecturer',NULL,NULL),('ACSI/007','Lucy','Abwotha','Abwothalucy@gmail.com','$2b$10$HzbCcVuAS4R61CW/zdQ7wO6RAGSlW42qHitZ8VevXuA4cwVOm/yUq','lecturer',NULL,NULL),('ACSI/014','Amstrong','Muasya','muasyaAmstrong@gmail.com','$2b$10$ybc.7VUJ90AVXfwOAWs5buDFLi2peafDsMjW5k5VOT58ODfn./0n6','lecturer',NULL,NULL),('ACSI/016','Mary','Nguchu','nguchuMary@tukenya.ac.ke','$2b$10$BuRoz7sCu1CgvInNmyjANOXbUBNfLy2wv63R2b.16vsUwTI/5ziMe','lecturer',NULL,NULL),('SCCI/00573/2020','Muturi','Melvin','melvinmurichu@gmail.com','$2b$10$fB66qgZmjoFXRT0n0IUT/eDj9NTAi4qUkHxtybhFgXys6LxS/ytei','student',NULL,NULL),('SCCI/00574/2021','john','kelvin','kelvin@gmail.com','$2b$10$li/V0iNeKIcclvun3Ll77OjFRA8KnILLNopVXXIi/4AsQX7j.s13q','student',NULL,NULL),('SCCI/00594/2021','Milly','Kagweru','kagweru@gmail.com','$2b$10$ZsnM3I7VToHMn7NnhjZUl.Uwv9f01Gbo4IR8HvN2Etqj6P.tYCDXa','student',NULL,NULL),('SCCI/00604/2021','Eunice','Nyambura','enyambura@gmail.com','$2b$10$umZehWsd5gjlx2QRgpyNDepUV0WCZi8tvrQQXQ3IErP0YhezLowyq','student',NULL,NULL),('SCCI/00605/2021','Felistus','Kioko','kioko@gmail.com','$2b$10$XWGulW/3seWux.zl49brpuARW5Z/PbGJ5UnzY0jnXEb7qGPVYPCmu','student',NULL,NULL),('SCCI/03853P/2021','Amalemba','Victor','amalemba@gmail.com','$2b$10$wJ96f5xU6lQSKBmTLHgRE.payVChAm7yP/H/jI51OQST.JvW0zfh.','student',NULL,NULL),('SCCI/0624/2021','Joshua','Omwami','Omwamijosh@gmail.com','$2b$10$HbwG5dhbeD9On.5bWN3IW.x9l.O7fWJeF.DKkb8cviPdnCCSziA5G','student','0796453897','https://res.cloudinary.com/dkc2oujm6/image/upload/v1751478633/profile/st1.jpg'),('SCII/00659/2021','Sharon','Otieno','otieno@gmail.com','$2b$10$KAlZ31fCDwsi8rOKiCdogOJXWj6lhrgo.2AS87TJyhD8kqhTJEPy2','student',NULL,NULL),('SCII/01060/2021','Mathew','maingi','maingi@gmail.com','$2b$10$bj8dTHahWqFt64K4FW2WKubstNKiNBIY3vyv6g5vu1EDYhbpChmbO','student',NULL,NULL),('SCNI/01290/2021','Bervely','Boyani','boyani@gmail.com','$2b$10$41KLGT8sdox4UDSrjwV/I.8.9ZqY1549SwTy0/POLPAor0cAaGmAW','student','0756789808','https://res.cloudinary.com/dkc2oujm6/image/upload/v1751479027/profile/20211231_123143.jpg'),('SCNI/01298/2021','Taff','Nyamita','nyamita@gmail.com','$2b$10$Cajca10HOKT32ZPQ9/svVODQ4SqRieus1guRe61e1SO9FtyAZP2/G','student',NULL,NULL);
/*!40000 ALTER TABLE `user_tb` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-06 10:09:29
