-- MariaDB dump 10.19  Distrib 10.4.32-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: gold_db
-- ------------------------------------------------------
-- Server version	10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `investments`
--

DROP TABLE IF EXISTS `investments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `investments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `plan_name` varchar(255) DEFAULT NULL,
  `amount_invested_trx` decimal(20,8) NOT NULL,
  `amount_invested_frs` decimal(10,2) NOT NULL,
  `expected_return_frs` decimal(10,2) DEFAULT 0.00,
  `duration_days` int(11) DEFAULT NULL,
  `payout_date` datetime DEFAULT NULL,
  `current_return_frs` decimal(10,2) DEFAULT 0.00,
  `transaction_hash` varchar(255) DEFAULT NULL,
  `status` enum('pending','completed','active','paid_out','failed') DEFAULT 'pending',
  `date_invested` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `investments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `investments`
--

LOCK TABLES `investments` WRITE;
/*!40000 ALTER TABLE `investments` DISABLE KEYS */;
INSERT INTO `investments` VALUES (45,9,'MegaRig 1',11.97743900,2000.00,5880.00,21,'2025-07-22 13:37:37',0.00,'02bf957e5fa5f251285b85c2707c2ef9292aa6a206ffb50a9b65b7ceda5ddd33','active','2025-07-01 12:37:43');
/*!40000 ALTER TABLE `investments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `notifications` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `type` varchar(20) NOT NULL,
  `is_read` tinyint(1) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
