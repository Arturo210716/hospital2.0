CREATE DATABASE  IF NOT EXISTS `test` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `test`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: test
-- ------------------------------------------------------
-- Server version	8.0.35

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
-- Table structure for table `tbb_personas`
--

DROP TABLE IF EXISTS `tbb_personas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbb_personas` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Titulo_Cortesia` varchar(255) DEFAULT NULL,
  `Nombre` varchar(255) DEFAULT NULL,
  `Primer_Apellido` varchar(255) DEFAULT NULL,
  `Segundo_Apellido` varchar(255) DEFAULT NULL,
  `Curp` varchar(18) DEFAULT NULL,
  `Genero` enum('Masculino','Femenino','Otro') DEFAULT NULL,
  `Tipo_Sangre` enum('AP','AN','BP','BN','ABP','ABN','OP','ON') DEFAULT NULL,
  `Fecha_Nacimiento` datetime DEFAULT NULL,
  `Fotografia` varchar(255) DEFAULT NULL,
  `Telefono` varchar(20) DEFAULT NULL,
  `Correo_Electronico` varchar(255) DEFAULT NULL,
  `Estatus` tinyint(1) DEFAULT NULL,
  `Fecha_Registro` datetime DEFAULT NULL,
  `Fecha_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ix_tbb_personas_ID` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbb_personas`
--

