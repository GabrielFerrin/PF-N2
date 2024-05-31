-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: viaduct.proxy.rlwy.net    Database: railway
-- ------------------------------------------------------
-- Server version	8.4.0

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
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `category` (
  `category_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `is_deleted` tinyint NOT NULL DEFAULT '0',
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`category_id`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category`
--

LOCK TABLES `category` WRITE;
/*!40000 ALTER TABLE `category` DISABLE KEYS */;
INSERT INTO `category` VALUES (2,'Tecnología',0,'2024-05-29 15:02:09','2024-05-29 15:02:09'),(3,'Nutrición',0,'2024-05-29 15:02:09','2024-05-29 15:02:09'),(4,'Política',0,'2024-05-29 15:02:09','2024-05-29 15:02:09'),(5,'Deportes',0,'2024-05-29 15:02:09','2024-05-29 15:02:09'),(6,'Cultura',0,'2024-05-29 15:02:09','2024-05-29 15:02:09'),(7,'Economía',0,'2024-05-29 15:02:09','2024-05-29 15:02:09'),(8,'Ciencia',0,'2024-05-29 15:02:09','2024-05-29 15:02:09'),(10,'Entretenimiento',0,'2024-05-29 15:02:09','2024-05-29 15:02:09'),(11,'Salud',0,'2024-05-29 15:02:09','2024-05-29 15:02:09'),(12,'Estilo de Vida',0,'2024-05-29 15:02:09','2024-05-29 15:02:09'),(13,'Viajes',0,'2024-05-29 15:02:09','2024-05-29 15:02:09'),(18,'Ecología',0,'2024-05-30 02:05:36','2024-05-30 02:05:36'),(22,'Activismo',0,'2024-05-30 02:08:34','2024-05-30 02:08:34'),(25,'Estudios Superiores',0,'2024-05-30 22:23:47','2024-05-30 22:23:47');
/*!40000 ALTER TABLE `category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `comment_id` int NOT NULL AUTO_INCREMENT,
  `post_id` int NOT NULL,
  `user_id` int NOT NULL,
  `content` text NOT NULL,
  `is_deleted` tinyint NOT NULL DEFAULT '0',
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`comment_id`),
  KEY `comment_ibfk_1` (`post_id`),
  KEY `comment_ibfk_2` (`user_id`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
INSERT INTO `comment` VALUES (1,11,16,'Tu publicación es una basura!',0,'2024-05-30 15:32:29','2024-05-31 01:49:06'),(3,11,17,'A mi qué me importa lo que opine una basura como tú!!!',0,'2024-05-30 15:33:49','2024-05-30 15:33:49'),(7,16,15,'Polititians are dirty, politics is beautiful!',0,'2024-05-30 23:18:56','2024-05-30 23:18:56'),(8,11,26,'You need to touch some grass. Stress is the real thing!!',0,'2024-05-31 01:32:34','2024-05-31 01:32:34'),(10,11,16,'Si no te importara no los estarías publicando, tarado!!!',0,'2024-05-31 01:39:31','2024-05-31 01:39:31'),(11,11,16,'Si no te importara no los estarías publicando, tarado!!!',0,'2024-05-31 01:39:41','2024-05-31 01:39:41'),(14,11,17,'Voy a bloquear a cualquier grosero que se asome por este post!!',0,'2024-05-31 01:43:18','2024-05-31 01:43:18');
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `country` (
  `country_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `is_deleted` tinyint NOT NULL DEFAULT '0',
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB AUTO_INCREMENT=191 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` VALUES (1,'Afghanistan',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(2,'Albania',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(3,'Algeria',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(4,'Andorra',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(5,'Angola',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(6,'Antigua and Barbuda',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(7,'Argentina',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(8,'Armenia',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(9,'Australia',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(10,'Austria',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(11,'Azerbaijan',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(12,'Bahamas',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(13,'Bahrain',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(14,'Bangladesh',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(15,'Barbados',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(16,'Belarus',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(17,'Belgium',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(18,'Belize',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(19,'Benin',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(20,'Bhutan',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(21,'Bolivia',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(22,'Bosnia and Herzegovina',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(23,'Botswana',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(24,'Brazil',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(25,'Brunei',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(26,'Bulgaria',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(27,'Burkina Faso',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(28,'Burundi',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(29,'Cabo Verde',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(30,'Cambodia',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(31,'Cameroon',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(32,'Canada',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(33,'Central African Republic',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(34,'Chad',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(35,'Chile',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(36,'China',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(37,'Colombia',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(38,'Comoros',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(39,'Congo',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(40,'Costa Rica',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(41,'Cote dIvoire',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(42,'Croatia',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(43,'Cuba',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(44,'Cyprus',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(45,'Czech Republic',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(46,'Denmark',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(47,'Djibouti',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(48,'Dominica',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(49,'Dominican Republic',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(50,'East Timor',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(51,'Ecuador',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(52,'Egypt',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(53,'El Salvador',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(54,'Equatorial Guinea',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(55,'Eritrea',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(56,'Estonia',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(57,'Ethiopia',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(58,'Fiji',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(59,'Finland',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(60,'France',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(61,'Gabon',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(62,'Gambia',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(63,'Georgia',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(64,'Germany',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(65,'Ghana',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(66,'Greece',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(67,'Grenada',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(68,'Guatemala',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(69,'Guinea',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(70,'Guinea-Bissau',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(71,'Guyana',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(72,'Haiti',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(73,'Honduras',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(74,'Hong Kong',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(75,'Hungary',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(76,'Iceland',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(77,'India',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(78,'Indonesia',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(79,'Iran',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(80,'Iraq',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(81,'Ireland',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(82,'Israel',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(83,'Italy',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(84,'Jamaica',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(85,'Japan',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(86,'Jordan',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(87,'Kazakhstan',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(88,'Kenya',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(89,'Kiribati',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(90,'Korea, North',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(91,'Korea, South',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(92,'Kuwait',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(93,'Kyrgyzstan',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(94,'Laos',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(95,'Latvia',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(96,'Lebanon',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(97,'Lesotho',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(98,'Liberia',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(99,'Libya',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(100,'Liechtenstein',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(101,'Lithuania',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(102,'Luxembourg',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(103,'Macedonia',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(104,'Madagascar',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(105,'Malawi',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(106,'Malaysia',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(107,'Maldives',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(108,'Mali',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(109,'Malta',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(110,'Marshall Islands',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(111,'Mauritania',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(112,'Mauritius',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(113,'Mexico',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(114,'Micronesia',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(115,'Moldova',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(116,'Monaco',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(117,'Mongolia',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(118,'Morocco',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(119,'Mozambique',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(120,'Myanmar',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(121,'Namibia',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(122,'Nauru',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(123,'Nepal',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(124,'Netherlands',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(125,'New Zealand',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(126,'Nicaragua',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(127,'Niger',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(128,'Nigeria',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(129,'Norway',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(130,'Oman',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(131,'Pakistan',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(132,'Palau',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(133,'Panama',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(134,'Papua New Guinea',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(135,'Paraguay',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(136,'Peru',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(137,'Philippines',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(138,'Poland',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(139,'Portugal',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(140,'Qatar',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(141,'Romania',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(142,'Russia',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(143,'Rwanda',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(144,'Samoa',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(145,'San Marino',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(146,'Sao Tome and Principe',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(147,'Saudi Arabia',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(148,'Senegal',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(149,'Serbia and Montenegro',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(150,'Seychelles',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(151,'Sierra Leone',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(152,'Singapore',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(153,'Slovakia',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(154,'Slovenia',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(155,'Solomon Islands',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(156,'Somalia',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(157,'South Africa',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(158,'Spain',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(159,'Sri Lanka',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(160,'Sudan',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(161,'Suriname',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(162,'Swaziland',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(163,'Sweden',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(164,'Switzerland',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(165,'Syria',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(166,'Taiwan',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(167,'Tajikistan',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(168,'Tanzania',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(169,'Thailand',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(170,'Togo',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(171,'Tonga',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(172,'Trinidad and Tobago',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(173,'Tunisia',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(174,'Turkey',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(175,'Turkmenistan',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(176,'Tuvalu',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(177,'Uganda',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(178,'Ukraine',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(179,'United Arab Emirates',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(180,'United Kingdom',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(181,'United States',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(182,'Uruguay',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(183,'Uzbekistan',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(184,'Vanuatu',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(185,'Vatican City',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(186,'Venezuela',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(187,'Vietnam',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(188,'Yemen',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(189,'Zambia',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(190,'Zimbabwe',0,'2024-05-29 15:02:08','2024-05-29 15:02:08');
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post`
--

DROP TABLE IF EXISTS `post`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post` (
  `post_id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `content` text NOT NULL,
  `user_id` int NOT NULL,
  `is_deleted` tinyint NOT NULL DEFAULT '0',
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`post_id`),
  KEY `post_ibfk_1` (`user_id`),
  CONSTRAINT `post_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post`
--

LOCK TABLES `post` WRITE;
/*!40000 ALTER TABLE `post` DISABLE KEYS */;
INSERT INTO `post` VALUES (11,'Not feeling well today','I ate something and my stomach hurts',17,0,'2024-05-29 23:50:14','2024-05-29 23:50:14'),(12,'I love sports','Today I realized I really love sports',17,0,'2024-05-30 00:07:28','2024-05-30 00:07:28'),(13,'I love sports','Today I realized I really love sports',20,0,'2024-05-30 01:39:02','2024-05-30 01:39:02'),(15,'Web Development is dificult!','You can stumble with many difficulties',26,0,'2024-05-30 23:11:01','2024-05-30 23:11:01'),(16,'I love sports','I\'m retaking golf. I used to play a lot',14,0,'2024-05-30 23:17:14','2024-05-30 23:55:21'),(17,'I love sports','Im retaking golf. I used to play a lot!',14,0,'2024-05-30 23:32:50','2024-05-31 00:13:38');
/*!40000 ALTER TABLE `post` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_category`
--

DROP TABLE IF EXISTS `post_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_category` (
  `category_id` int NOT NULL,
  `post_id` int NOT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  KEY `post_category_ibfk_1` (`post_id`),
  KEY `post_category_ibfk_2` (`category_id`),
  CONSTRAINT `post_category_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `post_category_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `category` (`category_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_category`
--

LOCK TABLES `post_category` WRITE;
/*!40000 ALTER TABLE `post_category` DISABLE KEYS */;
INSERT INTO `post_category` VALUES (2,11,'2024-05-29 23:50:14','2024-05-29 23:50:14'),(5,12,'2024-05-30 00:07:28','2024-05-30 00:07:28'),(12,12,'2024-05-30 00:07:28','2024-05-30 00:07:28'),(6,12,'2024-05-30 00:07:28','2024-05-30 00:07:28'),(5,13,'2024-05-30 01:39:02','2024-05-30 01:39:02'),(12,13,'2024-05-30 01:39:02','2024-05-30 01:39:02'),(5,15,'2024-05-30 23:11:01','2024-05-30 23:11:01'),(12,15,'2024-05-30 23:11:01','2024-05-30 23:11:01'),(10,16,'2024-05-30 23:17:14','2024-05-30 23:17:14'),(10,17,'2024-05-30 23:32:50','2024-05-30 23:32:50');
/*!40000 ALTER TABLE `post_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `post_image`
--

DROP TABLE IF EXISTS `post_image`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `post_image` (
  `post_image_id` int NOT NULL AUTO_INCREMENT,
  `post_id` int NOT NULL,
  `image` varchar(255) NOT NULL,
  `is_deleted` tinyint NOT NULL DEFAULT '0',
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`post_image_id`),
  KEY `post_image_ibfk_1` (`post_id`),
  CONSTRAINT `post_image_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `post` (`post_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `post_image`
--

LOCK TABLES `post_image` WRITE;
/*!40000 ALTER TABLE `post_image` DISABLE KEYS */;
/*!40000 ALTER TABLE `post_image` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `role` (
  `role_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `description` varchar(255) NOT NULL,
  `is_deleted` tinyint NOT NULL DEFAULT '0',
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'administrador','Posee todos los permisos',0,'2024-05-29 15:02:08','2024-05-29 15:02:08'),(2,'usuario','Tiene permisos relacionados con sus propios datos',0,'2024-05-29 15:02:08','2024-05-29 15:02:08');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role_id` int NOT NULL,
  `country_id` int NOT NULL,
  `bio` text NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `is_deleted` tinyint NOT NULL DEFAULT '0',
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `date_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`user_id`),
  KEY `user_ibfk_1` (`role_id`),
  KEY `user_ibfk_2` (`country_id`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_ibfk_2` FOREIGN KEY (`country_id`) REFERENCES `country` (`country_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (13,'Bob Johnson','bob.johnson@example.com','12341234',2,181,'I am a tech enthusiast and love to explore new technologies. I am always looking for new ways to improve my coding skills and stay up-to-date with the latest technologies.','local',0,'2024-05-29 15:06:58','2024-05-30 22:51:14'),(14,'Alice Brown','alice.brown@example.com','12341234',1,181,'I was born and raised in a small town in the countryside. I studied computer science in college and have been working as a software engineer for the past 5 years. In my free time, I enjoy hiking and playing guitar.','local',0,'2024-05-29 15:06:58','2024-05-30 22:51:14'),(15,'David Wilson','david.wilson@example.com','12341234',2,181,'I grew up in a big city and always dreamed of traveling the world. After completing my degree in international relations, I started working for a non-profit organization focused on sustainable development. I love exploring new cultures and meeting people from different backgrounds.','local',0,'2024-05-29 15:06:58','2024-05-30 22:51:15'),(16,'Emily Davis','emily.davis@example.com','12341234',2,181,'I was born and raised in a family of artists. I studied art history in college and have been working as a curator for a local art museum for the past 3 years. In my free time, I enjoy painting and playing the guitar.','local',0,'2024-05-29 15:06:58','2024-05-30 22:51:15'),(17,'Mike Thompson','mike.thompson@example.com','12341234',2,113,'I was born and raised in a small town in the countryside. I studied chemistry in college and have been working as a researcher for a pharmaceutical company for the past 5 years. In my free time, I enjoy hiking and playing tennis.','local',0,'2024-05-29 15:06:58','2024-05-30 22:51:16'),(18,'Sarah Garcia','sarah.garcia@example.com','12341234',2,113,'I grew up in a big city and always dreamed of exploring the world. After completing my degree in international business, I started working for a global consulting firm focused on sustainable development. I love traveling and meeting new people from different cultures.','local',0,'2024-05-29 15:06:58','2024-05-30 22:51:15'),(19,'Michael Smith','michael.smith@example.com','12341234',2,7,'I was born and raised in a small town in the countryside. I studied biology in college and have been working as a scientist for the past 5 years. In my free time, I enjoy playing guitar and reading.','local',0,'2024-05-29 15:06:58','2024-05-30 22:51:16'),(20,'Emma Johnson','emma.johnson@example.com','12341234',2,7,'I was born and raised in a family of artists. I studied architecture in college and have been working as an architect for a local architecture firm for the past 3 years. In my free time, I enjoy painting and playing the guitar.','local',0,'2024-05-29 15:06:58','2024-05-30 22:51:16'),(22,'Fernando Marínez','agferrin@gmail.com','12341234',1,51,'I\'m a FUNVAL student becoming a FullStack developer','local',0,'2024-05-30 19:27:52','2024-05-30 22:51:30'),(23,'Fernando Marínez','agferrin@gmail.coma','12341234',1,51,'I\'m a FUNVAL student becoming a FullStack developer','local',0,'2024-05-30 19:28:28','2024-05-30 22:51:30'),(24,'Fernando Martínez','agferrind@gmail.coma','12341234',1,51,'I\'m a FUNVAL student becoming a FullStack developer','local',0,'2024-05-30 20:38:55','2024-05-30 22:51:31'),(25,'Juan Piguave','juan@gmail.com','12341234',1,51,'I\'m a FUNVAL student becoming a FullStack developer','local',0,'2024-05-30 20:47:43','2024-05-30 22:51:31'),(26,'Gabriela Ferrin','gabriel@ferrin.com','12345678',1,1,'bio','image',0,'2024-05-30 21:57:05','2024-05-31 00:42:23');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_comment`
--

DROP TABLE IF EXISTS `v_comment`;
/*!50001 DROP VIEW IF EXISTS `v_comment`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_comment` AS SELECT 
 1 AS `comment_id`,
 1 AS `post_id`,
 1 AS `content`,
 1 AS `user_id`,
 1 AS `name`,
 1 AS `date_created`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_post`
--

DROP TABLE IF EXISTS `v_post`;
/*!50001 DROP VIEW IF EXISTS `v_post`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_post` AS SELECT 
 1 AS `post_id`,
 1 AS `title`,
 1 AS `content`,
 1 AS `user_id`,
 1 AS `user`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_post_by_cat`
--

DROP TABLE IF EXISTS `v_post_by_cat`;
/*!50001 DROP VIEW IF EXISTS `v_post_by_cat`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_post_by_cat` AS SELECT 
 1 AS `post_id`,
 1 AS `category_id`,
 1 AS `category`,
 1 AS `user_id`,
 1 AS `user`,
 1 AS `title`,
 1 AS `content`,
 1 AS `date_created`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_post_category`
--

DROP TABLE IF EXISTS `v_post_category`;
/*!50001 DROP VIEW IF EXISTS `v_post_category`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_post_category` AS SELECT 
 1 AS `post_id`,
 1 AS `name`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_user`
--

DROP TABLE IF EXISTS `v_user`;
/*!50001 DROP VIEW IF EXISTS `v_user`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_user` AS SELECT 
 1 AS `user_id`,
 1 AS `name`,
 1 AS `email`,
 1 AS `rol_name`,
 1 AS `country_name`,
 1 AS `bio`,
 1 AS `image`,
 1 AS `date_created`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `v_comment`
--

/*!50001 DROP VIEW IF EXISTS `v_comment`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_comment` AS select `a`.`comment_id` AS `comment_id`,`a`.`post_id` AS `post_id`,`a`.`content` AS `content`,`b`.`user_id` AS `user_id`,`b`.`name` AS `name`,`a`.`date_created` AS `date_created` from (`comment` `a` join `user` `b` on((`a`.`user_id` = `b`.`user_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_post`
--

/*!50001 DROP VIEW IF EXISTS `v_post`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_post` AS select `a`.`post_id` AS `post_id`,`a`.`title` AS `title`,`a`.`content` AS `content`,`b`.`user_id` AS `user_id`,`b`.`name` AS `user` from (`post` `a` join `user` `b` on((`a`.`user_id` = `b`.`user_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_post_by_cat`
--

/*!50001 DROP VIEW IF EXISTS `v_post_by_cat`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_post_by_cat` AS select `a`.`post_id` AS `post_id`,`a`.`category_id` AS `category_id`,`c`.`name` AS `category`,`d`.`user_id` AS `user_id`,`d`.`name` AS `user`,`b`.`title` AS `title`,`b`.`content` AS `content`,`b`.`date_created` AS `date_created` from (((`post_category` `a` join `post` `b` on((`a`.`post_id` = `b`.`post_id`))) join `category` `c` on((`a`.`category_id` = `c`.`category_id`))) join `user` `d` on((`b`.`user_id` = `d`.`user_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_post_category`
--

/*!50001 DROP VIEW IF EXISTS `v_post_category`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_post_category` AS select `a`.`post_id` AS `post_id`,`b`.`name` AS `name` from (`post_category` `a` join `category` `b` on((`a`.`category_id` = `b`.`category_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_user`
--

/*!50001 DROP VIEW IF EXISTS `v_user`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `v_user` AS select `a`.`user_id` AS `user_id`,`a`.`name` AS `name`,`a`.`email` AS `email`,`b`.`name` AS `rol_name`,`c`.`name` AS `country_name`,`a`.`bio` AS `bio`,`a`.`image` AS `image`,`a`.`date_created` AS `date_created` from ((`user` `a` join `role` `b` on((`a`.`role_id` = `b`.`role_id`))) join `country` `c` on((`a`.`country_id` = `c`.`country_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-05-30 21:05:01
