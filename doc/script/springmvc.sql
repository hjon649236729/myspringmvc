/*
Navicat MySQL Data Transfer

Source Server         : hzz
Source Server Version : 50716
Source Host           : localhost:3306
Source Database       : springmvc

Target Server Type    : MYSQL
Target Server Version : 50716
File Encoding         : 65001

Date: 2017-10-18 18:23:01
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for auth_userinfo
-- ----------------------------
DROP TABLE IF EXISTS `auth_userinfo`;
CREATE TABLE `auth_userinfo` (
  `id` int(20) NOT NULL,
  `userName` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `passWord` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `empName` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `createTime` timestamp NULL DEFAULT NULL,
  `updateTime` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

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
