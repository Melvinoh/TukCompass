-- MySQL dump 10.13  Distrib 8.0.43, for Linux (x86_64)
--
-- Host: localhost    Database: TukCompass_DB
-- ------------------------------------------------------
-- Server version	8.0.43-0ubuntu0.22.04.1

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
  `lecturerUnitID` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `lecturerID` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `unitID` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`lecturerUnitID`),
  KEY `lecturerID` (`lecturerID`),
  KEY `unitID` (`unitID`),
  CONSTRAINT `LecturerUnits_ibfk_21` FOREIGN KEY (`lecturerID`) REFERENCES `lecturers_tb` (`lecturerID`),
  CONSTRAINT `LecturerUnits_ibfk_22` FOREIGN KEY (`unitID`) REFERENCES `units_tb` (`unitID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
  `announcmentID` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `message` text COLLATE utf8mb4_general_ci,
  `fileUrl` text COLLATE utf8mb4_general_ci,
  `targetGroup` enum('all','lecturers','students') COLLATE utf8mb4_general_ci DEFAULT NULL,
  `createdBy` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `schoolID` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `createdAt` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`announcmentID`),
  KEY `createdBy` (`createdBy`),
  KEY `schoolID` (`schoolID`),
  CONSTRAINT `announcment_tb_ibfk_17` FOREIGN KEY (`createdBy`) REFERENCES `user_tb` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `announcment_tb_ibfk_18` FOREIGN KEY (`schoolID`) REFERENCES `school_tb` (`schoolID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `announcment_tb`
--

LOCK TABLES `announcment_tb` WRITE;
/*!40000 ALTER TABLE `announcment_tb` DISABLE KEYS */;
INSERT INTO `announcment_tb` VALUES ('2991d573-9751-460f-b18c-09619f15b8ef','Revised SCIT exam timetable sem 2','kindly checkout for the upadated time table','https://res.cloudinary.com/dkc2oujm6/image/upload/v1751549297/annoncments/NOTICE_-Reschduling_of_Start_Date_of_Examinations.pdf','students','ACSI/001','SCIT_001','2025-07-03 18:37:26'),('60274157-b415-46c5-9d32-fb037d830de3','Freshers Night 2025 Edittion','lets Avail ourselves today as we welcome our fresh mens to collage ','https://res.cloudinary.com/dkc2oujm6/image/upload/v1754603397/annoncments/images_2.jpg','students','SCCI/0624/2021','SCIT_001','2025-08-08 00:49:54'),('83d5a10b-2c3b-481d-abd7-ddc4d5148ad8','exam date reschedule','The examinations will commence on tuesday 8/07/2025 instead of the previously scheduled Monday 7/07/2025','https://res.cloudinary.com/dkc2oujm6/image/upload/v1751549297/annoncments/NOTICE_-Reschduling_of_Start_Date_of_Examinations.pdf','all','ACSI/001',NULL,'2025-07-03 16:28:15');
/*!40000 ALTER TABLE `announcment_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `c&sMembers_tb`
--

DROP TABLE IF EXISTS `c&sMembers_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `c&sMembers_tb` (
  `csMemberID` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `clubSportID` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `userID` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `clubSportsID` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`csMemberID`),
  UNIQUE KEY `c&sMembers_tb_userID_clubSportsID_unique` (`userID`,`clubSportsID`),
  KEY `clubSportID` (`clubSportID`),
  KEY `clubSportsID` (`clubSportsID`),
  CONSTRAINT `c&sMembers_tb_ibfk_1` FOREIGN KEY (`clubSportID`) REFERENCES `c&s_tb` (`clubSportsID`),
  CONSTRAINT `c&sMembers_tb_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `user_tb` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `c&sMembers_tb_ibfk_3` FOREIGN KEY (`clubSportsID`) REFERENCES `c&s_tb` (`clubSportsID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
  `clubSportsID` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `type` enum('clubs','sports') COLLATE utf8mb4_general_ci DEFAULT NULL,
  `profileURL` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `coverURL` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `patron` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`clubSportsID`),
  KEY `patron` (`patron`),
  CONSTRAINT `c&s_tb_ibfk_1` FOREIGN KEY (`patron`) REFERENCES `user_tb` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `c&s_tb`
--

LOCK TABLES `c&s_tb` WRITE;
/*!40000 ALTER TABLE `c&s_tb` DISABLE KEYS */;
INSERT INTO `c&s_tb` VALUES ('3D_005','3D animation ','clubs','https://res.cloudinary.com/dkc2oujm6/image/upload/v1754410413/TukCompass/download.jpg','https://res.cloudinary.com/dkc2oujm6/image/upload/v1754410414/TukCompass/3D-4.jpg','Shaping virtual worlds and characters through the art of 3D storytelling.','ACSI/016'),('BA_007','Tuk Basketball','sports','https://res.cloudinary.com/dkc2oujm6/image/upload/v1754410712/TukCompass/basketball.jpg','https://res.cloudinary.com/dkc2oujm6/image/upload/v1754410712/TukCompass/download_2.jpg','Building teamwork, discipline, and passion through the beautiful game.','ACSI/014'),('CH_001','Chess club','clubs','https://res.cloudinary.com/dkc2oujm6/image/upload/v1754410065/TukCompass/chessclub2.jpg','https://res.cloudinary.com/dkc2oujm6/image/upload/v1754410067/TukCompass/Chess_pieces_close_up.jpg','Sharpening minds through strategy, focus, and intellectual challenge.','ACSI/003'),('CS_004','Cyber Security','clubs','https://res.cloudinary.com/dkc2oujm6/image/upload/v1754410272/TukCompass/cyberSecurity.jpg','https://res.cloudinary.com/dkc2oujm6/image/upload/v1754410273/TukCompass/cyber_security_banner.jpg','Promoting cybersecurity awareness, ethical hacking, and digital resilience through research and collaboration.','ACSI/003'),('DC_003','dance club','clubs','https://res.cloudinary.com/dkc2oujm6/image/upload/v1754410146/TukCompass/dance_club.png','https://res.cloudinary.com/dkc2oujm6/image/upload/v1754410148/TukCompass/dance_baner.jpg','Expressing rhythm, culture, and energy through movement and unity.','ACSI/003'),('DR_002','Drama club','clubs','https://res.cloudinary.com/dkc2oujm6/image/upload/v1754409420/TukCompass/drama_club.png','https://res.cloudinary.com/dkc2oujm6/image/upload/v1754409422/TukCompass/drama_banner1.jpg','\"Bringing stories to life through creativity, collaboration, and performance.','ACSI/003'),('FB_006','Football club','sports','https://res.cloudinary.com/dkc2oujm6/image/upload/v1754410592/TukCompass/football_sport.png','https://res.cloudinary.com/dkc2oujm6/image/upload/v1754410594/TukCompass/download_1.jpg','Building teamwork, discipline, and passion through the beautiful game.','ACSI/006'),('GD_009','GDSC Tuk','clubs','https://res.cloudinary.com/dkc2oujm6/image/upload/v1754411335/TukCompass/download_5.jpg','https://res.cloudinary.com/dkc2oujm6/image/upload/v1754411336/TukCompass/download_2.png','Sharpening minds through strategy, focus, and intellectual challenge.','ACSI/016'),('TT_008','Table Tennis','sports','https://res.cloudinary.com/dkc2oujm6/image/upload/v1754410960/TukCompass/download_3.jpg','https://res.cloudinary.com/dkc2oujm6/image/upload/v1754410961/TukCompass/download_4.jpg','Building teamwork, discipline, and passion through the beautiful game.','ACSI/016');
/*!40000 ALTER TABLE `c&s_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chatMembers_tb`
--

DROP TABLE IF EXISTS `chatMembers_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatMembers_tb` (
  `memberID` varchar(45) COLLATE utf8mb4_general_ci NOT NULL,
  `chatID` varchar(45) COLLATE utf8mb4_general_ci NOT NULL,
  `userID` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `lastSeen` datetime DEFAULT NULL,
  PRIMARY KEY (`memberID`),
  KEY `chatID` (`chatID`),
  KEY `userID` (`userID`),
  CONSTRAINT `chatMembers_tb_ibfk_1` FOREIGN KEY (`chatID`) REFERENCES `chats_tb` (`chatID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chatMembers_tb_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `user_tb` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chatMembers_tb`
--

LOCK TABLES `chatMembers_tb` WRITE;
/*!40000 ALTER TABLE `chatMembers_tb` DISABLE KEYS */;
INSERT INTO `chatMembers_tb` VALUES ('2fbc1b60-777b-4eff-bed6-605d16f83e94','0ba1119f-a9bf-4ae5-826c-bf8afbd66380','SCCI/0624/2021','2025-09-15 11:41:46'),('44ed0738-378e-4eee-bd3c-7090cfaf393e','3118096c-b1af-4d3e-ad43-016441897b58','SCCI/0624/2021','2025-09-17 08:19:57'),('55bb3272-4910-4f3d-a239-c40a714e26ce','7863ed96-12d8-4d3b-9937-744db682d47f','SCCI/00627/2021','2025-09-15 07:36:16'),('5e16f50f-7d48-466a-8cce-1652447114a1','7863ed96-12d8-4d3b-9937-744db682d47f','SCCI/00594/2021',NULL),('600e70bd-1971-48ad-ae7e-904da2be666d','0ba1119f-a9bf-4ae5-826c-bf8afbd66380','SCCI/0625/2021','2025-09-17 10:21:09'),('7bd50df0-948c-4730-91d5-e8cdb43801d4','78ab622d-ac71-4d7d-92aa-4d98bb21d9cf','SCCI/03853P/2021',NULL),('81481d61-4bad-4ac6-8742-c2c1d56dd576','e9e4c064-cebd-4b64-94f2-4cd52624f2ce','SCCI/0624/2021','2025-09-13 22:19:33'),('8b1c6a07-3a62-42ae-be16-44840e50dd89','b5f950c6-6e23-43f0-9aeb-de141cf61ce3','SCCi/00624/2021',NULL),('8b978b9d-c8b3-4169-a451-41c0055cdabf','b5f950c6-6e23-43f0-9aeb-de141cf61ce3','SCCI/00678/2021','2025-09-15 11:38:34'),('9d495397-1914-4298-ac8f-cad6d5b40a71','b848e316-f2ee-42b2-9e5f-a878c990c9b5','SCCI/00605/2021',NULL),('9fbedf2d-1e1b-4360-87d6-755e858396b4','b848e316-f2ee-42b2-9e5f-a878c990c9b5','SCCI/0624/2021','2025-09-14 00:34:47'),('adcb7298-c2d1-4939-83d9-6ebfec09c72f','78ab622d-ac71-4d7d-92aa-4d98bb21d9cf','SCCI/00594/2021','2025-09-17 17:56:18'),('c47867fe-7f43-4cbd-b7c1-0d2887acf743','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/00594/2021','2025-09-19 06:52:50'),('c65ab407-c949-4128-9a3d-20bb2001419e','3118096c-b1af-4d3e-ad43-016441897b58','SCCI/00594/2021','2025-09-13 12:29:26'),('c7d2ae56-65e2-4085-ac71-228790bb43b7','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/0625/2021','2025-09-19 06:51:50'),('f7501c07-37ee-423f-bee3-4e7bee6e6589','e9e4c064-cebd-4b64-94f2-4cd52624f2ce','ACSI/014 ',NULL);
/*!40000 ALTER TABLE `chatMembers_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chatMessages_tb`
--

DROP TABLE IF EXISTS `chatMessages_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chatMessages_tb` (
  `messageID` varchar(45) COLLATE utf8mb4_general_ci NOT NULL,
  `chatID` varchar(45) COLLATE utf8mb4_general_ci NOT NULL,
  `senderID` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `messageContent` text COLLATE utf8mb4_general_ci,
  `mediaUrl` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `mediaType` enum('image','file','video','none') COLLATE utf8mb4_general_ci DEFAULT 'none',
  `createdAt` datetime DEFAULT NULL,
  PRIMARY KEY (`messageID`),
  KEY `chatID` (`chatID`),
  KEY `senderID` (`senderID`),
  CONSTRAINT `chatMessages_tb_ibfk_1` FOREIGN KEY (`chatID`) REFERENCES `chats_tb` (`chatID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chatMessages_tb_ibfk_2` FOREIGN KEY (`senderID`) REFERENCES `user_tb` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chatMessages_tb`
--

LOCK TABLES `chatMessages_tb` WRITE;
/*!40000 ALTER TABLE `chatMessages_tb` DISABLE KEYS */;
INSERT INTO `chatMessages_tb` VALUES ('065e8330-2bca-4427-ab49-6670ff2ebd71','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/00594/2021','waguan manaboliz',NULL,'none','2025-09-19 06:52:50'),('0dcebdb0-46de-4339-9054-f4bdf228fb18','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/00594/2021','yes yes',NULL,'none','2025-09-18 11:22:32'),('0eb05de3-3aec-4e01-b962-1b34fb50d8c5','b848e316-f2ee-42b2-9e5f-a878c990c9b5','SCCI/0624/2021','hello',NULL,'none','2025-09-13 23:58:31'),('1a55c3f8-16db-441d-bbed-ba3babd273a9','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/00594/2021','okay',NULL,'none','2025-09-17 12:33:44'),('1ab8c1a6-d041-4f3a-a509-944df7c973c5','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/0625/2021','usikuagae hivyo manze',NULL,'none','2025-09-17 14:47:25'),('1c324ca5-d96e-4aed-975a-0a0d43084542','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/0625/2021','truly veteran',NULL,'none','2025-09-18 13:17:49'),('1d755c90-06ad-4553-a721-22f39b688d36','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/00594/2021','he is fine',NULL,'none','2025-09-17 13:19:38'),('22def78d-93ac-467c-9924-d5402688b1cc','3118096c-b1af-4d3e-ad43-016441897b58','SCCI/0624/2021','what\'s app with this mixes',NULL,'none','2025-09-13 22:28:34'),('23af6317-c282-4853-b39c-acc74f32e36a','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/0625/2021','thanks manze',NULL,'none','2025-09-17 13:54:38'),('2793d73b-b5b1-4113-970a-28b94190d6ba','3118096c-b1af-4d3e-ad43-016441897b58','SCCI/0624/2021','yes yes managaliz',NULL,'none','2025-09-13 21:58:25'),('2cb24ea0-c404-4a44-97a2-1ef9034ee23e','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/00594/2021','yeah mahn',NULL,'none','2025-09-18 13:29:07'),('31bb3d36-14eb-478f-ba4a-2476ca058b56','0ba1119f-a9bf-4ae5-826c-bf8afbd66380','SCCI/0625/2021','hi',NULL,'none','2025-09-17 10:21:09'),('3a6db0ea-e99b-485c-8c0b-d7b5bb4e9722','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/00594/2021','at  what time will be that',NULL,'none','2025-09-17 12:22:54'),('3e449dfe-4290-4863-bf31-cd53d296cb5d','3118096c-b1af-4d3e-ad43-016441897b58','SCCI/0624/2021','raster man is a peacefullman','https://res.cloudinary.com/dkc2oujm6/image/upload/v1757766389/chat_media/Screenshot_2024-06-18_092753.png','none','2025-09-14 00:08:20'),('4094b64b-9f6c-4a72-9ac7-a26ff03786fe','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/00594/2021','thats funny',NULL,'none','2025-09-18 09:02:40'),('4212fcb7-3dc3-4b53-ad49-8de0b1e5a758','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/00594/2021','yes I will be available',NULL,'none','2025-09-17 12:14:49'),('4332511e-2cef-4a11-9f09-f9f9e1638076','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/00594/2021','well okay then but does that.. anyway',NULL,'none','2025-09-18 08:56:20'),('4dbadecc-9c6c-4d7d-a2e2-232c2437e798','3118096c-b1af-4d3e-ad43-016441897b58','SCCI/0624/2021','fi me dat..me ya do what ua say',NULL,'none','2025-09-12 23:21:59'),('5554f743-19d2-44de-a448-664bec2347d7','e9e4c064-cebd-4b64-94f2-4cd52624f2ce','SCCI/0624/2021','waguan teacher trully unrully','https://res.cloudinary.com/dkc2oujm6/image/upload/v1757719204/chat_media/Screenshot_2024-06-18_092859.png','image','2025-09-12 23:20:04'),('56b1c7eb-c702-430d-aed5-b1caa3ef98b2','0ba1119f-a9bf-4ae5-826c-bf8afbd66380','SCCI/0625/2021','hello',NULL,'none','2025-09-17 10:20:27'),('597ad8d7-9c35-48b0-818b-b1990e7c0571','b848e316-f2ee-42b2-9e5f-a878c990c9b5','SCCI/0624/2021','what  ya  say fi me do',NULL,'none','2025-09-14 00:24:08'),('5a5b592f-970a-4669-8b4a-50cc179bda59','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/0625/2021','have a look at this','https://res.cloudinary.com/dkc2oujm6/image/upload/v1757801973/chat_media/34.jpg','none','2025-09-18 08:58:22'),('606609ea-8c2b-4c30-8e05-9c5fdd8f1767','78ab622d-ac71-4d7d-92aa-4d98bb21d9cf','SCCI/00594/2021','hello',NULL,'none','2025-09-17 17:56:18'),('62721c7a-b241-4c16-955b-0cc9fa3f406f','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/0625/2021','waguan manaboliz',NULL,'none','2025-09-18 11:56:49'),('65cdae8f-b96f-4aa2-8c3f-81b5a364dd11','b848e316-f2ee-42b2-9e5f-a878c990c9b5','SCCI/0624/2021','how are you managaliz',NULL,'none','2025-09-13 23:59:00'),('65df422f-0c2b-48e2-b1e9-29d5a82d59ed','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/0625/2021','well not really',NULL,'none','2025-09-18 08:55:02'),('6b718c27-d9e7-41c2-be38-5ca58dd2b3aa','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/0625/2021','more life',NULL,'none','2025-09-18 13:33:50'),('6caa70cb-c37b-4337-b08f-12f3dcea9fa7','3118096c-b1af-4d3e-ad43-016441897b58','SCCI/0624/2021','trully unrullly ganja famer ','https://res.cloudinary.com/dkc2oujm6/image/upload/v1757766389/chat_media/Screenshot_2024-06-18_092753.png','image','2025-09-13 12:26:29'),('6cddbf9a-ac49-4807-8876-eca4cd8b3f37','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/0625/2021','hello managaliz will you be available today',NULL,'none','2025-09-17 12:13:43'),('6d1adca3-3df2-45f4-91ff-6103a03ccaed','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/0625/2021','naah i am not feeling it',NULL,'none','2025-09-18 09:28:17'),('756ddcf8-9473-46e6-b8ac-4893935c000b','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/0625/2021','in the afternoon',NULL,'none','2025-09-17 12:23:20'),('7bb3e2b7-94c6-4014-9537-623b3f87aeff','0ba1119f-a9bf-4ae5-826c-bf8afbd66380','SCCI/0624/2021','assesor has said you chat with me',NULL,'none','2025-09-15 11:41:46'),('7d0f72f7-c2db-4a5a-97ea-2e72423cdbd5','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/00594/2021','mbona sasa',NULL,'none','2025-09-17 14:37:37'),('7d6ba568-bf85-4e03-a066-8a7e23e98743','b848e316-f2ee-42b2-9e5f-a878c990c9b5','SCCI/0624/2021','rasterman is here yooh',NULL,'none','2025-09-14 00:10:07'),('7d8f7bbb-8803-42ae-a50f-4fa36c43dc2a','3118096c-b1af-4d3e-ad43-016441897b58','SCCI/0624/2021','waguan manaboliz trully unrully','https://res.cloudinary.com/dkc2oujm6/image/upload/v1757766389/chat_media/Screenshot_2024-06-18_092753.png','image','2025-09-13 12:28:54'),('7e27d996-4467-4aaa-9d28-1140adaf0e3b','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/0625/2021','waguaguan  managaliz',NULL,'none','2025-09-19 06:51:49'),('829bba91-c91a-414f-91fc-aa8726421547','7863ed96-12d8-4d3b-9937-744db682d47f','SCCI/00627/2021','hello',NULL,'none','2025-09-15 07:36:16'),('8478b6bf-825b-43ac-88a7-98975eb01320','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/00594/2021','yes it has...I definately will',NULL,'none','2025-09-17 13:29:14'),('8756cd1c-1128-4572-a0bc-588924eaab0d','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/00594/2021','well sure isn\'t it ?',NULL,'none','2025-09-18 09:24:47'),('8d093767-5b87-4082-a43b-89d4f1747c76','3118096c-b1af-4d3e-ad43-016441897b58','SCCI/0624/2021','waguan managaliz what ya say fi me do',NULL,'none','2025-09-12 23:13:55'),('93548432-2c61-4e36-964a-c97e30f39e93','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/0625/2021','bomboclat',NULL,'none','2025-09-18 12:23:45'),('997410f8-3054-439d-aa07-b33cf67102fd','3118096c-b1af-4d3e-ad43-016441897b58','SCCI/0624/2021','raster man is a peacefullman','https://res.cloudinary.com/dkc2oujm6/image/upload/v1757766389/chat_media/Screenshot_2024-06-18_092753.png','none','2025-09-17 08:19:57'),('9ee98b75-cd7c-4933-a3d0-ba6ec0eca4ec','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/00594/2021','any time managaliz',NULL,'none','2025-09-17 14:00:25'),('a28f5738-b758-4200-9582-7d55230161d1','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/0625/2021','its been a while utamsalimia',NULL,'none','2025-09-17 13:27:50'),('a3172864-b9de-4278-9a25-f31079b18730','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/0625/2021','c unaweza ni Jenga number yake',NULL,'none','2025-09-17 14:34:30'),('a47f9055-80f7-40b9-aa9f-4953162dceeb','3118096c-b1af-4d3e-ad43-016441897b58','SCCI/0624/2021','if ur mama fi a ratser mama  Fi raster barada',NULL,'none','2025-09-13 12:20:43'),('a6a914c0-5dea-48ea-aeea-2a7d424d32b8','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/00594/2021','alafu managaliz usisahau hio staff',NULL,'none','2025-09-18 11:49:54'),('b52ffc02-b278-4109-9775-eafaaecbf0f0','3118096c-b1af-4d3e-ad43-016441897b58','SCCI/00594/2021','waguan manaboliz trully unrully','https://res.cloudinary.com/dkc2oujm6/image/upload/v1757766389/chat_media/Screenshot_2024-06-18_092753.png','image','2025-09-13 12:29:26'),('b87e8af3-e707-4f90-9152-a16ddd3eaa42','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/0625/2021','don\'t forget snacks when u come',NULL,'none','2025-09-17 12:31:49'),('be738379-370e-463f-9244-8892c2f2b0ef','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/0625/2021','you think so','https://res.cloudinary.com/dkc2oujm6/image/upload/v1757801973/chat_media/34.jpg','none','2025-09-18 09:07:12'),('bf34fda3-d49c-4fca-b2b1-0ec43b3072ac','0ba1119f-a9bf-4ae5-826c-bf8afbd66380','SCCI/0625/2021','ooh yeah sure so lets meet at 2pm kindly',NULL,'none','2025-09-17 07:49:45'),('c50c3904-9dcf-4ea7-b1c7-ddb3ed6c78e5','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/00594/2021','is there something u want to tell me',NULL,'none','2025-09-17 17:19:14'),('caba8c62-3a92-4941-96e4-687793ddd0b5','0ba1119f-a9bf-4ae5-826c-bf8afbd66380','SCCI/0625/2021','hhello',NULL,'none','2025-09-14 23:00:56'),('cae6898b-2718-4c1d-b10e-364334aa662c','0ba1119f-a9bf-4ae5-826c-bf8afbd66380','SCCI/0625/2021','yes yes',NULL,'none','2025-09-15 02:09:14'),('d182f9b2-b52b-4495-8485-2019528ebf08','b5f950c6-6e23-43f0-9aeb-de141cf61ce3','SCCI/00678/2021','hae joshua',NULL,'none','2025-09-15 11:38:34'),('d2de4d9a-4ad3-4408-bcdb-c253ec4cbaa0','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/00594/2021','sure',NULL,'none','2025-09-17 14:28:58'),('d4e4954b-6d10-4db4-b234-0249d5cb689f','7863ed96-12d8-4d3b-9937-744db682d47f','SCCI/00627/2021','hello',NULL,'none','2025-09-15 06:54:48'),('d77cafb4-cf98-42a6-90cb-6b939ef5cc3b','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/00594/2021','uskii haiwezi mahn',NULL,'none','2025-09-17 14:48:48'),('df584942-c136-4f59-8ef4-7be78a45bacb','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/0625/2021','iwza ni vile unalenga',NULL,'none','2025-09-17 14:51:19'),('e5e11845-d70b-4114-ba2a-45768d9c1598','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/0625/2021','so how is your brother',NULL,'none','2025-09-17 13:19:04'),('e7e8e220-cc6e-4136-a038-4a1696e4c0b7','e9e4c064-cebd-4b64-94f2-4cd52624f2ce','SCCI/0624/2021','luku  ni fisa manze','https://res.cloudinary.com/dkc2oujm6/image/upload/v1757801973/chat_media/34.jpg','none','2025-09-13 22:19:33'),('e90b4b26-f905-437e-b224-b31e4899ddd8','b848e316-f2ee-42b2-9e5f-a878c990c9b5','SCCI/0624/2021','zzzz',NULL,'none','2025-09-14 00:34:47'),('e94437d5-6b8f-4628-921c-be0075e4b650','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/00594/2021','trully unruly',NULL,'none','2025-09-18 12:20:44'),('e98c6671-fed1-4100-a357-71862d838c3d','3118096c-b1af-4d3e-ad43-016441897b58','SCCI/0624/2021','raster man is a peacefullman','https://res.cloudinary.com/dkc2oujm6/image/upload/v1757766389/chat_media/Screenshot_2024-06-18_092753.png','none','2025-09-14 00:08:51'),('ea4164a7-09e2-4493-9ec7-4c9e05079c7d','0ba1119f-a9bf-4ae5-826c-bf8afbd66380','SCCI/0625/2021','are you ready now',NULL,'none','2025-09-17 09:31:21'),('ea4ca38f-c4aa-49e2-83c7-e5d148c0273f','e9e4c064-cebd-4b64-94f2-4cd52624f2ce','SCCI/0624/2021','hello mwalimu will u be available tomorrow',NULL,'none','2025-09-13 21:19:50'),('f6b96fa5-20a2-4cc1-869c-3d9c364ff7bb','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/00594/2021','trully ganjer farmer',NULL,'none','2025-09-18 12:40:42'),('f874c442-f260-4d89-8ac8-ab30dd1e222e','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/0625/2021','one more thing',NULL,'none','2025-09-17 14:14:38'),('fd5faece-7a31-4a4e-a318-26538754401b','a1ae073f-4f3c-4a61-b6a9-8408831dbd19','SCCI/0625/2021','don\'t  forget snacks this time',NULL,'none','2025-09-17 12:31:08'),('fe567bc4-d3ec-47c0-9149-c976c38ab828','0ba1119f-a9bf-4ae5-826c-bf8afbd66380','SCCI/0625/2021','hi',NULL,'none','2025-09-17 10:20:49');
/*!40000 ALTER TABLE `chatMessages_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `chats_tb`
--

DROP TABLE IF EXISTS `chats_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chats_tb` (
  `chatID` varchar(45) COLLATE utf8mb4_general_ci NOT NULL,
  `type` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `chatName` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `chatAvatar` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `createdBy` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`chatID`),
  KEY `createdBy` (`createdBy`),
  CONSTRAINT `chats_tb_ibfk_1` FOREIGN KEY (`createdBy`) REFERENCES `user_tb` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chats_tb`
--

LOCK TABLES `chats_tb` WRITE;
/*!40000 ALTER TABLE `chats_tb` DISABLE KEYS */;
INSERT INTO `chats_tb` VALUES ('0ba1119f-a9bf-4ae5-826c-bf8afbd66380','private',NULL,NULL,NULL,'2025-09-14 23:00:56','2025-09-14 23:00:56'),('3118096c-b1af-4d3e-ad43-016441897b58','private',NULL,NULL,NULL,'2025-09-12 23:13:54','2025-09-12 23:13:54'),('7863ed96-12d8-4d3b-9937-744db682d47f','private',NULL,NULL,NULL,'2025-09-15 06:54:48','2025-09-15 06:54:48'),('78ab622d-ac71-4d7d-92aa-4d98bb21d9cf','private',NULL,NULL,NULL,'2025-09-17 17:56:18','2025-09-17 17:56:18'),('a1ae073f-4f3c-4a61-b6a9-8408831dbd19','private',NULL,NULL,NULL,'2025-09-17 12:13:42','2025-09-17 12:13:42'),('b5f950c6-6e23-43f0-9aeb-de141cf61ce3','private',NULL,NULL,NULL,'2025-09-15 11:38:34','2025-09-15 11:38:34'),('b848e316-f2ee-42b2-9e5f-a878c990c9b5','private',NULL,NULL,NULL,'2025-09-13 23:58:30','2025-09-13 23:58:30'),('e9e4c064-cebd-4b64-94f2-4cd52624f2ce','private',NULL,NULL,NULL,'2025-09-12 23:16:34','2025-09-12 23:16:34');
/*!40000 ALTER TABLE `chats_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `class_tb`
--

DROP TABLE IF EXISTS `class_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `class_tb` (
  `classID` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `courseID` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `classRep` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `currentYear` int DEFAULT NULL,
  `currentSem` int DEFAULT NULL,
  `enrolmentYear` int DEFAULT NULL,
  `academicYear` varchar(10) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `completionYear` int DEFAULT NULL,
  PRIMARY KEY (`classID`),
  KEY `courseID` (`courseID`),
  KEY `classRep` (`classRep`),
  CONSTRAINT `class_tb_ibfk_103` FOREIGN KEY (`courseID`) REFERENCES `course_tb` (`courseID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `class_tb_ibfk_104` FOREIGN KEY (`classRep`) REFERENCES `user_tb` (`userID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
  `commentID` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `postID` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `userID` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`commentID`),
  KEY `postID` (`postID`),
  KEY `userID` (`userID`),
  CONSTRAINT `comments_tb_ibfk_37` FOREIGN KEY (`postID`) REFERENCES `posts_tb` (`postID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comments_tb_ibfk_38` FOREIGN KEY (`userID`) REFERENCES `user_tb` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments_tb`
--

LOCK TABLES `comments_tb` WRITE;
/*!40000 ALTER TABLE `comments_tb` DISABLE KEYS */;
INSERT INTO `comments_tb` VALUES ('01547ee7-dd10-4dbe-8dad-04b12dee7027','wawaguan my pepal','4b4db7d8-e18c-4c06-97b9-dc848caf68dd','SCCI/0624/2021'),('0c11de7c-dc56-42c9-8ead-aa6c9959cd77','how is the going guys','27f14f4a-1faa-41e5-b45b-3946fcb50068','SCCI/0624/2021'),('179baccd-bdb8-4e41-8586-ab3b6303bbaa','hello there','27f14f4a-1faa-41e5-b45b-3946fcb50068','SCCI/0624/2021'),('6e75f10b-86ae-47e6-a406-e47107928f25','HEY guys am new here','4b4db7d8-e18c-4c06-97b9-dc848caf68dd','SCCI/00678/2021'),('95b6ba7f-9369-417e-84e4-1a11c7ea4911','thanks for you warm welcome','d40adfd3-9120-4f6c-89dc-ea710b33f8a6','SCCI/0624/2021');
/*!40000 ALTER TABLE `comments_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `connects_tb`
--

DROP TABLE IF EXISTS `connects_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `connects_tb` (
  `connectID` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `followingID` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `followerID` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`connectID`),
  KEY `followingID` (`followingID`),
  KEY `followerID` (`followerID`),
  CONSTRAINT `connects_tb_ibfk_1` FOREIGN KEY (`followingID`) REFERENCES `user_tb` (`userID`) ON UPDATE CASCADE,
  CONSTRAINT `connects_tb_ibfk_2` FOREIGN KEY (`followerID`) REFERENCES `user_tb` (`userID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
  `courseID` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `courseName` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `departmentID` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`courseID`),
  KEY `departmentID` (`departmentID`),
  CONSTRAINT `course_tb_ibfk_1` FOREIGN KEY (`departmentID`) REFERENCES `department_tb` (`departmentID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
  `courseUnitID` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `courseID` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `unitID` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `year` int NOT NULL,
  `sem` int NOT NULL,
  PRIMARY KEY (`courseUnitID`),
  UNIQUE KEY `course_unit_tb_courseID_unitID_unique` (`courseID`,`unitID`),
  KEY `unitID` (`unitID`),
  CONSTRAINT `course_unit_tb_ibfk_93` FOREIGN KEY (`courseID`) REFERENCES `course_tb` (`courseID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `course_unit_tb_ibfk_94` FOREIGN KEY (`unitID`) REFERENCES `units_tb` (`unitID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `course_unit_tb`
--

LOCK TABLES `course_unit_tb` WRITE;
/*!40000 ALTER TABLE `course_unit_tb` DISABLE KEYS */;
INSERT INTO `course_unit_tb` VALUES ('03459af2-6e4d-45c9-bbce-06c054a81f3b','SCCI_01','BSIT2104',2,1),('041ce152-707d-4cbc-8315-71b22948b431','SCCI_01','ECSI1101',1,1),('0552b425-c8a4-43b8-903c-b8f84b973da3','SCCI_01','ECSI4106',4,1),('0b22f37e-2d70-4d83-831c-4f1a3c435ab1','SCCI_01','MTHC2103',2,1),('0d44c41b-0eaa-42c4-98e8-5d5486ba2812','SCCI_01','ECSI3103',3,1),('15be8a81-f702-48e5-9ff9-b18b33ec4f47','SCII_002','ECSI4114',4,1),('1ab76107-38d3-4baa-9455-f1d99bf5c3a7','SCCI_01','ECSI4104',4,1),('1e05c082-4336-4502-923f-11057a28b1e1','SCCI_01','ECSI4202',4,2),('3681de95-8be5-48cc-91a6-bde7c60c595f','SCII_002','ECSI4101',4,1),('377d0edd-4f77-48c3-855a-b42aa52b93ac','SCCI_01','PHYC1105',1,1),('4259e3a9-3221-4b08-8ed5-ef3f4094f455','SCII_002','ECSI4104',4,1),('474abf69-4e8b-4562-b761-ebb30c31b6bc','SCCI_01','ECSI4201',4,2),('796c0e41-a92d-49d4-9683-e2439501188b','SCII_002','ECSI4204',4,2),('799a751c-0320-47b5-b35b-b41d57a6d1fa','SCII_002','ECSI4201',4,2),('79bfef6f-04f3-4b37-b8d5-33d6e26cc7ee','SCII_002','ECSI4107',4,1),('7ef0fe44-c1b3-481a-bcfa-4dd2a3047e53','SCCI_01','ECSI2102',2,1),('929f055f-2810-4d70-8dad-b9337952b53d','SCII_002','ECSI4210',4,2),('93e8fbdc-caed-4685-b6b7-6e6b36d89f06','SCII_002','ECSI4112',4,1),('946ee32b-1c8d-47af-89ce-859e0220db9e','SCCI_01','ECSI3101',3,1),('9671e39f-876a-4494-bae2-4b2c40419b3d','SCCI_01','ECSI3102',3,1),('9dac6f36-396e-4338-be02-671f4039a357','SCCI_01','EEEE3201',4,2),('a0f4257d-dd53-4379-97f8-774d3c292f2e','SCCI_01','ECSI3104',3,1),('a2f2ca48-77ff-4419-a977-91f511a1beba','SCCI_01','ECSI4107',4,1),('ae51cf19-4882-413d-8a78-4c1bbdc8b2fa','SCCI_01','ECSI4103',4,1),('af110934-b218-40fb-be97-bb4c756896eb','SCCI_01','ECSI2101',2,1),('b0ec672e-f227-4c84-aa9d-ad12e2d5609e','SCII_002','ECSI4202',4,2),('b9a925f8-cf1c-4ff1-b43b-2bd99516c7bf','SCCI_01','ECSI4105',4,1),('bbdc4a05-e8d3-4ab9-b2a0-095248197660','SCII_002','ECSI4113',4,1),('c004e1f6-7bda-4c7e-86cb-bab560e85594','SCCI_01','ECSI4204',4,2),('c331d471-e8d5-4bde-84fa-ad77f915b603','SCCI_01','ECSI4206',4,2),('c4820dda-312b-4c72-86c0-7f5ff009b4a6','SCCI_01','ECSI4101',4,1),('d03cf0f3-d056-41d1-aa37-2269d3a5daa6','SCII_002','ECSI4111',4,1),('d0c54370-085c-4321-9c85-4026e08b6413','SCII_002','ECSI4211',4,2),('dcdb1cec-272b-4e51-a463-b7d6f8b0fc48','SCCI_01','MTHC1104',1,1),('dd566cde-a02e-4202-8046-c890beafe412','SCII_002','ECSI4203',4,2),('df76c4ce-49e0-41d9-a322-9b75764ae39f','SCII_002','ECSI4205',4,2),('e9cda2db-2631-4924-946b-a2d4d4446a0b','SCCI_01','ECSI4203',4,2),('eb8ae75c-07b5-4751-aeab-4d2d34d5857f','SCCI_01','ECSI4205',4,2),('f95a2434-95f4-49fe-9a77-a707da20fe86','SCCI_01','ECSI4102',4,1),('fac2067e-8074-41a9-af4c-458e9497732d','SCCI_01','ECSI1103',1,1),('fc4698a6-0c85-4bfa-8cec-8f3ca50bd940','SCCI_01','ECSI4108',4,1);
/*!40000 ALTER TABLE `course_unit_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `csMembers_tb`
--

DROP TABLE IF EXISTS `csMembers_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `csMembers_tb` (
  `csMemberID` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `clubSportID` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `userID` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`csMemberID`),
  UNIQUE KEY `csMembers_tb_userID_clubSportID_unique` (`clubSportID`,`userID`),
  KEY `userID` (`userID`),
  CONSTRAINT `csMembers_tb_ibfk_27` FOREIGN KEY (`clubSportID`) REFERENCES `c&s_tb` (`clubSportsID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `csMembers_tb_ibfk_28` FOREIGN KEY (`userID`) REFERENCES `user_tb` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `csMembers_tb`
--

LOCK TABLES `csMembers_tb` WRITE;
/*!40000 ALTER TABLE `csMembers_tb` DISABLE KEYS */;
INSERT INTO `csMembers_tb` VALUES ('b7ad1dab-4a2a-4ef6-93d7-10bbc2fcc17e','3D_005','SCCI/0624/2021'),('e04a8d68-f7b8-4055-9625-e3e80846c03d','3D_005','SCCI/0625/2021'),('dcc579f9-64df-4b55-a2a4-d8c1caa66231','BA_007','SCCI/0624/2021'),('105ebe57-2a07-4fbb-8d78-b2e7e366d94b','CH_001','SCCI/00678/2021'),('856fe476-f9f8-4057-8b08-4c1a63627b8e','CH_001','SCCI/0624/2021'),('f963d733-f1a9-4429-9775-895f6e5e57cd','CH_001','SCCI/0625/2021'),('749b8d9a-da39-411f-93c3-012d28083861','CS_004','SCCI/0624/2021'),('f9afdc63-b678-4446-b372-15532cb40dc3','DC_003','SCCI/0624/2021'),('f3e55de0-1c75-44d0-853e-523ed028dc93','DR_002','SCCI/0624/2021'),('39c4f968-121f-4263-bc8f-d188e276543a','FB_006','SCCI/0624/2021'),('4166cbb5-ff03-4232-9387-606502c87807','TT_008','SCCI/0624/2021');
/*!40000 ALTER TABLE `csMembers_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `csPosts_tb`
--

DROP TABLE IF EXISTS `csPosts_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `csPosts_tb` (
  `csPostID` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `clubSportID` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `postID` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`csPostID`),
  KEY `clubSportID` (`clubSportID`),
  KEY `postID` (`postID`),
  CONSTRAINT `csPosts_tb_ibfk_33` FOREIGN KEY (`clubSportID`) REFERENCES `c&s_tb` (`clubSportsID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `csPosts_tb_ibfk_34` FOREIGN KEY (`postID`) REFERENCES `posts_tb` (`postID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `csPosts_tb`
--

LOCK TABLES `csPosts_tb` WRITE;
/*!40000 ALTER TABLE `csPosts_tb` DISABLE KEYS */;
INSERT INTO `csPosts_tb` VALUES ('0c20d5e4-84a5-4497-96b9-ddbad9412fd6','DR_002','898058a9-65c3-461d-8951-4192efd94514'),('59d0199b-62e6-4229-9927-a5ef80420021','FB_006','27f14f4a-1faa-41e5-b45b-3946fcb50068'),('6dedfb9d-150f-4c6b-af22-39e291eb6fcc','BA_007','d40adfd3-9120-4f6c-89dc-ea710b33f8a6'),('7c111a85-d400-4720-b574-b321e3a72a9e','3D_005','ff0b2f1a-f436-428c-8dbe-0cb07f3e6b5d'),('a2111b8e-0cc1-4c2c-bee6-8b6ab0cb5b76','CH_001','4b4db7d8-e18c-4c06-97b9-dc848caf68dd'),('b9e073d5-576d-4430-af9b-d37124eb21f0','BA_007','4dafcc19-0d95-4654-acb7-d8897a88c7b8'),('c07f02be-328f-4322-b7d5-1f9e92ec3496','CH_001','71a9636b-f495-4b69-acdf-11e9255364f7'),('d8f7e8b9-fe91-4885-9e2a-291a8c1ce571','3D_005','2d7670d0-9ecb-4e0c-9a1e-6cf27bf349f8');
/*!40000 ALTER TABLE `csPosts_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `department_tb`
--

DROP TABLE IF EXISTS `department_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `department_tb` (
  `departmentID` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `departmentName` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `schoolID` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `departmentHeadID` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`departmentID`),
  KEY `schoolID` (`schoolID`),
  KEY `departmentHeadID` (`departmentHeadID`),
  CONSTRAINT `department_tb_ibfk_109` FOREIGN KEY (`schoolID`) REFERENCES `school_tb` (`schoolID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `department_tb_ibfk_110` FOREIGN KEY (`departmentHeadID`) REFERENCES `user_tb` (`userID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
  `eventID` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `title` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  `location` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `expireyDate` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `time` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `targetGroup` enum('all','lecturers','students') COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fileUrl` text COLLATE utf8mb4_general_ci,
  `createdBy` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `createdAt` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`eventID`),
  KEY `createdBy` (`createdBy`),
  CONSTRAINT `events_tb_ibfk_1` FOREIGN KEY (`createdBy`) REFERENCES `user_tb` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events_tb`
--

LOCK TABLES `events_tb` WRITE;
/*!40000 ALTER TABLE `events_tb` DISABLE KEYS */;
INSERT INTO `events_tb` VALUES ('0ccc9aa3-1ec3-4375-aa91-79bd99e6b8a9','no','yesyes','d32','2025-09-26',NULL,'03:40',NULL,'https://res.cloudinary.com/dkc2oujm6/image/upload/v1757846432/events/33.jpg','SCCI/0624/2021','2025-09-14 13:40:31'),('0d4fb9a3-71bb-47d6-9926-c0d9c0088201','title','description','j23','2025-09-19',NULL,'05:52',NULL,'https://res.cloudinary.com/dkc2oujm6/image/upload/v1757837803/events/34.jpg','SCCI/00627/2021','2025-09-15 09:53:14'),('0defa30e-6c15-4c7a-b125-71bbc871e560','ME','YES','23','2025-09-17',NULL,'17:20',NULL,'https://res.cloudinary.com/dkc2oujm6/image/upload/v1757846432/events/33.jpg','SCCI/0625/2021','2025-09-15 09:06:58'),('143ce80e-b152-470e-8a55-60bf4e35231b','Its Spoken 2025 Edition','Are  you good at rizzing or fantastic at mirista here then we g a good combo for a classic dual ... Spoken word event is here for to outshine and make the ladies go wwoooo ','lecture theater','2025-09-19',NULL,'06:20',NULL,'https://res.cloudinary.com/dkc2oujm6/image/upload/v1757837803/events/34.jpg','SCCI/0624/2021','2025-09-14 12:05:15'),('1ad709dd-2fad-4467-a4ec-e235a3118ccd','waguan','managaliz','546','2025-09-16',NULL,'04:25',NULL,'https://res.cloudinary.com/dkc2oujm6/image/upload/v1757837803/events/34.jpg','SCCI/0624/2021','2025-09-14 13:58:30'),('1de17a6a-9edb-42ff-b998-e349d0c9b4a1','yesno','yesno','d14','2025-09-19',NULL,'03:20',NULL,'https://res.cloudinary.com/dkc2oujm6/image/upload/v1757837803/events/34.jpg','SCCI/0624/2021','2025-09-14 12:58:38'),('37962665-e3b0-4b74-881a-3b215406a237','like wise','like thrise','d33','2025-09-26',NULL,'12:20',NULL,'https://res.cloudinary.com/dkc2oujm6/image/upload/v1757837803/events/34.jpg','SCCI/0624/2021','2025-09-14 13:17:23'),('420977f9-b5d3-43f1-b77b-6be5c6bc24ef','Faculty Research Grant Briefing 2025','A mandatory session for all academic staff on applying for internal and external research funding in 2025.','Lecture Theater','13-07-2025','11-08-2025','10:00 AM','lecturers','https://res.cloudinary.com/dkc2oujm6/image/upload/v1751527686/events/images.jpg','ACSI/006','2025-07-03 17:05:53'),('4933a8eb-0430-4d92-b0fa-ea02665a07ba','me','no','d23','2025-09-19',NULL,'17:20',NULL,'https://res.cloudinary.com/dkc2oujm6/image/upload/v1757837803/events/34.jpg','SCCI/0624/2021','2025-09-14 12:27:42'),('4b585832-dc93-4b07-8884-e2a6a77f62b3','yes','yes','d13','2025-09-20',NULL,'04:30',NULL,'https://res.cloudinary.com/dkc2oujm6/image/upload/v1757837803/events/34.jpg','SCCI/0624/2021','2025-09-14 12:41:13'),('4b862c52-c8b0-48bf-b93f-0925afa53df1','yesno','yesno','d14','2025-09-19',NULL,'03:20',NULL,'https://res.cloudinary.com/dkc2oujm6/image/upload/v1757837803/events/34.jpg','SCCI/0624/2021','2025-09-14 12:58:25'),('519893f8-d5fc-4e64-b7c9-f4a1460429e8','waguan','managaliz','546','2025-09-16',NULL,'04:25',NULL,'https://res.cloudinary.com/dkc2oujm6/image/upload/v1757837803/events/34.jpg','SCCI/0624/2021','2025-09-14 13:57:50'),('82d24ac6-bf0d-44b0-b1dd-30eda7384b2c','titl','description','loc34','2025-09-19',NULL,'08:49',NULL,'https://res.cloudinary.com/dkc2oujm6/image/upload/v1757837803/events/34.jpg','SCCI/0624/2021','2025-09-14 13:49:47'),('8520f0c6-d2da-4cf1-98da-3889e85e7ee7','Freshers Night','a wounderfull experience','graduation square','2025-09-24',NULL,'10:28',NULL,'https://res.cloudinary.com/dkc2oujm6/image/upload/v1757837803/events/34.jpg','SCCI/00678/2021','2025-09-15 14:30:17'),('967aad82-7ba6-4ccc-881a-e8d24ad92662','mutumba sales ','merchendize will be sold ','main hall','2025-08-23',NULL,'11:31',NULL,'https://res.cloudinary.com/dkc2oujm6/image/upload/v1755070419/events/35.jpg','SCCI/0624/2021','2025-08-13 10:33:35'),('b558967c-a40f-4b5a-af14-a18d69f48c6c','Its Spoken 2025 Edition','Are  you good at rizzing or fantastic at mirista here then we g a good combo for a classic dual ... Spoken word event is here for to outshine and make the ladies go wwoooo ','lecture theater','2025-09-19',NULL,'06:20',NULL,'https://res.cloudinary.com/dkc2oujm6/image/upload/v1757837803/events/34.jpg','SCCI/0624/2021','2025-09-14 11:32:28'),('bccff8a3-29c4-47ad-a968-e97b348ba506','me','yes','j32','2025-09-17',NULL,'06:25',NULL,'https://res.cloudinary.com/dkc2oujm6/image/upload/v1757846432/events/33.jpg','SCCI/0625/2021','2025-09-15 08:50:39'),('c263dfbf-caf2-4221-899e-355b4a3e3d51','Cultural  Week 2025 Edition','A mandatory session for all academic staff on applying for internal and external research funding in 2025.',' Block L','11-07-2025','11-08-2025','9:00 AM','all','https://res.cloudinary.com/dkc2oujm6/image/upload/v1754462603/events/drama_banner.jpg','SCCI/0624/2021','2025-08-06 09:43:14'),('c3669e6d-6ea5-493d-8543-a6fd9aa58a4c','ttttttthyhyhjuh','nonono','d32','2025-09-19',NULL,'17:30',NULL,'https://res.cloudinary.com/dkc2oujm6/image/upload/v1757837803/events/34.jpg','SCCI/00627/2021','2025-09-15 10:35:41'),('c53ba76e-051a-4a79-a5b4-35d378d11a0c','me','no','d23','2025-09-19',NULL,'17:20',NULL,'https://res.cloudinary.com/dkc2oujm6/image/upload/v1757837803/events/34.jpg','SCCI/0624/2021','2025-09-14 12:26:58'),('c5bbeabf-4c22-4660-befa-7ec4a5a31f5c','home coming party','you are all welcome to my home','Nairobi west','2025-08-23',NULL,'11:57',NULL,'https://res.cloudinary.com/dkc2oujm6/image/upload/v1755075525/events/33.jpg','SCCI/0624/2021','2025-08-13 11:58:50'),('c7b1be47-736f-4901-a8fe-5aec6ee79969','no','yesyes','d32','2025-09-26',NULL,'03:40',NULL,'https://res.cloudinary.com/dkc2oujm6/image/upload/v1757846432/events/33.jpg','SCCI/0624/2021','2025-09-14 13:40:53'),('cf3f0992-b5a8-4ba6-b8a9-53c225ec584e','freshers night party','come all and welcome the freshmen to campus  the night is going to be lit ....waguan managaliz and waguan manaboliz  ...rully unruly boboclat','graduation square','2025-09-12',NULL,'06:00',NULL,'https://res.cloudinary.com/dkc2oujm6/image/upload/v1757837803/events/34.jpg','SCCI/0624/2021','2025-09-14 11:16:43'),('d0171b43-1c03-47d0-9f53-5f1470883b43','home coming party','you are all welcome to my home','Nairobi west','2025-08-23',NULL,'11:57',NULL,'https://res.cloudinary.com/dkc2oujm6/image/upload/v1755075525/events/33.jpg','SCCI/0624/2021','2025-08-13 11:58:43'),('dad1fc19-6974-464f-b9b7-14b7b935194c','yes','no no','d32','2025-09-27',NULL,'04:25',NULL,'https://res.cloudinary.com/dkc2oujm6/image/upload/v1757837803/events/34.jpg','SCCI/0625/2021','2025-09-15 05:37:27'),('e18cb89e-09c2-44ba-b855-b001c928c59b','cultural Week 2025 Opening Ceremony','Join us for the official launch of cultural Week 2025 featuring keynote speeches, demos, and innovation exhibitions.','Conference Hall,  Block L','31-07-2025','31-08-2025','10:00 AM','all','https://res.cloudinary.com/dkc2oujm6/image/upload/v1751528750/events/cultural.jpg','ACSI/006','2025-07-03 10:45:49');
/*!40000 ALTER TABLE `events_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `faculty_tb`
--

DROP TABLE IF EXISTS `faculty_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `faculty_tb` (
  `facultyID` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `facultyName` varchar(50) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `deanID` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`facultyID`),
  KEY `deanID` (`deanID`),
  CONSTRAINT `faculty_tb_ibfk_1` FOREIGN KEY (`deanID`) REFERENCES `user_tb` (`userID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
  `lecturerID` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `departmentID` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`lecturerID`),
  KEY `departmentID` (`departmentID`),
  CONSTRAINT `lecturers_tb_ibfk_1` FOREIGN KEY (`lecturerID`) REFERENCES `user_tb` (`userID`) ON UPDATE CASCADE,
  CONSTRAINT `lecturers_tb_ibfk_2` FOREIGN KEY (`departmentID`) REFERENCES `department_tb` (`departmentID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lecturers_tb`
--

LOCK TABLES `lecturers_tb` WRITE;
/*!40000 ALTER TABLE `lecturers_tb` DISABLE KEYS */;
INSERT INTO `lecturers_tb` VALUES ('ACSI/002','DCCN_002'),('ACSI/001','DCSI_001'),('ACSI/003','DCSI_001'),('ACSI/005','DCSI_001'),('ACSI/006','DCSI_001'),('ACSI/007','DCSI_001'),('ACSI/014','DCSI_001'),('ACSI/016','DCSI_001');
/*!40000 ALTER TABLE `lecturers_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `likes_tb`
--

DROP TABLE IF EXISTS `likes_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `likes_tb` (
  `likeID` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `postID` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `userID` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`likeID`),
  KEY `postID` (`postID`),
  KEY `userID` (`userID`),
  CONSTRAINT `likes_tb_ibfk_37` FOREIGN KEY (`postID`) REFERENCES `posts_tb` (`postID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `likes_tb_ibfk_38` FOREIGN KEY (`userID`) REFERENCES `user_tb` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
  `postID` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `imageURL` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `date` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `userID` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`postID`),
  KEY `userID` (`userID`),
  CONSTRAINT `posts_tb_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user_tb` (`userID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts_tb`
--

LOCK TABLES `posts_tb` WRITE;
/*!40000 ALTER TABLE `posts_tb` DISABLE KEYS */;
INSERT INTO `posts_tb` VALUES ('27f14f4a-1faa-41e5-b45b-3946fcb50068','waguan  managaliz... waya say mia do','https://res.cloudinary.com/dkc2oujm6/image/upload/v1754605751/posts/33.jpg','2025-08-07 22:29:04','SCCI/0624/2021'),('2d7670d0-9ecb-4e0c-9a1e-6cf27bf349f8','hey guys..kindly check on my 3D designs and make comments on improvment..your suggestions is my devotion ','https://res.cloudinary.com/dkc2oujm6/image/upload/v1754596808/posts/35.jpg','2025-08-07 20:00:05','SCCI/0624/2021'),('4b4db7d8-e18c-4c06-97b9-dc848caf68dd','hey guys next week will be holding a chess tournament  .kindly lets prepare,great things are comming','https://res.cloudinary.com/dkc2oujm6/image/upload/v1751460248/posts/Document.jpg','2025-08-07 20:03:27','SCCI/0624/2021'),('4dafcc19-0d95-4654-acb7-d8897a88c7b8','hey guys what are we expecting for the season','https://res.cloudinary.com/dkc2oujm6/image/upload/v1754829851/posts/34.jpg','2025-08-10 12:44:08','SCCI/0624/2021'),('71a9636b-f495-4b69-acdf-11e9255364f7','hey guys what is  going on today','https://res.cloudinary.com/dkc2oujm6/image/upload/v1757936233/posts/34.jpg','2025-09-15 11:37:10','SCCI/00678/2021'),('76b50731-c883-4527-b73c-c9b34f0601cf','what about another round of trophies collections to our club','https://res.cloudinary.com/dkc2oujm6/image/upload/v1751460996/posts/download1.jpg','2025-07-02 15:57:52','SCCI/0624/2021'),('898058a9-65c3-461d-8951-4192efd94514','hey guys am new here kindly help me on this journey','https://res.cloudinary.com/dkc2oujm6/image/upload/v1754596808/posts/35.jpg','2025-08-13 09:01:47','SCCI/0624/2021'),('a5d32ec5-5881-4114-96c8-6043f4ab1dac','hey guys next week will be holding a chess tournament  .kindly lets prepare,great things are comming','https://res.cloudinary.com/dkc2oujm6/image/upload/v1751460248/posts/Document.jpg','2025-07-02 15:44:06','SCNI/01290/2021'),('d40adfd3-9120-4f6c-89dc-ea710b33f8a6','hey guys what are we expecting for the season','https://res.cloudinary.com/dkc2oujm6/image/upload/v1754829851/posts/34.jpg','2025-08-10 12:44:09','SCCI/0624/2021'),('ff0b2f1a-f436-428c-8dbe-0cb07f3e6b5d','hey guys..kindly check on my 3D designs and make comments on improvment..your suggestions is my devotion ','https://res.cloudinary.com/dkc2oujm6/image/upload/v1754596808/posts/35.jpg','2025-08-07 20:08:26','SCCI/0624/2021');
/*!40000 ALTER TABLE `posts_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `scheduleCourse_tb`
--

DROP TABLE IF EXISTS `scheduleCourse_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scheduleCourse_tb` (
  `scheduleCourseID` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `courseID` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `scheduleID` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`scheduleCourseID`),
  UNIQUE KEY `scheduleCourse_tb_courseID_scheduleID_unique` (`courseID`,`scheduleID`),
  KEY `scheduleID` (`scheduleID`),
  CONSTRAINT `scheduleCourse_tb_ibfk_67` FOREIGN KEY (`courseID`) REFERENCES `course_tb` (`courseID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `scheduleCourse_tb_ibfk_68` FOREIGN KEY (`scheduleID`) REFERENCES `schedule_tb` (`scheduleID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `scheduleCourse_tb`
--

LOCK TABLES `scheduleCourse_tb` WRITE;
/*!40000 ALTER TABLE `scheduleCourse_tb` DISABLE KEYS */;
INSERT INTO `scheduleCourse_tb` VALUES ('4eda52f9-e2e9-4a17-8bab-520f13ed94e2','SCCI_01','0d11cc64-354f-4d59-8c76-397c22f56900'),('5cb6e623-7918-48e8-9478-c674b1234d1a','SCCI_01','16885ced-e82f-4e71-898c-d358302019e7'),('718b5dc0-f93f-4cb3-a3c3-350a9d15ea88','SCCI_01','1d3a8b9d-9a9c-4b6b-b591-67fa7321a295'),('0d1cd9b9-cf20-4658-ac4e-90dec75bf266','SCCI_01','21bfb53c-88f9-4a6c-987e-b1e7e0de0b79'),('e030add7-d473-4220-b17c-d7b8c0b034a0','SCCI_01','4be1f925-d30e-4ac0-bb98-2407bd8ecf73'),('4432af52-3440-499d-a559-3822b48789f1','SCCI_01','51073cd6-1067-440b-87e7-ac9d29505c91'),('77a42b23-a0ba-4989-8064-71510a094285','SCCI_01','5e70cddc-bf5a-4e5c-9697-11888eec5b9c'),('b1721240-88a7-4f7f-a4fc-e96fcf21ab81','SCCI_01','5e837982-7003-4adf-8ef3-5db5c14d37af'),('81b1860c-f8a1-4d2a-ad2d-935b37e2b028','SCCI_01','68829d51-45d1-4a7c-a67b-d54cf3c9fdb4'),('174afdc0-5aed-42ec-9399-d1f003740563','SCCI_01','6ce55cb3-949c-409c-9386-2ed45cef60a5'),('a77536fc-4ebb-4435-a1a1-42952551c8af','SCCI_01','7962432b-3945-401e-abe6-45efa39d5834'),('b6265158-f73d-449e-aedc-a63c90c21619','SCCI_01','79edf02e-fe25-420a-8a13-3273b9131b60'),('70a1f744-7cd1-4b8d-ac0f-9efbcda7f705','SCCI_01','7dddf5ee-5dbf-4e92-a637-425393b93225'),('abe7d3a7-9453-44ce-a86b-a6de6945e704','SCCI_01','84830b56-bc0c-422a-83ef-a017a0b029d1'),('2f88010f-7e4e-404f-891f-7643c5afb1fa','SCCI_01','85a2100b-0d3d-4013-8151-c940e5564ed9'),('414027fc-8ef6-4e81-a79f-db971c90d30c','SCCI_01','8de63269-e7a7-44ac-aa07-193d891cdfe1'),('805e6906-fb3a-4aff-b664-9c85a4062c37','SCCI_01','9a967819-65fc-45a2-a736-0209aafe3258'),('7666d6d8-758b-4966-a4a0-659270b41b04','SCCI_01','9dd73677-2830-421a-9073-a94b83c90f8a'),('457a06fe-1688-43f4-9c0b-d60d5bf1af08','SCCI_01','a445dfd3-50a6-4694-8841-396f575ee409'),('cc32e801-7f21-4a2b-9452-c11d00d22379','SCCI_01','b51042f8-64dd-474e-9461-f0c31a80e143'),('2c7bf83a-0981-4693-bf26-d4894be45fe4','SCCI_01','bc413847-0a7f-45f3-a293-f0d6e5e204e5'),('fe8ff5e7-3be1-46e3-9fa2-367bae6f6c4a','SCCI_01','d3dbe7c8-06fe-4497-8395-a7acf8d63f86'),('df48e38a-f944-408d-aa15-e54c603f642e','SCCI_01','d8930065-504a-452d-98ab-97ee12e11594'),('91f94009-5ffa-4a0e-a322-28c84baa686e','SCCI_01','e3a38622-dab5-47cf-a1cb-ca7443500eaa'),('567374a5-fc3e-4f12-8e0a-734d6e91ada3','SCII_002','2ac9148a-9ea6-4428-8843-58b395090ff3'),('afac73d6-85bd-421c-a351-cd188e802829','SCII_002','2f3ed488-da30-4399-9040-7229aa1e167e'),('5a4bd58d-8bbe-419b-9eb1-6540be7502b1','SCII_002','37c80ef6-2310-4dad-85bd-7e8981ae23e3'),('d3ea067f-0463-48ea-a8c6-6f8c3f3433b2','SCII_002','42eaf07b-f817-489e-a27d-0b56f3551fa0'),('7b104c66-e7aa-4d2c-bdc6-02fdd14ad463','SCII_002','58c68ff9-d589-4f1d-8d3b-83c08667f576'),('ae03cbb8-6d83-4ed5-a605-9be0ff2cdd07','SCII_002','5b75cf4c-610e-43ef-a0b1-3903bbf88faa'),('88a54d1c-897a-4975-998d-44d1738eb509','SCII_002','5bafe5b0-13b5-49b2-8d05-887380cfabff'),('4dfbe7cd-8f56-42d4-b232-b62cfed1897d','SCII_002','6903cce1-afd8-4ab3-8fd5-d4ff0dcf7b0c'),('95bac541-4212-40d9-9bb5-7d98dbae13ce','SCII_002','88aa7ce9-0f6d-4883-9264-4b0d803eb463'),('d807b017-49b6-44bc-9288-24f8f606066f','SCII_002','8f6cdb6d-7e0d-42bc-ad4c-9593d6b9abd8'),('f6420922-621a-4512-93d7-fead8091b3d9','SCII_002','a075cb80-02b2-447f-9bc3-129a37d5654c'),('935998ca-23d6-496d-9a49-2e53794dd357','SCII_002','a70d8dcc-0b85-48c8-af30-21ca5a2b36aa'),('813c1d8d-b99e-44be-b5a3-06719308e6a1','SCII_002','aa00bd59-835d-4845-a2cb-84e3d997f3f7'),('5835cfee-621e-4c1a-a77b-d02ce9fbed50','SCII_002','ae8a41a6-1f9a-4ecb-adcd-8d74876a9632'),('545dd1dc-96d9-418a-a560-5e97156e21c4','SCII_002','bf7a19d5-c57b-4105-bde3-9b408ccb89ec'),('e70fb9e7-5375-4e60-8469-f2c5de3fc03e','SCII_002','c193f5af-88ac-438d-ae95-879d642a96c3'),('60715dea-462e-4654-92a7-5034e81b8387','SCII_002','d17b6ba5-208a-42fe-8fd4-303fedb9d42f'),('6fb4926c-146b-4936-a9ae-afd43f80a17c','SCII_002','d5f7d2b7-c70c-484e-9107-04b803b96a9e'),('710580a5-0830-4c4d-9f83-ac5068feac40','SCII_002','d90f5e39-3486-49ba-872e-9cfcfc1dcb9f'),('93d51fec-5b36-42e6-b6e8-be00645f41c9','SCII_002','e850e84f-4ed6-430a-a77a-87770bf23573'),('6b85e775-3bd9-44e7-968a-8331f52974f9','SCII_002','f8fe3730-8e6b-405d-b812-1997bd02bb7f'),('e50abb8c-e402-4337-9818-50f5ac478290','SCNI_03','0d11cc64-354f-4d59-8c76-397c22f56900'),('e953fcbc-4cd9-4429-a0cb-a383421888d4','SCNI_03','16885ced-e82f-4e71-898c-d358302019e7'),('5f0ba460-b973-461f-abf9-11142d3c6e2d','SCNI_03','1d3a8b9d-9a9c-4b6b-b591-67fa7321a295'),('92cd4863-01ac-4c2c-9ebe-407231d65d70','SCNI_03','21bfb53c-88f9-4a6c-987e-b1e7e0de0b79'),('572916bf-e961-4b14-8e3f-a6e70e8db990','SCNI_03','4be1f925-d30e-4ac0-bb98-2407bd8ecf73'),('f7f531f8-93f4-4123-87e6-2ec5bfec3f3c','SCNI_03','51073cd6-1067-440b-87e7-ac9d29505c91'),('030220c7-aa0c-44a7-b4f0-acf09ce7477a','SCNI_03','5e70cddc-bf5a-4e5c-9697-11888eec5b9c'),('d0329200-e8a6-47b2-8ef3-1cec34d6f3ed','SCNI_03','5e837982-7003-4adf-8ef3-5db5c14d37af'),('f0e54710-38f9-4ea8-88e2-f050cba02d0c','SCNI_03','68829d51-45d1-4a7c-a67b-d54cf3c9fdb4'),('f9c32779-37be-4e2c-b711-805179a41c50','SCNI_03','6ce55cb3-949c-409c-9386-2ed45cef60a5'),('1ed9f7cd-cf8d-4edb-bf69-9a48a0d94ce1','SCNI_03','7962432b-3945-401e-abe6-45efa39d5834'),('39944045-5291-41e2-aed8-7f95868d8485','SCNI_03','79edf02e-fe25-420a-8a13-3273b9131b60'),('0fe596c2-a668-48e8-9949-59b3c5f0a515','SCNI_03','7dddf5ee-5dbf-4e92-a637-425393b93225'),('6403ec36-f7cf-44a0-a87b-e24548a9f7da','SCNI_03','84830b56-bc0c-422a-83ef-a017a0b029d1'),('774c2489-0f75-4de0-b508-a07ccfefb684','SCNI_03','85a2100b-0d3d-4013-8151-c940e5564ed9'),('7cd1cfeb-ee3d-4e43-a763-7a10a62a6158','SCNI_03','8de63269-e7a7-44ac-aa07-193d891cdfe1'),('542f7010-84be-4589-9edb-4fb4940b96bb','SCNI_03','9a967819-65fc-45a2-a736-0209aafe3258'),('4800d9c3-056f-490c-acf9-bf4384a51e86','SCNI_03','9dd73677-2830-421a-9073-a94b83c90f8a'),('ec410d84-681d-4e97-9425-09691e958aec','SCNI_03','a445dfd3-50a6-4694-8841-396f575ee409'),('eeaa6d54-803d-4825-be75-5f71c2856b6b','SCNI_03','b51042f8-64dd-474e-9461-f0c31a80e143'),('d747fe53-9c6a-4266-b80f-d49d28cd0c89','SCNI_03','bc413847-0a7f-45f3-a293-f0d6e5e204e5'),('86464fc7-d0f8-4d10-b13a-a3f98ebe66d8','SCNI_03','d3dbe7c8-06fe-4497-8395-a7acf8d63f86'),('af0fd34f-1158-44fd-a0a5-87db90e391e4','SCNI_03','d8930065-504a-452d-98ab-97ee12e11594'),('f2adc7cb-d1b8-4b15-bb42-84834c12b1fa','SCNI_03','e3a38622-dab5-47cf-a1cb-ca7443500eaa');
/*!40000 ALTER TABLE `scheduleCourse_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `schedule_tb`
--

DROP TABLE IF EXISTS `schedule_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schedule_tb` (
  `scheduleID` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `unitOfferingID` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `day` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `startTime` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `endTime` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `mode` varchar(10) COLLATE utf8mb4_general_ci DEFAULT 'online',
  PRIMARY KEY (`scheduleID`),
  KEY `unitOfferingID` (`unitOfferingID`),
  CONSTRAINT `schedule_tb_ibfk_1` FOREIGN KEY (`unitOfferingID`) REFERENCES `unitOffering_tb` (`unitOfferingID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `schedule_tb`
--

LOCK TABLES `schedule_tb` WRITE;
/*!40000 ALTER TABLE `schedule_tb` DISABLE KEYS */;
INSERT INTO `schedule_tb` VALUES ('0d11cc64-354f-4d59-8c76-397c22f56900','fe9dfc6f-ca3e-4f6b-8cfb-019cb6127efb','monday','9:00','11:00','room D2'),('16885ced-e82f-4e71-898c-d358302019e7','947d9b31-5398-4db6-bfab-2e612ab1773e','Tuesday','11:00','13:00','Online'),('1d3a8b9d-9a9c-4b6b-b591-67fa7321a295','29f67d82-16c8-4cce-b82e-35b9974defcc','monday','07:00','09:00','Online'),('21bfb53c-88f9-4a6c-987e-b1e7e0de0b79','2146e11d-a71b-4a89-93fb-01df6f105990','friday','07:00','09:00','online'),('2ac9148a-9ea6-4428-8843-58b395090ff3','f89cd540-7740-47ac-81f6-2e772f3bae46','Monday','14:00','16:00','Online'),('2f3ed488-da30-4399-9040-7229aa1e167e','fe9dfc6f-ca3e-4f6b-8cfb-019cb6127efb','friday','11:00','13:00','online'),('37c80ef6-2310-4dad-85bd-7e8981ae23e3','2f7b8057-8857-43a8-a868-afdd3ab54387','Tuesday','07:00','09:00','online'),('42eaf07b-f817-489e-a27d-0b56f3551fa0','2146e11d-a71b-4a89-93fb-01df6f105990','friday','14:00','16:00','online'),('4be1f925-d30e-4ac0-bb98-2407bd8ecf73','fe9dfc6f-ca3e-4f6b-8cfb-019cb6127efb','monday','07:00','09:00','Online'),('51073cd6-1067-440b-87e7-ac9d29505c91','2146e11d-a71b-4a89-93fb-01df6f105990','wednesday','09:00','11:00','online'),('58c68ff9-d589-4f1d-8d3b-83c08667f576','2c1f315d-7b20-41b1-8245-61719ea85f6f','tuesday','16:00','18:00','online'),('5b75cf4c-610e-43ef-a0b1-3903bbf88faa','fe9dfc6f-ca3e-4f6b-8cfb-019cb6127efb','tuesday','16:00','18:00','online'),('5bafe5b0-13b5-49b2-8d05-887380cfabff','2146e11d-a71b-4a89-93fb-01df6f105990','friday','14:00','16:00','online'),('5e70cddc-bf5a-4e5c-9697-11888eec5b9c','2146e11d-a71b-4a89-93fb-01df6f105990','friday','07:00','09:00','online'),('5e837982-7003-4adf-8ef3-5db5c14d37af','fe9dfc6f-ca3e-4f6b-8cfb-019cb6127efb','friday','14:00','16:00','Online'),('68829d51-45d1-4a7c-a67b-d54cf3c9fdb4','2146e11d-a71b-4a89-93fb-01df6f105990','wednesday','09:00','11:00','online'),('6903cce1-afd8-4ab3-8fd5-d4ff0dcf7b0c','e22b7fe1-6dce-4792-9354-f47ec02f4934','Tuesday','07:00','09:00','online'),('6ce55cb3-949c-409c-9386-2ed45cef60a5','2f7b8057-8857-43a8-a868-afdd3ab54387','wednesday','07:00','09:00','room D2'),('7962432b-3945-401e-abe6-45efa39d5834','f89cd540-7740-47ac-81f6-2e772f3bae46','wednesday','16:00','18:00','room D2'),('79edf02e-fe25-420a-8a13-3273b9131b60','947d9b31-5398-4db6-bfab-2e612ab1773e','wednesday','16:00','18:00','room D2'),('7dddf5ee-5dbf-4e92-a637-425393b93225','29f67d82-16c8-4cce-b82e-35b9974defcc','monday','9:00','11:00','room D2'),('84830b56-bc0c-422a-83ef-a017a0b029d1','2c1f315d-7b20-41b1-8245-61719ea85f6f','monday','9:00','11:00','room D2'),('85a2100b-0d3d-4013-8151-c940e5564ed9','e22b7fe1-6dce-4792-9354-f47ec02f4934','thursday','14:00','16:00','room D2'),('88aa7ce9-0f6d-4883-9264-4b0d803eb463','29f67d82-16c8-4cce-b82e-35b9974defcc','tuesday','14:00','16:00','Online'),('8de63269-e7a7-44ac-aa07-193d891cdfe1','ec840b82-ef04-4cac-b153-066db4d21da4','Tuesday','11:00','13:00','Online'),('8f6cdb6d-7e0d-42bc-ad4c-9593d6b9abd8','fe9dfc6f-ca3e-4f6b-8cfb-019cb6127efb','tuesday','14:00','16:00','Online'),('9a967819-65fc-45a2-a736-0209aafe3258','ec840b82-ef04-4cac-b153-066db4d21da4','wednesday','16:00','18:00','room D2'),('9dd73677-2830-421a-9073-a94b83c90f8a','2f7b8057-8857-43a8-a868-afdd3ab54387','Monday','16:00','18:00','online'),('a075cb80-02b2-447f-9bc3-129a37d5654c','29f67d82-16c8-4cce-b82e-35b9974defcc','tuesday','16:00','18:00','online'),('a445dfd3-50a6-4694-8841-396f575ee409','fe9dfc6f-ca3e-4f6b-8cfb-019cb6127efb','thursday','11:00','13:00','room D2'),('a70d8dcc-0b85-48c8-af30-21ca5a2b36aa','ec840b82-ef04-4cac-b153-066db4d21da4','Monday','14:00','16:00','Online'),('aa00bd59-835d-4845-a2cb-84e3d997f3f7','2f7b8057-8857-43a8-a868-afdd3ab54387','wednesday','07:00','9:00','Online'),('ae8a41a6-1f9a-4ecb-adcd-8d74876a9632','2c1f315d-7b20-41b1-8245-61719ea85f6f','tuesday','14:00','16:00','Online'),('b51042f8-64dd-474e-9461-f0c31a80e143','f89cd540-7740-47ac-81f6-2e772f3bae46','Tuesday','11:00','13:00','Online'),('bc413847-0a7f-45f3-a293-f0d6e5e204e5','e22b7fe1-6dce-4792-9354-f47ec02f4934','friday','16:00','18:00','Online'),('bf7a19d5-c57b-4105-bde3-9b408ccb89ec','fe9dfc6f-ca3e-4f6b-8cfb-019cb6127efb','wednesday','11:00','13:00','Online'),('c193f5af-88ac-438d-ae95-879d642a96c3','947d9b31-5398-4db6-bfab-2e612ab1773e','Tuesday','14:00','16:00','online'),('d17b6ba5-208a-42fe-8fd4-303fedb9d42f','947d9b31-5398-4db6-bfab-2e612ab1773e','Monday','14:00','16:00','Online'),('d3dbe7c8-06fe-4497-8395-a7acf8d63f86','2c1f315d-7b20-41b1-8245-61719ea85f6f','monday','07:00','09:00','Online'),('d5f7d2b7-c70c-484e-9107-04b803b96a9e','ec840b82-ef04-4cac-b153-066db4d21da4','Tuesday','14:00','16:00','online'),('d8930065-504a-452d-98ab-97ee12e11594','2f7b8057-8857-43a8-a868-afdd3ab54387','Tuesday','14:00','16:00','Online'),('d90f5e39-3486-49ba-872e-9cfcfc1dcb9f','f89cd540-7740-47ac-81f6-2e772f3bae46','Tuesday','14:00','16:00','online'),('e3a38622-dab5-47cf-a1cb-ca7443500eaa','2f7b8057-8857-43a8-a868-afdd3ab54387','Wednesday','11:00','13:00','online'),('e850e84f-4ed6-430a-a77a-87770bf23573','e22b7fe1-6dce-4792-9354-f47ec02f4934','wednesday','09:00','11:00','Online'),('f8fe3730-8e6b-405d-b812-1997bd02bb7f','2146e11d-a71b-4a89-93fb-01df6f105990','wednesday','11:00','13:00','online');
/*!40000 ALTER TABLE `schedule_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `school_tb`
--

DROP TABLE IF EXISTS `school_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `school_tb` (
  `schoolID` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `schoolName` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `facultyID` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `schoolHeadID` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  ` facultyID` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`schoolID`),
  KEY `facultyID` (`facultyID`),
  KEY `schoolHeadID` (`schoolHeadID`),
  KEY ` facultyID` (` facultyID`),
  CONSTRAINT `school_tb_ibfk_57` FOREIGN KEY (`facultyID`) REFERENCES `faculty_tb` (`facultyID`) ON UPDATE CASCADE,
  CONSTRAINT `school_tb_ibfk_58` FOREIGN KEY (`schoolHeadID`) REFERENCES `user_tb` (`userID`) ON UPDATE CASCADE,
  CONSTRAINT `school_tb_ibfk_59` FOREIGN KEY (` facultyID`) REFERENCES `faculty_tb` (`facultyID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
  `studentID` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `courseID` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `classID` varchar(30) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`studentID`),
  KEY `courseID` (`courseID`),
  KEY `classID` (`classID`),
  CONSTRAINT `students_tb_ibfk_123` FOREIGN KEY (`courseID`) REFERENCES `course_tb` (`courseID`) ON UPDATE CASCADE,
  CONSTRAINT `students_tb_ibfk_124` FOREIGN KEY (`classID`) REFERENCES `class_tb` (`classID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students_tb`
--

LOCK TABLES `students_tb` WRITE;
/*!40000 ALTER TABLE `students_tb` DISABLE KEYS */;
INSERT INTO `students_tb` VALUES ('SCCI/00573/2020','SCCI_01','SCCI/2021'),('SCCI/00574/2021','SCCI_01','SCCI/2021'),('SCCI/00594/2021','SCCI_01','SCCI/2021'),('SCCI/00604/2021','SCCI_01','SCCI/2021'),('SCCI/00605/2021','SCCI_01','SCCI/2021'),('SCCi/00624/2021','SCCI_01','SCCI/2021'),('SCCI/00627/2021','SCCI_01','SCCI/2021'),('SCCI/00678/2021','SCCI_01','SCCI/2021'),('SCCI/03853P/2021','SCCI_01','SCCI/2021'),('SCCI/0624/2021','SCCI_01','SCCI/2021'),('SCCI/0625/2021','SCCI_01','SCCI/2021'),('SCCI/06262021','SCCI_01','SCCI/2021'),('SCII/00659/2021','SCII_002','SCII/2021'),('SCII/01060/2021','SCII_002','SCII/2021'),('SCNI/01290/2021','SCNI_03','SCNI/2021'),('SCNI/01298/2021','SCNI_03','SCNI/2021');
/*!40000 ALTER TABLE `students_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unitContent_tb`
--

DROP TABLE IF EXISTS `unitContent_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unitContent_tb` (
  `contentID` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `unitID` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `courseOutline` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `uploadedBy` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `uploadDate` datetime DEFAULT NULL,
  `description` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`contentID`),
  KEY `unitID` (`unitID`),
  KEY `uploadedBy` (`uploadedBy`),
  CONSTRAINT `unitContent_tb_ibfk_7` FOREIGN KEY (`unitID`) REFERENCES `units_tb` (`unitID`) ON UPDATE CASCADE,
  CONSTRAINT `unitContent_tb_ibfk_8` FOREIGN KEY (`uploadedBy`) REFERENCES `user_tb` (`userID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unitContent_tb`
--

LOCK TABLES `unitContent_tb` WRITE;
/*!40000 ALTER TABLE `unitContent_tb` DISABLE KEYS */;
INSERT INTO `unitContent_tb` VALUES ('4d88f315-011d-41c4-ad2f-855cdd62ad8c','ECSI4206','https://res.cloudinary.com/dkc2oujm6/raw/upload/v1751125202/unit_pdfs/DECENTRALIZATION__DEPARTMENTATION.pdf','ACSI/014','2025-06-28 15:40:02',NULL),('8c2fc283-fc53-47eb-a06e-72080a210c2e','ECSI4203','https://res.cloudinary.com/dkc2oujm6/image/upload/v1754512623/files/FOUNDATION_.pdf','SCCI/0624/2021','2025-08-06 17:36:59','• To understand the basics of microprocessors and microcontrollers architectures and its functionalities. • To develop an in-depth understanding of the operation of microprocessors and microcontrollers, machine language programming & interfacing techniques. • To design and develop Microprocessor/ microcontroller based systems for real time applications using low level language like ALP. • To understand the concepts of ARM processor.'),('bce4f94a-da45-42ce-bf2a-bec9de7cc6d4','ECSI4206','https://res.cloudinary.com/dkc2oujm6/raw/upload/v1751122978/unit_pdfs/INFORMATION%20SYSTEMS%20INTRODUCTION.pptx','ACSI/014','2025-06-28 15:15:05',NULL);
/*!40000 ALTER TABLE `unitContent_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unitEnrollment_tb`
--

DROP TABLE IF EXISTS `unitEnrollment_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unitEnrollment_tb` (
  `unitEnrollmentID` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `studentID` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `unitOfferingID` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `enrollmentDate` int DEFAULT NULL,
  `status` enum('active','complited') COLLATE utf8mb4_general_ci DEFAULT 'active',
  PRIMARY KEY (`unitEnrollmentID`),
  UNIQUE KEY `unitEnrollment_tb_studentID_unitOfferingID_unique` (`studentID`,`unitOfferingID`),
  KEY `unitOfferingID` (`unitOfferingID`),
  CONSTRAINT `unitEnrollment_tb_ibfk_69` FOREIGN KEY (`studentID`) REFERENCES `students_tb` (`studentID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `unitEnrollment_tb_ibfk_70` FOREIGN KEY (`unitOfferingID`) REFERENCES `unitOffering_tb` (`unitOfferingID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
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
  `offeringContentID` varchar(40) COLLATE utf8mb4_general_ci NOT NULL,
  `unitOfferingID` varchar(40) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `videoUrl` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `link` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `contentType` enum('video','link','pdf','assignment','past_papers') COLLATE utf8mb4_general_ci DEFAULT NULL,
  `uploadedAt` datetime DEFAULT NULL,
  `PdfUrl` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `fileName` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`offeringContentID`),
  KEY `unitOfferingID` (`unitOfferingID`),
  CONSTRAINT `unitOfferingContent_tb_ibfk_1` FOREIGN KEY (`unitOfferingID`) REFERENCES `unitOffering_tb` (`unitOfferingID`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unitOfferingContent_tb`
--

LOCK TABLES `unitOfferingContent_tb` WRITE;
/*!40000 ALTER TABLE `unitOfferingContent_tb` DISABLE KEYS */;
INSERT INTO `unitOfferingContent_tb` VALUES ('00563077-0b04-42c7-9bee-e0394fa6fe1d','fe9dfc6f-ca3e-4f6b-8cfb-019cb6127efb',NULL,NULL,'pdf','2025-08-07 06:44:54','https://res.cloudinary.com/dkc2oujm6/raw/upload/v1754546279/files/topic_1-_AI_course_overview.pptx','lecture 1'),('0975d5f1-db50-447f-8729-c0ffefd86494','fe9dfc6f-ca3e-4f6b-8cfb-019cb6127efb',NULL,'https://conference.ke/vbGBOgW6n3soPdvasUULSuz905fP/','link','2025-08-07 06:55:21','','class link 2 join '),('0f386946-5ee5-4a17-ad63-4bd5a178e22e','2f7b8057-8857-43a8-a868-afdd3ab54387',NULL,'https://conference.ke/vbGBOgW6n3soPdvasUULSuz905fP/','link','2025-08-12 04:15:27','','google meet link'),('132a105d-de57-4800-8ea2-dc5295c685ff','fe9dfc6f-ca3e-4f6b-8cfb-019cb6127efb',NULL,NULL,'pdf','2025-08-07 06:46:53','https://res.cloudinary.com/dkc2oujm6/raw/upload/v1754546493/files/topic_4-Logic_and_truth_tables.pptx','lecture 4'),('158d36dc-7ff4-4328-bdc4-7e18ae81b8e2','fe9dfc6f-ca3e-4f6b-8cfb-019cb6127efb',NULL,'https://meet.google.com/ziz-fuzw-biq','link','2025-08-07 06:50:26','','lecture 4'),('1d5caa68-a156-4c65-b1e8-594d5825052d','2f7b8057-8857-43a8-a868-afdd3ab54387',NULL,NULL,'assignment','2025-08-12 04:18:34','https://res.cloudinary.com/dkc2oujm6/image/upload/v1754966027/files/Recomendation__insuarance_letter.pdf','assignment  2'),('3172efe9-fdf0-4332-b8e2-5f6df47314bc','fe9dfc6f-ca3e-4f6b-8cfb-019cb6127efb',NULL,'https://www.youtube.com/live/pAkLNsZI5Nc?si=BAXlLm6W3j78byap','link','2025-08-07 06:51:59','','lecture 5 recording'),('32e76091-d4d7-4356-9123-6dd9f838adf2','fe9dfc6f-ca3e-4f6b-8cfb-019cb6127efb',NULL,NULL,'past_papers','2025-08-07 06:24:07','https://res.cloudinary.com/dkc2oujm6/raw/upload/v1754557291/files/Health_Education_-_Nov_2011.pdf','2022 past paper'),('33024adc-a6c7-4683-877a-825e9684c629','fe9dfc6f-ca3e-4f6b-8cfb-019cb6127efb',NULL,NULL,'past_papers','2025-08-07 06:24:50','https://res.cloudinary.com/dkc2oujm6/raw/upload/v1754557208/files/Applied_Sciences_-_Communication_skills.pdf','2021 past paper'),('383edc82-cfa2-4903-a6ae-58fe191eeb39','fe9dfc6f-ca3e-4f6b-8cfb-019cb6127efb',NULL,NULL,'past_papers','2025-08-07 06:25:54','https://res.cloudinary.com/dkc2oujm6/raw/upload/v1754556942/files/WhatsApp_Image_2025-07-15_at_4.jpeg','2024 past paper'),('3a6a96f4-d35f-46ec-b928-f03eb8f74f4c','2f7b8057-8857-43a8-a868-afdd3ab54387',NULL,NULL,'pdf','2025-08-12 04:16:40','https://res.cloudinary.com/dkc2oujm6/image/upload/v1754966204/files/Project_Sections_and_Guidelie_Reviewed.pdf','lecture 1'),('3ebf8005-8f69-4a01-b074-8075cbba9cac','2f7b8057-8857-43a8-a868-afdd3ab54387',NULL,NULL,'past_papers','2025-08-12 04:20:21','https://res.cloudinary.com/dkc2oujm6/image/upload/v1754966027/files/Recomendation__insuarance_letter.pdf','2021  exam paper'),('488082a5-97d0-4f68-b139-abee2048b9bb','fe9dfc6f-ca3e-4f6b-8cfb-019cb6127efb',NULL,NULL,'assignment','2025-08-07 06:58:28','https://res.cloudinary.com/dkc2oujm6/raw/upload/v1754560644/files/AI_ASSIGNMENT_2024.pdf','Assignment 2'),('48f10ba7-080e-4b54-bf68-fa4e75a14f0c','fe9dfc6f-ca3e-4f6b-8cfb-019cb6127efb',NULL,NULL,'past_papers','2025-08-07 06:25:32','https://res.cloudinary.com/dkc2oujm6/raw/upload/v1754556942/files/WhatsApp_Image_2025-07-15_at_4.jpeg','2021 past paper'),('4add5be2-652a-4896-be06-b12818d1ce4e','f89cd540-7740-47ac-81f6-2e772f3bae46',NULL,NULL,'assignment','2025-09-16 11:20:05','https://res.cloudinary.com/dkc2oujm6/image/upload/v1758032409/files/Assignment_2_e-commerce_.pdf','Assignment 2'),('555f0111-1e88-4125-a24b-c50e4ebcc8c7','2f7b8057-8857-43a8-a868-afdd3ab54387',NULL,NULL,'past_papers','2025-08-12 04:19:45','https://res.cloudinary.com/dkc2oujm6/image/upload/v1754966027/files/Recomendation__insuarance_letter.pdf','2020 exam paper'),('6d8592b0-da18-4d9c-b9e3-d57b76b3364a','2f7b8057-8857-43a8-a868-afdd3ab54387',NULL,NULL,'pdf','2025-08-12 04:17:22','https://res.cloudinary.com/dkc2oujm6/image/upload/v1754983045/files/Applied_Sciences_-_Communication_skills.pdf','lecture 3'),('896815d9-1fab-48c6-bcf8-96d5baf665a4','fe9dfc6f-ca3e-4f6b-8cfb-019cb6127efb',NULL,NULL,'assignment','2025-08-07 06:57:21','https://res.cloudinary.com/dkc2oujm6/raw/upload/v1754560644/files/AI_ASSIGNMENT_2024.pdf','Assignment 1'),('8de84499-02d9-47bc-bc90-9e51572d87b7','fe9dfc6f-ca3e-4f6b-8cfb-019cb6127efb',NULL,NULL,'past_papers','2025-08-07 06:24:34','https://res.cloudinary.com/dkc2oujm6/raw/upload/v1754557208/files/Applied_Sciences_-_Communication_skills.pdf','2022 past paper'),('903df8f7-0bb9-4ee3-9729-a2effb62023e','f89cd540-7740-47ac-81f6-2e772f3bae46',NULL,NULL,'pdf','2025-09-16 11:17:58','https://res.cloudinary.com/dkc2oujm6/image/upload/v1758032281/files/Resume.pdf','lecture 1'),('9c51238f-14e2-482f-a8c2-2cb627fb7a20','fe9dfc6f-ca3e-4f6b-8cfb-019cb6127efb',NULL,NULL,'pdf','2025-08-07 06:45:36','https://res.cloudinary.com/dkc2oujm6/raw/upload/v1754546352/files/topic_2-AI_agents.pptx','lecture 2'),('a3c0b0a5-a12a-4292-abdc-98eaf927dd4e','fe9dfc6f-ca3e-4f6b-8cfb-019cb6127efb',NULL,NULL,'pdf','2025-08-07 06:45:59','https://res.cloudinary.com/dkc2oujm6/raw/upload/v1754546436/files/topic_3-Searching_Algorithmes_and_problem_solving.pptx','lecture 3'),('ad6bd2a4-6c7a-47ea-838a-abc557841c5f','2f7b8057-8857-43a8-a868-afdd3ab54387',NULL,NULL,'assignment','2025-08-12 04:18:05','https://res.cloudinary.com/dkc2oujm6/image/upload/v1754966027/files/Recomendation__insuarance_letter.pdf','lecture 3'),('c47bfb88-e9cf-42e0-a320-1aa7f50610d9','2f7b8057-8857-43a8-a868-afdd3ab54387',NULL,NULL,'pdf','2025-08-12 04:16:06','https://res.cloudinary.com/dkc2oujm6/image/upload/v1754966204/files/Project_Sections_and_Guidelie_Reviewed.pdf','google meet link'),('ce62ccde-b5e1-4354-b5c6-b6c50152ab82','2f7b8057-8857-43a8-a868-afdd3ab54387',NULL,NULL,'pdf','2025-08-12 04:16:52','https://res.cloudinary.com/dkc2oujm6/image/upload/v1754966204/files/Project_Sections_and_Guidelie_Reviewed.pdf','lecture 2'),('d25a03e2-72d6-4bdb-b2d8-a9996895888a','2f7b8057-8857-43a8-a868-afdd3ab54387',NULL,NULL,'assignment','2025-08-12 04:18:25','https://res.cloudinary.com/dkc2oujm6/image/upload/v1754966027/files/Recomendation__insuarance_letter.pdf','assignment  1'),('d51843c2-36a9-4979-97e0-77f5cfc013c5','f89cd540-7740-47ac-81f6-2e772f3bae46',NULL,NULL,'assignment','2025-09-16 11:16:58','https://res.cloudinary.com/dkc2oujm6/image/upload/v1758032223/files/assignment_3.pdf','assignment 1'),('dbb09997-b43d-45d1-be92-9ef928d249c3','f89cd540-7740-47ac-81f6-2e772f3bae46',NULL,NULL,'pdf','2025-09-16 11:22:34','https://res.cloudinary.com/dkc2oujm6/image/upload/v1758032558/files/commission-of-oath.pdf','lecture 2'),('e236af1b-c8d3-41a0-aace-0281bbc058a9','fe9dfc6f-ca3e-4f6b-8cfb-019cb6127efb','https://www.facebook.com/share/r/1FsDvnfUZp/',NULL,'video','2025-08-07 06:52:59','','lecture 5 recording');
/*!40000 ALTER TABLE `unitOfferingContent_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unitOffering_tb`
--

DROP TABLE IF EXISTS `unitOffering_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unitOffering_tb` (
  `unitOfferingID` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `lecturerID` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `unitID` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `academicYear` varchar(10) COLLATE utf8mb4_general_ci NOT NULL,
  `year` int NOT NULL,
  `sem` int NOT NULL,
  PRIMARY KEY (`unitOfferingID`),
  UNIQUE KEY `unit_offering_tb_lecturer_i_d_unit_i_d_academic_year_year_sem` (`lecturerID`,`unitID`,`academicYear`,`year`,`sem`),
  KEY `unitID` (`unitID`),
  CONSTRAINT `unitOffering_tb_ibfk_69` FOREIGN KEY (`lecturerID`) REFERENCES `lecturers_tb` (`lecturerID`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `unitOffering_tb_ibfk_70` FOREIGN KEY (`unitID`) REFERENCES `units_tb` (`unitID`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unitOffering_tb`
--

LOCK TABLES `unitOffering_tb` WRITE;
/*!40000 ALTER TABLE `unitOffering_tb` DISABLE KEYS */;
INSERT INTO `unitOffering_tb` VALUES ('947d9b31-5398-4db6-bfab-2e612ab1773e','ACSI/002 ','ECSI4106','2022/2023',4,2),('ec840b82-ef04-4cac-b153-066db4d21da4','ACSI/002 ','ECSI4106','2023/2024',4,2),('f89cd540-7740-47ac-81f6-2e772f3bae46','ACSI/002 ','ECSI4106','2024/2025',4,2),('2146e11d-a71b-4a89-93fb-01df6f105990','ACSI/005','ECSI4204','2024/2025',4,2),('29f67d82-16c8-4cce-b82e-35b9974defcc','ACSI/007','ECSI4203','2022/2023',4,2),('2c1f315d-7b20-41b1-8245-61719ea85f6f','ACSI/007','ECSI4203','2023/2024',4,2),('fe9dfc6f-ca3e-4f6b-8cfb-019cb6127efb','ACSI/007','ECSI4203','2024/2025',4,2),('2f7b8057-8857-43a8-a868-afdd3ab54387','ACSI/014','ECSI4206','2024/2025',4,2),('e22b7fe1-6dce-4792-9354-f47ec02f4934','ACSI/016 ','ECSI4205','2024/2025',4,2);
/*!40000 ALTER TABLE `unitOffering_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `units_tb`
--

DROP TABLE IF EXISTS `units_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `units_tb` (
  `unitID` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `unitName` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `unitDescription` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`unitID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `units_tb`
--

LOCK TABLES `units_tb` WRITE;
/*!40000 ALTER TABLE `units_tb` DISABLE KEYS */;
INSERT INTO `units_tb` VALUES ('BSIT2104','Finacial Accounting',NULL),('ECSI1101','Introduction to computer technology',NULL),('ECSI1103','Office Automation System',NULL),('ECSI2101','Web Technologies 1',NULL),('ECSI2102','Database Design ',NULL),('ECSI3101','System development',NULL),('ECSI3102','Network Design ',NULL),('ECSI3103','opperating system principles',NULL),('ECSI3104','Mobile computing',NULL),('ECSI4101','Project Managment',NULL),('ECSI4102','Software Engineering & Development',NULL),('ECSI4103','Distributed Systems',NULL),('ECSI4104','Information System Audit & Control',NULL),('ECSI4105','Database Administration',NULL),('ECSI4106','Automata Theory and Languages',NULL),('ECSI4107','Compiler Design & Constraction',NULL),('ECSI4108','Computer Vision',NULL),('ECSI4111','Telecommunication System Managment',NULL),('ECSI4112','Cyber Security 2',NULL),('ECSI4113','Internet Technologies',NULL),('ECSI4114','Advanced Artificial Inteligence',NULL),('ECSI4201','Organization Managment',NULL),('ECSI4202','Enviroment Managment',NULL),('ECSI4203','Estimating Tendering & Computer Services Contracts',NULL),('ECSI4204','ICT Emerging Trends & Society',NULL),('ECSI4205','Legal & Ethical Issues In Computing',NULL),('ECSI4206','Managment Information System',NULL),('ECSI4210','ERP system Managment',NULL),('ECSI4211','Office Computing Managment',NULL),('EEEE3201','Microprocessors & Digital Design',NULL),('MTHC1104','Mathematics',NULL),('MTHC2103','Caculus 1',NULL),('PHYC1105','physics',NULL);
/*!40000 ALTER TABLE `units_tb` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_tb`
--

DROP TABLE IF EXISTS `user_tb`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_tb` (
  `userID` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `fname` varchar(15) COLLATE utf8mb4_general_ci NOT NULL,
  `sname` varchar(15) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(30) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `role` enum('student','lecturer','admin') COLLATE utf8mb4_general_ci DEFAULT 'student',
  `mobile` varchar(15) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `profileUrl` text COLLATE utf8mb4_general_ci,
  PRIMARY KEY (`userID`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `email_2` (`email`),
  UNIQUE KEY `email_3` (`email`),
  UNIQUE KEY `email_4` (`email`),
  UNIQUE KEY `email_5` (`email`),
  UNIQUE KEY `email_6` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_tb`
--

LOCK TABLES `user_tb` WRITE;
/*!40000 ALTER TABLE `user_tb` DISABLE KEYS */;
INSERT INTO `user_tb` VALUES ('ACSI/001','Dr samson','Njuki','snjuki@tukenya.ac.ke','$2b$10$n3LUpsebOd4Zgt66mFtjhuLWmZmzSjIV3DmtDIkAuB1RoqAsy8Wj2','lecturer',NULL,NULL),('ACSI/002','Ebbie','wawira','ebbie@gmail.com','$2b$10$qK.l0JCVWmyWyWDpVeiKcO8w91uIuQsdfZwGq3f9dhP1TxVCotF9q','lecturer',NULL,'https://res.cloudinary.com/dkc2oujm6/image/upload/v1758030317/profile/Screenshot_2024-06-18_092936.png'),('ACSI/003','Dr Edwin','Obare','obare@tukenya.ac.ke','$2b$10$61/YshEaWZSIyDR77Yj8xO.lMxOwc.kphAVEL4wIaZceg4xY0am9O','lecturer',NULL,NULL),('ACSI/005','Luke','Otieno','luke@tukenya.ac.ke','$2b$10$BdpJmgpVIeAp0Oq3giyMju7vl7PU2if0Oa1x0eG4iI7ySmb1EweNW','lecturer',NULL,NULL),('ACSI/006','peter','Mulei','muleiPeter@tukenya.ac.ke','$2b$10$CuiSpxBIhm/7BCj.pS7yUO8pE1EzBOacgF9oKF5OxnJ8sfglc3F9O','lecturer',NULL,NULL),('ACSI/007','Lucy','Abwotha','Abwothalucy@gmail.com','$2b$10$HzbCcVuAS4R61CW/zdQ7wO6RAGSlW42qHitZ8VevXuA4cwVOm/yUq','lecturer',NULL,NULL),('ACSI/014','Amstrong','Muasya','muasyaAmstrong@gmail.com','$2b$10$ybc.7VUJ90AVXfwOAWs5buDFLi2peafDsMjW5k5VOT58ODfn./0n6','lecturer',NULL,'https://res.cloudinary.com/dkc2oujm6/image/upload/v1754410712/TukCompass/download_2.jpg'),('ACSI/016','Mary','Nguchu','nguchuMary@tukenya.ac.ke','$2b$10$BuRoz7sCu1CgvInNmyjANOXbUBNfLy2wv63R2b.16vsUwTI/5ziMe','lecturer',NULL,NULL),('SCCI/00573/2020','Muturi','Melvin','melvinmurichu@gmail.com','$2b$10$fB66qgZmjoFXRT0n0IUT/eDj9NTAi4qUkHxtybhFgXys6LxS/ytei','student',NULL,NULL),('SCCI/00574/2021','john','kelvin','kelvin@gmail.com','$2b$10$li/V0iNeKIcclvun3Ll77OjFRA8KnILLNopVXXIi/4AsQX7j.s13q','student',NULL,NULL),('SCCI/00594/2021','Milly','Kagweru','kagweru@gmail.com','$2b$10$ZsnM3I7VToHMn7NnhjZUl.Uwv9f01Gbo4IR8HvN2Etqj6P.tYCDXa','student',NULL,'https://res.cloudinary.com/dkc2oujm6/image/upload/v1754410414/TukCompass/3D-4.jpg'),('SCCI/00604/2021','Eunice','Nyambura','enyambura@gmail.com','$2b$10$umZehWsd5gjlx2QRgpyNDepUV0WCZi8tvrQQXQ3IErP0YhezLowyq','student',NULL,NULL),('SCCI/00605/2021','Felistus','Kioko','kioko@gmail.com','$2b$10$XWGulW/3seWux.zl49brpuARW5Z/PbGJ5UnzY0jnXEb7qGPVYPCmu','student',NULL,NULL),('SCCi/00624/2021','joshua','omwami','omwami@gmail.com','$2b$10$JhWSePupwLzrHJmfZKoIM.Uh/Wca4OdRYazOg5uDBlNqGCeE99kwm','student',NULL,NULL),('SCCI/00627/2021','john','maina','maina@gmail.com','$2b$10$meGNkacCl1kC5EoNlHbhb.WxN.mF0Z9d0wZfJ.GGRetdY7LyISJM6','student',NULL,NULL),('SCCI/00678/2021','Martin','Muchiri','muchir@gmail.com','$2b$10$/wyT8jPoOc1fp5qJRhkmQu.eSi5rGPpb03JZt9tM.uB2RnfrCtG2W','student',NULL,NULL),('SCCI/03853P/2021','Amalemba','Victor','amalemba@gmail.com','$2b$10$wJ96f5xU6lQSKBmTLHgRE.payVChAm7yP/H/jI51OQST.JvW0zfh.','student',NULL,NULL),('SCCI/0624/2021','Joshua','Omwami','Omwamijosh@gmail.com','$2b$10$HbwG5dhbeD9On.5bWN3IW.x9l.O7fWJeF.DKkb8cviPdnCCSziA5G','student','0796453897','https://res.cloudinary.com/dkc2oujm6/image/upload/v1751478633/profile/st1.jpg'),('SCCI/0625/2021','Martin','Muchiri','muchiri@gmail.com','$2b$10$UzANdsVY1e7..dHFeb1t2OU7VAE7J/JLGslix9aAALaZPK86H/Po2','student',NULL,NULL),('SCCI/06262021','Mark','ngatia','ngatia@gmail.com','$2b$10$OK4pOd0xytSwSAefiAThPenx1kJ2kdfA9nIYv0BwMNsryBdripDtq','student',NULL,NULL),('SCII/00659/2021','Sharon','Otieno','otieno@gmail.com','$2b$10$KAlZ31fCDwsi8rOKiCdogOJXWj6lhrgo.2AS87TJyhD8kqhTJEPy2','student',NULL,NULL),('SCII/01060/2021','Mathew','maingi','maingi@gmail.com','$2b$10$bj8dTHahWqFt64K4FW2WKubstNKiNBIY3vyv6g5vu1EDYhbpChmbO','student',NULL,NULL),('SCNI/01290/2021','Bervely','Boyani','boyani@gmail.com','$2b$10$41KLGT8sdox4UDSrjwV/I.8.9ZqY1549SwTy0/POLPAor0cAaGmAW','student','0756789808','https://res.cloudinary.com/dkc2oujm6/image/upload/v1751479027/profile/20211231_123143.jpg'),('SCNI/01298/2021','Taff','Nyamita','nyamita@gmail.com','$2b$10$Cajca10HOKT32ZPQ9/svVODQ4SqRieus1guRe61e1SO9FtyAZP2/G','student',NULL,NULL);
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

-- Dump completed on 2025-09-19 13:33:09
