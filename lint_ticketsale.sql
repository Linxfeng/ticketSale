/*
SQLyog Ultimate v11.26 (32 bit)
MySQL - 5.5.28 : Database - ticketsale
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`ticketsale` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `ticketsale`;

/*Table structure for table `advert` */

DROP TABLE IF EXISTS `advert`;

CREATE TABLE `advert` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL COMMENT '标题',
  `content` varchar(255) NOT NULL COMMENT '内容',
  `create_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `del` int(1) NOT NULL DEFAULT '0' COMMENT '是否有效，0有效，1失效',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

/*Data for the table `advert` */

insert  into `advert`(`id`,`title`,`content`,`create_time`,`del`) values (1,'国庆火车票大减价！庆祝祖国生日！','新华社北京9月29日新媒体专电（记者王贤 李思远）近日有网友爆料称，部分列车票价“十一”前后不一致，质疑12306网站系统出了问题。铁路部门回应：十一前这些车次的票价其实是打折之后的价格，十一期间调整为原价，故票价有所上涨。','2017-09-13 08:13:12',0),(2,'武汉铁路局关于2017年9月加开部分旅客列车的公告','1、2017年09月30日至2017年10月08日南昌-西安间每日加开K790/1次。\r\n2、2017年10月01日至2017年10月09日西安-南昌间每日加开K792/89次。\r\n3、2017年9月29,30日,10月3,4,7,8日沈阳北-福州间加开K668/5次。\r\n4、2017年10月1,2,5,6,9,10日福州-沈阳北间加开K666/7次。\r\n具体详情请登陆WWW.12306.CN网站查询，如有变化请以车站当日公告为准。','2017-09-21 10:28:39',0),(3,'广铁集团公司关于2017年国庆增开部分旅客列车的公告','1、2017年10月1日、10月7日、10月8日、10月9日增开广州东--九江K4257/8次旅客列车；\r\n2、2017年10月1日、10月7日、10月8日、10月9日增开深圳东--南昌K4356次旅客列车；\r\n3、2017年10月1日、10月7日、10月8日、10月9日增开广州东--厦门K4377/6/7次旅客列车；\r\n  具体详情请登录www.12306.cn网站查询，并以车站当日公告为准。','2017-09-20 10:30:01',0),(4,'关于调整互联网、电话订票起售时间的公告','自2014年11月28日起，铁路部门将对互联网、电话订票的起售时间进行调整。放票时间点从16个调整为21个，即8：00至18：00期间，每个整点和半点均有新票起售，同时C、D、G字头列车不再单独起售，起售时间与车站保持一致。','2017-09-20 10:30:30',0),(5,'太原铁路局关于加开旅客列车的公告','2017年09月28日至2017年10月08日河津-北京西间每日加开K4098次，\r\n2017年09月29日至2017年10月09日北京西-临汾间每日加开K4097次。','2017-09-19 11:12:36',0),(6,'广铁集团公司关于开行石长线动车组旅客列车的公告','　2017年9月21日起，石长铁路正式开行长沙站至常德站、石门县北站的动车组列车，具体车次如下：\r\n　　1、自2017年9月21日起，开行长沙—石门县北D7574次、D7570次、D7566次旅客列车。\r\n　　2、自2017年9月21日起，开行石门县北—长沙D7573次、D7567次旅客列车。\r\n　　3、自2017年9月21日起，开行长沙—常德D7576次、D7572次旅客列车。\r\n 具体详情请登录www.12306.cn网站查询，并以车站当日公告为准。','2017-09-18 11:13:33',0),(7,'广铁集团恢复开行部分旅客列车的公告','　1、2017年9月14日，深圳北至温州南恢复开行D2294次旅客列车。\r\n　　2、2017年9月14日，深圳北至南京恢复开行D2282次旅客列车。\r\n　　3、2017年9月14日，深圳北至上海虹桥恢复开行D2284次旅客列车。\r\n具体详情请登录www.12306.cn网站查询，并以车站当日公告为准。','2017-09-16 11:15:36',0),(8,'海南环岛线部分旅客列车临时停运的公告','1、2017年9月15日三亚开D7206次，海口开D7207次旅客列车临时停运。\r\n2、2017年9月15日三亚开D7204、D7208、D7212次，海口开D7205、D7209次旅客列车临时停运。\r\n3、2017年9月15日三亚开D7310、D7324、D7344次，海口东开D7317、D7333、D7345次旅客列车临时停运。\r\n具体详情请登录www.12306.cn网站查询，并以车站当日公告为准。','2017-09-14 11:16:20',1),(9,'1231测试','1212312121','2017-09-20 09:46:23',1),(10,'标题','内容','2019-04-23 10:05:42',1),(11,'标题','内容','2019-04-23 10:11:39',1),(12,'测试公告标题','测试公告内容','2019-04-23 10:16:36',1),(13,'标题','内容','2019-04-23 10:17:50',1),(14,'测试123','测试111','2019-04-23 10:22:51',1),(15,'测试111','测试111111111','2019-04-23 10:23:20',1),(16,'测试111','啊啊啊啊啊啊啊啊','2019-04-23 13:00:20',1);

/*Table structure for table `order` */

DROP TABLE IF EXISTS `order`;

CREATE TABLE `order` (
  `oid` varchar(32) NOT NULL,
  `uid` varchar(32) NOT NULL,
  `pid` varchar(32) NOT NULL,
  `tid` varchar(10) NOT NULL,
  `start_station` varchar(20) NOT NULL,
  `start_time` datetime NOT NULL,
  `end_station` varchar(20) NOT NULL,
  `endtime` datetime NOT NULL,
  `seat_type` int(1) NOT NULL,
  `amount` double NOT NULL,
  `order_status` int(1) NOT NULL DEFAULT '0',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `del` int(1) DEFAULT '0',
  PRIMARY KEY (`oid`),
  KEY `uid` (`uid`),
  KEY `pid` (`pid`),
  KEY `tid` (`tid`),
  CONSTRAINT `order_passenger` FOREIGN KEY (`pid`) REFERENCES `passenger` (`pid`),
  CONSTRAINT `order_train` FOREIGN KEY (`tid`) REFERENCES `train` (`tid`),
  CONSTRAINT `order_user` FOREIGN KEY (`uid`) REFERENCES `user_info` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `order` */

/*Table structure for table `passenger` */

DROP TABLE IF EXISTS `passenger`;

CREATE TABLE `passenger` (
  `pid` varchar(32) NOT NULL,
  `uid` varchar(32) NOT NULL,
  `true_name` varchar(20) NOT NULL,
  `id_card` varchar(20) NOT NULL,
  `role` int(1) NOT NULL DEFAULT '0',
  `del` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`pid`),
  KEY `P_UID` (`uid`),
  CONSTRAINT `P_UID` FOREIGN KEY (`uid`) REFERENCES `user_info` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `passenger` */

insert  into `passenger`(`pid`,`uid`,`true_name`,`id_card`,`role`,`del`) values ('1554645635284698','1554086717367104','测试','123456789012345678',0,0),('1554646963127107','1554086717367104','测试','123456789098765431',0,0),('1554647001539758','1554086717367104','测试','123456789098765432',1,0);

/*Table structure for table `station` */

DROP TABLE IF EXISTS `station`;

CREATE TABLE `station` (
  `id` varchar(32) NOT NULL,
  `tid` varchar(10) NOT NULL,
  `name1` varchar(20) NOT NULL,
  `time1` time NOT NULL,
  `name2` varchar(20) NOT NULL,
  `time2` time NOT NULL,
  `is_next_day` int(1) DEFAULT '0',
  `ticket` int(5) DEFAULT NULL,
  `money` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `tid` (`tid`),
  KEY `name1` (`name1`),
  KEY `name2` (`name2`),
  CONSTRAINT `S_TID` FOREIGN KEY (`tid`) REFERENCES `train` (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `station` */

insert  into `station`(`id`,`tid`,`name1`,`time1`,`name2`,`time2`,`is_next_day`,`ticket`,`money`) values ('1555413202375622','D2206','上海','09:30:00','杭州','10:40:00',0,100,60),('1555413202375782','D2206','杭州','12:10:00','苏州','13:30:00',0,180,50),('1555416796697793','D352','上海','12:00:00','杭州','13:00:00',0,200,70),('1555416796697920','D352','北京','09:00:00','上海','11:00:00',0,100,80),('1555416796697982','D352','杭州','14:00:00','苏州','15:00:00',0,200,50),('1555553070020346','T112','上海','10:25:00','杭州','12:20:00',0,100,28),('1555553070020655','T112','杭州','12:25:00','苏州','14:20:00',0,100,36),('1555553070020794','T112','北京','09:20:00','上海','10:20:00',0,100,20);

/*Table structure for table `t_advert` */

DROP TABLE IF EXISTS `t_advert`;

CREATE TABLE `t_advert` (
  `aid` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL,
  `content` varchar(255) NOT NULL,
  `sendtime` datetime NOT NULL,
  `del` int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`aid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `t_advert` */