LOCK TABLES `tbb_personas` WRITE;
/*!40000 ALTER TABLE `tbb_personas` DISABLE KEYS */;
INSERT INTO `tbb_personas` VALUES (1,'Sr.','Carlos','González','Martínez','GOMC850715HDFRRR04','Masculino','OP','1985-07-15 00:00:00','carlos_gonzalez.jpg','5551234567','carlos.gonzalez@example.com',1,'2024-08-22 20:46:50','2024-08-22 20:46:50'),(2,'Sr.','Ana','Morales','Castro','MOCN890212MDFRLS01','Femenino','AN','1989-02-12 00:00:00','ana_morales.jpg','5551234501','ana.morales@example.com',1,'2024-08-22 22:13:17','2024-08-22 22:13:17'),(3,'Sra.','Luis','Pérez','Rivas','PERL791215HDFRVS02','Masculino','OP','1979-12-15 00:00:00','luis_perez.jpg','5551234502','luis.perez@example.com',1,'2024-08-22 22:13:17','2024-08-22 22:13:17'),(4,'Dr.','Sofia','Martínez','López','MALS800103MDFLS03','Femenino','BP','1980-01-03 00:00:00','sofia_martinez.jpg','5551234599','sofia.martinez@example.com',1,'2024-08-22 22:13:17','2024-08-22 22:13:17'),(5,'string','string','string','string','string','Masculino','ABP','2024-08-23 04:21:41','string','string','string',1,'2024-08-23 04:21:41','2024-08-23 04:21:41'),(6,'string','string','string','string','string','Otro','BP','2024-08-23 04:21:41','string','string','string',1,'2024-08-23 04:21:41','2024-08-23 04:21:41'),(7,'string','string','string','string','string','Otro','ON','2024-08-23 04:21:41','string','string','string',1,'2024-08-23 04:21:41','2024-08-23 04:21:41'),(8,'string','string','string','string','string','Femenino','AN','2024-08-23 04:21:41','string','string','string',1,'2024-08-23 04:21:41','2024-08-23 04:21:41'),(9,'string','string','string','string','string','Femenino','AN','2024-08-23 04:21:41','string','string','string',1,'2024-08-23 04:21:41','2024-08-23 04:21:41'),(10,'string','string','string','string','string','Femenino','AP','2024-08-23 04:21:41','string','string','string',1,'2024-08-23 04:21:41','2024-08-23 04:21:41');
/*!40000 ALTER TABLE `tbb_personas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbb_usuarios`
--

DROP TABLE IF EXISTS `tbb_usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbb_usuarios` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Persona_ID` int DEFAULT NULL,
  `Nombre_Usuario` varchar(60) DEFAULT NULL,
  `Correo_Electronico` varchar(100) DEFAULT NULL,
  `Contrasena` varchar(40) DEFAULT NULL,
  `Numero_Telefonico_Movil` varchar(20) DEFAULT NULL,
  `Estatus` enum('Activo','Inactivo','Bloqueado','Suspendido') DEFAULT NULL,
  `Fecha_Registro` datetime DEFAULT NULL,
  `Fecha_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `Persona_ID` (`Persona_ID`),
  KEY `ix_tbb_usuarios_ID` (`ID`),
  CONSTRAINT `tbb_usuarios_ibfk_1` FOREIGN KEY (`Persona_ID`) REFERENCES `tbb_personas` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbb_usuarios`
--

LOCK TABLES `tbb_usuarios` WRITE;
/*!40000 ALTER TABLE `tbb_usuarios` DISABLE KEYS */;
INSERT INTO `tbb_usuarios` VALUES (1,1,'jose','string','123','string','Activo','2024-08-23 03:55:31','2024-08-23 03:55:31');
/*!40000 ALTER TABLE `tbb_usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbc_roles`
--

DROP TABLE IF EXISTS `tbc_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbc_roles` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `estatus` tinyint(1) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `fecha_actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ix_tbc_roles_ID` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbc_roles`
--

LOCK TABLES `tbc_roles` WRITE;
/*!40000 ALTER TABLE `tbc_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbc_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbd_recetamedica`
--

DROP TABLE IF EXISTS `tbd_recetamedica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbd_recetamedica` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `Nombre` varchar(255) NOT NULL,
  `Fecha_Nacimiento` datetime NOT NULL,
  `Peso` varchar(20) NOT NULL,
  `Talla` varchar(20) NOT NULL,
  `Edad` varchar(20) NOT NULL,
  `Presion_arterial` varchar(20) NOT NULL,
  `Diagnostico` varchar(255) NOT NULL,
  `Prescripcion_Medica` varchar(255) NOT NULL,
  `Fecha_Registro` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Fecha_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `ix_tbd_recetaMedica_ID` (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbd_recetamedica`
--

LOCK TABLES `tbd_recetamedica` WRITE;
/*!40000 ALTER TABLE `tbd_recetamedica` DISABLE KEYS */;
INSERT INTO `tbd_recetamedica` VALUES (1,'Juan Perez','1985-06-15 00:00:00','75kg','1.75m','39 años','120/80','Hipertensión leve','Tomar 1 pastilla de Losartan 50mg diariamente','2024-08-22 20:27:10',NULL);
/*!40000 ALTER TABLE `tbd_recetamedica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tbd_usuarios_roles`
--

DROP TABLE IF EXISTS `tbd_usuarios_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tbd_usuarios_roles` (
  `Usuario_ID` int NOT NULL,
  `Rol_ID` int NOT NULL,
  `Estatus` tinyint(1) DEFAULT NULL,
  `Fecha_Registro` datetime DEFAULT NULL,
  `Fecha_Actualizacion` datetime DEFAULT NULL,
  PRIMARY KEY (`Usuario_ID`,`Rol_ID`),
  KEY `Rol_ID` (`Rol_ID`),
  CONSTRAINT `tbd_usuarios_roles_ibfk_1` FOREIGN KEY (`Usuario_ID`) REFERENCES `tbb_usuarios` (`ID`),
  CONSTRAINT `tbd_usuarios_roles_ibfk_2` FOREIGN KEY (`Rol_ID`) REFERENCES `tbc_roles` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tbd_usuarios_roles`
--

LOCK TABLES `tbd_usuarios_roles` WRITE;
/*!40000 ALTER TABLE `tbd_usuarios_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `tbd_usuarios_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'test'
--

--
-- Dumping routines for database 'test'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-08-22 22:25:50
