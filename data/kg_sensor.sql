-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               8.0.21 - MySQL Community Server - GPL
-- Server OS:                    Win64
-- HeidiSQL Version:             11.0.0.6037
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for sensor_situation
DROP DATABASE IF EXISTS `sensor_situation`;
CREATE DATABASE IF NOT EXISTS `sensor_situation` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `sensor_situation`;

-- Dumping structure for table sensor_situation.metadata
DROP TABLE IF EXISTS `metadata`;
CREATE TABLE IF NOT EXISTS `metadata` (
  `id` int NOT NULL,
  `metadata_info` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '采集数据',
  `metadata_time` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '采集时间',
  `metadata_predic_info` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '预测数据',
  `metadata_sensor_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '传感器名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='元数据';

-- Dumping data for table sensor_situation.metadata: ~2 rows (approximately)
DELETE FROM `metadata`;
/*!40000 ALTER TABLE `metadata` DISABLE KEYS */;
INSERT INTO `metadata` (`id`, `metadata_info`, `metadata_time`, `metadata_predic_info`, `metadata_sensor_name`) VALUES
	(1, '{data:23}', '2020-09-10 17:58:01', '{predict: 1}', 'temperature'),
	(2, '{data:24}', '2020-09-10 18:00:04', '{predict: 0}', 'temperature');
/*!40000 ALTER TABLE `metadata` ENABLE KEYS */;

-- Dumping structure for table sensor_situation.metadata_to_predict_model
DROP TABLE IF EXISTS `metadata_to_predict_model`;
CREATE TABLE IF NOT EXISTS `metadata_to_predict_model` (
  `id` int NOT NULL,
  `metadata_id` int NOT NULL,
  `predict_model_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `metadata_id` (`metadata_id`,`predict_model_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table sensor_situation.metadata_to_predict_model: ~2 rows (approximately)
DELETE FROM `metadata_to_predict_model`;
/*!40000 ALTER TABLE `metadata_to_predict_model` DISABLE KEYS */;
INSERT INTO `metadata_to_predict_model` (`id`, `metadata_id`, `predict_model_id`) VALUES
	(1, 1, 1),
	(2, 2, 1);
/*!40000 ALTER TABLE `metadata_to_predict_model` ENABLE KEYS */;

-- Dumping structure for table sensor_situation.metadata_to_situation
DROP TABLE IF EXISTS `metadata_to_situation`;
CREATE TABLE IF NOT EXISTS `metadata_to_situation` (
  `id` int NOT NULL,
  `metadata_id` int NOT NULL,
  `situation_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `metadata_id` (`metadata_id`),
  KEY `situation_id` (`situation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Dumping data for table sensor_situation.metadata_to_situation: ~0 rows (approximately)
DELETE FROM `metadata_to_situation`;
/*!40000 ALTER TABLE `metadata_to_situation` DISABLE KEYS */;
INSERT INTO `metadata_to_situation` (`id`, `metadata_id`, `situation_id`) VALUES
	(1, 1, 1);
/*!40000 ALTER TABLE `metadata_to_situation` ENABLE KEYS */;

-- Dumping structure for table sensor_situation.predict_model
DROP TABLE IF EXISTS `predict_model`;
CREATE TABLE IF NOT EXISTS `predict_model` (
  `id` int NOT NULL,
  `predict_model_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '预测模型类型',
  `predict_model_file` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT '' COMMENT '预测模型文件',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='预测模型';

-- Dumping data for table sensor_situation.predict_model: ~2 rows (approximately)
DELETE FROM `predict_model`;
/*!40000 ALTER TABLE `predict_model` DISABLE KEYS */;
INSERT INTO `predict_model` (`id`, `predict_model_type`, `predict_model_file`) VALUES
	(1, 'has_person', './has_person.model'),
	(2, 'has_fire', './has_fire.model');
/*!40000 ALTER TABLE `predict_model` ENABLE KEYS */;

-- Dumping structure for table sensor_situation.situation
DROP TABLE IF EXISTS `situation`;
CREATE TABLE IF NOT EXISTS `situation` (
  `id` int NOT NULL,
  `situation_name` varchar(255) DEFAULT '' COMMENT '情境名称',
  `situation_content` varchar(255) DEFAULT '' COMMENT '情境描述',
  `situation_operation` varchar(255) DEFAULT '' COMMENT '情境操作',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='情境';

-- Dumping data for table sensor_situation.situation: ~2 rows (approximately)
DELETE FROM `situation`;
/*!40000 ALTER TABLE `situation` DISABLE KEYS */;
INSERT INTO `situation` (`id`, `situation_name`, `situation_content`, `situation_operation`) VALUES
	(1, '人体存在', '有人体走过来', 'has_person_action'),
	(2, '火灾发生', '有火灾发生', 'has_fire_action');
/*!40000 ALTER TABLE `situation` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