insert  into `t_advert`(`aid`,`title`,`content`,`sendtime`,`del`) values (1,'国庆火车票大减价！庆祝祖国生日！','新华社北京9月29日新媒体专电（记者王贤 李思远）近日有网友爆料称，部分列车票价“十一”前后不一致，质疑12306网站系统出了问题。铁路部门回应：十一前这些车次的票价其实是打折之后的价格，十一期间调整为原价，故票价有所上涨。','2017-09-13 08:13:12',1),(2,'武汉铁路局关于2017年9月加开部分旅客列车的公告','1、2017年09月30日至2017年10月08日南昌-西安间每日加开K790/1次。\r\n2、2017年10月01日至2017年10月09日西安-南昌间每日加开K792/89次。\r\n3、2017年9月29,30日,10月3,4,7,8日沈阳北-福州间加开K668/5次。\r\n4、2017年10月1,2,5,6,9,10日福州-沈阳北间加开K666/7次。\r\n具体详情请登陆WWW.12306.CN网站查询，如有变化请以车站当日公告为准。','2017-09-21 10:28:39',0),(3,'广铁集团公司关于2017年国庆增开部分旅客列车的公告','1、2017年10月1日、10月7日、10月8日、10月9日增开广州东--九江K4257/8次旅客列车；\r\n2、2017年10月1日、10月7日、10月8日、10月9日增开深圳东--南昌K4356次旅客列车；\r\n3、2017年10月1日、10月7日、10月8日、10月9日增开广州东--厦门K4377/6/7次旅客列车；\r\n  具体详情请登录www.12306.cn网站查询，并以车站当日公告为准。','2017-09-20 10:30:01',0),(4,'关于调整互联网、电话订票起售时间的公告','自2014年11月28日起，铁路部门将对互联网、电话订票的起售时间进行调整。放票时间点从16个调整为21个，即8：00至18：00期间，每个整点和半点均有新票起售，同时C、D、G字头列车不再单独起售，起售时间与车站保持一致。','2017-09-20 10:30:30',0),(5,'太原铁路局关于加开旅客列车的公告','2017年09月28日至2017年10月08日河津-北京西间每日加开K4098次，\r\n2017年09月29日至2017年10月09日北京西-临汾间每日加开K4097次。','2017-09-19 11:12:36',0),(6,'广铁集团公司关于开行石长线动车组旅客列车的公告','　2017年9月21日起，石长铁路正式开行长沙站至常德站、石门县北站的动车组列车，具体车次如下：\r\n　　1、自2017年9月21日起，开行长沙—石门县北D7574次、D7570次、D7566次旅客列车。\r\n　　2、自2017年9月21日起，开行石门县北—长沙D7573次、D7567次旅客列车。\r\n　　3、自2017年9月21日起，开行长沙—常德D7576次、D7572次旅客列车。\r\n 具体详情请登录www.12306.cn网站查询，并以车站当日公告为准。','2017-09-18 11:13:33',0),(7,'广铁集团恢复开行部分旅客列车的公告','　1、2017年9月14日，深圳北至温州南恢复开行D2294次旅客列车。\r\n　　2、2017年9月14日，深圳北至南京恢复开行D2282次旅客列车。\r\n　　3、2017年9月14日，深圳北至上海虹桥恢复开行D2284次旅客列车。\r\n具体详情请登录www.12306.cn网站查询，并以车站当日公告为准。','2017-09-16 11:15:36',0),(8,'海南环岛线部分旅客列车临时停运的公告','1、2017年9月15日三亚开D7206次，海口开D7207次旅客列车临时停运。\r\n2、2017年9月15日三亚开D7204、D7208、D7212次，海口开D7205、D7209次旅客列车临时停运。\r\n3、2017年9月15日三亚开D7310、D7324、D7344次，海口东开D7317、D7333、D7345次旅客列车临时停运。\r\n具体详情请登录www.12306.cn网站查询，并以车站当日公告为准。','2017-09-14 11:16:20',1),(9,'1231测试','1212312121','2017-09-20 09:46:23',1);

