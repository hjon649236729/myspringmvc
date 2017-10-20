/*
Navicat MySQL Data Transfer

Source Server         : root
Source Server Version : 50716
Source Host           : localhost:3306
Source Database       : springmvc

Target Server Type    : MYSQL
Target Server Version : 50716
File Encoding         : 65001

Date: 2017-10-20 19:14:49
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for auth_userinfo
-- ----------------------------
DROP TABLE IF EXISTS `auth_userinfo`;
CREATE TABLE `auth_userinfo` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `userName` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `passWord` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `empName` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `createTime` timestamp NULL DEFAULT NULL,
  `updateTime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of auth_userinfo
-- ----------------------------
INSERT INTO `auth_userinfo` VALUES ('1', 'admin', 'admin', '管理员', '2017-10-18 10:36:28', '2017-10-18 10:36:36');
INSERT INTO `auth_userinfo` VALUES ('2', 'user2', 'user1', '用戶1', '2017-10-18 10:36:28', '2017-10-18 10:36:36');
INSERT INTO `auth_userinfo` VALUES ('3', 'user3', 'user1', '用戶1', '2017-10-18 10:36:28', '2017-10-18 10:36:36');
INSERT INTO `auth_userinfo` VALUES ('4', 'user4', 'user1', '用戶1', '2017-10-18 10:36:28', '2017-10-18 10:36:36');
INSERT INTO `auth_userinfo` VALUES ('5', 'user5', 'user1', '用戶1', '2017-10-18 10:36:28', '2017-10-18 10:36:36');
INSERT INTO `auth_userinfo` VALUES ('6', 'user6', 'user1', '用戶1', '2017-10-18 10:36:28', '2017-10-18 10:36:36');
INSERT INTO `auth_userinfo` VALUES ('7', 'user7', 'user1', '用戶1', '2017-10-18 10:36:28', '2017-10-18 10:36:36');
INSERT INTO `auth_userinfo` VALUES ('8', 'user8', 'user1', '用戶1', '2017-10-18 10:36:28', '2017-10-18 10:36:36');
INSERT INTO `auth_userinfo` VALUES ('9', 'user9', 'user1', '用戶1', '2017-10-18 10:36:28', '2017-10-18 10:36:36');
INSERT INTO `auth_userinfo` VALUES ('10', 'user10', 'user1', '用戶1', '2017-10-18 10:36:28', '2017-10-18 10:36:36');
INSERT INTO `auth_userinfo` VALUES ('11', 'user11', 'user1', '用戶1', '2017-10-18 10:36:28', '2017-10-18 10:36:36');
INSERT INTO `auth_userinfo` VALUES ('12', 'user12', 'user1', '用戶1', '2017-10-18 10:36:28', '2017-10-18 10:36:36');
INSERT INTO `auth_userinfo` VALUES ('13', 'user13', 'user1', '用戶1', '2017-10-18 10:36:28', '2017-10-18 10:36:36');
INSERT INTO `auth_userinfo` VALUES ('14', 'user14', 'user1', '用戶1', '2017-10-18 10:36:28', '2017-10-18 10:36:36');
INSERT INTO `auth_userinfo` VALUES ('15', 'user15', 'user1', '用戶1', '2017-10-18 10:36:28', '2017-10-18 10:36:36');
INSERT INTO `auth_userinfo` VALUES ('16', 'user16', 'user1', '用戶1', '2017-10-18 10:36:28', '2017-10-18 10:36:36');
INSERT INTO `auth_userinfo` VALUES ('17', 'user17', 'user1', '用戶1', '2017-10-18 10:36:28', '2017-10-18 10:36:36');
INSERT INTO `auth_userinfo` VALUES ('18', 'user18', 'user1', '用戶1', '2017-10-18 10:36:28', '2017-10-18 10:36:36');
INSERT INTO `auth_userinfo` VALUES ('19', 'user19', 'user1', '用戶1', '2017-10-18 10:36:28', '2017-10-18 10:36:36');
INSERT INTO `auth_userinfo` VALUES ('20', 'user20', 'user1', '用戶1', '2017-10-18 10:36:28', '2017-10-18 10:36:36');
INSERT INTO `auth_userinfo` VALUES ('21', 'user21', 'user1', '用戶1', '2017-10-18 10:36:28', '2017-10-18 10:36:36');
INSERT INTO `auth_userinfo` VALUES ('22', 'user22', 'user1', '用戶1', '2017-10-18 10:36:28', '2017-10-18 10:36:36');
INSERT INTO `auth_userinfo` VALUES ('23', 'user1', 'user1', '用戶1', '2017-10-18 10:36:28', '2017-10-18 10:36:36');
INSERT INTO `auth_userinfo` VALUES ('24', 'sadfasd森远股份塔顶地大柳塔在地', '111', '模压村李厚霖暮云春树下大雨要在', '2017-10-20 12:30:19', '2017-10-20 12:30:19');

-- ----------------------------
-- Table structure for common_enum
-- ----------------------------
DROP TABLE IF EXISTS `common_enum`;
CREATE TABLE `common_enum` (
  `id` int(20) NOT NULL,
  `module` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `text` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of common_enum
-- ----------------------------

-- ----------------------------
-- Table structure for common_setting
-- ----------------------------
DROP TABLE IF EXISTS `common_setting`;
CREATE TABLE `common_setting` (
  `id` bigint(20) NOT NULL,
  `module` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `remark` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `createtime` datetime DEFAULT NULL,
  `createuser` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of common_setting
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers` (
  `SCHED_NAME` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `BLOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars` (
  `SCHED_NAME` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `CALENDAR_NAME` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `CALENDAR` blob NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`CALENDAR_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers` (
  `SCHED_NAME` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `CRON_EXPRESSION` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `TIME_ZONE_ID` varchar(80) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------
INSERT INTO `qrtz_cron_triggers` VALUES ('DefaultQuartzScheduler', '动态任务触发器1', 'XLXXCC_JOB_GROUP', '0/1 * * * * ?', 'Asia/Shanghai');

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers` (
  `SCHED_NAME` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `ENTRY_ID` varchar(95) COLLATE utf8_unicode_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `FIRED_TIME` bigint(13) NOT NULL,
  `SCHED_TIME` bigint(13) NOT NULL,
  `PRIORITY` int(11) NOT NULL,
  `STATE` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `JOB_NAME` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `JOB_GROUP` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `IS_NONCONCURRENT` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `REQUESTS_RECOVERY` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`ENTRY_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------
INSERT INTO `qrtz_fired_triggers` VALUES ('DefaultQuartzScheduler', 'NON_CLUSTERED1508490241370', '动态任务触发器1', 'XLXXCC_JOB_GROUP', 'NON_CLUSTERED', '1508492571092', '1508492572000', '5', 'ACQUIRED', null, null, '0', '0');

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details` (
  `SCHED_NAME` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `JOB_NAME` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `JOB_GROUP` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `DESCRIPTION` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `JOB_CLASS_NAME` varchar(250) COLLATE utf8_unicode_ci NOT NULL,
  `IS_DURABLE` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `IS_NONCONCURRENT` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `IS_UPDATE_DATA` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `REQUESTS_RECOVERY` varchar(1) COLLATE utf8_unicode_ci NOT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------
INSERT INTO `qrtz_job_details` VALUES ('DefaultQuartzScheduler', '动态任务调度1', 'XLXXCC_JOB_GROUP', null, 'com.hjon.modules.auth.job.AuthJob', '0', '1', '1', '0', 0x230D0A23467269204F63742032302031373A34303A33382043535420323031370D0A);

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks` (
  `SCHED_NAME` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `LOCK_NAME` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`LOCK_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps` (
  `SCHED_NAME` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state` (
  `SCHED_NAME` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `INSTANCE_NAME` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `LAST_CHECKIN_TIME` bigint(13) NOT NULL,
  `CHECKIN_INTERVAL` bigint(13) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`INSTANCE_NAME`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers` (
  `SCHED_NAME` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `REPEAT_COUNT` bigint(7) NOT NULL,
  `REPEAT_INTERVAL` bigint(12) NOT NULL,
  `TIMES_TRIGGERED` bigint(10) NOT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers` (
  `SCHED_NAME` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `STR_PROP_1` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `STR_PROP_2` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `STR_PROP_3` varchar(512) COLLATE utf8_unicode_ci DEFAULT NULL,
  `INT_PROP_1` int(11) DEFAULT NULL,
  `INT_PROP_2` int(11) DEFAULT NULL,
  `LONG_PROP_1` bigint(20) DEFAULT NULL,
  `LONG_PROP_2` bigint(20) DEFAULT NULL,
  `DEC_PROP_1` decimal(13,4) DEFAULT NULL,
  `DEC_PROP_2` decimal(13,4) DEFAULT NULL,
  `BOOL_PROP_1` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  `BOOL_PROP_2` varchar(1) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`) REFERENCES `qrtz_triggers` (`SCHED_NAME`, `TRIGGER_NAME`, `TRIGGER_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers` (
  `SCHED_NAME` varchar(120) COLLATE utf8_unicode_ci NOT NULL,
  `TRIGGER_NAME` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `TRIGGER_GROUP` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `JOB_NAME` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `JOB_GROUP` varchar(200) COLLATE utf8_unicode_ci NOT NULL,
  `DESCRIPTION` varchar(250) COLLATE utf8_unicode_ci DEFAULT NULL,
  `NEXT_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PREV_FIRE_TIME` bigint(13) DEFAULT NULL,
  `PRIORITY` int(11) DEFAULT NULL,
  `TRIGGER_STATE` varchar(16) COLLATE utf8_unicode_ci NOT NULL,
  `TRIGGER_TYPE` varchar(8) COLLATE utf8_unicode_ci NOT NULL,
  `START_TIME` bigint(13) NOT NULL,
  `END_TIME` bigint(13) DEFAULT NULL,
  `CALENDAR_NAME` varchar(200) COLLATE utf8_unicode_ci DEFAULT NULL,
  `MISFIRE_INSTR` smallint(2) DEFAULT NULL,
  `JOB_DATA` blob,
  PRIMARY KEY (`SCHED_NAME`,`TRIGGER_NAME`,`TRIGGER_GROUP`),
  KEY `SCHED_NAME` (`SCHED_NAME`,`JOB_NAME`,`JOB_GROUP`),
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`) REFERENCES `qrtz_job_details` (`SCHED_NAME`, `JOB_NAME`, `JOB_GROUP`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
INSERT INTO `qrtz_triggers` VALUES ('DefaultQuartzScheduler', '动态任务触发器1', 'XLXXCC_JOB_GROUP', '动态任务调度1', 'XLXXCC_JOB_GROUP', null, '1508492572000', '1508492571000', '5', 'ACQUIRED', 'CRON', '1508492438000', '0', null, '0', '');
