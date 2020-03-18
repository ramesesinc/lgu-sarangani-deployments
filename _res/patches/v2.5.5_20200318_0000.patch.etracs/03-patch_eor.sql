-- 
-- NOTE: Please use Navicat in running the scripts below
-- 
-- 1. Connect to EOR database 
-- 2. Execute the following scripts below: 
--
CREATE DATABASE eor CHARACTER SET utf8; 
USE eor; 

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for eor
-- ----------------------------
DROP TABLE IF EXISTS `eor`;
CREATE TABLE `eor` (
  `objid` varchar(50) NOT NULL,
  `receiptno` varchar(50) NULL,
  `receiptdate` date NULL,
  `txndate` datetime NULL,
  `state` varchar(10) NULL,
  `partnerid` varchar(50) NULL,
  `txntype` varchar(20) NULL,
  `traceid` varchar(50) NULL,
  `tracedate` datetime NULL,
  `refid` varchar(50) NULL,
  `paidby` varchar(255) NULL,
  `paidbyaddress` varchar(255) NULL,
  `payer_objid` varchar(50) NULL,
  `paymethod` varchar(20) NULL,
  `paymentrefid` varchar(50) NULL,
  `remittanceid` varchar(50) NULL,
  `remarks` varchar(255) NULL,
  `amount` decimal(16,4) NULL,
  PRIMARY KEY (`objid`),
  UNIQUE KEY `uix_eor_receiptno` (`receiptno`),
  KEY `ix_receiptdate` (`receiptdate`),
  KEY `ix_txndate` (`txndate`),
  KEY `ix_partnerid` (`partnerid`),
  KEY `ix_traceid` (`traceid`),
  KEY `ix_refid` (`refid`),
  KEY `ix_paidby` (`paidby`),
  KEY `ix_payer_objid` (`payer_objid`),
  KEY `ix_paymentrefid` (`paymentrefid`),
  KEY `ix_remittanceid` (`remittanceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for eor_item
-- ----------------------------
DROP TABLE IF EXISTS `eor_item`;
CREATE TABLE `eor_item` (
  `objid` varchar(50) NOT NULL,
  `parentid` varchar(50) NULL,
  `item_objid` varchar(50) NULL,
  `item_code` varchar(100) NULL,
  `item_title` varchar(100) NULL,
  `amount` decimal(16,4) NULL,
  `remarks` varchar(255) NULL,
  `item_fund_objid` varchar(50) NULL,
  PRIMARY KEY (`objid`),
  KEY `fk_eoritem_eor` (`parentid`),
  KEY `ix_item_objid` (`item_objid`),
  KEY `ix_item_fund_objid` (`item_fund_objid`),
  CONSTRAINT `fk_eoritem_eor` FOREIGN KEY (`parentid`) REFERENCES `eor` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for eor_number
-- ----------------------------
DROP TABLE IF EXISTS `eor_number`;
CREATE TABLE `eor_number` (
  `objid` varchar(255) NOT NULL,
  `currentno` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for eor_paymentorder
-- ----------------------------
DROP TABLE IF EXISTS `eor_paymentorder`;
CREATE TABLE `eor_paymentorder` (
  `objid` varchar(50) NOT NULL,
  `txndate` datetime NULL,
  `txntype` varchar(50) NULL,
  `txntypename` varchar(100) NULL,
  `payer_objid` varchar(50) NULL,
  `payer_name` text,
  `paidby` text,
  `paidbyaddress` varchar(150) NULL,
  `particulars` varchar(500) NULL,
  `amount` decimal(16,2) NULL,
  `expirydate` date NULL,
  `refid` varchar(50) NULL,
  `refno` varchar(50) NULL,
  `info` text,
  `origin` varchar(100) NULL,
  `controlno` varchar(50) NULL,
  `locationid` varchar(25) NULL,
  `items` mediumtext,
  `state` varchar(20) NULL,
  `email` varchar(255) NULL,
  `mobileno` varchar(50) NULL,
  `phoneno` varchar(50) NULL,
  PRIMARY KEY (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for eor_paymentorder_cancelled
-- ----------------------------
DROP TABLE IF EXISTS `eor_paymentorder_cancelled`;
CREATE TABLE `eor_paymentorder_cancelled` (
  `objid` varchar(50) NOT NULL,
  `txndate` datetime NULL,
  `txntype` varchar(50) NULL,
  `txntypename` varchar(100) NULL,
  `payer_objid` varchar(50) NULL,
  `payer_name` longtext,
  `paidby` longtext,
  `paidbyaddress` varchar(150) NULL,
  `particulars` text,
  `amount` decimal(16,2) NULL,
  `expirydate` date NULL,
  `refid` varchar(50) NULL,
  `refno` varchar(50) NULL,
  `info` longtext,
  `origin` varchar(100) NULL,
  `controlno` varchar(50) NULL,
  `locationid` varchar(25) NULL,
  `items` longtext,
  `state` varchar(10) NULL,
  `email` varchar(255) NULL,
  `mobileno` varchar(50) NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_txndate` (`txndate`),
  KEY `ix_txntype` (`txntype`),
  KEY `ix_payer_objid` (`payer_objid`),
  KEY `ix_payer_name` (`payer_name`(255)),
  KEY `ix_expirydate` (`expirydate`),
  KEY `ix_refid` (`refid`),
  KEY `ix_refno` (`refno`),
  KEY `ix_controlno` (`controlno`),
  KEY `ix_locationid` (`locationid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for eor_paymentorder_paid
-- ----------------------------
DROP TABLE IF EXISTS `eor_paymentorder_paid`;
CREATE TABLE `eor_paymentorder_paid` (
  `objid` varchar(50) NOT NULL,
  `txndate` datetime NULL,
  `txntype` varchar(50) NULL,
  `txntypename` varchar(100) NULL,
  `payer_objid` varchar(50) NULL,
  `payer_name` longtext,
  `paidby` longtext,
  `paidbyaddress` varchar(150) NULL,
  `particulars` text,
  `amount` decimal(16,2) NULL,
  `expirydate` date NULL,
  `refid` varchar(50) NULL,
  `refno` varchar(50) NULL,
  `info` longtext,
  `origin` varchar(100) NULL,
  `controlno` varchar(50) NULL,
  `locationid` varchar(25) NULL,
  `items` longtext,
  `state` varchar(10) NULL,
  `email` varchar(255) NULL,
  `mobileno` varchar(50) NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_txndate` (`txndate`),
  KEY `ix_txntype` (`txntype`),
  KEY `ix_payer_objid` (`payer_objid`),
  KEY `ix_payer_name` (`payer_name`(255)),
  KEY `ix_expirydate` (`expirydate`),
  KEY `ix_refid` (`refid`),
  KEY `ix_refno` (`refno`),
  KEY `ix_controlno` (`controlno`),
  KEY `ix_locationid` (`locationid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for eor_payment_error
-- ----------------------------
DROP TABLE IF EXISTS `eor_payment_error`;
CREATE TABLE `eor_payment_error` (
  `objid` varchar(50) NOT NULL,
  `txndate` datetime NOT NULL,
  `txntype` varchar(50) NOT NULL,
  `paymentrefid` varchar(50) NOT NULL,
  `errmsg` text NOT NULL,
  `errdetail` longtext,
  PRIMARY KEY (`objid`),
  KEY `ix_txndate` (`txndate`),
  KEY `ix_txntype` (`txntype`),
  KEY `ix_paymentrefid` (`paymentrefid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for eor_remittance
-- ----------------------------
DROP TABLE IF EXISTS `eor_remittance`;
CREATE TABLE `eor_remittance` (
  `objid` varchar(50) NOT NULL,
  `state` varchar(50) NULL,
  `controlno` varchar(50) NULL,
  `partnerid` varchar(50) NULL,
  `controldate` date NULL,
  `dtcreated` datetime NULL,
  `createdby_objid` varchar(50) NULL,
  `createdby_name` varchar(255) NULL,
  `amount` decimal(16,4) NULL,
  `dtposted` datetime NULL,
  `postedby_objid` varchar(50) NULL,
  `postedby_name` varchar(255) NULL,
  PRIMARY KEY (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for eor_remittance_fund
-- ----------------------------
DROP TABLE IF EXISTS `eor_remittance_fund`;
CREATE TABLE `eor_remittance_fund` (
  `objid` varchar(100) NOT NULL,
  `remittanceid` varchar(50) NULL,
  `fund_objid` varchar(50) NULL,
  `fund_code` varchar(50) NULL,
  `fund_title` varchar(255) NULL,
  `amount` decimal(16,4) NULL,
  `bankaccount_objid` varchar(50) NULL,
  `bankaccount_title` varchar(255) NULL,
  `bankaccount_bank_name` varchar(255) NULL,
  `validation_refno` varchar(50) NULL,
  `validation_refdate` date NULL,
  PRIMARY KEY (`objid`),
  KEY `fk_eor_remittance_fund_remittance` (`remittanceid`),
  CONSTRAINT `fk_eor_remittance_fund_remittance` FOREIGN KEY (`remittanceid`) REFERENCES `eor_remittance` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for eor_share
-- ----------------------------
DROP TABLE IF EXISTS `eor_share`;
CREATE TABLE `eor_share` (
  `objid` varchar(50) NOT NULL,
  `parentid` varchar(50) NOT NULL,
  `refitem_objid` varchar(50) NULL,
  `refitem_code` varchar(25) NULL,
  `refitem_title` varchar(255) NULL,
  `payableitem_objid` varchar(50) NULL,
  `payableitem_code` varchar(25) NULL,
  `payableitem_title` varchar(255) NULL,
  `amount` decimal(16,4) NULL,
  `share` decimal(16,2) NULL,
  PRIMARY KEY (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for paymentpartner
-- ----------------------------
DROP TABLE IF EXISTS `paymentpartner`;
CREATE TABLE `paymentpartner` (
  `objid` varchar(50) NOT NULL,
  `code` varchar(50) NULL,
  `name` varchar(100) NULL,
  `branch` varchar(255) NULL,
  `contact` varchar(255) NULL,
  `mobileno` varchar(32) NULL,
  `phoneno` varchar(32) NULL,
  `email` varchar(255) NULL,
  `indexno` varchar(3) NULL,
  PRIMARY KEY (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for unpostedpayment
-- ----------------------------
DROP TABLE IF EXISTS `unpostedpayment`;
CREATE TABLE `unpostedpayment` (
  `objid` varchar(50) NOT NULL,
  `txndate` datetime NOT NULL,
  `txntype` varchar(50) NOT NULL,
  `txntypename` varchar(150) NOT NULL,
  `paymentrefid` varchar(50) NOT NULL,
  `amount` decimal(16,2) NOT NULL,
  `orgcode` varchar(20) NOT NULL,
  `partnerid` varchar(50) NOT NULL,
  `traceid` varchar(100) NOT NULL,
  `tracedate` datetime NOT NULL,
  `refno` varchar(50) NULL,
  `origin` varchar(50) NULL,
  `paymentorder` longtext,
  `errmsg` text NOT NULL,
  `errdetail` longtext,
  PRIMARY KEY (`objid`),
  UNIQUE KEY `ix_paymentrefid` (`paymentrefid`),
  KEY `ix_txndate` (`txndate`),
  KEY `ix_txntype` (`txntype`),
  KEY `ix_partnerid` (`partnerid`),
  KEY `ix_traceid` (`traceid`),
  KEY `ix_tracedate` (`tracedate`),
  KEY `ix_refno` (`refno`),
  KEY `ix_origin` (`origin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET FOREIGN_KEY_CHECKS=1;

INSERT INTO `paymentpartner` (`objid`, `code`, `name`, `branch`, `contact`, `mobileno`, `phoneno`, `email`, `indexno`) VALUES ('DBP', '101', 'DEVELOPMENT BANK OF THE PHILIPPINES', NULL, NULL, NULL, NULL, NULL, '101');
INSERT INTO `paymentpartner` (`objid`, `code`, `name`, `branch`, `contact`, `mobileno`, `phoneno`, `email`, `indexno`) VALUES ('LBP', '102', 'LAND BANK OF THE PHILIPPINES', NULL, NULL, NULL, NULL, NULL, '102');
