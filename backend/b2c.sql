/*
 Navicat Premium Data Transfer

 Source Server         : b2c
 Source Server Type    : MySQL
 Source Server Version : 80200
 Source Host           : localhost:3306
 Source Schema         : b2c

 Target Server Type    : MySQL
 Target Server Version : 80200
 File Encoding         : 65001

 Date: 01/01/2024 18:28:27
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `price` decimal(10, 2) NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cart
-- ----------------------------
INSERT INTO `cart` VALUES ('admin', '雪糕', 2.50);

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `id` int NULL DEFAULT NULL,
  `description` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `price` decimal(10, 2) NULL DEFAULT NULL,
  `account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES ('芝士可乐', 1, '[加芝士的汽水]包治百病！', 2.00, 'admin');
INSERT INTO `goods` VALUES ('雪糕', 6219, '这是一个又甜又白的雪糕', 2.50, 'admin');

-- ----------------------------
-- Table structure for logistics
-- ----------------------------
DROP TABLE IF EXISTS `logistics`;
CREATE TABLE `logistics`  (
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `seller` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `nowaddr` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `buyer` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `done` char(4) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of logistics
-- ----------------------------
INSERT INTO `logistics` VALUES ('山东省威海市文化西路2号哈尔滨工业大学(威海)研究院北424', 'admin', '山东省威海市文化西路2号哈尔滨工业大学(威海)研究院北424', 'hehe', '芝士可乐', '1');
INSERT INTO `logistics` VALUES ('山东省威海市文化西路2号哈尔滨工业大学(威海)研究院北424', 'xixi', '山东省威海市文化西路2号哈尔滨工业大学(威海)研究院北424', 'hehe', '黑暗剑', '1');
INSERT INTO `logistics` VALUES ('山东省威海市文化西路2号哈尔滨工业大学(威海)研究院北424', 'admin', '未知', 'admin', '雪糕', '0');
INSERT INTO `logistics` VALUES ('山东省威海市文化西路2号哈尔滨工业大学(威海)研究院北424', 'xixi', '未知', 'admin', '黑暗剑', '0');

-- ----------------------------
-- Table structure for miyao
-- ----------------------------
DROP TABLE IF EXISTS `miyao`;
CREATE TABLE `miyao`  (
  `account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `privatekey` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `publickey` varchar(4096) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of miyao
-- ----------------------------
INSERT INTO `miyao` VALUES ('admin', '-----BEGIN RSA PRIVATE KEY-----\nMIIEqQIBAAKCAQEAjra14LONbz4VsrvONqLdGsXcFWbi2xK67SOCd+Lj3DnLYzmK\nd8ObJ3uM49Nv6pNuXPDnLZ5aQ8NLFWvT7M1Pzyax8duMylMTGZ3+OQf+cQ3eDTSF\njfGX4kjwu4GY6iRZ/+09Y9y1ld/Erw3yQDDuWTFjeFEaxkv+3gqM3HcWoMKLNLVc\ngLT0tlEwzTauHnZAV2PvI8938VupXnNOVlj1FxZhEDIj3Kll/IFzroUnhuNesuo5\niGQevwrUlJ6sFQOoJ5CxUTS5b2KsjIvDAA+nVfXsIv7IB92VvspEMBqazp80tab+\nrCNwP1IoYu3tv/PeBkiH4BkpdTCsJLy0nUybdQIDAQABAoIBAFJ1mbNiq6cKHWlv\ngGArTEwK5PZsw0lHkkAw01LIA1adAjqr5aj7mat/hNGiuri0RQFopHrEU21x6vFO\no13g52tO9WREsh25UIDtvBVh3A+grpu8rCpu3I6ADLCa2ir3pBTvFBieT0Fw0OlA\nyqdyXlWk5s9/NVQ8Vm4Z+eNcNCeA2JwLVcJnUAE05hSghrund3oA7DSWSoJiFqMM\nJA+Haz/1K9FTSEtEyYPjEZC3Aj7RkGykYua/WYEVJbhSCKc1yw9xI5XVZcG9OI+j\ntvMc/HFueBBnFrxaMlTBqG1ahRmiy8vuI/lQU1XBkVKFry9YFlMDeN5DQaejd3c6\nLc84vKUCgYkAxVXo3o9xaPVvoyX+HwKlFKP5ZkTYSck1jY8sFCGTkEBN+KC6FJaW\nn58xCT6G/Wmpr9xWj5qZVlVeIS9Xu/4Utj6Je5MzQmJ1Ta0Pbw6mPBQPdhLOOkXU\npu8VJ10sTgVxPtL7fb613KswEbsui2cmBiX+bHbY4l9L+CxDAhyUmAx1JJxHt+As\nfwJ5ALkj1ybCxY0lK+VyCjhd6kRFfie2ouJZAiXQHM7B0IKxasy0+8H6qcIfwsWg\npz94BKEPrvC7/lVUl1nYqfgUTSxEqwheltSRhDFYspU/yXD1iq5x74q4pHqAfOLs\ncBMjQxIPowG24X4rIDI242F0ne/LDr7KOOROCwKBiEI1yfVqwY2K1BM0eygidgsP\n3W0v6jYPmbVOdWanwWAkA0VJgEXKJO2Xtxc38Ij0O+fykOSL5aju6a9OuCwuWvqu\nzug0gn1ilaMjTstfae08edePBbzNk0UTcNCNVYE0GEQQ/Cq7oz9P/MfmOv6w9DQZ\n6VyxH6IMgWvaRf1eY4kEnQVUnkeWorcCeQCS72P5Kkm5XI/7GMgNtlOP/YtDH4sk\nkznGIuZKHb5Li11UvCq26CbEn4poaLl0AN/Dp/vSqZEPzgQU1YUIE6yv/ouzJ8cT\nS64br+aD100brnRzQI+5jBNV+hWjz7yfI7Q+aFSZrrhF9xolYDSUCwax4nmAaGRA\npcMCgYhQKP7fkRC+cnlQqyZ7a3btgG/bBSSLdPpoaWK5Q3QQu+eSPWMglpCnWlmY\nsEBE2+fRrsQUARq2IhbB021VaFcdHeRX04yenaYqyj4+kkADSGMmvdQzb5esGrhF\nA3sityO2kXPzF+wUsU8u/f9Qp5GHUKOuEACjIo64b0NsLIJfKIAVOz+G/teI\n-----END RSA PRIVATE KEY-----\n', '-----BEGIN RSA PUBLIC KEY-----\nMIIBCgKCAQEAjra14LONbz4VsrvONqLdGsXcFWbi2xK67SOCd+Lj3DnLYzmKd8Ob\nJ3uM49Nv6pNuXPDnLZ5aQ8NLFWvT7M1Pzyax8duMylMTGZ3+OQf+cQ3eDTSFjfGX\n4kjwu4GY6iRZ/+09Y9y1ld/Erw3yQDDuWTFjeFEaxkv+3gqM3HcWoMKLNLVcgLT0\ntlEwzTauHnZAV2PvI8938VupXnNOVlj1FxZhEDIj3Kll/IFzroUnhuNesuo5iGQe\nvwrUlJ6sFQOoJ5CxUTS5b2KsjIvDAA+nVfXsIv7IB92VvspEMBqazp80tab+rCNw\nP1IoYu3tv/PeBkiH4BkpdTCsJLy0nUybdQIDAQAB\n-----END RSA PUBLIC KEY-----\n');
INSERT INTO `miyao` VALUES ('hehe', '-----BEGIN RSA PRIVATE KEY-----\nMIIEqgIBAAKCAQEAjlSZ9/LniASRsgOAkrVulGw1fTOv4eQ4wzLvHUitJdlKZX+q\nppXASk26GcAvGIn1zRVX6xgd0Sa0xKKvXyGBUgrIHUxjWWMGp73a8dCiy91zSbWz\neYwU7hKlef2JqMBz+JXLPXnerOHMAorACOcRFO34AAAK2yoN4HqGHqu/d6krU1tj\noRUfhik5H2j2cgr1qPDpKuFktlZdk9l6wrqg+6vkFb59oj6gUjlB9qOLs8XYgjB/\nlfHZjpC5n3DB0gNSW9QF6OAxyVK2dAcwcEAIGaGelJVWhLgzG1O4hkG2bM8x11Jt\nCPa82YzxNS/D+/1L7rPHcO2Pr0ALVyb974VLZwIDAQABAoIBAD48/H8SNvChntxK\n78Q3lj1M/C7dlUGgPLoO4cTabOyqEgBETWk+/rD/QCvWgEGowlWFycZB63f0BwQd\nZ7afvh8UG+HD74W86cIcIUuwwh+HnMxUqkCyYsygVr/7gGDMl2nShudBDYBn1IAg\nEE1UTYHrdZD6c8TWpIZoi8AMZENC/AVo9oHZv8k51VOANyUVxf7pGQ+BOftDKqnh\n8RS24RKvPtMaJuXXjKSDk+8jMBm7t5WozJy9pw0jPpwH+lVg8llUjhhaTp3VhTDT\nZXF8XTX4mJ2GDtx9eFe7MkPTc4P1id1uLDZL/l3b/6NqwexA7MVwdChXC/QcNO/o\nemyIUNECgYkA7r5uPuZPOCLzC2uTjltW1/c0NADFG+S8JsLBCr+W81gFbKFNtKKv\nEpaRHPOabQpOW24CAhNr5285iRaSVEskj/6ScMBFt6Dr1iWdWhgO7twi/iyiUwCE\nLsXw2tQn4uxKc146CefLP2cTq1fD7CP3oXYhii7wOWPyyZf7tJQlyKBLQp/86aUy\nJQJ5AJieMl/TYtySZyhHdPTkwC2nYQKWcJ/H8oyjAgCp7g755xHsVjCevqwvzKE0\nZwYzsSxfm/g7GEztmoE7FLyIVIoYIRMwAcEXF+rlJPrCqeeX7WhfI89/86MPFZfG\ntk6g5iu8kxhcyEXVgYke5O4E8soMHcTsk0uDmwKBiQDtoQ+8faJWHrtJH69D33gm\nB8CnDiki5V29OtXH7ADEf1UO1dKxO8gEOWeAqJuJctuhN3K6PDiHp/Zdk+DcE9r1\nlA6QOWBrMLnscY4YEaAzcVtHIIgFE5t9rrlYJhj5TfWgtSYRm+x6VA+I2ReCoB4n\nUJx7nNKwXOJYc3UuPNMKyTl/vByRNkMdAngBNzFbhgmBjED6FyedU70cH/sr1Brt\niuApspqveqsEv4TRpbpCBOGr6W2N0ycG6557pf9OCNp2smXKpbfSkJtrxiltR7Kb\n4R01p8GVpbtItvMTI77bRj+gitw3K0QEeE+dBZF+Xi7SL5Mqjm5wXuW4KkSKbv/1\nWAUCgYkA3oSlrahrzRN+vr4c4jc8ItwTQJUhwcBNKG6gvcg4TlOm6l12sTkdgemD\nPjgpmlixkucAtnOGY1lR8kHlgLPvmZG7ohTEt3wMDWHKMq2/xWjCW/+KOQRcDwXs\nj+gASqMS8Dt7S3SYNCVMYFOjTao+gbGGdTCtHSizPHq3Rrauo1aRf9Vfpek/VA==\n-----END RSA PRIVATE KEY-----\n', '-----BEGIN RSA PUBLIC KEY-----\nMIIBCgKCAQEAjlSZ9/LniASRsgOAkrVulGw1fTOv4eQ4wzLvHUitJdlKZX+qppXA\nSk26GcAvGIn1zRVX6xgd0Sa0xKKvXyGBUgrIHUxjWWMGp73a8dCiy91zSbWzeYwU\n7hKlef2JqMBz+JXLPXnerOHMAorACOcRFO34AAAK2yoN4HqGHqu/d6krU1tjoRUf\nhik5H2j2cgr1qPDpKuFktlZdk9l6wrqg+6vkFb59oj6gUjlB9qOLs8XYgjB/lfHZ\njpC5n3DB0gNSW9QF6OAxyVK2dAcwcEAIGaGelJVWhLgzG1O4hkG2bM8x11JtCPa8\n2YzxNS/D+/1L7rPHcO2Pr0ALVyb974VLZwIDAQAB\n-----END RSA PUBLIC KEY-----\n');
INSERT INTO `miyao` VALUES ('user', '-----BEGIN RSA PRIVATE KEY-----\nMIIEqQIBAAKCAQEAv9FUTKYa+YOLSIPB5doM2HwynDRy9nGsa9R86V1iyVO8LsFk\nbkwou8cVIrpqNMHMVAQCPUEen6isvb4u6iOWQiudo+Z4sj/vbJVcxS/aQvYkB4Iq\n1I3qH/3Hdkff8f1+YYTL2dfpFcjKaAN5BPKPaVGKGRF5xpyk9e+Gw7rSBaH7Ue/K\nzxeNnoJNZjACwqP1IuNUCOzXCGIK7v6Vg4h1+axIG+bkl8KC2bs42cRKYvz/5A6z\nyigqpQ3vhHm6mtolK/3uS8iN1b0UvICMDQNJ0PJAwICr6uNbrLghrtTlJtVvseNb\nELIFkRXLQKyAkceyJZFmHgTvNS+TTm28C7r3JwIDAQABAoIBAHDK3aAouInqERf1\n6imHm7Ac8AGsUcGavEG39C+hazppk6mGrNCy1ez9Nu9x4IvfPZBVvx9X0HMf01vL\nnnitrmiAjzTWjDh8ogQenCuTZOulIzCLGTZdsMNZDlX+E7CPWCZt2RTjAjt+E48w\nI5SGMVBD00nEXfAtId0FJOfJiXHaeyMALeNZdmzSNFdls06pMZeCMSI4ZGPBafl3\nbEFE9Pa1eNtq+2v7TGjDJb/H9GWejXoLxlxBOD7LPMjfdqC6CTJLu5g0CH6Rcmb/\n78kkcE/3r6o/z3F/7NGkSbINlpuwQJffD8YtBbLeptbG5KnWIYgn3OQzNkzZIJAX\n0nlcjokCgYkAwkKM+5uCs8/TLGUq46m2llYaLKt3NEUfsaZPrYe9fH7dtqXloEIS\nWrZaYYJvjkdcwNQ+jiPDOxQc5FHEPdMkObJm0l6o+1jVFD5ypO7yNdXNCVK0RW1h\nnBeHH4ZMNoBQVnSYvrUU8AG88f9uARtbaDglw4WDhJBm4OcCn8sftxp02mTafXlk\n1QJ5APzIEdNkeSEqWRsbZ8Yfdt7QYqw7GY9TzmbeW2R1T0Rr5P8/anxQ4ryhcTRy\nV2JC3Ras/7Gl9ZEmc9Ocp4lnGfEXiRLeAp0NRzV719ADgT2AtTDrSOs+PxXH1WHz\nvEl+gmkheGk3R23/FADTnNX/Iq3YPFL/4S4aCwKBiGZ4SHnoXBeRhukiLG+O9Ft0\n67WodObDl6ZT/i+hLJjhKv7Pn8LbV2c2TZKmBUZd6lVlH+JGhxNA1sSxRPz/xVoR\n+x75A9Yh07QsBLlvuaAgOVmzoJgGzLhTyNkeNFGDed1A/9mJF5RKtmpIvLQkxCDD\njVgHs4pXyYzVDpNPyFkDwaP6Ey6gvEkCeQDl5b/wlixkMXOg56fV1L/znWpgYc+5\nPus1O327O8W/4LEAQ9jA/393Nw0SOfunblBNU0Gpe9p/DI3DI3Jr0M0TK+iKtEeE\nNpNQ3TVGBioAmZIwz4weBxqw4HH9CANyhBBvNPWiG5hnPdofdlXpeoU7vrH+eqF9\noEkCgYhNrIw0uh0dwxGH9zcvxuvawd/q8mcqpopHOx53SyTVAtuSX2AekUho3m/q\ntqJBcBug168YpYL9bmExOcfkM3Q206AoHPo7838orjMHFCfMlumUrXzZfn9PE0vw\nL7bZW7OAU3gdns+uC5d+Gll7Dz6l2RWUslJrFy7IaegPqdRf3/6q731KRoXI\n-----END RSA PRIVATE KEY-----\n', '-----BEGIN RSA PUBLIC KEY-----\nMIIBCgKCAQEAv9FUTKYa+YOLSIPB5doM2HwynDRy9nGsa9R86V1iyVO8LsFkbkwo\nu8cVIrpqNMHMVAQCPUEen6isvb4u6iOWQiudo+Z4sj/vbJVcxS/aQvYkB4Iq1I3q\nH/3Hdkff8f1+YYTL2dfpFcjKaAN5BPKPaVGKGRF5xpyk9e+Gw7rSBaH7Ue/KzxeN\nnoJNZjACwqP1IuNUCOzXCGIK7v6Vg4h1+axIG+bkl8KC2bs42cRKYvz/5A6zyigq\npQ3vhHm6mtolK/3uS8iN1b0UvICMDQNJ0PJAwICr6uNbrLghrtTlJtVvseNbELIF\nkRXLQKyAkceyJZFmHgTvNS+TTm28C7r3JwIDAQAB\n-----END RSA PUBLIC KEY-----\n');

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `account` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `usertype` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('admin', '200305', 'admin', '3');
INSERT INTO `users` VALUES ('hehe', '123456', 'DullBean', '1');
INSERT INTO `users` VALUES ('user', '123456', '1111', '2');

SET FOREIGN_KEY_CHECKS = 1;
