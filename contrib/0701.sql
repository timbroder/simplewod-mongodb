-- MySQL dump 10.11
--
-- Host: localhost    Database: gpowered_cflog
-- ------------------------------------------------------
-- Server version	5.0.77

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
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

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
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL auto_increment,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `permission_id_refs_id_5886d21f` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

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
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `auth_message` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `message` longtext NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `auth_message_user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

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
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_content_type_id` (`content_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

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
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL auto_increment,
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
  PRIMARY KEY  (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'tim','','','timothy.broder@gmail.com','sha1$36834$723ecae6590183b235843dd78788ebfa33e4775f',1,1,1,'2010-07-02 15:51:42','2010-06-17 09:30:30');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `group_id_refs_id_f116770` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

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
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `permission_id_refs_id_67e79cb` (`permission_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

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
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL auto_increment,
  `action_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_type_id` int(11) default NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `django_admin_log_user_id` (`user_id`),
  KEY `django_admin_log_content_type_id` (`content_type_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

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
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `django_evolution` (
  `id` int(11) NOT NULL auto_increment,
  `version_id` int(11) NOT NULL,
  `app_label` varchar(200) NOT NULL,
  `label` varchar(100) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `django_evolution_version_id` (`version_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

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
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `django_project_version` (
  `id` int(11) NOT NULL auto_increment,
  `signature` longtext NOT NULL,
  `when` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `django_project_version`
--

LOCK TABLES `django_project_version` WRITE;
/*!40000 ALTER TABLE `django_project_version` DISABLE KEYS */;
INSERT INTO `django_project_version` VALUES (1,'(dp1\nS\'sessions\'\np2\nccopy_reg\n_reconstructor\np3\n(cdjango.utils.datastructures\nSortedDict\np4\nc__builtin__\ndict\np5\n(dp6\nS\'Session\'\np7\n(dp8\nS\'fields\'\np9\n(dp10\nS\'session_key\'\np11\n(dp12\nS\'field_type\'\np13\ncdjango.db.models.fields\nCharField\np14\nsS\'max_length\'\np15\nI40\nsS\'primary_key\'\np16\nI01\nssS\'expire_date\'\np17\n(dp18\ng13\ncdjango.db.models.fields\nDateTimeField\np19\nssS\'session_data\'\np20\n(dp21\ng13\ncdjango.db.models.fields\nTextField\np22\nsssS\'meta\'\np23\n(dp24\nS\'unique_together\'\np25\n(lp26\nsS\'db_table\'\np27\nS\'django_session\'\np28\nsS\'db_tablespace\'\np29\nS\'\'\nsS\'pk_column\'\np30\ng11\nssstRp31\n(dp32\nS\'keyOrder\'\np33\n(lp34\ng7\nasbsS\'admin\'\np35\ng3\n(g4\ng5\n(dp36\nS\'LogEntry\'\np37\n(dp38\ng9\n(dp39\nS\'action_flag\'\np40\n(dp41\ng13\ncdjango.db.models.fields\nPositiveSmallIntegerField\np42\nssS\'action_time\'\np43\n(dp44\ng13\ng19\nssS\'object_repr\'\np45\n(dp46\ng13\ng14\nsg15\nI200\nssS\'object_id\'\np47\n(dp48\ng13\ng22\nsS\'null\'\np49\nI01\nssS\'change_message\'\np50\n(dp51\ng13\ng22\nssS\'user\'\np52\n(dp53\ng13\ncdjango.db.models.fields.related\nForeignKey\np54\nsS\'related_model\'\np55\nS\'auth.User\'\np56\nssS\'content_type\'\np57\n(dp58\ng13\ng54\nsg49\nI01\nsg55\nS\'contenttypes.ContentType\'\np59\nssS\'id\'\np60\n(dp61\ng13\ncdjango.db.models.fields\nAutoField\np62\nsg16\nI01\nsssg23\n(dp63\ng25\n(lp64\nsg27\nS\'django_admin_log\'\np65\nsg29\nS\'\'\nsg30\ng60\nssstRp66\n(dp67\ng33\n(lp68\ng37\nasbsS\'registration\'\np69\ng3\n(g4\ng5\n(dp70\nS\'RegistrationProfile\'\np71\n(dp72\ng9\n(dp73\nS\'activation_key\'\np74\n(dp75\ng13\ng14\nsg15\nI40\nssg60\n(dp76\ng13\ng62\nsg16\nI01\nssg52\n(dp77\ng13\ng54\nsS\'unique\'\np78\nI01\nsg55\nS\'auth.User\'\np79\nsssg23\n(dp80\ng25\n(lp81\nsg27\nS\'registration_registrationprofile\'\np82\nsg29\nS\'\'\nsg30\ng60\nssstRp83\n(dp84\ng33\n(lp85\ng71\nasbsS\'sites\'\np86\ng3\n(g4\ng5\n(dp87\nS\'Site\'\np88\n(dp89\ng9\n(dp90\nS\'domain\'\np91\n(dp92\ng13\ng14\nsg15\nI100\nssg60\n(dp93\ng13\ng62\nsg16\nI01\nssS\'name\'\np94\n(dp95\ng13\ng14\nsg15\nI50\nsssg23\n(dp96\ng25\n(lp97\nsg27\nS\'django_site\'\np98\nsg29\nS\'\'\nsg30\ng60\nssstRp99\n(dp100\ng33\n(lp101\ng88\nasbsS\'auth\'\np102\ng3\n(g4\ng5\n(dp103\nS\'Message\'\np104\n(dp105\ng9\n(dp106\nS\'message\'\np107\n(dp108\ng13\ng22\nssg60\n(dp109\ng13\ng62\nsg16\nI01\nssg52\n(dp110\ng13\ng54\nsg55\nS\'auth.User\'\np111\nsssg23\n(dp112\ng25\n(lp113\nsg27\nS\'auth_message\'\np114\nsg29\nS\'\'\nsg30\ng60\nsssS\'Group\'\np115\n(dp116\ng9\n(dp117\nS\'permissions\'\np118\n(dp119\ng13\ncdjango.db.models.fields.related\nManyToManyField\np120\nsg55\nS\'auth.Permission\'\np121\nssg60\n(dp122\ng13\ng62\nsg16\nI01\nssg94\n(dp123\ng13\ng14\nsg78\nI01\nsg15\nI80\nsssg23\n(dp124\ng25\n(lp125\nsg27\nS\'auth_group\'\np126\nsg29\nS\'\'\nsg30\ng60\nsssS\'User\'\np127\n(dp128\ng9\n(dp129\nS\'username\'\np130\n(dp131\ng13\ng14\nsg78\nI01\nsg15\nI30\nssS\'first_name\'\np132\n(dp133\ng13\ng14\nsg15\nI30\nssS\'last_name\'\np134\n(dp135\ng13\ng14\nsg15\nI30\nssS\'is_active\'\np136\n(dp137\ng13\ncdjango.db.models.fields\nBooleanField\np138\nssS\'email\'\np139\n(dp140\ng13\ncdjango.db.models.fields\nEmailField\np141\nsg15\nI75\nssS\'is_superuser\'\np142\n(dp143\ng13\ng138\nssS\'is_staff\'\np144\n(dp145\ng13\ng138\nssS\'last_login\'\np146\n(dp147\ng13\ng19\nssS\'groups\'\np148\n(dp149\ng13\ng120\nsg55\nS\'auth.Group\'\np150\nssS\'user_permissions\'\np151\n(dp152\ng13\ng120\nsg55\nS\'auth.Permission\'\np153\nssS\'password\'\np154\n(dp155\ng13\ng14\nsg15\nI128\nssg60\n(dp156\ng13\ng62\nsg16\nI01\nssS\'date_joined\'\np157\n(dp158\ng13\ng19\nsssg23\n(dp159\ng25\n(lp160\nsg27\nS\'auth_user\'\np161\nsg29\nS\'\'\nsg30\ng60\nsssS\'Permission\'\np162\n(dp163\ng9\n(dp164\nS\'codename\'\np165\n(dp166\ng13\ng14\nsg15\nI100\nssg60\n(dp167\ng13\ng62\nsg16\nI01\nssg57\n(dp168\ng13\ng54\nsg55\nS\'contenttypes.ContentType\'\np169\nssg94\n(dp170\ng13\ng14\nsg15\nI50\nsssg23\n(dp171\ng25\n((S\'content_type\'\nS\'codename\'\nttp172\nsg27\nS\'auth_permission\'\np173\nsg29\nS\'\'\nsg30\ng60\nssstRp174\n(dp175\ng33\n(lp176\ng162\nag115\nag127\nag104\nasbsS\'sluggable\'\np177\ng3\n(g4\ng5\n(dtRp178\n(dp179\ng33\n(lp180\nsbsS\'contenttypes\'\np181\ng3\n(g4\ng5\n(dp182\nS\'ContentType\'\np183\n(dp184\ng9\n(dp185\nS\'model\'\np186\n(dp187\ng13\ng14\nsg15\nI100\nssS\'app_label\'\np188\n(dp189\ng13\ng14\nsg15\nI100\nssg60\n(dp190\ng13\ng62\nsg16\nI01\nssg94\n(dp191\ng13\ng14\nsg15\nI100\nsssg23\n(dp192\ng25\n((S\'app_label\'\nS\'model\'\nttp193\nsg27\nS\'django_content_type\'\np194\nsg29\nS\'\'\nsg30\ng60\nssstRp195\n(dp196\ng33\n(lp197\ng183\nasbsS\'django_evolution\'\np198\ng3\n(g4\ng5\n(dp199\nS\'Evolution\'\np200\n(dp201\ng9\n(dp202\nS\'label\'\np203\n(dp204\ng13\ng14\nsg15\nI100\nssS\'version\'\np205\n(dp206\ng13\ng54\nsg55\nS\'django_evolution.Version\'\np207\nssg60\n(dp208\ng13\ng62\nsg16\nI01\nssg188\n(dp209\ng13\ng14\nsg15\nI200\nsssg23\n(dp210\ng25\n(lp211\nsg27\nS\'django_evolution\'\np212\nsg29\nS\'\'\nsg30\ng60\nsssS\'Version\'\np213\n(dp214\ng9\n(dp215\nS\'when\'\np216\n(dp217\ng13\ng19\nssg60\n(dp218\ng13\ng62\nsg16\nI01\nssS\'signature\'\np219\n(dp220\ng13\ng22\nsssg23\n(dp221\ng25\n(lp222\nsg27\nS\'django_project_version\'\np223\nsg29\nS\'\'\nsg30\ng60\nssstRp224\n(dp225\ng33\n(lp226\ng213\nag200\nasbsS\'__version__\'\np227\nI1\nsS\'workouts\'\np228\ng3\n(g4\ng5\n(dp229\nS\'Workout\'\np230\n(dp231\ng9\n(dp232\ng52\n(dp233\ng13\ng54\nsg55\nS\'auth.User\'\np234\nssS\'workout\'\np235\n(dp236\ng13\ng22\nssS\'title\'\np237\n(dp238\ng15\nI128\nsg13\ng14\nsg49\nI01\nssg60\n(dp239\ng13\ng62\nsg16\nI01\nssS\'slug\'\np240\n(dp241\ng13\ncdjango.db.models.fields\nSlugField\np242\nsg15\nI50\nsS\'db_index\'\np243\nI01\nsssg23\n(dp244\ng25\n(lp245\nsg27\nS\'workouts_workout\'\np246\nsg29\nS\'\'\nsg30\ng60\nsssS\'Result\'\np247\n(dp248\ng9\n(dp249\ng52\n(dp250\ng13\ng54\nsg55\nS\'auth.User\'\np251\nssS\'tags\'\np252\n(dp253\ng13\ng14\nsg15\nI255\nssS\'notes\'\np254\n(dp255\ng13\ng22\nsg49\nI01\nssg235\n(dp256\ng13\ng54\nsg55\nS\'workouts.Workout\'\np257\nssS\'dateslug\'\np258\n(dp259\ng15\nI16\nsg13\ng14\nsg49\nI01\nssS\'date\'\np260\n(dp261\ng13\ncdjango.db.models.fields\nDateField\np262\nssg60\n(dp263\ng13\ng62\nsg16\nI01\nssS\'result\'\np264\n(dp265\ng13\ng22\nsssg23\n(dp266\ng25\n(lp267\nsg27\nS\'workouts_result\'\np268\nsg29\nS\'\'\nsg30\ng60\nssstRp269\n(dp270\ng33\n(lp271\ng230\nag247\nasbsS\'tagging\'\np272\ng3\n(g4\ng5\n(dp273\nS\'Tag\'\np274\n(dp275\ng9\n(dp276\ng60\n(dp277\ng13\ng62\nsg16\nI01\nssg94\n(dp278\ng13\ng14\nsg78\nI01\nsg15\nI50\nsg243\nI01\nsssg23\n(dp279\ng25\n(lp280\nsg27\nS\'tagging_tag\'\np281\nsg29\nS\'\'\nsg30\ng60\nsssS\'TaggedItem\'\np282\n(dp283\ng9\n(dp284\nS\'tag\'\np285\n(dp286\ng13\ng54\nsg55\nS\'tagging.Tag\'\np287\nssg60\n(dp288\ng13\ng62\nsg16\nI01\nssg57\n(dp289\ng13\ng54\nsg55\nS\'contenttypes.ContentType\'\np290\nssg47\n(dp291\ng13\ncdjango.db.models.fields\nPositiveIntegerField\np292\nsg243\nI01\nsssg23\n(dp293\ng25\n((S\'tag\'\nS\'content_type\'\nS\'object_id\'\nttp294\nsg27\nS\'tagging_taggeditem\'\np295\nsg29\nS\'\'\nsg30\ng60\nssstRp296\n(dp297\ng33\n(lp298\ng274\nag282\nasbs.','2010-06-17 09:30:30');
/*!40000 ALTER TABLE `django_project_version` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY  (`session_key`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('4efc9b4c34b98831e5f3fa3c6c85b1a5','gAJ9cQEoVRJfYXV0aF91c2VyX2JhY2tlbmRxAlUpZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5k\ncy5Nb2RlbEJhY2tlbmRxA1UNX2F1dGhfdXNlcl9pZHEEigEBdS4yYWRlM2I3ZDg1NDNjY2Y2OTUx\nN2E1ODlmZTllODRjZA==\n','2010-07-10 07:21:27'),('044e7f8298c0b4f4f19f1ba93ccee91a','gAJ9cQEoVRJfYXV0aF91c2VyX2JhY2tlbmRxAlUpZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5k\ncy5Nb2RlbEJhY2tlbmRxA1UNX2F1dGhfdXNlcl9pZHEEigEBdS4yYWRlM2I3ZDg1NDNjY2Y2OTUx\nN2E1ODlmZTllODRjZA==\n','2010-07-01 10:33:10'),('e47e64bdc317032acc14332f42443254','gAJ9cQEoVRJfYXV0aF91c2VyX2JhY2tlbmRxAlUpZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5k\ncy5Nb2RlbEJhY2tlbmRxA1UNX2F1dGhfdXNlcl9pZHEEigEBdS4yYWRlM2I3ZDg1NDNjY2Y2OTUx\nN2E1ODlmZTllODRjZA==\n','2010-07-16 15:51:42');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL auto_increment,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

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
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `registration_registrationprofile` (
  `id` int(11) NOT NULL auto_increment,
  `user_id` int(11) NOT NULL,
  `activation_key` varchar(40) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

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
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `tagging_tag` (
  `id` int(11) NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `tagging_tag`
--

LOCK TABLES `tagging_tag` WRITE;
/*!40000 ALTER TABLE `tagging_tag` DISABLE KEYS */;
INSERT INTO `tagging_tag` VALUES (1,'_behind_neck_split_jerk'),(2,'_split_jerk'),(3,'push_jerk'),(4,'_clean'),(5,'_jerk'),(6,'burpees'),(7,'_double_unders'),(8,'_5k'),(9,'running'),(10,'OH_Squat'),(11,'_Push_Press');
/*!40000 ALTER TABLE `tagging_tag` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tagging_taggeditem`
--

DROP TABLE IF EXISTS `tagging_taggeditem`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `tagging_taggeditem` (
  `id` int(11) NOT NULL auto_increment,
  `tag_id` int(11) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `object_id` int(10) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `tag_id` (`tag_id`,`content_type_id`,`object_id`),
  KEY `tagging_taggeditem_tag_id` (`tag_id`),
  KEY `tagging_taggeditem_content_type_id` (`content_type_id`),
  KEY `tagging_taggeditem_object_id` (`object_id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `tagging_taggeditem`
--

LOCK TABLES `tagging_taggeditem` WRITE;
/*!40000 ALTER TABLE `tagging_taggeditem` DISABLE KEYS */;
INSERT INTO `tagging_taggeditem` VALUES (1,1,10,1),(2,2,10,1),(3,3,10,1),(4,4,10,2),(5,5,10,2),(6,6,10,2),(7,7,10,3),(8,6,10,3),(9,8,10,4),(10,9,10,4),(11,10,10,5),(12,11,10,5),(13,9,10,7);
/*!40000 ALTER TABLE `tagging_taggeditem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workouts_result`
--

DROP TABLE IF EXISTS `workouts_result`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `workouts_result` (
  `id` int(11) NOT NULL auto_increment,
  `tags` varchar(255) NOT NULL,
  `workout_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `dateslug` varchar(16) default NULL,
  `result` longtext NOT NULL,
  `notes` longtext,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `workouts_result_workout_id` (`workout_id`),
  KEY `workouts_result_user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `workouts_result`
--

LOCK TABLES `workouts_result` WRITE;
/*!40000 ALTER TABLE `workouts_result` DISABLE KEYS */;
INSERT INTO `workouts_result` VALUES (1,'',1,'2010-06-17','2010-06-17','made it to 155\r\nthen 165\r\nthen 175',NULL,1),(2,'',2,'2010-06-17','2010-06-17','11:59',NULL,1),(3,'',3,'2010-06-17','2010-06-17','23:45',NULL,1),(4,'',4,'2010-06-15','2010-06-15','22:19',NULL,1),(5,'',5,'2010-06-17','2010-06-17','115-125-135-135-145F-X\r\n135-145-155-165-175',NULL,1),(6,'',6,'2010-07-02','2010-07-02','15:03',NULL,1),(7,'',7,'2010-07-02','2010-07-02','zzz',NULL,1);
/*!40000 ALTER TABLE `workouts_result` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `workouts_workout`
--

DROP TABLE IF EXISTS `workouts_workout`;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
CREATE TABLE `workouts_workout` (
  `id` int(11) NOT NULL auto_increment,
  `slug` varchar(50) NOT NULL,
  `title` varchar(128) default NULL,
  `workout` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `workouts_workout_slug` (`slug`),
  KEY `workouts_workout_user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
SET character_set_client = @saved_cs_client;

--
-- Dumping data for table `workouts_workout`
--

LOCK TABLES `workouts_workout` WRITE;
/*!40000 ALTER TABLE `workouts_workout` DISABLE KEYS */;
INSERT INTO `workouts_workout` VALUES (1,'push-split-behind','Push Split Behind','Push Jerk 5 x 3 (180sec) rest\r\n\r\nSplit Jerk 3 x 3 (180sec) rest\r\n\r\nBehind the Neck Split Jerk 3 x 1 (180-210sec) rest',1),(2,'wednesday-june-23-2010','Wednesday, June 23, 2010','10-9-8-7-6-5-4-3-2-1\r\n\r\n95# bar Clean & Jerk\r\nBurpees',1),(3,'amanda','Amanda','5 Rounds For Time Of:\r\n100 Double Unders\r\n20 Burpees',1),(4,'5k','5k','Run 5k',1),(5,'tuesday-june-29-2010','Tuesday, June 29, 2010','OH Squats - 2, 2, 2, 2, 2, 2\r\nPush Press - 3, 3, 3, 2, 2\r\n\r\n4 Rounds For Time of:\r\n10 Meter Overhead Lunge Walk @ 35/25 lbs\r\n8 Supine Ring Rows\r\n20 Meter Shuttle Sprint (down/back)\r\n8 DB Cleans 35lbs',1),(6,'friday-july-02-2010','Friday, July 02, 2010','Ten rounds for time of:\r\n10 Pull-ups\r\n10 Dips\r\n10 Sit-ups\r\n10 Squats',1),(7,'friday-july-02-2010-1','Friday, July 02, 2010','tabatta run\r\n\r\n3x legblaaster on the 2:30',1);
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

-- Dump completed on 2010-07-02 23:13:38