INSERT INTO `notifications` VALUES (4,5,'Bienvenue, fr !','welcome',1,'2025-06-29 14:50:36'),(5,5,'Votre investissement a été confirmé.','success',0,'2025-06-29 14:58:49'),(8,6,'Bienvenue, gt !','welcome',1,'2025-06-29 15:23:56'),(9,6,'Votre investissement a été confirmé.','success',1,'2025-06-29 15:26:09'),(12,7,'Bienvenue, dd !','welcome',1,'2025-06-29 15:32:14'),(13,8,'Bienvenue, tt !','welcome',0,'2025-06-29 22:59:01'),(14,8,'Votre investissement a été confirmé.','success',0,'2025-06-29 23:01:12'),(25,4,'Votre demande de retrait de 500 FCFA est en cours de traitement.','info',1,'2025-07-01 12:43:33'),(26,4,'Votre retrait de 500.00 FCFA a été traité.','success',1,'2025-07-01 12:43:57');
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `currency` varchar(10) DEFAULT NULL,
  `status` enum('pending','completed','failed') DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `type` varchar(50) DEFAULT 'deposit',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transactions`
--

LOCK TABLES `transactions` WRITE;
/*!40000 ALTER TABLE `transactions` DISABLE KEYS */;
/*!40000 ALTER TABLE `transactions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('user','admin') NOT NULL DEFAULT 'user',
  `invitation_code` varchar(50) DEFAULT NULL,
  `referred_by` int(11) DEFAULT NULL,
  `referral_bonus_paid` tinyint(1) NOT NULL DEFAULT 0,
  `is_confirmed` tinyint(1) DEFAULT 1,
  `confirmation_token` varchar(255) DEFAULT NULL,
  `wallet_address` varchar(255) DEFAULT NULL,
  `referral_code` varchar(255) DEFAULT NULL,
  `referrer_id` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `balance_fcf` decimal(15,2) NOT NULL DEFAULT 0.00,
  `profile_image_url` varchar(255) DEFAULT '/assets/img/default-profile.png',
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `referral_code` (`referral_code`),
  KEY `fk_referred_by` (`referred_by`),
  CONSTRAINT `fk_referred_by` FOREIGN KEY (`referred_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'25','25@gmail.com','$2b$10$52rAhjKbNeLRutsb65WV7uYuj7whN9PFnEzXRZwfdihU7na8UIfdy','user','2525',NULL,0,1,NULL,NULL,NULL,NULL,'2025-06-28 00:16:49',0.00,'/assets/img/default-profile.png'),(2,'gh','fg@gmail.com','$2b$10$who1hom9II.3Xyn0/xMXV.YkVOqz1uYCxWu0WqFkD8qcXLU8VA/o2','user','256324',NULL,0,1,NULL,NULL,NULL,NULL,'2025-06-28 00:17:15',0.00,'/assets/img/default-profile.png'),(3,'Benitonono','bg@gmail.com','$2b$10$y7kOV7vJd9pdLRlLxgRJYOH9VHKJWjzO6u2f9X5Y9rqJLkQ9yJe7G','user','25214',NULL,0,1,NULL,'TLuWf9CgWSqFqtenm5QVb6iHrtsYGkdfJm',NULL,NULL,'2025-06-28 00:31:46',0.00,'/uploads/profile_image-1751156867543-366218762.PNG'),(4,'hh','hh@gmail.com','$2b$10$IUE9B3mJ8Pvv4gkZzlyzu.qs4B1DBeQlMSAz4KBGdjPA9IpgfXUXO','admin','27OL3HPX',NULL,0,1,NULL,'TWTn5vtXnTUhseQCcUdrJjADNsDDKxRSYK',NULL,NULL,'2025-06-29 12:21:58',0.00,'/assets/img/default-profile.png'),(5,'fr','fr@gmail.com','$2b$10$lYZZcQoa.eYAEUMXdUUNAeyHOwjC4CdAuKJKZdIJbDaqSkP4icbK.','user','XA3JP8CQ',4,1,1,NULL,NULL,NULL,NULL,'2025-06-29 14:50:36',0.00,'/assets/img/default-profile.png'),(6,'gt','gt@gmail.com','$2b$10$OdnpMespiNc31E9GGy3.1.H8PwWa4jTuibkJ5QHn9xMC9eHsI4Vlm','user','KE611RFP',4,1,1,NULL,'TLuWf9CgWSqFqtenm5ghtdmlkhgdtrjhdQVb6ijbbyyvyvyvyygygyvyvyvyvyvyHrtsYGkdfddddJH',NULL,NULL,'2025-06-29 15:23:56',0.00,'/assets/img/default-profile.png'),(7,'dd','dd@gmail.com','$2b$10$vTnPyAjBnj.WayFt7RA1xenOTEDDGyyofJfqGgq1E8obt8ItwsUQS','user','5ZJ8K207',4,0,1,NULL,NULL,NULL,NULL,'2025-06-29 15:32:14',0.00,'/assets/img/default-profile.png'),(8,'tt','tt@gmail.com','$2b$10$vkZz8EYx17BR2KxkQhg6O.IUNp10rPy5k9haUZGPQrAir.0Qn2Xqq','user','OK5SGTKF',4,1,1,NULL,NULL,NULL,NULL,'2025-06-29 22:59:01',0.00,'/assets/img/default-profile.png'),(9,'chef','chef@gmail.com','$2b$10$A7fMfWzGDr6S2/5SsXGuA.a1ffOpE3FjivRz2pNrBHMHJ/azSLHOy','user','VE9PYQAY',4,1,1,NULL,NULL,NULL,NULL,'2025-07-01 11:36:59',0.00,'/assets/img/default-profile.png');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `withdrawals`
--

DROP TABLE IF EXISTS `withdrawals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `withdrawals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `amount_fcf` decimal(15,2) NOT NULL,
  `wallet_address` varchar(255) NOT NULL,
  `status` enum('pending','completed','failed','processing') NOT NULL DEFAULT 'pending',
  `transaction_hash` varchar(255) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `processed_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `withdrawals_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `withdrawals`
--

LOCK TABLES `withdrawals` WRITE;
/*!40000 ALTER TABLE `withdrawals` DISABLE KEYS */;
INSERT INTO `withdrawals` VALUES (1,4,500.00,'TLuWf9CgWSqFqtenm5QVb6iHrtsYGkdfJB','failed',NULL,'Échec: Clé privée TRON non configurée sur le serveur (.env).','2025-06-29 15:02:19',NULL),(2,4,500.00,'TLuWf9CgWSqFqtenm5QVb6iHrtsYGkdfJB','pending',NULL,NULL,'2025-06-29 15:28:36',NULL),(3,4,500.00,'TLuWf9CgWSqFqtenm5QVb6iHrtsYGkdfJB','pending',NULL,NULL,'2025-06-29 23:04:04',NULL),(4,4,500.00,'TLuWf9CgWSqFqtenm5QVb6iHrtsYGkdfJB','pending',NULL,NULL,'2025-06-30 09:45:03',NULL),(5,4,500.00,'TWTn5vtXnTUhseQCcUdrJjADNsDDKxRSYK','failed',NULL,'Échec: Account resource insufficient error.','2025-07-01 12:32:13',NULL),(6,4,500.00,'TWTn5vtXnTUhseQCcUdrJjADNsDDKxRSYK','completed','f768ba3a83e7873937b0be3f284db4c451e41321262fe5b42aefa1555eec7c87',NULL,'2025-07-01 12:43:32','2025-07-01 12:43:57');
/*!40000 ALTER TABLE `withdrawals` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-03 22:52:21
