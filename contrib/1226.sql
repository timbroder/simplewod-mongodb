-- MySQL dump 10.13  Distrib 5.1.41, for Win32 (ia32)
--
-- Host: localhost    Database: logger
-- ------------------------------------------------------
-- Server version	5.1.41

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `permission_id_refs_id_5886d21f` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_message`
--

DROP TABLE IF EXISTS `auth_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `auth_message_user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_message`
--

LOCK TABLES `auth_message` WRITE;
/*!40000 ALTER TABLE `auth_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_content_type_id` (`content_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add permission',1,'add_permission'),(2,'Can change permission',1,'change_permission'),(3,'Can delete permission',1,'delete_permission'),(4,'Can add group',2,'add_group'),(5,'Can change group',2,'change_group'),(6,'Can delete group',2,'delete_group'),(7,'Can add user',3,'add_user'),(8,'Can change user',3,'change_user'),(9,'Can delete user',3,'delete_user'),(10,'Can add message',4,'add_message'),(11,'Can change message',4,'change_message'),(12,'Can delete message',4,'delete_message'),(13,'Can add content type',5,'add_contenttype'),(14,'Can change content type',5,'change_contenttype'),(15,'Can delete content type',5,'delete_contenttype'),(16,'Can add session',6,'add_session'),(17,'Can change session',6,'change_session'),(18,'Can delete session',6,'delete_session'),(19,'Can add site',7,'add_site'),(20,'Can change site',7,'change_site'),(21,'Can delete site',7,'delete_site'),(22,'Can add log entry',8,'add_logentry'),(23,'Can change log entry',8,'change_logentry'),(24,'Can delete log entry',8,'delete_logentry'),(25,'Can add workout',9,'add_workout'),(26,'Can change workout',9,'change_workout'),(27,'Can delete workout',9,'delete_workout'),(28,'Can add result',10,'add_result'),(29,'Can change result',10,'change_result'),(30,'Can delete result',10,'delete_result'),(31,'Can add tag',11,'add_tag'),(32,'Can change tag',11,'change_tag'),(33,'Can delete tag',11,'delete_tag'),(34,'Can add tagged item',12,'add_taggeditem'),(35,'Can change tagged item',12,'change_taggeditem'),(36,'Can delete tagged item',12,'delete_taggeditem'),(37,'Can add version',13,'add_version'),(38,'Can change version',13,'change_version'),(39,'Can delete version',13,'delete_version'),(40,'Can add evolution',14,'add_evolution'),(41,'Can change evolution',14,'change_evolution'),(42,'Can delete evolution',14,'delete_evolution'),(43,'Can add registration profile',15,'add_registrationprofile'),(44,'Can change registration profile',15,'change_registrationprofile'),(45,'Can delete registration profile',15,'delete_registrationprofile');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `password` varchar(128) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `last_login` datetime NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'tim','','','timothy.broder@gmail.com','sha1$36834$723ecae6590183b235843dd78788ebfa33e4775f',1,1,1,'2010-11-24 18:22:52','2010-06-17 09:30:30');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `group_id_refs_id_f116770` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `permission_id_refs_id_67e79cb` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_user_id` (`user_id`),
  KEY `django_admin_log_content_type_id` (`content_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2010-07-19 10:16:53',1,10,'16','Monday, July 19, 2010 - tim - 2010-07-19',2,'Changed result.'),(2,'2010-07-21 09:56:01',1,10,'19','Fran - tim - 2010-07-21',1,''),(3,'2010-11-25 12:29:31',1,11,'49','-back-squat',3,''),(4,'2010-11-25 12:30:46',1,11,'13','-burpees',3,''),(5,'2010-11-25 12:32:11',1,11,'27','-Deadlift',3,''),(6,'2010-11-25 12:33:24',1,11,'7','-double-unders',3,''),(7,'2010-11-25 12:34:43',1,11,'34','-front-squat',3,''),(8,'2010-11-25 12:36:42',1,11,'36','-GHD-Situp',3,''),(9,'2010-11-25 12:38:00',1,11,'28','-Press',3,''),(10,'2010-11-25 12:39:21',1,11,'11','-Push-Press',3,''),(11,'2010-11-25 12:40:05',1,11,'41','-running',3,'');
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'permission','auth','permission'),(2,'group','auth','group'),(3,'user','auth','user'),(4,'message','auth','message'),(5,'content type','contenttypes','contenttype'),(6,'session','sessions','session'),(7,'site','sites','site'),(8,'log entry','admin','logentry'),(9,'workout','workouts','workout'),(10,'result','workouts','result'),(11,'tag','tagging','tag'),(12,'tagged item','tagging','taggeditem'),(13,'version','django_evolution','version'),(14,'evolution','django_evolution','evolution'),(15,'registration profile','registration','registrationprofile');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_evolution`
--

DROP TABLE IF EXISTS `django_evolution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_evolution` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version_id` int(11) NOT NULL,
  `app_label` varchar(200) NOT NULL,
  `label` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_evolution_version_id` (`version_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_evolution`
--

LOCK TABLES `django_evolution` WRITE;
/*!40000 ALTER TABLE `django_evolution` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_evolution` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_project_version`
--

DROP TABLE IF EXISTS `django_project_version`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_project_version` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `signature` longtext NOT NULL,
  `when` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_project_version`
--

LOCK TABLES `django_project_version` WRITE;
/*!40000 ALTER TABLE `django_project_version` DISABLE KEYS */;
INSERT INTO `django_project_version` VALUES (1,'(dp1\nS\'sessions\'\np2\nccopy_reg\n_reconstructor\np3\n(cdjango.utils.datastructures\nSortedDict\np4\nc__builtin__\ndict\np5\n(dp6\nS\'Session\'\np7\n(dp8\nS\'fields\'\np9\n(dp10\nS\'session_key\'\np11\n(dp12\nS\'field_type\'\np13\ncdjango.db.models.fields\nCharField\np14\nsS\'max_length\'\np15\nI40\nsS\'primary_key\'\np16\nI01\nssS\'expire_date\'\np17\n(dp18\ng13\ncdjango.db.models.fields\nDateTimeField\np19\nssS\'session_data\'\np20\n(dp21\ng13\ncdjango.db.models.fields\nTextField\np22\nsssS\'meta\'\np23\n(dp24\nS\'unique_together\'\np25\n(lp26\nsS\'db_table\'\np27\nS\'django_session\'\np28\nsS\'db_tablespace\'\np29\nS\'\'\nsS\'pk_column\'\np30\ng11\nssstRp31\n(dp32\nS\'keyOrder\'\np33\n(lp34\ng7\nasbsS\'admin\'\np35\ng3\n(g4\ng5\n(dp36\nS\'LogEntry\'\np37\n(dp38\ng9\n(dp39\nS\'action_flag\'\np40\n(dp41\ng13\ncdjango.db.models.fields\nPositiveSmallIntegerField\np42\nssS\'action_time\'\np43\n(dp44\ng13\ng19\nssS\'object_repr\'\np45\n(dp46\ng13\ng14\nsg15\nI200\nssS\'object_id\'\np47\n(dp48\ng13\ng22\nsS\'null\'\np49\nI01\nssS\'change_message\'\np50\n(dp51\ng13\ng22\nssS\'user\'\np52\n(dp53\ng13\ncdjango.db.models.fields.related\nForeignKey\np54\nsS\'related_model\'\np55\nS\'auth.User\'\np56\nssS\'content_type\'\np57\n(dp58\ng13\ng54\nsg49\nI01\nsg55\nS\'contenttypes.ContentType\'\np59\nssS\'id\'\np60\n(dp61\ng13\ncdjango.db.models.fields\nAutoField\np62\nsg16\nI01\nsssg23\n(dp63\ng25\n(lp64\nsg27\nS\'django_admin_log\'\np65\nsg29\nS\'\'\nsg30\ng60\nssstRp66\n(dp67\ng33\n(lp68\ng37\nasbsS\'registration\'\np69\ng3\n(g4\ng5\n(dp70\nS\'RegistrationProfile\'\np71\n(dp72\ng9\n(dp73\nS\'activation_key\'\np74\n(dp75\ng13\ng14\nsg15\nI40\nssg60\n(dp76\ng13\ng62\nsg16\nI01\nssg52\n(dp77\ng13\ng54\nsS\'unique\'\np78\nI01\nsg55\nS\'auth.User\'\np79\nsssg23\n(dp80\ng25\n(lp81\nsg27\nS\'registration_registrationprofile\'\np82\nsg29\nS\'\'\nsg30\ng60\nssstRp83\n(dp84\ng33\n(lp85\ng71\nasbsS\'sites\'\np86\ng3\n(g4\ng5\n(dp87\nS\'Site\'\np88\n(dp89\ng9\n(dp90\nS\'domain\'\np91\n(dp92\ng13\ng14\nsg15\nI100\nssg60\n(dp93\ng13\ng62\nsg16\nI01\nssS\'name\'\np94\n(dp95\ng13\ng14\nsg15\nI50\nsssg23\n(dp96\ng25\n(lp97\nsg27\nS\'django_site\'\np98\nsg29\nS\'\'\nsg30\ng60\nssstRp99\n(dp100\ng33\n(lp101\ng88\nasbsS\'auth\'\np102\ng3\n(g4\ng5\n(dp103\nS\'Message\'\np104\n(dp105\ng9\n(dp106\nS\'message\'\np107\n(dp108\ng13\ng22\nssg60\n(dp109\ng13\ng62\nsg16\nI01\nssg52\n(dp110\ng13\ng54\nsg55\nS\'auth.User\'\np111\nsssg23\n(dp112\ng25\n(lp113\nsg27\nS\'auth_message\'\np114\nsg29\nS\'\'\nsg30\ng60\nsssS\'Group\'\np115\n(dp116\ng9\n(dp117\nS\'permissions\'\np118\n(dp119\ng13\ncdjango.db.models.fields.related\nManyToManyField\np120\nsg55\nS\'auth.Permission\'\np121\nssg60\n(dp122\ng13\ng62\nsg16\nI01\nssg94\n(dp123\ng13\ng14\nsg78\nI01\nsg15\nI80\nsssg23\n(dp124\ng25\n(lp125\nsg27\nS\'auth_group\'\np126\nsg29\nS\'\'\nsg30\ng60\nsssS\'User\'\np127\n(dp128\ng9\n(dp129\nS\'username\'\np130\n(dp131\ng13\ng14\nsg78\nI01\nsg15\nI30\nssS\'first_name\'\np132\n(dp133\ng13\ng14\nsg15\nI30\nssS\'last_name\'\np134\n(dp135\ng13\ng14\nsg15\nI30\nssS\'is_active\'\np136\n(dp137\ng13\ncdjango.db.models.fields\nBooleanField\np138\nssS\'email\'\np139\n(dp140\ng13\ncdjango.db.models.fields\nEmailField\np141\nsg15\nI75\nssS\'is_superuser\'\np142\n(dp143\ng13\ng138\nssS\'is_staff\'\np144\n(dp145\ng13\ng138\nssS\'last_login\'\np146\n(dp147\ng13\ng19\nssS\'groups\'\np148\n(dp149\ng13\ng120\nsg55\nS\'auth.Group\'\np150\nssS\'user_permissions\'\np151\n(dp152\ng13\ng120\nsg55\nS\'auth.Permission\'\np153\nssS\'password\'\np154\n(dp155\ng13\ng14\nsg15\nI128\nssg60\n(dp156\ng13\ng62\nsg16\nI01\nssS\'date_joined\'\np157\n(dp158\ng13\ng19\nsssg23\n(dp159\ng25\n(lp160\nsg27\nS\'auth_user\'\np161\nsg29\nS\'\'\nsg30\ng60\nsssS\'Permission\'\np162\n(dp163\ng9\n(dp164\nS\'codename\'\np165\n(dp166\ng13\ng14\nsg15\nI100\nssg60\n(dp167\ng13\ng62\nsg16\nI01\nssg57\n(dp168\ng13\ng54\nsg55\nS\'contenttypes.ContentType\'\np169\nssg94\n(dp170\ng13\ng14\nsg15\nI50\nsssg23\n(dp171\ng25\n((S\'content_type\'\nS\'codename\'\nttp172\nsg27\nS\'auth_permission\'\np173\nsg29\nS\'\'\nsg30\ng60\nssstRp174\n(dp175\ng33\n(lp176\ng162\nag115\nag127\nag104\nasbsS\'sluggable\'\np177\ng3\n(g4\ng5\n(dtRp178\n(dp179\ng33\n(lp180\nsbsS\'contenttypes\'\np181\ng3\n(g4\ng5\n(dp182\nS\'ContentType\'\np183\n(dp184\ng9\n(dp185\nS\'model\'\np186\n(dp187\ng13\ng14\nsg15\nI100\nssS\'app_label\'\np188\n(dp189\ng13\ng14\nsg15\nI100\nssg60\n(dp190\ng13\ng62\nsg16\nI01\nssg94\n(dp191\ng13\ng14\nsg15\nI100\nsssg23\n(dp192\ng25\n((S\'app_label\'\nS\'model\'\nttp193\nsg27\nS\'django_content_type\'\np194\nsg29\nS\'\'\nsg30\ng60\nssstRp195\n(dp196\ng33\n(lp197\ng183\nasbsS\'django_evolution\'\np198\ng3\n(g4\ng5\n(dp199\nS\'Evolution\'\np200\n(dp201\ng9\n(dp202\nS\'label\'\np203\n(dp204\ng13\ng14\nsg15\nI100\nssS\'version\'\np205\n(dp206\ng13\ng54\nsg55\nS\'django_evolution.Version\'\np207\nssg60\n(dp208\ng13\ng62\nsg16\nI01\nssg188\n(dp209\ng13\ng14\nsg15\nI200\nsssg23\n(dp210\ng25\n(lp211\nsg27\nS\'django_evolution\'\np212\nsg29\nS\'\'\nsg30\ng60\nsssS\'Version\'\np213\n(dp214\ng9\n(dp215\nS\'when\'\np216\n(dp217\ng13\ng19\nssg60\n(dp218\ng13\ng62\nsg16\nI01\nssS\'signature\'\np219\n(dp220\ng13\ng22\nsssg23\n(dp221\ng25\n(lp222\nsg27\nS\'django_project_version\'\np223\nsg29\nS\'\'\nsg30\ng60\nssstRp224\n(dp225\ng33\n(lp226\ng213\nag200\nasbsS\'__version__\'\np227\nI1\nsS\'workouts\'\np228\ng3\n(g4\ng5\n(dp229\nS\'Workout\'\np230\n(dp231\ng9\n(dp232\ng52\n(dp233\ng13\ng54\nsg55\nS\'auth.User\'\np234\nssS\'workout\'\np235\n(dp236\ng13\ng22\nssS\'title\'\np237\n(dp238\ng15\nI128\nsg13\ng14\nsg49\nI01\nssg60\n(dp239\ng13\ng62\nsg16\nI01\nssS\'slug\'\np240\n(dp241\ng13\ncdjango.db.models.fields\nSlugField\np242\nsg15\nI50\nsS\'db_index\'\np243\nI01\nsssg23\n(dp244\ng25\n(lp245\nsg27\nS\'workouts_workout\'\np246\nsg29\nS\'\'\nsg30\ng60\nsssS\'Result\'\np247\n(dp248\ng9\n(dp249\ng52\n(dp250\ng13\ng54\nsg55\nS\'auth.User\'\np251\nssS\'tags\'\np252\n(dp253\ng13\ng14\nsg15\nI255\nssS\'notes\'\np254\n(dp255\ng13\ng22\nsg49\nI01\nssg235\n(dp256\ng13\ng54\nsg55\nS\'workouts.Workout\'\np257\nssS\'dateslug\'\np258\n(dp259\ng15\nI16\nsg13\ng14\nsg49\nI01\nssS\'date\'\np260\n(dp261\ng13\ncdjango.db.models.fields\nDateField\np262\nssg60\n(dp263\ng13\ng62\nsg16\nI01\nssS\'result\'\np264\n(dp265\ng13\ng22\nsssg23\n(dp266\ng25\n(lp267\nsg27\nS\'workouts_result\'\np268\nsg29\nS\'\'\nsg30\ng60\nssstRp269\n(dp270\ng33\n(lp271\ng230\nag247\nasbsS\'tagging\'\np272\ng3\n(g4\ng5\n(dp273\nS\'Tag\'\np274\n(dp275\ng9\n(dp276\ng60\n(dp277\ng13\ng62\nsg16\nI01\nssg94\n(dp278\ng13\ng14\nsg78\nI01\nsg15\nI50\nsg243\nI01\nsssg23\n(dp279\ng25\n(lp280\nsg27\nS\'tagging_tag\'\np281\nsg29\nS\'\'\nsg30\ng60\nsssS\'TaggedItem\'\np282\n(dp283\ng9\n(dp284\nS\'tag\'\np285\n(dp286\ng13\ng54\nsg55\nS\'tagging.Tag\'\np287\nssg60\n(dp288\ng13\ng62\nsg16\nI01\nssg57\n(dp289\ng13\ng54\nsg55\nS\'contenttypes.ContentType\'\np290\nssg47\n(dp291\ng13\ncdjango.db.models.fields\nPositiveIntegerField\np292\nsg243\nI01\nsssg23\n(dp293\ng25\n((S\'tag\'\nS\'content_type\'\nS\'object_id\'\nttp294\nsg27\nS\'tagging_taggeditem\'\np295\nsg29\nS\'\'\nsg30\ng60\nssstRp296\n(dp297\ng33\n(lp298\ng274\nag282\nasbs.','2010-06-17 09:30:30'),(2,'(dp1\nS\'sessions\'\np2\nccopy_reg\n_reconstructor\np3\n(cdjango.utils.datastructures\nSortedDict\np4\nc__builtin__\ndict\np5\n(dp6\nS\'Session\'\np7\n(dp8\nS\'fields\'\np9\n(dp10\nS\'session_key\'\np11\n(dp12\nS\'field_type\'\np13\ncdjango.db.models.fields\nCharField\np14\nsS\'max_length\'\np15\nI40\nsS\'primary_key\'\np16\nI01\nssS\'session_data\'\np17\n(dp18\ng13\ncdjango.db.models.fields\nTextField\np19\nssS\'expire_date\'\np20\n(dp21\ng13\ncdjango.db.models.fields\nDateTimeField\np22\nsssS\'meta\'\np23\n(dp24\nS\'unique_together\'\np25\n(lp26\nsS\'db_table\'\np27\nS\'django_session\'\np28\nsS\'db_tablespace\'\np29\nS\'\'\nsS\'pk_column\'\np30\ng11\nssstRp31\n(dp32\nS\'keyOrder\'\np33\n(lp34\ng7\nasbsS\'admin\'\np35\ng3\n(g4\ng5\n(dp36\nS\'LogEntry\'\np37\n(dp38\ng9\n(dp39\nS\'action_flag\'\np40\n(dp41\ng13\ncdjango.db.models.fields\nPositiveSmallIntegerField\np42\nssS\'action_time\'\np43\n(dp44\ng13\ng22\nssS\'object_repr\'\np45\n(dp46\ng13\ng14\nsg15\nI200\nssS\'object_id\'\np47\n(dp48\ng13\ng19\nsS\'null\'\np49\nI01\nssS\'change_message\'\np50\n(dp51\ng13\ng19\nssS\'user\'\np52\n(dp53\ng13\ncdjango.db.models.fields.related\nForeignKey\np54\nsS\'related_model\'\np55\nS\'auth.User\'\np56\nssS\'content_type\'\np57\n(dp58\ng13\ng54\nsg49\nI01\nsg55\nS\'contenttypes.ContentType\'\np59\nssS\'id\'\np60\n(dp61\ng13\ncdjango.db.models.fields\nAutoField\np62\nsg16\nI01\nsssg23\n(dp63\ng25\n(lp64\nsg27\nS\'django_admin_log\'\np65\nsg29\nS\'\'\nsg30\ng60\nssstRp66\n(dp67\ng33\n(lp68\ng37\nasbsS\'django_evolution\'\np69\ng3\n(g4\ng5\n(dp70\nS\'Evolution\'\np71\n(dp72\ng9\n(dp73\nS\'app_label\'\np74\n(dp75\ng13\ng14\nsg15\nI200\nssS\'version\'\np76\n(dp77\ng13\ng54\nsg55\nS\'django_evolution.Version\'\np78\nssg60\n(dp79\ng13\ng62\nsg16\nI01\nssS\'label\'\np80\n(dp81\ng13\ng14\nsg15\nI100\nsssg23\n(dp82\ng25\n(lp83\nsg27\nS\'django_evolution\'\np84\nsg29\nS\'\'\nsg30\ng60\nsssS\'Version\'\np85\n(dp86\ng9\n(dp87\nS\'when\'\np88\n(dp89\ng13\ng22\nssg60\n(dp90\ng13\ng62\nsg16\nI01\nssS\'signature\'\np91\n(dp92\ng13\ng19\nsssg23\n(dp93\ng25\n(lp94\nsg27\nS\'django_project_version\'\np95\nsg29\nS\'\'\nsg30\ng60\nssstRp96\n(dp97\ng33\n(lp98\ng85\nag71\nasbsS\'tagging_autocomplete\'\np99\ng3\n(g4\ng5\n(dtRp100\n(dp101\nS\'keyOrder\'\np102\n(lp103\nsbsS\'sluggable\'\np104\ng3\n(g4\ng5\n(dtRp105\n(dp106\ng33\n(lp107\nsbsS\'auth\'\np108\ng3\n(g4\ng5\n(dp109\nS\'Message\'\np110\n(dp111\ng9\n(dp112\nS\'message\'\np113\n(dp114\ng13\ng19\nssg60\n(dp115\ng13\ng62\nsg16\nI01\nssg52\n(dp116\ng13\ng54\nsg55\nS\'auth.User\'\np117\nsssg23\n(dp118\ng25\n(lp119\nsg27\nS\'auth_message\'\np120\nsg29\nS\'\'\nsg30\ng60\nsssS\'Group\'\np121\n(dp122\ng9\n(dp123\ng60\n(dp124\ng13\ng62\nsg16\nI01\nssS\'name\'\np125\n(dp126\ng15\nI80\nsg13\ng14\nsS\'unique\'\np127\nI01\nssS\'permissions\'\np128\n(dp129\ng13\ncdjango.db.models.fields.related\nManyToManyField\np130\nsg55\nS\'auth.Permission\'\np131\nsssg23\n(dp132\ng25\n(lp133\nsg27\nS\'auth_group\'\np134\nsg29\nS\'\'\nsg30\ng60\nsssS\'User\'\np135\n(dp136\ng9\n(dp137\nS\'username\'\np138\n(dp139\ng15\nI30\nsg13\ng14\nsg127\nI01\nssS\'first_name\'\np140\n(dp141\ng13\ng14\nsg15\nI30\nssS\'last_name\'\np142\n(dp143\ng13\ng14\nsg15\nI30\nssS\'is_active\'\np144\n(dp145\ng13\ncdjango.db.models.fields\nBooleanField\np146\nssg60\n(dp147\ng13\ng62\nsg16\nI01\nssS\'is_superuser\'\np148\n(dp149\ng13\ng146\nssS\'is_staff\'\np150\n(dp151\ng13\ng146\nssS\'last_login\'\np152\n(dp153\ng13\ng22\nssS\'groups\'\np154\n(dp155\ng13\ng130\nsg55\nS\'auth.Group\'\np156\nssS\'user_permissions\'\np157\n(dp158\ng13\ng130\nsg55\nS\'auth.Permission\'\np159\nssS\'password\'\np160\n(dp161\ng13\ng14\nsg15\nI128\nssS\'email\'\np162\n(dp163\ng13\ncdjango.db.models.fields\nEmailField\np164\nsg15\nI75\nssS\'date_joined\'\np165\n(dp166\ng13\ng22\nsssg23\n(dp167\ng25\n(lp168\nsg27\nS\'auth_user\'\np169\nsg29\nS\'\'\nsg30\ng60\nsssS\'Permission\'\np170\n(dp171\ng9\n(dp172\nS\'codename\'\np173\n(dp174\ng13\ng14\nsg15\nI100\nssg60\n(dp175\ng13\ng62\nsg16\nI01\nssg57\n(dp176\ng13\ng54\nsg55\nS\'contenttypes.ContentType\'\np177\nssg125\n(dp178\ng13\ng14\nsg15\nI50\nsssg23\n(dp179\ng25\n((S\'content_type\'\nS\'codename\'\nttp180\nsg27\nS\'auth_permission\'\np181\nsg29\nS\'\'\nsg30\ng60\nssstRp182\n(dp183\ng33\n(lp184\ng170\nag121\nag135\nag110\nasbsS\'sites\'\np185\ng3\n(g4\ng5\n(dp186\nS\'Site\'\np187\n(dp188\ng9\n(dp189\nS\'domain\'\np190\n(dp191\ng13\ng14\nsg15\nI100\nssg60\n(dp192\ng13\ng62\nsg16\nI01\nssg125\n(dp193\ng13\ng14\nsg15\nI50\nsssg23\n(dp194\ng25\n(lp195\nsg27\nS\'django_site\'\np196\nsg29\nS\'\'\nsg30\ng60\nssstRp197\n(dp198\ng33\n(lp199\ng187\nasbsS\'contenttypes\'\np200\ng3\n(g4\ng5\n(dp201\nS\'ContentType\'\np202\n(dp203\ng9\n(dp204\nS\'model\'\np205\n(dp206\ng13\ng14\nsg15\nI100\nssg60\n(dp207\ng13\ng62\nsg16\nI01\nssg125\n(dp208\ng13\ng14\nsg15\nI100\nssg74\n(dp209\ng13\ng14\nsg15\nI100\nsssg23\n(dp210\ng25\n((S\'app_label\'\nS\'model\'\nttp211\nsg27\nS\'django_content_type\'\np212\nsg29\nS\'\'\nsg30\ng60\nssstRp213\n(dp214\ng33\n(lp215\ng202\nasbsS\'registration\'\np216\ng3\n(g4\ng5\n(dp217\nS\'RegistrationProfile\'\np218\n(dp219\ng9\n(dp220\nS\'activation_key\'\np221\n(dp222\ng13\ng14\nsg15\nI40\nssg60\n(dp223\ng13\ng62\nsg16\nI01\nssg52\n(dp224\ng13\ng54\nsg127\nI01\nsg55\nS\'auth.User\'\np225\nsssg23\n(dp226\ng25\n(lp227\nsg27\nS\'registration_registrationprofile\'\np228\nsg29\nS\'\'\nsg30\ng60\nssstRp229\n(dp230\ng33\n(lp231\ng218\nasbsS\'__version__\'\np232\nI1\nsS\'workouts\'\np233\ng3\n(g4\ng5\n(dp234\nS\'Workout\'\np235\n(dp236\ng9\n(dp237\ng60\n(dp238\ng13\ng62\nsg16\nI01\nssS\'workout\'\np239\n(dp240\ng13\ng19\nssg52\n(dp241\ng13\ng54\nsg55\nS\'auth.User\'\np242\nssS\'slug\'\np243\n(dp244\ng13\ncdjango.db.models.fields\nSlugField\np245\nsg15\nI50\nsS\'db_index\'\np246\nI01\nssS\'title\'\np247\n(dp248\ng13\ng14\nsg15\nI128\nsg49\nI01\nsssg23\n(dp249\ng25\n(lp250\nsg27\nS\'workouts_workout\'\np251\nsg29\nS\'\'\nsg30\ng60\nsssS\'Result\'\np252\n(dp253\ng9\n(dp254\nS\'result\'\np255\n(dp256\ng13\ng19\nssS\'tags\'\np257\n(dp258\ng13\ng14\nsg15\nI255\nssS\'notes\'\np259\n(dp260\ng13\ng19\nsg49\nI01\nssg60\n(dp261\ng13\ng62\nsg16\nI01\nssg52\n(dp262\ng13\ng54\nsg55\nS\'auth.User\'\np263\nssS\'date\'\np264\n(dp265\ng13\ncdjango.db.models.fields\nDateField\np266\nssg239\n(dp267\ng13\ng54\nsg55\nS\'workouts.Workout\'\np268\nssS\'dateslug\'\np269\n(dp270\ng13\ng14\nsg15\nI16\nsg49\nI01\nsssg23\n(dp271\ng25\n(lp272\nsg27\nS\'workouts_result\'\np273\nsg29\nS\'\'\nsg30\ng60\nssstRp274\n(dp275\ng33\n(lp276\ng235\nag252\nasbsS\'tagging\'\np277\ng3\n(g4\ng5\n(dp278\nS\'TaggedItem\'\np279\n(dp280\ng9\n(dp281\nS\'tag\'\np282\n(dp283\ng13\ng54\nsg55\nS\'tagging.Tag\'\np284\nssg60\n(dp285\ng13\ng62\nsg16\nI01\nssg57\n(dp286\ng13\ng54\nsg55\nS\'contenttypes.ContentType\'\np287\nssg47\n(dp288\ng13\ncdjango.db.models.fields\nPositiveIntegerField\np289\nsg246\nI01\nsssg23\n(dp290\ng25\n((S\'tag\'\nS\'content_type\'\nS\'object_id\'\nttp291\nsg27\nS\'tagging_taggeditem\'\np292\nsg29\nS\'\'\nsg30\ng60\nsssS\'Tag\'\np293\n(dp294\ng9\n(dp295\ng60\n(dp296\ng13\ng62\nsg16\nI01\nssg125\n(dp297\ng15\nI50\nsg13\ng14\nsg127\nI01\nsg246\nI01\nsssg23\n(dp298\ng25\n(lp299\nsg27\nS\'tagging_tag\'\np300\nsg29\nS\'\'\nsg30\ng60\nssstRp301\n(dp302\ng33\n(lp303\ng293\nag279\nasbs.','2010-11-25 20:31:33'),(3,'(dp1\nS\'sessions\'\np2\nccopy_reg\n_reconstructor\np3\n(cdjango.utils.datastructures\nSortedDict\np4\nc__builtin__\ndict\np5\n(dp6\nS\'Session\'\np7\n(dp8\nS\'fields\'\np9\n(dp10\nS\'session_key\'\np11\n(dp12\nS\'field_type\'\np13\ncdjango.db.models.fields\nCharField\np14\nsS\'max_length\'\np15\nI40\nsS\'primary_key\'\np16\nI01\nssS\'expire_date\'\np17\n(dp18\ng13\ncdjango.db.models.fields\nDateTimeField\np19\nssS\'session_data\'\np20\n(dp21\ng13\ncdjango.db.models.fields\nTextField\np22\nsssS\'meta\'\np23\n(dp24\nS\'unique_together\'\np25\n(lp26\nsS\'db_table\'\np27\nS\'django_session\'\np28\nsS\'db_tablespace\'\np29\nS\'\'\nsS\'pk_column\'\np30\ng11\nssstRp31\n(dp32\nS\'keyOrder\'\np33\n(lp34\ng7\nasbsS\'admin\'\np35\ng3\n(g4\ng5\n(dp36\nS\'LogEntry\'\np37\n(dp38\ng9\n(dp39\nS\'action_flag\'\np40\n(dp41\ng13\ncdjango.db.models.fields\nPositiveSmallIntegerField\np42\nssS\'action_time\'\np43\n(dp44\ng13\ng19\nssS\'object_repr\'\np45\n(dp46\ng13\ng14\nsg15\nI200\nssS\'object_id\'\np47\n(dp48\ng13\ng22\nsS\'null\'\np49\nI01\nssS\'change_message\'\np50\n(dp51\ng13\ng22\nssS\'user\'\np52\n(dp53\ng13\ncdjango.db.models.fields.related\nForeignKey\np54\nsS\'related_model\'\np55\nS\'auth.User\'\np56\nssS\'content_type\'\np57\n(dp58\ng13\ng54\nsg49\nI01\nsg55\nS\'contenttypes.ContentType\'\np59\nssS\'id\'\np60\n(dp61\ng13\ncdjango.db.models.fields\nAutoField\np62\nsg16\nI01\nsssg23\n(dp63\ng25\n(lp64\nsg27\nS\'django_admin_log\'\np65\nsg29\nS\'\'\nsg30\ng60\nssstRp66\n(dp67\ng33\n(lp68\ng37\nasbsS\'registration\'\np69\ng3\n(g4\ng5\n(dp70\nS\'RegistrationProfile\'\np71\n(dp72\ng9\n(dp73\nS\'activation_key\'\np74\n(dp75\ng13\ng14\nsg15\nI40\nssg60\n(dp76\ng13\ng62\nsg16\nI01\nssg52\n(dp77\ng13\ng54\nsS\'unique\'\np78\nI01\nsg55\nS\'auth.User\'\np79\nsssg23\n(dp80\ng25\n(lp81\nsg27\nS\'registration_registrationprofile\'\np82\nsg29\nS\'\'\nsg30\ng60\nssstRp83\n(dp84\ng33\n(lp85\ng71\nasbsS\'tagging_autocomplete\'\np86\ng3\n(g4\ng5\n(dtRp87\n(dp88\ng33\n(lp89\nsbsS\'sites\'\np90\ng3\n(g4\ng5\n(dp91\nS\'Site\'\np92\n(dp93\ng9\n(dp94\nS\'domain\'\np95\n(dp96\ng13\ng14\nsg15\nI100\nssg60\n(dp97\ng13\ng62\nsg16\nI01\nssS\'name\'\np98\n(dp99\ng13\ng14\nsg15\nI50\nsssg23\n(dp100\ng25\n(lp101\nsg27\nS\'django_site\'\np102\nsg29\nS\'\'\nsg30\ng60\nssstRp103\n(dp104\ng33\n(lp105\ng92\nasbsS\'auth\'\np106\ng3\n(g4\ng5\n(dp107\nS\'Message\'\np108\n(dp109\ng9\n(dp110\nS\'message\'\np111\n(dp112\ng13\ng22\nssg60\n(dp113\ng13\ng62\nsg16\nI01\nssg52\n(dp114\ng13\ng54\nsg55\nS\'auth.User\'\np115\nsssg23\n(dp116\ng25\n(lp117\nsg27\nS\'auth_message\'\np118\nsg29\nS\'\'\nsg30\ng60\nsssS\'Group\'\np119\n(dp120\ng9\n(dp121\nS\'permissions\'\np122\n(dp123\ng13\ncdjango.db.models.fields.related\nManyToManyField\np124\nsg55\nS\'auth.Permission\'\np125\nssg60\n(dp126\ng13\ng62\nsg16\nI01\nssg98\n(dp127\ng15\nI80\nsg13\ng14\nsg78\nI01\nsssg23\n(dp128\ng25\n(lp129\nsg27\nS\'auth_group\'\np130\nsg29\nS\'\'\nsg30\ng60\nsssS\'User\'\np131\n(dp132\ng9\n(dp133\nS\'username\'\np134\n(dp135\ng15\nI30\nsg13\ng14\nsg78\nI01\nssS\'first_name\'\np136\n(dp137\ng13\ng14\nsg15\nI30\nssS\'last_name\'\np138\n(dp139\ng13\ng14\nsg15\nI30\nssS\'is_active\'\np140\n(dp141\ng13\ncdjango.db.models.fields\nBooleanField\np142\nssS\'email\'\np143\n(dp144\ng13\ncdjango.db.models.fields\nEmailField\np145\nsg15\nI75\nssS\'is_superuser\'\np146\n(dp147\ng13\ng142\nssS\'is_staff\'\np148\n(dp149\ng13\ng142\nssS\'last_login\'\np150\n(dp151\ng13\ng19\nssS\'groups\'\np152\n(dp153\ng13\ng124\nsg55\nS\'auth.Group\'\np154\nssS\'user_permissions\'\np155\n(dp156\ng13\ng124\nsg55\nS\'auth.Permission\'\np157\nssS\'password\'\np158\n(dp159\ng13\ng14\nsg15\nI128\nssg60\n(dp160\ng13\ng62\nsg16\nI01\nssS\'date_joined\'\np161\n(dp162\ng13\ng19\nsssg23\n(dp163\ng25\n(lp164\nsg27\nS\'auth_user\'\np165\nsg29\nS\'\'\nsg30\ng60\nsssS\'Permission\'\np166\n(dp167\ng9\n(dp168\nS\'codename\'\np169\n(dp170\ng13\ng14\nsg15\nI100\nssg60\n(dp171\ng13\ng62\nsg16\nI01\nssg57\n(dp172\ng13\ng54\nsg55\nS\'contenttypes.ContentType\'\np173\nssg98\n(dp174\ng13\ng14\nsg15\nI50\nsssg23\n(dp175\ng25\n((S\'content_type\'\nS\'codename\'\nttp176\nsg27\nS\'auth_permission\'\np177\nsg29\nS\'\'\nsg30\ng60\nssstRp178\n(dp179\ng33\n(lp180\ng166\nag119\nag131\nag108\nasbsS\'sluggable\'\np181\ng3\n(g4\ng5\n(dtRp182\n(dp183\ng33\n(lp184\nsbsS\'contenttypes\'\np185\ng3\n(g4\ng5\n(dp186\nS\'ContentType\'\np187\n(dp188\ng9\n(dp189\nS\'model\'\np190\n(dp191\ng13\ng14\nsg15\nI100\nssS\'app_label\'\np192\n(dp193\ng13\ng14\nsg15\nI100\nssg60\n(dp194\ng13\ng62\nsg16\nI01\nssg98\n(dp195\ng13\ng14\nsg15\nI100\nsssg23\n(dp196\ng25\n((S\'app_label\'\nS\'model\'\nttp197\nsg27\nS\'django_content_type\'\np198\nsg29\nS\'\'\nsg30\ng60\nssstRp199\n(dp200\ng33\n(lp201\ng187\nasbsS\'django_evolution\'\np202\ng3\n(g4\ng5\n(dp203\nS\'Evolution\'\np204\n(dp205\ng9\n(dp206\nS\'label\'\np207\n(dp208\ng13\ng14\nsg15\nI100\nssS\'version\'\np209\n(dp210\ng13\ng54\nsg55\nS\'django_evolution.Version\'\np211\nssg60\n(dp212\ng13\ng62\nsg16\nI01\nssg192\n(dp213\ng13\ng14\nsg15\nI200\nsssg23\n(dp214\ng25\n(lp215\nsg27\nS\'django_evolution\'\np216\nsg29\nS\'\'\nsg30\ng60\nsssS\'Version\'\np217\n(dp218\ng9\n(dp219\nS\'when\'\np220\n(dp221\ng13\ng19\nssg60\n(dp222\ng13\ng62\nsg16\nI01\nssS\'signature\'\np223\n(dp224\ng13\ng22\nsssg23\n(dp225\ng25\n(lp226\nsg27\nS\'django_project_version\'\np227\nsg29\nS\'\'\nsg30\ng60\nssstRp228\n(dp229\ng33\n(lp230\ng217\nag204\nasbsS\'__version__\'\np231\nI1\nsS\'workouts\'\np232\ng3\n(g4\ng5\n(dp233\nS\'Workout\'\np234\n(dp235\ng9\n(dp236\nS\'title\'\np237\n(dp238\ng15\nI128\nsg13\ng14\nsg49\nI01\nssS\'workout\'\np239\n(dp240\ng13\ng22\nssS\'tags\'\np241\n(dp242\ng13\ng14\nsg15\nI255\nssg60\n(dp243\ng13\ng62\nsg16\nI01\nssg52\n(dp244\ng13\ng54\nsg55\nS\'auth.User\'\np245\nssS\'slug\'\np246\n(dp247\ng13\ncdjango.db.models.fields\nSlugField\np248\nsg15\nI50\nsS\'db_index\'\np249\nI01\nsssg23\n(dp250\ng25\n(lp251\nsg27\nS\'workouts_workout\'\np252\nsg29\nS\'\'\nsg30\ng60\nsssS\'Result\'\np253\n(dp254\ng9\n(dp255\ng52\n(dp256\ng13\ng54\nsg55\nS\'auth.User\'\np257\nssg241\n(dp258\ng13\ng14\nsg15\nI255\nssS\'notes\'\np259\n(dp260\ng13\ng22\nsg49\nI01\nssg239\n(dp261\ng13\ng54\nsg55\nS\'workouts.Workout\'\np262\nssS\'dateslug\'\np263\n(dp264\ng15\nI16\nsg13\ng14\nsg49\nI01\nssS\'date\'\np265\n(dp266\ng13\ncdjango.db.models.fields\nDateField\np267\nssg60\n(dp268\ng13\ng62\nsg16\nI01\nssS\'result\'\np269\n(dp270\ng13\ng22\nsssg23\n(dp271\ng25\n(lp272\nsg27\nS\'workouts_result\'\np273\nsg29\nS\'\'\nsg30\ng60\nssstRp274\n(dp275\ng33\n(lp276\ng234\nag253\nasbsS\'tagging\'\np277\ng3\n(g4\ng5\n(dp278\nS\'Tag\'\np279\n(dp280\ng9\n(dp281\ng60\n(dp282\ng13\ng62\nsg16\nI01\nssg98\n(dp283\ng15\nI50\nsg13\ng14\nsg78\nI01\nsg249\nI01\nsssg23\n(dp284\ng25\n(lp285\nsg27\nS\'tagging_tag\'\np286\nsg29\nS\'\'\nsg30\ng60\nsssS\'TaggedItem\'\np287\n(dp288\ng9\n(dp289\nS\'tag\'\np290\n(dp291\ng13\ng54\nsg55\nS\'tagging.Tag\'\np292\nssg60\n(dp293\ng13\ng62\nsg16\nI01\nssg57\n(dp294\ng13\ng54\nsg55\nS\'contenttypes.ContentType\'\np295\nssg47\n(dp296\ng13\ncdjango.db.models.fields\nPositiveIntegerField\np297\nsg249\nI01\nsssg23\n(dp298\ng25\n((S\'tag\'\nS\'content_type\'\nS\'object_id\'\nttp299\nsg27\nS\'tagging_taggeditem\'\np300\nsg29\nS\'\'\nsg30\ng60\nssstRp301\n(dp302\ng33\n(lp303\ng279\nag287\nasbs.','2010-11-25 20:31:48'),(4,'(dp1\nS\'sessions\'\np2\nccopy_reg\n_reconstructor\np3\n(cdjango.utils.datastructures\nSortedDict\np4\nc__builtin__\ndict\np5\n(dp6\nS\'Session\'\np7\n(dp8\nS\'fields\'\np9\n(dp10\nS\'session_key\'\np11\n(dp12\nS\'field_type\'\np13\ncdjango.db.models.fields\nCharField\np14\nsS\'max_length\'\np15\nI40\nsS\'primary_key\'\np16\nI01\nssS\'expire_date\'\np17\n(dp18\ng13\ncdjango.db.models.fields\nDateTimeField\np19\nssS\'session_data\'\np20\n(dp21\ng13\ncdjango.db.models.fields\nTextField\np22\nsssS\'meta\'\np23\n(dp24\nS\'unique_together\'\np25\n(lp26\nsS\'db_table\'\np27\nS\'django_session\'\np28\nsS\'db_tablespace\'\np29\nS\'\'\nsS\'pk_column\'\np30\ng11\nssstRp31\n(dp32\nS\'keyOrder\'\np33\n(lp34\ng7\nasbsS\'admin\'\np35\ng3\n(g4\ng5\n(dp36\nS\'LogEntry\'\np37\n(dp38\ng9\n(dp39\nS\'action_flag\'\np40\n(dp41\ng13\ncdjango.db.models.fields\nPositiveSmallIntegerField\np42\nssS\'action_time\'\np43\n(dp44\ng13\ng19\nssS\'object_repr\'\np45\n(dp46\ng13\ng14\nsg15\nI200\nssS\'object_id\'\np47\n(dp48\ng13\ng22\nsS\'null\'\np49\nI01\nssS\'change_message\'\np50\n(dp51\ng13\ng22\nssS\'user\'\np52\n(dp53\ng13\ncdjango.db.models.fields.related\nForeignKey\np54\nsS\'related_model\'\np55\nS\'auth.User\'\np56\nssS\'content_type\'\np57\n(dp58\ng13\ng54\nsg49\nI01\nsg55\nS\'contenttypes.ContentType\'\np59\nssS\'id\'\np60\n(dp61\ng13\ncdjango.db.models.fields\nAutoField\np62\nsg16\nI01\nsssg23\n(dp63\ng25\n(lp64\nsg27\nS\'django_admin_log\'\np65\nsg29\nS\'\'\nsg30\ng60\nssstRp66\n(dp67\ng33\n(lp68\ng37\nasbsS\'registration\'\np69\ng3\n(g4\ng5\n(dp70\nS\'RegistrationProfile\'\np71\n(dp72\ng9\n(dp73\nS\'activation_key\'\np74\n(dp75\ng13\ng14\nsg15\nI40\nssg60\n(dp76\ng13\ng62\nsg16\nI01\nssg52\n(dp77\ng13\ng54\nsS\'unique\'\np78\nI01\nsg55\nS\'auth.User\'\np79\nsssg23\n(dp80\ng25\n(lp81\nsg27\nS\'registration_registrationprofile\'\np82\nsg29\nS\'\'\nsg30\ng60\nssstRp83\n(dp84\ng33\n(lp85\ng71\nasbsS\'tagging_autocomplete\'\np86\ng3\n(g4\ng5\n(dtRp87\n(dp88\ng33\n(lp89\nsbsS\'sites\'\np90\ng3\n(g4\ng5\n(dp91\nS\'Site\'\np92\n(dp93\ng9\n(dp94\nS\'domain\'\np95\n(dp96\ng13\ng14\nsg15\nI100\nssg60\n(dp97\ng13\ng62\nsg16\nI01\nssS\'name\'\np98\n(dp99\ng13\ng14\nsg15\nI50\nsssg23\n(dp100\ng25\n(lp101\nsg27\nS\'django_site\'\np102\nsg29\nS\'\'\nsg30\ng60\nssstRp103\n(dp104\ng33\n(lp105\ng92\nasbsS\'auth\'\np106\ng3\n(g4\ng5\n(dp107\nS\'Message\'\np108\n(dp109\ng9\n(dp110\nS\'message\'\np111\n(dp112\ng13\ng22\nssg60\n(dp113\ng13\ng62\nsg16\nI01\nssg52\n(dp114\ng13\ng54\nsg55\nS\'auth.User\'\np115\nsssg23\n(dp116\ng25\n(lp117\nsg27\nS\'auth_message\'\np118\nsg29\nS\'\'\nsg30\ng60\nsssS\'Group\'\np119\n(dp120\ng9\n(dp121\nS\'permissions\'\np122\n(dp123\ng13\ncdjango.db.models.fields.related\nManyToManyField\np124\nsg55\nS\'auth.Permission\'\np125\nssg60\n(dp126\ng13\ng62\nsg16\nI01\nssg98\n(dp127\ng15\nI80\nsg13\ng14\nsg78\nI01\nsssg23\n(dp128\ng25\n(lp129\nsg27\nS\'auth_group\'\np130\nsg29\nS\'\'\nsg30\ng60\nsssS\'User\'\np131\n(dp132\ng9\n(dp133\nS\'username\'\np134\n(dp135\ng15\nI30\nsg13\ng14\nsg78\nI01\nssS\'first_name\'\np136\n(dp137\ng13\ng14\nsg15\nI30\nssS\'last_name\'\np138\n(dp139\ng13\ng14\nsg15\nI30\nssS\'is_active\'\np140\n(dp141\ng13\ncdjango.db.models.fields\nBooleanField\np142\nssS\'email\'\np143\n(dp144\ng13\ncdjango.db.models.fields\nEmailField\np145\nsg15\nI75\nssS\'is_superuser\'\np146\n(dp147\ng13\ng142\nssS\'is_staff\'\np148\n(dp149\ng13\ng142\nssS\'last_login\'\np150\n(dp151\ng13\ng19\nssS\'groups\'\np152\n(dp153\ng13\ng124\nsg55\nS\'auth.Group\'\np154\nssS\'user_permissions\'\np155\n(dp156\ng13\ng124\nsg55\nS\'auth.Permission\'\np157\nssS\'password\'\np158\n(dp159\ng13\ng14\nsg15\nI128\nssg60\n(dp160\ng13\ng62\nsg16\nI01\nssS\'date_joined\'\np161\n(dp162\ng13\ng19\nsssg23\n(dp163\ng25\n(lp164\nsg27\nS\'auth_user\'\np165\nsg29\nS\'\'\nsg30\ng60\nsssS\'Permission\'\np166\n(dp167\ng9\n(dp168\nS\'codename\'\np169\n(dp170\ng13\ng14\nsg15\nI100\nssg60\n(dp171\ng13\ng62\nsg16\nI01\nssg57\n(dp172\ng13\ng54\nsg55\nS\'contenttypes.ContentType\'\np173\nssg98\n(dp174\ng13\ng14\nsg15\nI50\nsssg23\n(dp175\ng25\n((S\'content_type\'\nS\'codename\'\nttp176\nsg27\nS\'auth_permission\'\np177\nsg29\nS\'\'\nsg30\ng60\nssstRp178\n(dp179\ng33\n(lp180\ng166\nag119\nag131\nag108\nasbsS\'sluggable\'\np181\ng3\n(g4\ng5\n(dtRp182\n(dp183\ng33\n(lp184\nsbsS\'contenttypes\'\np185\ng3\n(g4\ng5\n(dp186\nS\'ContentType\'\np187\n(dp188\ng9\n(dp189\nS\'model\'\np190\n(dp191\ng13\ng14\nsg15\nI100\nssS\'app_label\'\np192\n(dp193\ng13\ng14\nsg15\nI100\nssg60\n(dp194\ng13\ng62\nsg16\nI01\nssg98\n(dp195\ng13\ng14\nsg15\nI100\nsssg23\n(dp196\ng25\n((S\'app_label\'\nS\'model\'\nttp197\nsg27\nS\'django_content_type\'\np198\nsg29\nS\'\'\nsg30\ng60\nssstRp199\n(dp200\ng33\n(lp201\ng187\nasbsS\'django_evolution\'\np202\ng3\n(g4\ng5\n(dp203\nS\'Evolution\'\np204\n(dp205\ng9\n(dp206\nS\'label\'\np207\n(dp208\ng13\ng14\nsg15\nI100\nssS\'version\'\np209\n(dp210\ng13\ng54\nsg55\nS\'django_evolution.Version\'\np211\nssg60\n(dp212\ng13\ng62\nsg16\nI01\nssg192\n(dp213\ng13\ng14\nsg15\nI200\nsssg23\n(dp214\ng25\n(lp215\nsg27\nS\'django_evolution\'\np216\nsg29\nS\'\'\nsg30\ng60\nsssS\'Version\'\np217\n(dp218\ng9\n(dp219\nS\'when\'\np220\n(dp221\ng13\ng19\nssg60\n(dp222\ng13\ng62\nsg16\nI01\nssS\'signature\'\np223\n(dp224\ng13\ng22\nsssg23\n(dp225\ng25\n(lp226\nsg27\nS\'django_project_version\'\np227\nsg29\nS\'\'\nsg30\ng60\nssstRp228\n(dp229\ng33\n(lp230\ng217\nag204\nasbsS\'__version__\'\np231\nI1\nsS\'workouts\'\np232\ng3\n(g4\ng5\n(dp233\nS\'Workout\'\np234\n(dp235\ng9\n(dp236\nS\'created_at\'\np237\n(dp238\ng13\ng19\nssS\'title\'\np239\n(dp240\ng15\nI128\nsg13\ng14\nsg49\nI01\nssS\'workout\'\np241\n(dp242\ng13\ng22\nssS\'tags\'\np243\n(dp244\ng13\ng14\nsg15\nI255\nssS\'updated_at\'\np245\n(dp246\ng13\ng19\nssg60\n(dp247\ng13\ng62\nsg16\nI01\nssg52\n(dp248\ng13\ng54\nsg55\nS\'auth.User\'\np249\nssS\'slug\'\np250\n(dp251\ng13\ncdjango.db.models.fields\nSlugField\np252\nsg15\nI50\nsS\'db_index\'\np253\nI01\nsssg23\n(dp254\ng25\n(lp255\nsg27\nS\'workouts_workout\'\np256\nsg29\nS\'\'\nsg30\ng60\nsssS\'Result\'\np257\n(dp258\ng9\n(dp259\ng52\n(dp260\ng13\ng54\nsg55\nS\'auth.User\'\np261\nssg237\n(dp262\ng13\ng19\nssg243\n(dp263\ng13\ng14\nsg15\nI255\nssS\'notes\'\np264\n(dp265\ng13\ng22\nsg49\nI01\nssg241\n(dp266\ng13\ng54\nsg55\nS\'workouts.Workout\'\np267\nssg245\n(dp268\ng13\ng19\nssS\'dateslug\'\np269\n(dp270\ng15\nI16\nsg13\ng14\nsg49\nI01\nssS\'date\'\np271\n(dp272\ng13\ncdjango.db.models.fields\nDateField\np273\nssg60\n(dp274\ng13\ng62\nsg16\nI01\nssS\'result\'\np275\n(dp276\ng13\ng22\nsssg23\n(dp277\ng25\n(lp278\nsg27\nS\'workouts_result\'\np279\nsg29\nS\'\'\nsg30\ng60\nssstRp280\n(dp281\ng33\n(lp282\ng234\nag257\nasbsS\'tagging\'\np283\ng3\n(g4\ng5\n(dp284\nS\'Tag\'\np285\n(dp286\ng9\n(dp287\ng60\n(dp288\ng13\ng62\nsg16\nI01\nssg98\n(dp289\ng15\nI50\nsg13\ng14\nsg78\nI01\nsg253\nI01\nsssg23\n(dp290\ng25\n(lp291\nsg27\nS\'tagging_tag\'\np292\nsg29\nS\'\'\nsg30\ng60\nsssS\'TaggedItem\'\np293\n(dp294\ng9\n(dp295\nS\'tag\'\np296\n(dp297\ng13\ng54\nsg55\nS\'tagging.Tag\'\np298\nssg60\n(dp299\ng13\ng62\nsg16\nI01\nssg57\n(dp300\ng13\ng54\nsg55\nS\'contenttypes.ContentType\'\np301\nssg47\n(dp302\ng13\ncdjango.db.models.fields\nPositiveIntegerField\np303\nsg253\nI01\nsssg23\n(dp304\ng25\n((S\'tag\'\nS\'content_type\'\nS\'object_id\'\nttp305\nsg27\nS\'tagging_taggeditem\'\np306\nsg29\nS\'\'\nsg30\ng60\nssstRp307\n(dp308\ng33\n(lp309\ng285\nag293\nasbs.','2010-11-27 19:33:45');
/*!40000 ALTER TABLE `django_project_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('4efc9b4c34b98831e5f3fa3c6c85b1a5','gAJ9cQEoVRJfYXV0aF91c2VyX2JhY2tlbmRxAlUpZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5k\ncy5Nb2RlbEJhY2tlbmRxA1UNX2F1dGhfdXNlcl9pZHEEigEBdS4yYWRlM2I3ZDg1NDNjY2Y2OTUx\nN2E1ODlmZTllODRjZA==\n','2010-07-10 07:21:27'),('044e7f8298c0b4f4f19f1ba93ccee91a','gAJ9cQEoVRJfYXV0aF91c2VyX2JhY2tlbmRxAlUpZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5k\ncy5Nb2RlbEJhY2tlbmRxA1UNX2F1dGhfdXNlcl9pZHEEigEBdS4yYWRlM2I3ZDg1NDNjY2Y2OTUx\nN2E1ODlmZTllODRjZA==\n','2010-07-01 10:33:10'),('ba4605ebbac8daab15da8a1969e70f23','gAJ9cQEoVRJfYXV0aF91c2VyX2JhY2tlbmRxAlUpZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5k\ncy5Nb2RlbEJhY2tlbmRxA1UNX2F1dGhfdXNlcl9pZHEEigEBdS4yYWRlM2I3ZDg1NDNjY2Y2OTUx\nN2E1ODlmZTllODRjZA==\n','2010-08-05 12:25:35'),('e47e64bdc317032acc14332f42443254','gAJ9cQEoVRJfYXV0aF91c2VyX2JhY2tlbmRxAlUpZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5k\ncy5Nb2RlbEJhY2tlbmRxA1UNX2F1dGhfdXNlcl9pZHEEigEBdS4yYWRlM2I3ZDg1NDNjY2Y2OTUx\nN2E1ODlmZTllODRjZA==\n','2010-07-16 15:51:42'),('49a82f0b47bf0d2e2df0ee5c972321d9','gAJ9cQEoVRJfYXV0aF91c2VyX2JhY2tlbmRxAlUpZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5k\ncy5Nb2RlbEJhY2tlbmRxA1UNX2F1dGhfdXNlcl9pZHEEigEBdS4yYWRlM2I3ZDg1NDNjY2Y2OTUx\nN2E1ODlmZTllODRjZA==\n','2010-07-21 10:46:49'),('be469d70823008fbd641f1b63a18c743','gAJ9cQEuNmYxYzQxZWI5MDczZTZlY2JjOTRiNTM1NWIwYjU0ZjQ=\n','2010-08-02 07:35:18'),('15914e526fb0f2dbc48f9018e2ed28dd','gAJ9cQEoVRJfYXV0aF91c2VyX2JhY2tlbmRxAlUpZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5k\ncy5Nb2RlbEJhY2tlbmRxA1UNX2F1dGhfdXNlcl9pZHEEigEBdS4yYWRlM2I3ZDg1NDNjY2Y2OTUx\nN2E1ODlmZTllODRjZA==\n','2010-08-25 18:19:04'),('6a3c4549b5ab048113a15dfc69f438fc','gAJ9cQEoVRJfYXV0aF91c2VyX2JhY2tlbmRxAlUpZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5k\ncy5Nb2RlbEJhY2tlbmRxA1UNX2F1dGhfdXNlcl9pZHEEigEBdS4yYWRlM2I3ZDg1NDNjY2Y2OTUx\nN2E1ODlmZTllODRjZA==\n','2010-09-14 09:08:24'),('f870032c169d748dea30b027f8870e5b','gAJ9cQEoVRJfYXV0aF91c2VyX2JhY2tlbmRxAlUpZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5k\ncy5Nb2RlbEJhY2tlbmRxA1UNX2F1dGhfdXNlcl9pZHEEigEBdS4yYWRlM2I3ZDg1NDNjY2Y2OTUx\nN2E1ODlmZTllODRjZA==\n','2010-10-19 07:44:02'),('87b882ee82878fe3d2144aa6731156f9','gAJ9cQEoVRJfYXV0aF91c2VyX2JhY2tlbmRxAlUpZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5k\ncy5Nb2RlbEJhY2tlbmRxA1UNX2F1dGhfdXNlcl9pZHEEigEBdS4yYWRlM2I3ZDg1NDNjY2Y2OTUx\nN2E1ODlmZTllODRjZA==\n','2010-10-25 17:13:49'),('afcc8476c8916ed690e5ab59e0ede6fa','gAJ9cQEoVRJfYXV0aF91c2VyX2JhY2tlbmRxAlUpZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5k\ncy5Nb2RlbEJhY2tlbmRxA1UNX2F1dGhfdXNlcl9pZHEEigEBdS4yYWRlM2I3ZDg1NDNjY2Y2OTUx\nN2E1ODlmZTllODRjZA==\n','2010-11-15 18:07:02'),('10e5158b6ca65083b0deaf1876ca02e5','gAJ9cQEoVRJfYXV0aF91c2VyX2JhY2tlbmRxAlUpZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5k\ncy5Nb2RlbEJhY2tlbmRxA1UNX2F1dGhfdXNlcl9pZHEEigEBdS4yYWRlM2I3ZDg1NDNjY2Y2OTUx\nN2E1ODlmZTllODRjZA==\n','2010-12-08 18:22:52');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (1,'example.com','example.com');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registration_registrationprofile`
--

DROP TABLE IF EXISTS `registration_registrationprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registration_registrationprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `activation_key` varchar(40) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registration_registrationprofile`
--

LOCK TABLES `registration_registrationprofile` WRITE;
/*!40000 ALTER TABLE `registration_registrationprofile` DISABLE KEYS */;
/*!40000 ALTER TABLE `registration_registrationprofile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tagging_tag`
--

DROP TABLE IF EXISTS `tagging_tag`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tagging_tag` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tagging_tag`
--

LOCK TABLES `tagging_tag` WRITE;
/*!40000 ALTER TABLE `tagging_tag` DISABLE KEYS */;
INSERT INTO `tagging_tag` VALUES (1,'behind-neck-split-jerk'),(2,'split-jerk'),(3,'push-jerk'),(4,'clean'),(5,'jerk'),(6,'burpees'),(8,'5k'),(9,'running'),(10,'oh-squat'),(12,'100-burpees'),(14,'box-jumps'),(15,'situps'),(16,'push-press'),(17,'cindy'),(18,'deadlift'),(19,'back-squat'),(20,'box-front-squat'),(21,'sumo-deadlift'),(22,'ghd-situp'),(23,'ghd-back-extensions'),(24,'diamond-pushups'),(25,'double-unders'),(26,'good-mornings'),(29,'sdhp'),(30,'fran'),(31,'pullups'),(32,'thrusters'),(33,'angie'),(35,'box-jump'),(37,'kettlebell-swing'),(38,'pushup'),(39,'kettlebell-swings'),(40,'pullup'),(42,'hellen'),(43,'chinup'),(44,'press'),(45,'ghd-extensions'),(46,'squats'),(47,'ring-dips'),(48,'cat-hill'),(50,'hang-squat-clean'),(51,'pullips'),(52,'front-squat'),(54,'power-snatch');
/*!40000 ALTER TABLE `tagging_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tagging_taggeditem`
--

DROP TABLE IF EXISTS `tagging_taggeditem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tagging_taggeditem` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tag_id` int(11) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `object_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tag_id` (`tag_id`,`content_type_id`,`object_id`),
  KEY `tagging_taggeditem_tag_id` (`tag_id`),
  KEY `tagging_taggeditem_content_type_id` (`content_type_id`),
  KEY `tagging_taggeditem_object_id` (`object_id`)
) ENGINE=MyISAM AUTO_INCREMENT=149 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tagging_taggeditem`
--

LOCK TABLES `tagging_taggeditem` WRITE;
/*!40000 ALTER TABLE `tagging_taggeditem` DISABLE KEYS */;
INSERT INTO `tagging_taggeditem` VALUES (1,1,10,1),(2,2,10,1),(3,3,10,1),(4,4,10,2),(5,5,10,2),(6,6,10,2),(73,52,10,21),(8,6,10,3),(9,8,10,4),(10,9,10,4),(11,10,10,5),(80,16,10,12),(13,9,10,7),(14,12,10,8),(71,18,10,16),(16,9,10,9),(17,14,10,10),(18,15,10,10),(19,16,10,10),(20,17,10,11),(21,18,10,11),(81,9,10,23),(23,19,10,12),(24,20,10,13),(25,21,10,13),(26,22,10,14),(27,23,10,14),(28,14,10,15),(29,24,10,15),(30,25,10,15),(31,26,10,16),(72,25,10,3),(79,16,10,5),(34,29,10,17),(35,14,10,17),(36,30,10,18),(37,31,10,18),(38,32,10,18),(39,33,10,20),(74,52,10,28),(41,3,10,21),(42,35,10,22),(44,37,10,22),(45,38,10,22),(46,25,10,22),(47,39,10,23),(48,40,10,23),(50,42,10,23),(51,43,10,24),(52,44,10,24),(77,22,10,22),(54,45,10,25),(55,31,10,25),(56,46,10,25),(57,47,10,25),(58,48,10,26),(59,9,10,26),(70,6,10,8),(61,4,10,27),(62,50,10,27),(63,51,10,27),(64,52,10,27),(69,19,10,27),(78,9,10,16),(67,54,10,28),(68,19,10,28),(76,22,10,25),(82,1,9,1),(83,3,9,1),(84,2,9,1),(85,6,9,2),(86,4,9,2),(87,5,9,2),(88,6,9,3),(89,25,9,3),(90,8,9,4),(91,9,9,4),(92,10,9,5),(93,16,9,5),(94,9,9,7),(95,12,9,8),(96,6,9,8),(97,9,9,9),(98,14,9,10),(99,16,9,10),(100,15,9,10),(101,17,9,11),(102,18,9,11),(103,19,9,12),(104,16,9,12),(105,20,9,13),(106,21,9,13),(107,23,9,14),(108,22,9,14),(109,14,9,15),(110,24,9,15),(111,25,9,15),(112,18,9,16),(113,26,9,16),(114,9,9,16),(115,14,9,17),(116,29,9,17),(117,30,9,18),(118,31,9,18),(119,32,9,18),(120,33,9,19),(121,52,9,20),(122,3,9,20),(123,35,9,21),(124,25,9,21),(125,22,9,21),(126,37,9,21),(127,38,9,21),(128,42,9,22),(129,39,9,22),(130,40,9,22),(131,9,9,22),(132,43,9,23),(133,44,9,23),(134,45,9,24),(135,22,9,24),(136,31,9,24),(137,47,9,24),(138,46,9,24),(139,48,9,25),(140,9,9,25),(141,19,9,26),(142,4,9,26),(143,52,9,26),(144,50,9,26),(145,51,9,26),(146,19,9,27),(147,52,9,27),(148,54,9,27);
/*!40000 ALTER TABLE `tagging_taggeditem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workouts_result`
--

DROP TABLE IF EXISTS `workouts_result`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workouts_result` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tags` varchar(255) NOT NULL,
  `workout_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `dateslug` varchar(16) DEFAULT NULL,
  `result` longtext NOT NULL,
  `notes` longtext,
  `user_id` int(11) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `workouts_result_workout_id` (`workout_id`),
  KEY `workouts_result_user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workouts_result`
--

LOCK TABLES `workouts_result` WRITE;
/*!40000 ALTER TABLE `workouts_result` DISABLE KEYS */;
INSERT INTO `workouts_result` VALUES (1,'',1,'2010-06-17','2010-06-17','made it to 155\r\nthen 165\r\nthen 175',NULL,1,'2010-11-27 19:33:42','2010-11-27 19:33:42'),(2,'',2,'2010-06-17','2010-06-17','11:59',NULL,1,'2010-11-27 19:33:42','2010-11-27 19:33:42'),(3,'',3,'2010-06-17','2010-06-17','23:45',NULL,1,'2010-11-27 19:33:42','2010-11-27 19:33:42'),(4,'',4,'2010-06-15','2010-06-15','22:19',NULL,1,'2010-11-27 19:33:42','2010-11-27 19:33:42'),(5,'',5,'2010-06-17','2010-06-17','115-125-135-135-145F-X\r\n135-145-155-165-175',NULL,1,'2010-11-27 19:33:42','2010-11-27 19:33:42'),(6,'',6,'2010-07-02','2010-07-02','15:03',NULL,1,'2010-11-27 19:33:42','2010-11-27 19:33:42'),(7,'',7,'2010-07-02','2010-07-02','zzz',NULL,1,'2010-11-27 19:33:42','2010-11-27 19:33:42'),(8,'',8,'2010-07-03','2010-07-03','6:57',NULL,1,'2010-11-27 19:33:42','2010-11-27 19:33:42'),(9,'',9,'2010-07-07','2010-07-07','no time',NULL,1,'2010-11-27 19:33:42','2010-11-27 19:33:42'),(10,'',10,'2010-07-07','2010-07-07','6:50',NULL,1,'2010-11-27 19:33:42','2010-11-27 19:33:42'),(11,'',11,'2010-07-08','2010-07-08','18:05',NULL,1,'2010-11-27 19:33:42','2010-11-27 19:33:42'),(12,'',12,'2010-07-09','2010-07-09','Push Press\r\n95x4\r\n135x4\r\n145x3\r\n155x2\r\n165x1F\r\n\r\nBack Squat\r\n165x3\r\n185x3\r\n205x3\r\n225x1\r\n245x1\r\n\r\ndon\'t remember time',NULL,1,'2010-11-27 19:33:42','2010-11-27 19:33:42'),(13,'',13,'2010-07-12','2010-07-12','185x3\r\n205x3\r\n215x2,F\r\n\r\n185x3\r\n205x3\r\n225x3\r\n245x3\r\n255FFF, 245x3\r\n255x10',NULL,1,'2010-11-27 19:33:42','2010-11-27 19:33:42'),(14,'',14,'2010-07-13','2010-07-13','subbed sledghammer and tire for dball slams\r\n\r\n60 seconds rest\r\n\r\n11:13',NULL,1,'2010-11-27 19:33:42','2010-11-27 19:33:42'),(15,'',15,'2010-07-14','2010-07-14','6 rounds even',NULL,1,'2010-11-27 19:33:42','2010-11-27 19:33:42'),(16,'',16,'2010-07-19','2010-07-19','Good Mornings\r\n95x3\r\n115x3\r\n135x3\r\n165x3\r\n\r\nPress\r\n95x5\r\n115x2,95x3\r\n105x3\r\n115x2,105x1\r\n\r\nDeadlift\r\n225x3\r\n245x3\r\n263x3\r\n285F\r\n285F\r\n285F\r\n300x1\r\n\r\nHelicopter 2:40','',1,'2010-11-27 19:33:42','2010-11-27 19:33:42'),(17,'',17,'2010-07-20','2010-07-20','5:20',NULL,1,'2010-11-27 19:33:42','2010-11-27 19:33:42'),(18,'',18,'2009-11-17','2009-11-17','7:22',NULL,1,'2010-11-27 19:33:42','2010-11-27 19:33:42'),(19,'Fran, Thrusters, Pullups',18,'2010-07-21','2010-07-21','5:46','no sleep, FML',1,'2010-11-27 19:33:42','2010-11-27 19:33:42'),(20,'',19,'2010-07-26','2010-07-26','15:45',NULL,1,'2010-11-27 19:33:42','2010-11-27 19:33:42'),(21,'',20,'2010-07-27','2010-07-27','6 rounds + 5 jerks',NULL,1,'2010-11-27 19:33:42','2010-11-27 19:33:42'),(22,'',21,'2010-08-23','2010-08-23','DU\'s 36,29,32,22,5\r\nGHF 14,10,10,9,4\r\nPushups 20,18,15,18,17\r\nBox 7,9,9,8,10\r\nKettle 17,16,12,11,12\r\n\r\nTotal 370\r\n',NULL,1,'2010-11-27 19:33:42','2010-11-27 19:33:42'),(23,'',22,'2010-08-31','2010-08-31','10:40\r\n\r\nstairs at the box',NULL,1,'2010-11-27 19:33:42','2010-11-27 19:33:42'),(24,'',23,'2010-10-11','2010-10-11','95x6, 105x4, 110x2, 105x6, 110x4, 115x2\r\nsets of 5 for all pullups. I didn\'t get as high as I wanted so I focused on that instead of adding weight',NULL,1,'2010-11-27 19:33:42','2010-11-27 19:33:42'),(25,'',24,'2010-10-12','2010-10-12','3:33\r\n3:50\r\n4:25\r\n5:09\r\n6:07\r\n\r\nfelt like i was going to blackout on the GHD on round 4, spent the whole rest trying not to puke',NULL,1,'2010-11-27 19:33:42','2010-11-27 19:33:42'),(26,'',25,'2010-10-13','2010-10-13','1:22\r\n1:22\r\n1:22\r\n1:21',NULL,1,'2010-11-27 19:33:42','2010-11-27 19:33:42'),(27,'',26,'2010-10-13','2010-10-13','at 135#\r\nA1. 3,3,3,3,3,3,3\r\nA2. 8,7,9,9,10,9,12\r\nB. 95#, 115#, couldn\'t commit to 135#\r\nC1. 4 each round\r\nC2. CTB for first 2 rounds, regular kipping 2nd 2 rounds',NULL,1,'2010-11-27 19:33:42','2010-11-27 19:33:42'),(28,'',27,'2010-11-01','2010-11-01','worked up to 225#\r\n105\r\n155#',NULL,1,'2010-11-27 19:33:42','2010-11-27 19:33:42');
/*!40000 ALTER TABLE `workouts_result` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workouts_workout`
--

DROP TABLE IF EXISTS `workouts_workout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `workouts_workout` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `slug` varchar(50) NOT NULL,
  `title` varchar(128) DEFAULT NULL,
  `workout` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  `tags` varchar(255) NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `workouts_workout_slug` (`slug`),
  KEY `workouts_workout_user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `workouts_workout`
--

LOCK TABLES `workouts_workout` WRITE;
/*!40000 ALTER TABLE `workouts_workout` DISABLE KEYS */;
INSERT INTO `workouts_workout` VALUES (1,'push-split-behind','Push Split Behind','Push Jerk 5 x 3 (180sec) rest\r\n\r\nSplit Jerk 3 x 3 (180sec) rest\r\n\r\nBehind the Neck Split Jerk 3 x 1 (180-210sec) rest',1,'','2010-11-27 19:33:42','2010-11-27 19:33:42'),(2,'wednesday-june-23-2010','Wednesday, June 23, 2010','10-9-8-7-6-5-4-3-2-1\r\n\r\n95# bar Clean & Jerk\r\nBurpees',1,'','2010-11-27 19:33:42','2010-11-27 19:33:42'),(3,'amanda','Amanda','5 Rounds For Time Of:\r\n100 Double Unders\r\n20 Burpees',1,'','2010-11-27 19:33:42','2010-11-27 19:33:42'),(4,'5k','5k','Run 5k',1,'','2010-11-27 19:33:42','2010-11-27 19:33:42'),(5,'tuesday-june-29-2010','Tuesday, June 29, 2010','OH Squats - 2, 2, 2, 2, 2, 2\r\nPush Press - 3, 3, 3, 2, 2\r\n\r\n4 Rounds For Time of:\r\n10 Meter Overhead Lunge Walk @ 35/25 lbs\r\n8 Supine Ring Rows\r\n20 Meter Shuttle Sprint (down/back)\r\n8 DB Cleans 35lbs',1,'','2010-11-27 19:33:42','2010-11-27 19:33:42'),(6,'friday-july-02-2010','Friday, July 02, 2010','Ten rounds for time of:\r\n10 Pull-ups\r\n10 Dips\r\n10 Sit-ups\r\n10 Squats',1,'','2010-11-27 19:33:42','2010-11-27 19:33:42'),(7,'friday-july-02-2010-1','Friday, July 02, 2010','tabatta run\r\n\r\n3x legblaaster on the 2:30',1,'','2010-11-27 19:33:42','2010-11-27 19:33:42'),(8,'100-burpees','100 Burpees','100 Burpees for time',1,'','2010-11-27 19:33:42','2010-11-27 19:33:42'),(9,'wednesday-july-07-2010','Wednesday, July 07, 2010','4 people relays doing 6x100',1,'','2010-11-27 19:33:42','2010-11-27 19:33:42'),(10,'wednesday-july-07-2010-1','Wednesday, July 07, 2010','10-9-8-7-6-5 of:\r\n\r\nPush Press @ 95/65\r\n\r\nBox Jumps 24 Inch Box\r\n\r\nSitups x 2',1,'','2010-11-27 19:33:42','2010-11-27 19:33:42'),(11,'dead-cindy','Dead Cindy',' Jump Rope Barefoot 6 min., mixing in variables of DU\'s, Cross Overs, single foot, running.\r\n\r\n5 - 7 wall walks (start standing up with your back to the wall about 3 feet away. Lean back until your hands come in contact with the wall. Walk your way down as deep as you can. Reaching the floor is your ultimate goal. Walk back up the wall with out falling. That is 1 wall walk). Rest as needed between.\r\n\r\nFor Time:\r\n\r\n5 Deadlifts @ 50-60% 1 RM\r\n\r\n5 Rounds of Cindy (5 Pullups/10 Pushups/15 Air Squats)\r\n\r\n6 Deadlifts\r\n\r\n4 Rounds of Cindy\r\n\r\n7 Deadlifts\r\n\r\n3 Rounds of Cindy\r\n\r\n8 Deadlifts\r\n\r\n2 Rounds of Cindy',1,'','2010-11-27 19:33:42','2010-11-27 19:33:42'),(12,'friday-july-09-2010','Friday, July 09, 2010','Push Press Behind Neck: 4, 4, 3, 2, 2 @ 60-70% 1 RM Press\r\n\r\nBack Squat: 3, 3, 2, 1, 1 @ 70-90% 1 RM (rest 90 Seconds between sets)\r\n\r\nRest 5 Min\r\n\r\n4 Rounds For Time of:\r\n\r\n5 Hand Stand Pushups\r\n\r\n10 Toes to Bar\r\n\r\n10 Back Squats @ 65/45 lbs',1,'','2010-11-27 19:33:42','2010-11-27 19:33:42'),(13,'monday-july-12-2010','Monday, July 12, 2010',' Box Front Squat 3 x 3, 85%  (180sec rest)  Apply the Box w/ a Front Squat.\r\n\r\nRest 5 min\r\n\r\nSumo Deadlift 5 x 3 , 85% (180sec rest)  ',1,'','2010-11-27 19:33:42','2010-11-27 19:33:42'),(14,'tuesday-july-13-2010','Tuesday, July 13, 2010',' 5 rounds for time rest 120sec between each of the round\r\n\r\n10 GHD Sit Ups\r\n\r\n15 GHD Glute Ham Raises\r\n\r\n20 M25lb/W20lb DBall slams (Dball is raised over head and slammed down to the ground in a full squat)',1,'','2010-11-27 19:33:42','2010-11-27 19:33:42'),(15,'wednesday-july-14-2010','Wednesday, July 14, 2010','As Many Rounds in 15 Minutes Of :\r\n50 Double Unders\r\n20 Box Jumps - 24 Inch Box\r\n10 Diamond Pushups',1,'','2010-11-27 19:33:42','2010-11-27 19:33:42'),(16,'monday-july-19-2010','Monday, July 19, 2010','Good Mornings: 5, 5, 3, 3 Rest 240sec between sets\r\n\r\nRest 3min\r\n\r\nPress: 5, 3, 3, 3 Rest 240sec between sets\r\n\r\nRest 3min\r\n\r\nDL: 3, 3, 2, 1, 1 Rest 240sec between sets\r\n\r\nRest 10 min\r\n\r\nMini Flight Simulator\r\n5 unbroken double unders\r\n10 unbroken double unders\r\n15 unbroken double unders\r\n20 unbroken double unders\r\n25 unbroken double unders\r\n20 unbroken double unders\r\n15 unbroken double unders\r\n10 unbroken double unders\r\n5 unbroken double unders',1,'','2010-11-27 19:33:42','2010-11-27 19:33:42'),(17,'tuesday-july-20-2010','Tuesday, July 20, 2010','5 rounds for time:\r\n5 SDHP 115#\r\n10 Box Jumps (M: 30\"/W: 24\")',1,'','2010-11-27 19:33:42','2010-11-27 19:33:42'),(18,'fran','Fran','21-15-9 reps, for time\r\nThruster 95 lbs\r\nPull-ups\r\n',1,'','2010-11-27 19:33:42','2010-11-27 19:33:42'),(19,'angie','Angie','100 pullups\r\n100 pushups\r\n100 situps\r\n100 squats',1,'','2010-11-27 19:33:42','2010-11-27 19:33:42'),(20,'tuesday-july-27-2010','Tuesday, July 27, 2010','AMRAP in 12 Minutes of :\r\n5 Jerks @ 115/85 lbs\r\n5 Front Squats\r\n12 Lateral Jumps over bar\r\n12 Pushups',1,'','2010-11-27 19:33:42','2010-11-27 19:33:42'),(21,'monday-august-23-2010','Monday, August 23, 2010','5 Total Rounds.\r\n30sec on,20sec off: Move from one exercise to the other in this order.\r\nDouble Unders\r\nGHD Sit ups\r\nPush ups\r\nSeated Box Jumps. Sit on 12\" box ,Jump up onto the 30\" Box.\r\nKettle Bell Swings 1.5 pood.',1,'','2010-11-27 19:33:42','2010-11-27 19:33:42'),(22,'hellen','Hellen','3 Rounds for Time of:\r\n400 Meter run\r\n21 KB Swings @ 1.5/1 pood\r\n12 Pullups',1,'','2010-11-27 19:33:42','2010-11-27 19:33:42'),(23,'monday-october-11-2010','Monday, October 11, 2010','A1. Seated BB Press Waveload @ 31X2; 6,4,2,6,4,2; rest 3 min\r\nA2. Supinated Paused Weighted CTB Chin Ups @ 31X2; 4-5 x 6; rest 3 min',1,'','2010-11-27 19:33:42','2010-11-27 19:33:42'),(24,'tuesday-october-12-2010','Tuesday, October 12, 2010','5 sets @ 95%:\r\n20 ring dips\r\n20 unbroken chin ups\r\n20 GHD sit ups\r\n20 squats\r\n20 GHD extensions\r\nrest 2 min b/t sets',1,'','2010-11-27 19:33:42','2010-11-27 19:33:42'),(25,'cat-hill-4x400m','Cat Hill 4x400m','4x400m up cat hill\r\nrest 5x',1,'','2010-11-27 19:33:42','2010-11-27 19:33:42'),(26,'wednesday-october-13-2010','Wednesday, October 13, 2010','A1. Front Squat @ 30X0; 2-3 x 7; rest 10 sec\r\nA2. Back Squat @ 30X0; amrap x 7; rest 2 min\r\nA3. L Pull Ups @ 31X1; amrap (-1) x 7; rest 3 min\r\nB. Hang Squat Clean - build quickly on the minute to a heavy single with perfect form\r\nC1. Mixed Grip Chin Ups @ 30X0; 3-4 x 4; rest 10 sec\r\nC2. CTB Chin Ups - 10 AFAP x 4; rest 2 min\r\n',1,'','2010-11-27 19:33:42','2010-11-27 19:33:42'),(27,'monday-november-01-2010','Monday, November 01, 2010','A1. back squat with chains @ 30X2; 3-4 x 5; rest 90 sec\r\nA2. power snatch @ 13X0; 3-4 x 5; rest 90 sec\r\nB. front squat @ 30X0; 3,3,3 - 80%; rest 1 min\r\nC. knees to elbows moderate speed; 15 unbroken, rest 1 min x 5\r\nD. windshield wiper practice - 3 min',1,'','2010-11-27 19:33:42','2010-11-27 19:33:42');
/*!40000 ALTER TABLE `workouts_workout` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2010-12-26 17:25:31