/*Table structure for table `t_order` */

DROP TABLE IF EXISTS `t_order`;

CREATE TABLE `t_order` (
  `oid` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `pid` int(11) NOT NULL,
  `tid` varchar(10) NOT NULL,
  `s_start` varchar(20) NOT NULL,
  `starttime` datetime NOT NULL,
  `s_end` varchar(20) NOT NULL,
  `endtime` datetime NOT NULL,
  `createtime` datetime NOT NULL,
  `stype` varchar(20) NOT NULL,
  `money` double NOT NULL,
  `otype` int(2) NOT NULL DEFAULT '0',
  `del` int(2) NOT NULL DEFAULT '0',
  PRIMARY KEY (`oid`),
  KEY `uid` (`uid`),
  KEY `pid` (`pid`),
  KEY `t_order_ibfk_3` (`tid`),
  CONSTRAINT `t_order_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `t_user` (`uid`),
  CONSTRAINT `t_order_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `t_passenger` (`pid`),
  CONSTRAINT `t_order_ibfk_3` FOREIGN KEY (`tid`) REFERENCES `t_train` (`tid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `t_order` */

insert  into `t_order`(`oid`,`uid`,`pid`,`tid`,`s_start`,`starttime`,`s_end`,`endtime`,`createtime`,`stype`,`money`,`otype`,`del`) values (1,1,1,'T112','嘉兴','2017-09-11 11:22:57','苏州','2017-09-11 13:08:32','2017-09-10 21:36:00','硬座',48.5,1,0),(2,1,2,'T112','杭州','2017-09-11 10:23:04','苏州','2017-09-11 13:08:25','2017-09-11 21:36:23','硬卧',142.8,1,1),(3,1,1,'T112','嘉兴','2017-09-11 11:22:57','苏州','2017-09-11 13:08:32','2017-09-10 21:36:00','硬座',48.5,0,0),(4,2,4,'T204','昆山','2017-09-13 12:39:26','镇江','2017-09-13 14:54:40','2017-09-13 08:39:53','硬座',96.6,0,0),(5,1,2,'D2206','苏州','2017-09-30 07:18:00','南京','2017-09-30 09:13:00','2017-09-19 06:53:16','二等座',186.5,0,0),(6,1,6,'D2206','昆山','2017-09-30 08:42:00','南京','2017-09-30 07:16:00','2017-09-19 10:19:29','二等座',186.5,0,0),(7,1,6,'D2206','昆山','2017-09-30 08:42:00','南京','2017-09-30 07:16:00','2017-09-19 10:19:43','二等座',186.5,0,0),(8,1,6,'D2206','昆山','2017-09-30 08:42:00','南京','2017-09-30 07:16:00','2017-09-19 10:20:56','二等座',186.5,0,0),(9,1,6,'D2206','昆山','2017-09-30 08:42:00','南京','2017-09-30 07:16:00','2017-09-19 10:22:17','二等座',186.5,0,0);

/*Table structure for table `t_passenger` */

DROP TABLE IF EXISTS `t_passenger`;

CREATE TABLE `t_passenger` (
  `pid` int(11) NOT NULL AUTO_INCREMENT,
  `truename` varchar(20) NOT NULL,
  `idcard` varchar(20) NOT NULL,
  `role` int(2) NOT NULL DEFAULT '0',
  `del` int(2) DEFAULT '0',
  PRIMARY KEY (`pid`),
  UNIQUE KEY `idcard` (`idcard`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Data for the table `t_passenger` */

insert  into `t_passenger`(`pid`,`truename`,`idcard`,`role`,`del`) values (1,'张飞','332654187915647821',1,0),(2,'程咬金','332654199508212289',0,0),(3,'诸葛亮','332654199508152267',0,0),(4,'花木兰','332654199510092216',0,0),(5,'小南瓜','121214522014202248',1,0),(6,'小王','121214522014202279',0,0),(7,'狗狗','123456789123456144',0,0),(8,'李晓华','154156654563454544',1,0);

/*Table structure for table `t_station` */

DROP TABLE IF EXISTS `t_station`;

CREATE TABLE `t_station` (
  `tid` varchar(10) NOT NULL,
  `sname1` varchar(20) NOT NULL,
  `stime1` time NOT NULL,
  `sname2` varchar(20) NOT NULL,
  `stime2` time NOT NULL,
  `ticket` int(10) DEFAULT NULL,
  `tmoney` double DEFAULT NULL,
  KEY `tid` (`tid`),
  KEY `sname1` (`sname1`),
  KEY `sname2` (`sname2`),
  CONSTRAINT `t_station_ibfk_1` FOREIGN KEY (`tid`) REFERENCES `t_train` (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_station` */

insert  into `t_station`(`tid`,`sname1`,`stime1`,`sname2`,`stime2`,`ticket`,`tmoney`) values ('T112','杭州','10:23:00','海宁','11:00:00',900,15.8),('T112','海宁','11:02:00','嘉兴','11:22:00',900,16.2),('T112','嘉兴','11:25:00','昆山','12:44:00',898,22.5),('T112','昆山','12:47:00','苏州','13:08:00',898,17.5),('T112','苏州','14:16:00','南京','15:23:00',900,25.6),('T204','上海','12:01:00','昆山','12:05:00',900,20.8),('T204','昆山','12:39:00','苏州','13:00:00',899,18.8),('T204','苏州','13:05:00','无锡','13:32:00',899,16.9),('T204','无锡','13:35:00','常州','13:58:00',899,23.4),('T204','常州','14:01:00','镇江','14:54:00',899,22.5),('T204','镇江','14:57:00','南京','15:38:00',900,18.5),('T204','南京','16:01:00','徐州','19:29:00',900,30.6),('D2206','上海','06:38:00','昆山','07:00:00',900,28.8),('D2206','昆山','07:03:00','苏州','07:16:00',900,32.5),('D2206','苏州','07:18:00','无锡','07:33:00',900,19.6),('D2206','无锡','07:49:00','常州','08:06:00',900,32.6),('D2206','常州','08:08:00','丹阳','08:25:00',900,22.8),('D2206','丹阳','08:27:00','镇江','08:40:00',900,21.6),('D2206','镇江','08:42:00','南京','09:13:00',900,16.5),('D2206','南京','09:15:00','合肥','10:14:00',900,28.8),('D2206','合肥','10:16:00','汉口','12:03:00',900,30.5),('D2206','汉口','12:05:00','宜昌','14:38:00',900,41.6),('D656','宁波','06:30:00','绍兴','07:24:00',1000,16.2),('D656','绍兴','07:26:00','杭州','07:47:00',1000,12.8),('D656','杭州','07:51:00','湖州','08:26:00',1000,16.6),('D656','湖州','08:31:00','宜兴','09:00:00',1000,12.5),('D656','宜兴','09:09:00','南京','10:05:00',1000,19.6),('D656','南京','10:25:00','合肥','10:30:00',1000,9.8),('G307','北京','08:23:00','保定','09:11:00',1000,24.5),('G307','保定','09:17:00','石家庄','09:53:00',1000,23.6),('G307','石家庄','09:55:00','邯郸','10:34:00',1000,30.5),('G307','邯郸','10:53:00','安阳','11:10:00',1000,21.4),('G307','安阳','11:12:00','郑州','11:54:00',1000,25.6),('G307','郑州','11:57:00','汉口','13:49:00',1000,24.4),('G307','汉口','13:55:00','荆州','15:20:00',1000,26.2),('G307','荆州','15:22:00','宜昌','15:55:00',1000,25.6),('G307','宜昌','16:00:00','恩施','17:51:00',1000,35.6),('G307','恩施','17:55:00','利川','18:29:00',1000,34.1),('G307','利川','18:31:00','重庆','20:15:00',1000,45.3),('G307','重庆','20:38:00','成都','22:36:00',1000,68.5),('G1301','上海','10:23:00','嘉兴','10:50:00',1000,35.3),('G1301','嘉兴','10:54:00','杭州','11:26:00',1000,46.3),('G1301','杭州','11:30:00','义乌','12:02:00',1000,35.8),('G1301','义乌','12:07:00','金华','12:24:00',1000,38.7),('G1301','金华','12:26:00','上饶','13:17:00',1000,56.8),('G1301','上饶','13:19:00','南昌','14:22:00',1000,65.7),('G1301','南昌','14:26:00','宜春','15:15:00',1000,58.9),('G1301','宜春','15:17:00','长沙','16:09:00',1000,59.7),('G1301','长沙','16:12:00','衡阳','16:56:00',1000,48.9),('G1301','衡阳','16:58:00','韶关','18:04:00',1000,43.9),('G1301','韶关','18:06:00','广州','19:03:00',1000,68.9),('D352','上海','06:04:00','无锡','06:49:00',1000,32.5),('D352','无锡','06:51:00','常州','07:08:00',1000,31.5),('D352','常州','07:10:00','镇江','07:37:00',1000,36.5),('D352','镇江','07:39:00','南京','08:10:00',1000,39.8),('D352','南京','08:13:00','合肥','09:11:00',1000,29.8),('D352','合肥','09:15:00','金寨','10:05:00',1000,39.8),('D352','金寨','10:07:00','汉口','11:28:00',1000,34.5),('D352','汉口','11:34:00','荆州','12:47:00',1000,31.2),('D352','荆州','12:49:00','宜昌','13:21:00',1000,36.4),('D352','宜昌','13:34:00','建始','14:59:00',1000,29.8),('D352','建始','15:01:00','恩施','15:24:00',1000,45.5),('D352','恩施','15:28:00','利川','16:03:00',1000,40.5),('D352','利川','16:07:00','石柱县','16:47:00',1000,48.5),('D352','石柱县','16:49:00','涪陵','17:24:00',1000,32.5),('D352','涪陵','17:26:00','重庆','18:03:00',1000,39.5),('D352','重庆','18:11:00','潼南','18:56:00',1000,42.5),('D352','潼南','18:58:00','遂宁','19:27:00',1000,34.5),('D352','遂宁','19:31:00','成都','20:27:00',1000,60.5),('G1698','福州','08:42:00','南平','09:16:00',800,56.5),('G1698','南平','09:18:00','建瓯','09:34:00',800,45.5),('G1698','南平','09:18:00','建瓯','09:34:00',800,45.5),('G1698','建瓯','09:36:00','武夷山','09:51:00',800,36.5),('G1698','武夷山','09:53:00','上饶','10:23:00',800,34.5),('G1698','上饶','10:25:00','抚州','11:12:00',800,36.5),('G1698','抚州','11:14:00','新余','12:16:00',800,68.5),('G1698','新余','12:18:00','长沙','13:21:00',800,68.4);

/*Table structure for table `t_train` */

DROP TABLE IF EXISTS `t_train`;

CREATE TABLE `t_train` (
  `tid` varchar(10) NOT NULL,
  `ttype` varchar(10) NOT NULL,
  `stype1` varchar(20) DEFAULT NULL,
  `scount1` varchar(10) DEFAULT NULL,
  `tmoney1` double DEFAULT NULL,
  `stype2` varchar(20) DEFAULT NULL,
  `scount2` varchar(10) DEFAULT NULL,
  `tmoney2` double DEFAULT NULL,
  `stype3` varchar(20) DEFAULT NULL,
  `scount3` int(10) DEFAULT NULL,
  `tmoney3` double DEFAULT NULL,
  `runtime` double DEFAULT NULL,
  `stacount` int(5) NOT NULL,
  `salesum` int(10) NOT NULL DEFAULT '0',
  PRIMARY KEY (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `t_train` */

insert  into `t_train`(`tid`,`ttype`,`stype1`,`scount1`,`tmoney1`,`stype2`,`scount2`,`tmoney2`,`stype3`,`scount3`,`tmoney3`,`runtime`,`stacount`,`salesum`) values ('D2206','D-动车','二等座','400',38,'一等座','300',180,'商务座',200,240,8,11,0),('D352','D-动车','二等座','700',50,'一等座','200',180,'商务座',100,500,14.5,20,0),('D656','D-动车','二等座','500',32,'一等座','300',180,'商务座',200,260,4,7,0),('G1301','G-高铁','二等座','600',40,'一等座','400',230,'商务座',100,400,8.5,10,0),('G1698','G-高铁','二等座','500',35,'一等座','200',220,'商务座',100,450,4.5,9,0),('G307','G-高铁','二等座','500',45,'一等座','300',240,'商务座',200,300,14,12,0),('T112','T-特快','硬座','499',20,'硬卧','299',120,'软卧',100,210,5,6,2),('T204','T-特快','硬座','399',15,'硬卧','280',130,'软卧',80,220,7.5,8,1);

/*Table structure for table `t_user` */

DROP TABLE IF EXISTS `t_user`;

CREATE TABLE `t_user` (
  `uid` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `password` varchar(50) NOT NULL,
  `utype` int(2) NOT NULL DEFAULT '0',
  `phone` varchar(20) DEFAULT NULL,
  `address` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

/*Data for the table `t_user` */

insert  into `t_user`(`uid`,`username`,`password`,`utype`,`phone`,`address`) values (1,'张三','325f7e02fa1f90826b88114be7fd3f9c',0,'17859621045','浙江'),(2,'李四','325f7e02fa1f90826b88114be7fd3f9c',0,NULL,NULL),(3,'王五','325f7e02fa1f90826b88114be7fd3f9c',0,NULL,NULL),(4,'admin','ba4211c25cce05c82d4ae51a7e9cc3da',1,NULL,NULL),(5,'老王','325f7e02fa1f90826b88114be7fd3f9c',0,'',''),(8,'小李','325f7e02fa1f90826b88114be7fd3f9c',0,'',''),(9,'李晓明','325f7e02fa1f90826b88114be7fd3f9c',0,'',''),(10,'大飞','583301d20d3f52b56298b35338c93eb0',0,'13345678942','南非'),(11,'狗子','325f7e02fa1f90826b88114be7fd3f9c',0,'13355678941','南美'),(12,'小林','325f7e02fa1f90826b88114be7fd3f9c',0,'','');

/*Table structure for table `train` */

DROP TABLE IF EXISTS `train`;

CREATE TABLE `train` (
  `tid` varchar(10) NOT NULL,
  `train_type` varchar(20) NOT NULL,
  `seat_type1` varchar(20) DEFAULT NULL,
  `last_ticket1` int(5) DEFAULT NULL,
  `money1` double DEFAULT NULL,
  `seat_type2` varchar(20) DEFAULT NULL,
  `last_ticket2` int(5) DEFAULT NULL,
  `money2` double DEFAULT NULL,
  `seat_type3` varchar(20) DEFAULT NULL,
  `last_ticket3` int(5) DEFAULT NULL,
  `money3` double DEFAULT NULL,
  `drive_time` varchar(20) DEFAULT NULL,
  `station_sum` int(5) DEFAULT '0',
  `sale_sum` int(5) DEFAULT '0',
  `del` int(1) DEFAULT '0',
  PRIMARY KEY (`tid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `train` */

insert  into `train`(`tid`,`train_type`,`seat_type1`,`last_ticket1`,`money1`,`seat_type2`,`last_ticket2`,`money2`,`seat_type3`,`last_ticket3`,`money3`,`drive_time`,`station_sum`,`sale_sum`,`del`) values ('D2206','D-动车','商务座',100,80,'一等座',200,60,'二等座',280,30,'4',3,0,0),('D352','D-动车','商务座',100,80,'一等座',100,60,'二等座',100,36,'6',4,0,0),('T112','T-特快','硬卧',20,80,'硬座',120,36,'无座',100,36,'5',4,0,0);

/*Table structure for table `user_info` */

DROP TABLE IF EXISTS `user_info`;

CREATE TABLE `user_info` (
  `uid` varchar(32) NOT NULL,
  `username` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL,
  `user_type` int(1) NOT NULL DEFAULT '0',
  `phone` varchar(15) NOT NULL,
  `address` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `UNI_PHONE` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user_info` */

insert  into `user_info`(`uid`,`username`,`password`,`user_type`,`phone`,`address`) values ('1554086536966864','测试','71be3a911696ca5a969e973e304d006c',0,'13312341233','浙江省杭州市'),('1554086631226515','admin','71be3a911696ca5a969e973e304d006c',1,'13312341234','浙江省杭州市'),('1554086717367104','123','71be3a911696ca5a969e973e304d006c',0,'13312341231','浙江省杭州市');

/*Table structure for table `user_passenger` */

DROP TABLE IF EXISTS `user_passenger`;

CREATE TABLE `user_passenger` (
  `uid` int(11) NOT NULL,
  `pid` int(11) DEFAULT NULL,
  KEY `uid` (`uid`),
  KEY `pid` (`pid`),
  CONSTRAINT `user_passenger_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `t_user` (`uid`),
  CONSTRAINT `user_passenger_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `t_passenger` (`pid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user_passenger` */

insert  into `user_passenger`(`uid`,`pid`) values (1,1),(2,3),(2,4),(1,2),(1,5),(10,7),(12,8);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
