-- phpMyAdmin SQL Dump
-- version 4.7.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 05, 2018 at 10:02 AM
-- Server version: 10.1.24-MariaDB-cll-lve
-- PHP Version: 5.6.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `simcycre_signer`
--

-- --------------------------------------------------------

--
-- Table structure for table `chat`
--

CREATE TABLE `chat` (
  `id` int(11) NOT NULL,
  `sender` int(11) NOT NULL,
  `message` text NOT NULL,
  `time_` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `file` varchar(64) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `companies`
--

CREATE TABLE `companies` (
  `id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `email` varchar(64) NOT NULL,
  `phone` varchar(16) NOT NULL,
  `reminders` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `companies`
--

INSERT INTO `companies` (`id`, `name`, `email`, `phone`, `reminders`) VALUES
(1, 'Signer Inc', 'demo@simcycreative.com', '123456789', 1);

-- --------------------------------------------------------

--
-- Table structure for table `files`
--

CREATE TABLE `files` (
  `id` int(11) NOT NULL,
  `company` int(11) NOT NULL,
  `folder` int(11) NOT NULL,
  `uploaded_by` int(11) NOT NULL,
  `uploaded_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `name` varchar(256) NOT NULL,
  `filename` varchar(256) NOT NULL,
  `type` varchar(16) NOT NULL,
  `size` int(11) NOT NULL,
  `sharing_key` varchar(32) NOT NULL,
  `status` enum('unsigned','signed') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `files`
--

INSERT INTO `files` (`id`, `company`, `folder`, `uploaded_by`, `uploaded_on`, `name`, `filename`, `type`, `size`, `sharing_key`, `status`) VALUES
(107, 1, 1, 1, '2018-03-05 10:02:04', 'Sample File', 'doc5a9d159cd9997.pdf', '', 0, 'GuLQR08s2NQgS8CXnCPt1520244108', 'signed');

-- --------------------------------------------------------

--
-- Table structure for table `folders`
--

CREATE TABLE `folders` (
  `id` int(11) NOT NULL,
  `company` int(11) NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_on` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `name` varchar(256) NOT NULL,
  `level` int(11) NOT NULL,
  `folder` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `folders`
--

INSERT INTO `folders` (`id`, `company`, `created_by`, `created_on`, `name`, `level`, `folder`) VALUES
(1, 1, 1, '2017-07-02 21:00:00', 'public_folder', 1, 1),
(32, 1, 1, '2018-03-05 10:01:08', 'Sample Folder', 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `history`
--

CREATE TABLE `history` (
  `id` int(11) NOT NULL,
  `company` int(11) NOT NULL,
  `file` varchar(32) NOT NULL,
  `activity` text NOT NULL,
  `time_` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `type` enum('default','success','danger') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `history`
--

INSERT INTO `history` (`id`, `company`, `file`, `activity`, `time_`, `type`) VALUES
(6, 1, 'e3PSiHvH0LF2EULlZEBS1505308613', '<span class=\"text-primary\">Albert </span> signed the document.', '2017-09-27 08:26:37', 'success'),
(7, 1, 'e3PSiHvH0LF2EULlZEBS1505308613', '<span class=\"text-primary\">Albert </span> signed the document.', '2017-09-27 08:27:58', 'success'),
(8, 1, 'e3PSiHvH0LF2EULlZEBS1505308613', '<span class=\"text-primary\">Albert Novelty</span> signed the document.', '2017-09-27 08:28:43', 'success'),
(9, 1, 'HZSj3FYjSLlv8rPbauBe1505308612', '<span class=\"text-primary\">Albert Novelty</span> signed the document.', '2017-09-27 08:29:05', 'success'),
(10, 1, 'F9Jqxn09lpmCvGtCRpdL1506549720', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2017-09-27 22:02:00', 'default'),
(11, 1, 'F9Jqxn09lpmCvGtCRpdL1506549720', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2017-09-27 22:13:17', 'success'),
(12, 1, 'HZSj3FYjSLlv8rPbauBe1505308612', 'Signing request sent to <span class=\"text-primary\">kimelidaniel13@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2017-09-28 08:15:30', 'default'),
(13, 1, 'HZSj3FYjSLlv8rPbauBe1505308612', 'Signing request sent to <span class=\"text-primary\">kimelidaniel13@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2017-09-28 08:15:56', 'default'),
(14, 1, 'HZSj3FYjSLlv8rPbauBe1505308612', 'Signing request sent to <span class=\"text-primary\">kimelidaniel13@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2017-09-28 08:16:50', 'default'),
(15, 1, 'HZSj3FYjSLlv8rPbauBe1505308612', 'Signing request sent to <span class=\"text-primary\">kimelidaniel13@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2017-09-28 08:17:21', 'default'),
(16, 1, 'HZSj3FYjSLlv8rPbauBe1505308612', 'Signing request sent to <span class=\"text-primary\">kimelidaniel13@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2017-09-28 08:19:05', 'default'),
(17, 1, 'HZSj3FYjSLlv8rPbauBe1505308612', 'Signing request sent to <span class=\"text-primary\">kimelidaniel13@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2017-09-28 08:19:41', 'default'),
(18, 1, 'HZSj3FYjSLlv8rPbauBe1505308612', 'Signing request sent to <span class=\"text-primary\">simcycreative@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2017-09-28 08:24:47', 'default'),
(19, 1, 'HZSj3FYjSLlv8rPbauBe1505308612', 'Signing request sent to <span class=\"text-primary\">kimelidaniel13@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2017-09-28 08:25:13', 'default'),
(20, 1, 'HZSj3FYjSLlv8rPbauBe1505308612', 'Signing request sent to <span class=\"text-primary\">kimelidaniel13@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2017-09-28 08:25:50', 'default'),
(21, 1, 'HZSj3FYjSLlv8rPbauBe1505308612', 'Signing request sent to <span class=\"text-primary\">kimelidaniel13@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2017-09-28 08:26:58', 'default'),
(22, 1, 'HZSj3FYjSLlv8rPbauBe1505308612', 'Signing request sent to <span class=\"text-primary\">simcycreative@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2017-09-28 08:36:53', 'default'),
(23, 1, 'HZSj3FYjSLlv8rPbauBe1505308612', 'Signing request sent to <span class=\"text-primary\">kimelidaniel13@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2017-09-28 08:38:49', 'default'),
(24, 1, 'HZSj3FYjSLlv8rPbauBe1505308612', '<span class=\"text-primary\">Albert Novelty</span> declined to sign the document', '2017-09-30 13:13:26', 'danger'),
(25, 1, 'HZSj3FYjSLlv8rPbauBe1505308612', '<span class=\"text-primary\">Albert Novelty</span> declined to sign the document', '2017-09-30 13:23:04', 'danger'),
(26, 5, 'HZSj3FYjSLlv8rPbauBe1505308612', '<span class=\"text-primary\">Albert Novelty</span> signed the document.', '2017-09-30 15:59:26', 'success'),
(27, 5, 'HZSj3FYjSLlv8rPbauBe1505308612', '<span class=\"text-primary\">Albert Novelty</span> signed the document.', '2017-09-30 16:00:28', 'success'),
(28, 5, 'HZSj3FYjSLlv8rPbauBe1505308612', '<span class=\"text-primary\">Albert Novelty</span> signed the document.', '2017-09-30 16:02:33', 'success'),
(29, 5, 'HZSj3FYjSLlv8rPbauBe1505308612', '<span class=\"text-primary\">Albert Novelty</span> signed the document.', '2017-09-30 16:05:47', 'success'),
(30, 5, 'HZSj3FYjSLlv8rPbauBe1505308612', '<span class=\"text-primary\">Albert Novelty</span> signed the document.', '2017-09-30 16:05:48', 'success'),
(31, 5, 'HZSj3FYjSLlv8rPbauBe1505308612', '<span class=\"text-primary\">Albert Novelty</span> signed the document.', '2017-09-30 16:06:03', 'success'),
(32, 5, 'HZSj3FYjSLlv8rPbauBe1505308612', '<span class=\"text-primary\">Albert Novelty</span> signed the document.', '2017-09-30 16:06:04', 'success'),
(33, 5, 'HZSj3FYjSLlv8rPbauBe1505308612', '<span class=\"text-primary\">Albert Novelty</span> signed the document.', '2017-09-30 16:07:26', 'success'),
(34, 5, 'HZSj3FYjSLlv8rPbauBe1505308612', '<span class=\"text-primary\">Albert Novelty</span> signed the document.', '2017-09-30 16:07:26', 'success'),
(35, 5, 'HZSj3FYjSLlv8rPbauBe1505308612', '<span class=\"text-primary\">Albert Novelty</span> signed the document.', '2017-09-30 16:10:39', 'success'),
(36, 5, 'HZSj3FYjSLlv8rPbauBe1505308612', '<span class=\"text-primary\">Albert Novelty</span> signed the document.', '2017-09-30 16:10:39', 'success'),
(37, 5, 'HZSj3FYjSLlv8rPbauBe1505308612', '<span class=\"text-primary\">Albert Novelty</span> signed the document.', '2017-09-30 16:10:55', 'success'),
(38, 5, 'HZSj3FYjSLlv8rPbauBe1505308612', '<span class=\"text-primary\">Albert Novelty</span> signed the document.', '2017-09-30 16:10:55', 'success'),
(39, 5, 'HZSj3FYjSLlv8rPbauBe1505308612', '<span class=\"text-primary\">Albert Novelty</span> signed the document.', '2017-09-30 16:12:19', 'success'),
(40, 5, 'HZSj3FYjSLlv8rPbauBe1505308612', '<span class=\"text-primary\">Albert Novelty</span> signed the document.', '2017-09-30 16:22:05', 'success'),
(41, 5, 'AU15lNRXIRFEkWiBbPdE1506796039', 'File Uploaded by <span class=\"text-primary\">Albert Novelty</span>.', '2017-09-30 18:27:19', 'default'),
(42, 5, 'Y89MJRkcTlXIBHjSrNZq1506796053', 'File Uploaded by <span class=\"text-primary\">Albert Novelty</span>.', '2017-09-30 18:27:33', 'default'),
(43, 5, 'gSXTmI8fwJlc2abdHjb61506796193', 'File Uploaded by <span class=\"text-primary\">Albert Novelty</span>.', '2017-09-30 18:29:53', 'default'),
(44, 5, 'CvTAnBrgnognDPn4us8B1506796213', 'File Uploaded by <span class=\"text-primary\">Albert Novelty</span>.', '2017-09-30 18:30:13', 'default'),
(45, 5, 'gSXTmI8fwJlc2abdHjb61506796193', 'Signing request sent to <span class=\"text-primary\">myceo360@gmail.com</span> by <span class=\"text-primary\">Albert Novelty</span>.', '2017-09-30 18:31:26', 'default'),
(46, 5, 'gSXTmI8fwJlc2abdHjb61506796193', 'Signing request sent to <span class=\"text-primary\">kimelidaniel13@gmail.com</span> by <span class=\"text-primary\">Albert Novelty</span>.', '2017-09-30 18:32:13', 'default'),
(47, 5, 'CvTAnBrgnognDPn4us8B1506796213', 'Signing request sent to <span class=\"text-primary\">myceo360@gmail.com</span> by <span class=\"text-primary\">Albert Novelty</span>.', '2017-09-30 18:42:00', 'default'),
(48, 5, 'CvTAnBrgnognDPn4us8B1506796213', 'Signing request sent to <span class=\"text-primary\">myceo360@gmail.com</span> by <span class=\"text-primary\">Albert Novelty</span>.', '2017-09-30 18:42:28', 'default'),
(49, 1, 'NYQRMgzS7OmKrPsQ0wWQ1506898315', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2017-10-01 22:51:55', 'default'),
(50, 1, 'NYQRMgzS7OmKrPsQ0wWQ1506898315', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2017-10-09 10:28:37', 'success'),
(51, 1, 'qNyrkDPzJkDEnqb4aXQE1512589867', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2017-12-06 19:51:07', 'default'),
(52, 1, 'qNyrkDPzJkDEnqb4aXQE1512589867', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2017-12-06 19:51:34', 'success'),
(53, 1, 'HYLwGTdUtID11DgLyovN1512590788', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2017-12-06 20:06:28', 'default'),
(54, 1, 'HYLwGTdUtID11DgLyovN1512590788', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2017-12-06 20:07:01', 'success'),
(55, 1, 'HYLwGTdUtID11DgLyovN1512590788', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2017-12-06 20:13:53', 'success'),
(56, 1, 'HYLwGTdUtID11DgLyovN1512590788', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2017-12-06 20:15:50', 'success'),
(57, 1, 'HYLwGTdUtID11DgLyovN1512590788', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2017-12-06 20:17:00', 'success'),
(58, 1, 'HYLwGTdUtID11DgLyovN1512590788', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2017-12-06 20:19:52', 'success'),
(59, 1, 'HYLwGTdUtID11DgLyovN1512590788', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2017-12-06 20:22:16', 'success'),
(60, 1, 'HYLwGTdUtID11DgLyovN1512590788', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2017-12-06 20:24:03', 'success'),
(61, 1, 'HYLwGTdUtID11DgLyovN1512590788', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2017-12-06 20:24:38', 'success'),
(62, 1, 'HYLwGTdUtID11DgLyovN1512590788', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2017-12-06 20:25:57', 'success'),
(63, 1, 'HYLwGTdUtID11DgLyovN1512590788', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2017-12-06 20:27:03', 'success'),
(64, 1, 'HYLwGTdUtID11DgLyovN1512590788', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2017-12-06 20:27:18', 'success'),
(65, 1, '6749WYoz2gsttWKZWR2F1512592987', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2017-12-06 20:43:07', 'default'),
(66, 1, '6749WYoz2gsttWKZWR2F1512592987', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2017-12-06 20:43:24', 'success'),
(67, 1, '6749WYoz2gsttWKZWR2F1512592987', 'Signing request sent to <span class=\"text-primary\">homeattract@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2017-12-07 07:23:31', 'default'),
(68, 1, '6749WYoz2gsttWKZWR2F1512592987', '<span class=\"text-primary\">Daniel Kimeli</span> <span class=\"text-danger\">cancelled</span> a signing request sent to <span class=\"text-primary\">homeattract@gmail.com</span>.', '2017-12-07 12:11:56', 'danger'),
(69, 1, '6749WYoz2gsttWKZWR2F1512592987', '<span class=\"text-primary\">Daniel Kimeli</span> <span class=\"text-danger\">cancelled</span> a signing request sent to <span class=\"text-primary\">homeattract@gmail.com</span>.', '2017-12-07 12:14:55', 'danger'),
(70, 1, '6749WYoz2gsttWKZWR2F1512592987', '<span class=\"text-primary\">Daniel Kimeli</span> <span class=\"text-danger\">cancelled</span> a signing request sent to <span class=\"text-primary\">homeattract@gmail.com</span>.', '2017-12-07 12:18:51', 'danger'),
(71, 1, '6749WYoz2gsttWKZWR2F1512592987', '<span class=\"text-primary\">Daniel Kimeli</span> <span class=\"text-danger\">cancelled</span> a signing request sent to <span class=\"text-primary\">homeattract@gmail.com</span>.', '2017-12-07 12:23:42', 'danger'),
(72, 1, '6749WYoz2gsttWKZWR2F1512592987', '<span class=\"text-primary\">Daniel Kimeli</span> sent a signing reminder to <span class=\"text-primary\">homeattract@gmail.com</span>', '2017-12-08 08:29:57', 'default'),
(73, 1, '6749WYoz2gsttWKZWR2F1512592987', '<span class=\"text-primary\">Daniel Kimeli</span> sent a signing reminder to <span class=\"text-primary\">homeattract@gmail.com</span>', '2017-12-08 08:33:39', 'default'),
(74, 1, 'elZspeNhYKHde3NyvPob1512809929', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2017-12-09 08:58:49', 'default'),
(75, 1, 'elZspeNhYKHde3NyvPob1512809929', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2017-12-09 08:59:06', 'success'),
(76, 1, 'elZspeNhYKHde3NyvPob1512809929', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2017-12-09 09:00:07', 'success'),
(77, 1, 'elZspeNhYKHde3NyvPob1512809929', 'Signing request sent to <span class=\"text-primary\">ivylenine@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2017-12-09 09:02:32', 'default'),
(78, 1, 'V28Tr7n79V1hhM9Phxy51512810875', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2017-12-09 09:14:35', 'default'),
(79, 7, '1LQcr7Ktqjoelm1GZHu51512811718', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2017-12-09 09:28:38', 'default'),
(80, 1, 'HYLwGTdUtID11DgLyovN1512590788', 'Signing request sent to <span class=\"text-primary\">instac@gmx.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2017-12-11 20:04:12', 'default'),
(81, 1, 'HYLwGTdUtID11DgLyovN1512590788', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2017-12-11 20:04:29', 'success'),
(82, 1, 'HYLwGTdUtID11DgLyovN1512590788', 'Signing request sent to <span class=\"text-primary\">instac@gmx.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2017-12-11 20:10:07', 'default'),
(83, 1, 'HYLwGTdUtID11DgLyovN1512590788', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2017-12-11 20:10:27', 'success'),
(84, 8, 'HYLwGTdUtID11DgLyovN1512590788', '<span class=\"text-primary\">inst insta</span> signed the document.', '2017-12-11 20:11:14', 'success'),
(85, 1, 'HYLwGTdUtID11DgLyovN1512590788', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2017-12-11 20:14:18', 'success'),
(87, 1, 'gvE1tOKqeF3HNah4asTf1513081392', 'This file was duplicated from  <span class=\"text-primary\">Business letter</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2017-12-12 12:23:12', 'default'),
(88, 1, '', 'This file was replace with a new one by <span class=\"text-primary\">Daniel Kimeli</span>.', '2017-12-12 12:57:12', 'default'),
(89, 1, 'gvE1tOKqeF3HNah4asTf1513081392', 'This file was replace with a new one by <span class=\"text-primary\">Daniel Kimeli</span>.', '2017-12-12 12:59:29', 'default'),
(90, 1, 'HYLwGTdUtID11DgLyovN1512590788', 'Signing request sent to <span class=\"text-primary\">instac@gmx.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2017-12-13 19:11:21', 'default'),
(91, 1, 'HYLwGTdUtID11DgLyovN1512590788', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2017-12-13 19:12:06', 'success'),
(92, 1, 'HYLwGTdUtID11DgLyovN1512590788', 'Signing request sent to <span class=\"text-primary\">instac@gmx.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2017-12-13 19:12:57', 'default'),
(93, 8, 'HYLwGTdUtID11DgLyovN1512590788', '<span class=\"text-primary\">inst insta</span> signed the document.', '2017-12-13 19:13:23', 'success'),
(94, 1, 'gvE1tOKqeF3HNah4asTf1513081392', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-02 13:19:58', 'success'),
(95, 1, 'gvE1tOKqeF3HNah4asTf1513081392', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-02 15:50:08', 'success'),
(96, 1, 'S2mSndxy1kqnEtMxfgQo1514908380', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-02 15:53:00', 'default'),
(97, 1, 'S2mSndxy1kqnEtMxfgQo1514908380', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-02 15:53:23', 'success'),
(98, 1, 'S2mSndxy1kqnEtMxfgQo1514908380', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-02 15:55:55', 'success'),
(99, 1, 'S2mSndxy1kqnEtMxfgQo1514908380', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-02 16:01:00', 'success'),
(100, 1, 'S2mSndxy1kqnEtMxfgQo1514908380', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-02 16:01:43', 'success'),
(101, 1, 'S2mSndxy1kqnEtMxfgQo1514908380', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-02 16:02:29', 'success'),
(102, 1, 'S2mSndxy1kqnEtMxfgQo1514908380', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-02 16:03:25', 'success'),
(103, 1, 'S2mSndxy1kqnEtMxfgQo1514908380', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-02 16:04:15', 'success'),
(104, 1, 'S2mSndxy1kqnEtMxfgQo1514908380', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-02 16:05:47', 'success'),
(105, 1, 'S2mSndxy1kqnEtMxfgQo1514908380', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-02 16:08:23', 'success'),
(106, 1, 'S2mSndxy1kqnEtMxfgQo1514908380', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-02 16:08:55', 'success'),
(107, 1, 'S2mSndxy1kqnEtMxfgQo1514908380', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-02 16:09:39', 'success'),
(108, 1, 'S2mSndxy1kqnEtMxfgQo1514908380', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-02 16:12:27', 'success'),
(109, 1, 'S2mSndxy1kqnEtMxfgQo1514908380', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-02 16:13:27', 'success'),
(110, 1, 'S2mSndxy1kqnEtMxfgQo1514908380', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-02 16:14:58', 'success'),
(111, 1, 'S2mSndxy1kqnEtMxfgQo1514908380', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-02 16:15:37', 'success'),
(112, 1, 'S2mSndxy1kqnEtMxfgQo1514908380', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-02 16:16:05', 'success'),
(113, 1, 'S2mSndxy1kqnEtMxfgQo1514908380', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-02 16:17:00', 'success'),
(114, 1, 'S2mSndxy1kqnEtMxfgQo1514908380', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-02 16:31:13', 'success'),
(115, 1, 'S2mSndxy1kqnEtMxfgQo1514908380', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-02 16:32:40', 'success'),
(116, 1, 'S2mSndxy1kqnEtMxfgQo1514908380', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-02 16:33:25', 'success'),
(117, 1, 'S2mSndxy1kqnEtMxfgQo1514908380', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-02 16:33:47', 'success'),
(118, 1, 'S2mSndxy1kqnEtMxfgQo1514908380', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-02 16:37:47', 'success'),
(119, 1, 'gvE1tOKqeF3HNah4asTf1513081392', 'Signing request sent to <span class=\"text-primary\">mrbrain@msn.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-02 16:42:52', 'default'),
(120, 1, 'HYLwGTdUtID11DgLyovN1512590788', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-02 16:44:04', 'success'),
(121, 1, 'HYLwGTdUtID11DgLyovN1512590788', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-02 16:45:25', 'success'),
(122, 1, 'gvE1tOKqeF3HNah4asTf1513081392', '<span class=\"text-primary\">sadsad sad</span> signed the document.', '2018-01-02 16:46:00', 'success'),
(123, 1, 'gvE1tOKqeF3HNah4asTf1513081392', '<span class=\"text-primary\">sadsad sad</span> wrote on the document.', '2018-01-02 16:46:13', 'success'),
(124, 1, 'gvE1tOKqeF3HNah4asTf1513081392', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-02 16:50:10', 'success'),
(125, 1, 'gvE1tOKqeF3HNah4asTf1513081392', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-02 17:13:57', 'success'),
(126, 1, 'HYLwGTdUtID11DgLyovN1512590788', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-02 18:17:03', 'success'),
(127, 1, '6749WYoz2gsttWKZWR2F1512592987', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-02 19:35:27', 'success'),
(128, 1, '6749WYoz2gsttWKZWR2F1512592987', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-02 19:35:37', 'success'),
(129, 1, 'gvE1tOKqeF3HNah4asTf1513081392', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-03 03:07:59', 'success'),
(130, 1, 'gvE1tOKqeF3HNah4asTf1513081392', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-03 03:09:18', 'success'),
(131, 1, 'HYLwGTdUtID11DgLyovN1512590788', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-03 05:54:45', 'success'),
(132, 1, 'HYLwGTdUtID11DgLyovN1512590788', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-03 13:08:12', 'success'),
(133, 1, 'gvE1tOKqeF3HNah4asTf1513081392', 'Signing request sent to <span class=\"text-primary\">simcycreative@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-03 19:48:18', 'default'),
(134, 1, 'gvE1tOKqeF3HNah4asTf1513081392', 'Signing request sent to <span class=\"text-primary\">simcycreative@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-03 19:56:39', 'default'),
(135, 1, 'gvE1tOKqeF3HNah4asTf1513081392', 'Signing request sent to <span class=\"text-primary\">kimelidani@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-03 19:58:48', 'default'),
(136, 1, 'HYLwGTdUtID11DgLyovN1512590788', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-03 19:59:14', 'success'),
(137, 1, 'gvE1tOKqeF3HNah4asTf1513081392', 'Signing request sent to <span class=\"text-primary\">kimelidani@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-03 20:02:16', 'default'),
(138, 1, 'gvE1tOKqeF3HNah4asTf1513081392', 'Signing request sent to <span class=\"text-primary\">demo@simcycreative.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-03 20:03:11', 'default'),
(139, 1, 'gvE1tOKqeF3HNah4asTf1513081392', 'Signing request sent to <span class=\"text-primary\">demo@simcycreative.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-03 20:04:23', 'default'),
(140, 1, 'gvE1tOKqeF3HNah4asTf1513081392', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-03 23:01:19', 'success'),
(141, 1, 'gvE1tOKqeF3HNah4asTf1513081392', '<span class=\"text-primary\">Daniel Kimeli</span> declined to sign the document', '2018-01-03 23:02:50', 'danger'),
(142, 8, 'HYLwGTdUtID11DgLyovN1512590788', '<span class=\"text-primary\">inst insta</span> signed the document.', '2018-01-03 23:16:11', 'success'),
(143, 1, 'cFH1joS8JOjehgY2ErpU1515022085', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-03 23:28:05', 'default'),
(144, 1, 'gvE1tOKqeF3HNah4asTf1513081392', '<span class=\"text-primary\">Daniel Kimeli</span> declined to sign the document', '2018-01-04 00:13:52', 'danger'),
(145, 1, 'HYLwGTdUtID11DgLyovN1512590788', 'This file was replaced with a new one by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-04 00:22:51', 'default'),
(146, 1, 'gvE1tOKqeF3HNah4asTf1513081392', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-04 00:47:01', 'success'),
(147, 1, 'zZzzSwyN5ibJhdV8qTDS1515026954', 'This file was duplicated from  <span class=\"text-primary\">Business letter-copy</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-04 00:49:14', 'default'),
(148, 1, '3OlwldXzdyHrsnPgf1cN1515028219', 'This file was duplicated from  <span class=\"text-primary\">custom_docs</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-04 01:10:19', 'default'),
(149, 1, 'HYLwGTdUtID11DgLyovN1512590788', 'Signing request sent to <span class=\"text-primary\">mrbrain@msn.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-04 02:50:13', 'default'),
(150, 1, 'gvE1tOKqeF3HNah4asTf1513081392', '<span class=\"text-primary\">sadsad sad</span> signed the document.', '2018-01-04 03:09:18', 'success'),
(151, 1, 'gvE1tOKqeF3HNah4asTf1513081392', '<span class=\"text-primary\">sadsad sad</span> wrote on the document.', '2018-01-04 03:09:29', 'success'),
(152, 1, 'HYLwGTdUtID11DgLyovN1512590788', '<span class=\"text-primary\">sadsad sad</span> signed the document.', '2018-01-04 03:09:44', 'success'),
(153, 1, 'HYLwGTdUtID11DgLyovN1512590788', '<span class=\"text-primary\">sadsad sad</span> wrote on the document.', '2018-01-04 03:09:54', 'success'),
(154, 1, 'RHWVXfnwqj9zWHMVzosj1515035487', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-04 03:11:27', 'default'),
(155, 1, '5lx7PMWI7teBC4hV8GQa1515035678', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-04 03:14:38', 'default'),
(156, 1, '5lx7PMWI7teBC4hV8GQa1515035678', 'Signing request sent to <span class=\"text-primary\">mrbrain@msn.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-04 03:15:45', 'default'),
(157, 1, '5lx7PMWI7teBC4hV8GQa1515035678', '<span class=\"text-primary\">sadsad sad</span> signed the document.', '2018-01-04 03:16:19', 'success'),
(158, 1, '5lx7PMWI7teBC4hV8GQa1515035678', '<span class=\"text-primary\">sadsad sad</span> wrote on the document.', '2018-01-04 03:16:28', 'success'),
(159, 1, 'xL27TkxQ4i3SmF5KtEcb1515035966', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-04 03:19:26', 'default'),
(160, 1, 'xL27TkxQ4i3SmF5KtEcb1515035966', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-04 03:19:40', 'success'),
(161, 1, 'xL27TkxQ4i3SmF5KtEcb1515035966', 'Signing request sent to <span class=\"text-primary\">instac@gmx.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-04 09:39:32', 'default'),
(162, 8, 'xL27TkxQ4i3SmF5KtEcb1515035966', '<span class=\"text-primary\">inst insta</span> signed the document.', '2018-01-04 09:40:16', 'success'),
(163, 1, 'xL27TkxQ4i3SmF5KtEcb1515035966', 'Signing request sent to <span class=\"text-primary\">instac@gmx.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-04 09:45:26', 'default'),
(164, 1, 'xL27TkxQ4i3SmF5KtEcb1515035966', '<span class=\"text-primary\">inst insta</span> declined to sign the document', '2018-01-04 09:46:35', 'danger'),
(165, 8, '6O4je2MZNS5AcABUNJ861515059726', 'File Uploaded by <span class=\"text-primary\">inst insta</span>.', '2018-01-04 09:55:26', 'default'),
(166, 8, '6O4je2MZNS5AcABUNJ861515059726', '<span class=\"text-primary\">inst insta</span> wrote on the document.', '2018-01-04 10:12:47', 'success'),
(167, 8, '6O4je2MZNS5AcABUNJ861515059726', 'Signing request sent to <span class=\"text-primary\">instac2@gmx.com</span> by <span class=\"text-primary\">inst insta</span>.', '2018-01-04 10:25:13', 'default'),
(168, 8, '6O4je2MZNS5AcABUNJ861515059726', '<span class=\"text-primary\">Tuto Buto</span> sent a signing reminder to <span class=\"text-primary\">instac2@gmx.com</span>', '2018-01-04 10:27:17', 'default'),
(169, 8, '6O4je2MZNS5AcABUNJ861515059726', 'Signing request sent to <span class=\"text-primary\">instac@gmx.com</span> by <span class=\"text-primary\">Tuto Buto</span>.', '2018-01-04 10:27:56', 'default'),
(170, 8, '6O4je2MZNS5AcABUNJ861515059726', '<span class=\"text-primary\">Tuto Buto</span> sent a signing reminder to <span class=\"text-primary\">instac@gmx.com</span>', '2018-01-04 10:28:29', 'default'),
(171, 8, '6O4je2MZNS5AcABUNJ861515059726', '<span class=\"text-primary\">Tuto Buto</span> <span class=\"text-danger\">cancelled</span> a signing request sent to <span class=\"text-primary\">instac@gmx.com</span>.', '2018-01-04 10:33:26', 'danger'),
(172, 8, '6O4je2MZNS5AcABUNJ861515059726', '<span class=\"text-primary\">Tuto Buto</span> wrote on the document.', '2018-01-04 10:37:30', 'success'),
(173, 1, 'gvE1tOKqeF3HNah4asTf1513081392', 'Signing request sent to <span class=\"text-primary\">mrbrain@msn.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-05 07:09:31', 'default'),
(174, 1, 'gvE1tOKqeF3HNah4asTf1513081392', '<span class=\"text-primary\">sadsad sad</span> signed the document.', '2018-01-05 07:10:11', 'success'),
(175, 1, 'gvE1tOKqeF3HNah4asTf1513081392', '<span class=\"text-primary\">sadsad sad</span> wrote on the document.', '2018-01-05 07:15:10', 'success'),
(176, 1, 'gvE1tOKqeF3HNah4asTf1513081392', '<span class=\"text-primary\">sadsad sad</span> signed the document.', '2018-01-05 07:15:33', 'success'),
(177, 1, 'gvE1tOKqeF3HNah4asTf1513081392', '<span class=\"text-primary\">sadsad sad</span> signed the document.', '2018-01-05 07:15:48', 'success'),
(178, 1, 'gvE1tOKqeF3HNah4asTf1513081392', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-05 23:21:52', 'success'),
(179, 1, 'gvE1tOKqeF3HNah4asTf1513081392', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-05 23:22:27', 'success'),
(180, 1, 'gvE1tOKqeF3HNah4asTf1513081392', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-06 21:45:36', 'success'),
(181, 1, 'HYLwGTdUtID11DgLyovN1512590788', 'Signing request sent to <span class=\"text-primary\">Sfvv@fsfg.com</span> by <span class=\"text-primary\">sadsad sad</span>.', '2018-01-08 07:57:52', 'default'),
(182, 1, 'HYLwGTdUtID11DgLyovN1512590788', 'Signing request sent to <span class=\"text-primary\">Sdgsd</span> by <span class=\"text-primary\">sadsad sad</span>.', '2018-01-08 07:58:29', 'default'),
(183, 1, 'gvE1tOKqeF3HNah4asTf1513081392', 'Signing request sent to <span class=\"text-primary\">instac3@gmx.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-08 08:48:20', 'default'),
(184, 8, 'gvE1tOKqeF3HNah4asTf1513081392', '<span class=\"text-primary\">inst insta</span> signed the document.', '2018-01-08 08:48:36', 'success'),
(185, 1, 'HYLwGTdUtID11DgLyovN1512590788', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-08 09:06:42', 'success'),
(186, 1, 'HYLwGTdUtID11DgLyovN1512590788', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-08 09:07:06', 'success'),
(187, 1, 'gvE1tOKqeF3HNah4asTf1513081392', 'Signing request sent to <span class=\"text-primary\">mrbrain@msn.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-08 10:13:29', 'default'),
(188, 1, '1NxoEY9mCBMtF8KE9fuJ1515406854', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-08 10:20:54', 'default'),
(189, 1, '1NxoEY9mCBMtF8KE9fuJ1515406854', 'Signing request sent to <span class=\"text-primary\">mrbrain@msn.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-08 10:21:02', 'default'),
(190, 1, '1NxoEY9mCBMtF8KE9fuJ1515406854', '<span class=\"text-primary\">sadsa sadsad</span> signed the document.', '2018-01-08 10:21:22', 'success'),
(191, 1, 'yOqrRF9dL4XZTS6EvRnZ1515407431', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-08 10:30:31', 'default'),
(192, 1, 'miHm46lsh5yJn70fyurt1515407451', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-08 10:30:51', 'default'),
(193, 1, 'yOqrRF9dL4XZTS6EvRnZ1515407431', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-08 17:56:39', 'success'),
(194, 1, 'miHm46lsh5yJn70fyurt1515407451', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-10 06:32:58', 'success'),
(195, 1, 'miHm46lsh5yJn70fyurt1515407451', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-10 06:33:45', 'success'),
(196, 1, 'yOqrRF9dL4XZTS6EvRnZ1515407431', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-10 22:47:01', 'success'),
(197, 1, 'miHm46lsh5yJn70fyurt1515407451', 'Signing request sent to <span class=\"text-primary\">info@andreagiuliani.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-11 20:09:43', 'default'),
(198, 1, 'miHm46lsh5yJn70fyurt1515407451', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-11 20:10:29', 'success'),
(199, 1, 'xG8KIp86pEMeqIpXJfSd1515777894', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-12 17:24:54', 'default'),
(200, 1, 'miHm46lsh5yJn70fyurt1515407451', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-12 17:26:49', 'success'),
(201, 1, 'miHm46lsh5yJn70fyurt1515407451', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-12 19:01:28', 'success'),
(202, 1, 'pXwvTwVuSOjtG9El4bGE1515785911', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-12 19:38:31', 'default'),
(203, 1, 'miHm46lsh5yJn70fyurt1515407451', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-12 19:44:43', 'success'),
(204, 1, 'xG8KIp86pEMeqIpXJfSd1515777894', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-13 20:59:02', 'success'),
(205, 1, 'xG8KIp86pEMeqIpXJfSd1515777894', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-13 21:02:17', 'success'),
(206, 1, 'yOqrRF9dL4XZTS6EvRnZ1515407431', 'Signing request sent to <span class=\"text-primary\">jhamiltonramm@icoud.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-13 21:05:25', 'default'),
(207, 1, 'miHm46lsh5yJn70fyurt1515407451', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-13 23:59:20', 'success'),
(208, 1, 'miHm46lsh5yJn70fyurt1515407451', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-14 00:11:47', 'success'),
(209, 1, 'xG8KIp86pEMeqIpXJfSd1515777894', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-14 00:25:10', 'success'),
(210, 1, 'xG8KIp86pEMeqIpXJfSd1515777894', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-14 00:25:46', 'success'),
(211, 2, 'fKjNRvTRSQszPDukzfkN1515967509', 'File Uploaded by <span class=\"text-primary\">Maxime Legard</span>.', '2018-01-14 22:05:09', 'default'),
(212, 2, 'LMTa8mf7CaxalBHtYSLV1515967509', 'File Uploaded by <span class=\"text-primary\">Maxime Legard</span>.', '2018-01-14 22:05:09', 'default'),
(213, 2, 'LMTa8mf7CaxalBHtYSLV1515967509', '<span class=\"text-primary\">Maxime Legard</span> signed the document.', '2018-01-14 22:08:38', 'success'),
(214, 2, 'LMTa8mf7CaxalBHtYSLV1515967509', '<span class=\"text-primary\">Maxime Legard</span> signed the document.', '2018-01-14 22:08:50', 'success'),
(215, 2, 'LMTa8mf7CaxalBHtYSLV1515967509', 'Signing request sent to <span class=\"text-primary\">max03.ml@icloud.com</span> by <span class=\"text-primary\">Maxime Legard</span>.', '2018-01-14 22:10:02', 'default'),
(216, 2, 'LMTa8mf7CaxalBHtYSLV1515967509', '<span class=\"text-primary\">Maxime Legard</span> signed the document.', '2018-01-14 22:10:33', 'success'),
(217, 2, 'v5bA8CslpVCROQlNpbYV1515967932', 'File Uploaded by <span class=\"text-primary\">Maxime Legard</span>.', '2018-01-14 22:12:12', 'default'),
(218, 2, 'v5bA8CslpVCROQlNpbYV1515967932', 'Signing request sent to <span class=\"text-primary\">mickael@mcg-multimedia.fr</span> by <span class=\"text-primary\">Maxime Legard</span>.', '2018-01-14 22:13:20', 'default'),
(219, 1, 'v5bA8CslpVCROQlNpbYV1515967932', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-14 22:14:22', 'success'),
(220, 1, 'xG8KIp86pEMeqIpXJfSd1515777894', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-14 22:15:53', 'success'),
(221, 1, 'miHm46lsh5yJn70fyurt1515407451', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-14 22:16:20', 'success'),
(222, 1, 'xG8KIp86pEMeqIpXJfSd1515777894', 'Signing request sent to <span class=\"text-primary\">jhamiltonramm@icloud.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-15 21:47:35', 'default'),
(223, 3, 'xG8KIp86pEMeqIpXJfSd1515777894', '<span class=\"text-primary\">jay hamilton</span> signed the document.', '2018-01-15 21:52:07', 'success'),
(224, 1, '1JlkuqKg1P4TWyD820ks1516054674', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-15 22:17:54', 'default'),
(225, 1, '1JlkuqKg1P4TWyD820ks1516054674', 'Signing request sent to <span class=\"text-primary\">marketing@drphonefix.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-15 22:19:09', 'default'),
(226, 1, '1JlkuqKg1P4TWyD820ks1516054674', 'Signing request sent to <span class=\"text-primary\">ochoadesigns77@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-15 22:24:43', 'default'),
(227, 1, '1JlkuqKg1P4TWyD820ks1516054674', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-15 22:25:03', 'success'),
(228, 1, '1JlkuqKg1P4TWyD820ks1516054674', 'Signing request sent to <span class=\"text-primary\">ochoadesigns77@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-15 22:26:41', 'default'),
(229, 1, '1JlkuqKg1P4TWyD820ks1516054674', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-15 22:27:21', 'success'),
(230, 1, '1JlkuqKg1P4TWyD820ks1516054674', '<span class=\"text-primary\">Daniel Kimeli</span> <span class=\"text-danger\">cancelled</span> a signing request sent to <span class=\"text-primary\">marketing@drphonefix.com</span>.', '2018-01-16 15:57:16', 'danger'),
(231, 1, 'wpegTNHTomDfYITnSFT41516120447', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-16 16:34:07', 'default'),
(232, 1, 'wpegTNHTomDfYITnSFT41516120447', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-16 16:34:36', 'success'),
(233, 1, 'SyXJ7ebdDY9aWgEBPCd41516170993', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-17 06:36:33', 'default'),
(234, 1, 'SyXJ7ebdDY9aWgEBPCd41516170993', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-17 06:37:24', 'success'),
(235, 1, 'SyXJ7ebdDY9aWgEBPCd41516170993', 'Signing request sent to <span class=\"text-primary\">khalidabes@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-17 06:39:27', 'default'),
(236, 1, 'SyXJ7ebdDY9aWgEBPCd41516170993', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-17 06:40:28', 'success'),
(237, 1, 'SyXJ7ebdDY9aWgEBPCd41516170993', 'This file was replaced with a new one by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-17 06:41:51', 'default'),
(238, 1, 'SyXJ7ebdDY9aWgEBPCd41516170993', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-17 06:42:13', 'success'),
(239, 1, 'SyXJ7ebdDY9aWgEBPCd41516170993', 'Signing request sent to <span class=\"text-primary\">khalidabes@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-17 06:42:49', 'default'),
(240, 5, 'SyXJ7ebdDY9aWgEBPCd41516170993', '<span class=\"text-primary\">khalid soft</span> signed the document.', '2018-01-17 06:47:12', 'success'),
(241, 5, 'SyXJ7ebdDY9aWgEBPCd41516170993', '<span class=\"text-primary\">khalid soft</span> signed the document.', '2018-01-17 06:47:52', 'success'),
(242, 5, 'SyXJ7ebdDY9aWgEBPCd41516170993', '<span class=\"text-primary\">khalid soft</span> signed the document.', '2018-01-17 06:48:27', 'success'),
(243, 1, 'SyXJ7ebdDY9aWgEBPCd41516170993', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-18 06:20:29', 'success'),
(244, 1, 'SyXJ7ebdDY9aWgEBPCd41516170993', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-18 12:38:10', 'success'),
(245, 1, 'fvxji5z0p5muYL9HnXpa1516279237', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-18 12:40:37', 'default'),
(246, 1, 'fvxji5z0p5muYL9HnXpa1516279237', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-18 12:41:47', 'success'),
(247, 1, 'YA3J5fYDZHtF56fcU1C71516279841', 'File Uploaded by <span class=\"text-primary\">Prach Konphet</span>.', '2018-01-18 12:50:41', 'default'),
(248, 1, 'SyXJ7ebdDY9aWgEBPCd41516170993', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-18 12:50:52', 'success'),
(249, 1, 'YA3J5fYDZHtF56fcU1C71516279841', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-18 12:52:14', 'success'),
(250, 6, 'pzpUwiKaTTbYXSTcE14W1516334254', 'File Uploaded by <span class=\"text-primary\">ffewfwef wefwef</span>.', '2018-01-19 03:57:34', 'default'),
(251, 6, 'pzpUwiKaTTbYXSTcE14W1516334254', '<span class=\"text-primary\">ffewfwef wefwef</span> signed the document.', '2018-01-19 03:58:24', 'success'),
(252, 6, 'pzpUwiKaTTbYXSTcE14W1516334254', '<span class=\"text-primary\">ffewfwef wefwef</span> signed the document.', '2018-01-19 04:00:22', 'success'),
(253, 1, 'RDFY3tyoibre1jRrZAbV1516352629', 'This file was duplicated from  <span class=\"text-primary\">dev</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-19 09:03:49', 'default'),
(254, 1, 'SyXJ7ebdDY9aWgEBPCd41516170993', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-19 09:33:15', 'success'),
(255, 1, 'RDFY3tyoibre1jRrZAbV1516352629', 'Signing request sent to <span class=\"text-primary\">ihedioha.victor@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-19 13:01:30', 'default'),
(256, 1, 'RDFY3tyoibre1jRrZAbV1516352629', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-19 13:02:03', 'success'),
(257, 1, '1oer8wNxI7ggtzaEMOmw1516367504', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-19 13:11:44', 'default'),
(258, 1, '1oer8wNxI7ggtzaEMOmw1516367504', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-19 13:12:29', 'success'),
(259, 1, '1oer8wNxI7ggtzaEMOmw1516367504', 'Signing request sent to <span class=\"text-primary\">ihedioha.victor@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-19 13:13:36', 'default'),
(260, 1, '1oer8wNxI7ggtzaEMOmw1516367504', 'Signing request sent to <span class=\"text-primary\">ihedioha.victor@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-19 13:14:59', 'default'),
(261, 1, 'RDFY3tyoibre1jRrZAbV1516352629', 'Signing request sent to <span class=\"text-primary\">garrett@triscari.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-19 17:01:15', 'default'),
(262, 1, 'SyXJ7ebdDY9aWgEBPCd41516170993', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-19 20:01:28', 'success'),
(263, 1, 'RDFY3tyoibre1jRrZAbV1516352629', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-19 21:02:08', 'success'),
(264, 1, '1oer8wNxI7ggtzaEMOmw1516367504', 'Signing request sent to <span class=\"text-primary\">TEST@DENTALMEDIA.DK</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-20 00:09:39', 'default'),
(265, 1, '1oer8wNxI7ggtzaEMOmw1516367504', '<span class=\"text-primary\">Daniel Kimeli</span> <span class=\"text-danger\">cancelled</span> a signing request sent to <span class=\"text-primary\">TEST@DENTALMEDIA.DK</span>.', '2018-01-20 06:09:55', 'danger'),
(266, 1, '1oer8wNxI7ggtzaEMOmw1516367504', '<span class=\"text-primary\">Daniel Kimeli</span> sent a signing reminder to <span class=\"text-primary\">ihedioha.victor@gmail.com</span>', '2018-01-20 13:56:27', 'default'),
(267, 1, '1oer8wNxI7ggtzaEMOmw1516367504', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-20 14:14:47', 'success'),
(268, 1, '1oer8wNxI7ggtzaEMOmw1516367504', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-20 14:15:06', 'success'),
(269, 1, '1oer8wNxI7ggtzaEMOmw1516367504', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-20 22:13:47', 'success'),
(270, 1, 'SyXJ7ebdDY9aWgEBPCd41516170993', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-21 09:47:49', 'success'),
(271, 1, 'SyXJ7ebdDY9aWgEBPCd41516170993', 'Signing request sent to <span class=\"text-primary\">tezdesigner@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-23 00:11:45', 'default'),
(272, 1, 'RDFY3tyoibre1jRrZAbV1516352629', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-23 00:14:03', 'success'),
(273, 1, 'RDFY3tyoibre1jRrZAbV1516352629', 'Signing request sent to <span class=\"text-primary\">tezdesigner@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-23 00:40:04', 'default'),
(274, 1, 'RDFY3tyoibre1jRrZAbV1516352629', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-23 00:44:21', 'success'),
(275, 1, '1oer8wNxI7ggtzaEMOmw1516367504', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-23 05:35:20', 'success'),
(276, 1, 'SyXJ7ebdDY9aWgEBPCd41516170993', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-23 11:35:25', 'success'),
(277, 1, 'wQAHEilSKWORWvTP1z0t1516722390', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-23 15:46:30', 'default'),
(278, 1, 'wQAHEilSKWORWvTP1z0t1516722390', 'Signing request sent to <span class=\"text-primary\">chris@bigbambi.co.uk</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-23 15:48:04', 'default'),
(279, 1, 'wQAHEilSKWORWvTP1z0t1516722390', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-23 15:49:55', 'success'),
(280, 1, 'sJQhClxDvBbeXQHpWWqd1516727096', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-23 17:04:56', 'default'),
(281, 1, 'sJQhClxDvBbeXQHpWWqd1516727096', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-23 17:05:19', 'success'),
(282, 1, 'sJQhClxDvBbeXQHpWWqd1516727096', 'Signing request sent to <span class=\"text-primary\">sleekandstylish@icloud.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-23 17:05:45', 'default'),
(283, 1, 'xG8KIp86pEMeqIpXJfSd1515777894', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-24 02:23:37', 'success'),
(284, 1, 'sJQhClxDvBbeXQHpWWqd1516727096', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-24 11:47:59', 'success'),
(285, 1, 'wQAHEilSKWORWvTP1z0t1516722390', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-24 12:04:33', 'success'),
(286, 1, 'wQAHEilSKWORWvTP1z0t1516722390', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-24 12:05:11', 'success'),
(287, 1, 'wQAHEilSKWORWvTP1z0t1516722390', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-24 17:05:49', 'success'),
(288, 1, 'A8JxakMmSIP3V6oMADNt1516814478', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-24 17:21:18', 'default'),
(289, 1, 'A8JxakMmSIP3V6oMADNt1516814478', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-24 17:21:35', 'success'),
(290, 1, 'rgqQaaksD7EdlMUxRqoB1516866242', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-25 07:44:02', 'default'),
(291, 1, 'rgqQaaksD7EdlMUxRqoB1516866242', 'Signing request sent to <span class=\"text-primary\">reposedhippie@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-25 07:44:38', 'default'),
(292, 1, 'rgqQaaksD7EdlMUxRqoB1516866242', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-25 07:44:54', 'success'),
(293, 1, 'rgqQaaksD7EdlMUxRqoB1516866242', 'Signing request sent to <span class=\"text-primary\">reposedhippie@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-25 07:45:29', 'default'),
(294, 1, 'sJQhClxDvBbeXQHpWWqd1516727096', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-25 16:32:48', 'success'),
(295, 1, 'sJQhClxDvBbeXQHpWWqd1516727096', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-25 16:33:10', 'success'),
(296, 1, 'rgqQaaksD7EdlMUxRqoB1516866242', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-25 18:20:06', 'success'),
(297, 1, '1JlkuqKg1P4TWyD820ks1516054674', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-25 19:07:43', 'success'),
(298, 1, '1JlkuqKg1P4TWyD820ks1516054674', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-25 19:09:07', 'success'),
(299, 1, 'SyXJ7ebdDY9aWgEBPCd41516170993', 'Signing request sent to <span class=\"text-primary\">andre@cssto.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-25 20:47:51', 'default'),
(300, 1, 'rgqQaaksD7EdlMUxRqoB1516866242', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-26 19:08:25', 'success'),
(301, 1, 'xG8KIp86pEMeqIpXJfSd1515777894', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-26 22:26:51', 'success'),
(302, 1, 'sJQhClxDvBbeXQHpWWqd1516727096', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-27 12:07:33', 'success'),
(303, 1, 'GLM5O5GmoTBMAPYZVUzz1517203862', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-29 05:31:02', 'default');
INSERT INTO `history` (`id`, `company`, `file`, `activity`, `time_`, `type`) VALUES
(304, 1, 'GLM5O5GmoTBMAPYZVUzz1517203862', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-29 05:32:02', 'success'),
(305, 1, 'GLM5O5GmoTBMAPYZVUzz1517203862', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-29 05:32:33', 'success'),
(306, 1, 'GLM5O5GmoTBMAPYZVUzz1517203862', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-29 05:34:58', 'success'),
(307, 1, 'GLM5O5GmoTBMAPYZVUzz1517203862', 'Signing request sent to <span class=\"text-primary\">indianic@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-29 05:36:32', 'default'),
(308, 1, 'GLM5O5GmoTBMAPYZVUzz1517203862', 'Signing request sent to <span class=\"text-primary\">indianic@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-29 05:42:38', 'default'),
(309, 1, 'GLM5O5GmoTBMAPYZVUzz1517203862', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-29 05:44:59', 'success'),
(310, 1, 'GLM5O5GmoTBMAPYZVUzz1517203862', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-29 05:49:31', 'success'),
(311, 1, 'rgqQaaksD7EdlMUxRqoB1516866242', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-29 22:12:56', 'success'),
(312, 1, 'Mt297RstdbHNGEacAvvD1517292429', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-30 06:07:10', 'default'),
(313, 1, '1Bny0KV1znkrZjKKHptZ1517292436', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-30 06:07:17', 'default'),
(314, 1, 'bfsnwiPAOkR1FbEZZ1Ip1517292437', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-30 06:07:17', 'default'),
(315, 1, 'bfsnwiPAOkR1FbEZZ1Ip1517292437', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-30 06:09:20', 'success'),
(316, 1, 'bfsnwiPAOkR1FbEZZ1Ip1517292437', 'Signing request sent to <span class=\"text-primary\">atticoresf@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-30 06:11:56', 'default'),
(317, 1, 'bfsnwiPAOkR1FbEZZ1Ip1517292437', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-30 06:12:22', 'success'),
(318, 1, 'bfsnwiPAOkR1FbEZZ1Ip1517292437', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-30 06:15:33', 'success'),
(319, 1, 'GLM5O5GmoTBMAPYZVUzz1517203862', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-30 16:21:22', 'success'),
(320, 1, 'RDFY3tyoibre1jRrZAbV1516352629', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-30 20:01:13', 'success'),
(321, 1, 'rgqQaaksD7EdlMUxRqoB1516866242', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-31 00:52:17', 'success'),
(322, 1, 'RDFY3tyoibre1jRrZAbV1516352629', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-31 07:04:13', 'success'),
(323, 1, 'VHySCu6EZd1UboPMtpsG1517400483', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-31 12:08:03', 'default'),
(324, 1, 'VHySCu6EZd1UboPMtpsG1517400483', 'Signing request sent to <span class=\"text-primary\">nayeem0326@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-01-31 12:09:13', 'default'),
(325, 1, 'VHySCu6EZd1UboPMtpsG1517400483', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-31 12:09:45', 'success'),
(326, 1, 'GLM5O5GmoTBMAPYZVUzz1517203862', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-31 12:48:11', 'success'),
(327, 1, 'VHySCu6EZd1UboPMtpsG1517400483', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-31 14:27:03', 'success'),
(328, 1, 'xG8KIp86pEMeqIpXJfSd1515777894', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-31 14:57:22', 'success'),
(329, 1, 'GLM5O5GmoTBMAPYZVUzz1517203862', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-31 18:49:15', 'success'),
(330, 1, 'sJQhClxDvBbeXQHpWWqd1516727096', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-01-31 20:39:50', 'success'),
(331, 1, 'RDFY3tyoibre1jRrZAbV1516352629', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-01-31 20:41:12', 'success'),
(332, 1, 'GLM5O5GmoTBMAPYZVUzz1517203862', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-01 09:14:00', 'success'),
(333, 1, 'RDFY3tyoibre1jRrZAbV1516352629', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-02 11:16:34', 'success'),
(334, 1, 'RDFY3tyoibre1jRrZAbV1516352629', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-02 11:17:04', 'success'),
(335, 1, 'wQAHEilSKWORWvTP1z0t1516722390', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-02 23:32:29', 'success'),
(336, 1, 'VHySCu6EZd1UboPMtpsG1517400483', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-02 23:52:46', 'success'),
(337, 1, 'VHySCu6EZd1UboPMtpsG1517400483', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-02-02 23:53:12', 'success'),
(338, 1, 'sgBAAFIhWl3Xv1UkAvUn1517625370', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-03 02:36:10', 'default'),
(339, 1, 'A3Or3vSWMiRBKOw0tWMI1517625743', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-03 02:42:23', 'default'),
(340, 1, '1JlkuqKg1P4TWyD820ks1516054674', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-03 05:27:20', 'success'),
(341, 1, 'sJQhClxDvBbeXQHpWWqd1516727096', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-03 10:19:52', 'success'),
(342, 1, 'sJQhClxDvBbeXQHpWWqd1516727096', 'Signing request sent to <span class=\"text-primary\">roku.hachi@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-03 10:23:05', 'default'),
(343, 1, '1oer8wNxI7ggtzaEMOmw1516367504', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-04 21:19:29', 'success'),
(344, 1, 'wQAHEilSKWORWvTP1z0t1516722390', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-04 21:27:41', 'success'),
(345, 1, 'xG8KIp86pEMeqIpXJfSd1515777894', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-05 20:21:12', 'success'),
(346, 1, 'GLM5O5GmoTBMAPYZVUzz1517203862', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-02-06 04:59:17', 'success'),
(347, 1, 'OOKhhyJkmOGdzB59B4C91517893258', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-06 05:00:58', 'default'),
(348, 1, 'OOKhhyJkmOGdzB59B4C91517893258', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-02-06 05:01:54', 'success'),
(349, 1, 'TdhMMJQq6UbuEWhVqRiI1517902257', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-06 07:30:57', 'default'),
(350, 1, 'OOKhhyJkmOGdzB59B4C91517893258', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-06 11:08:08', 'success'),
(351, 1, 'TdhMMJQq6UbuEWhVqRiI1517902257', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-02-06 17:44:18', 'success'),
(352, 1, 'TdhMMJQq6UbuEWhVqRiI1517902257', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-06 17:45:02', 'success'),
(353, 1, 'sgBAAFIhWl3Xv1UkAvUn1517625370', 'Signing request sent to <span class=\"text-primary\">pierrevwyk@outlook.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-06 18:31:27', 'default'),
(354, 1, 'OOKhhyJkmOGdzB59B4C91517893258', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-08 05:25:21', 'success'),
(355, 1, 'xG8KIp86pEMeqIpXJfSd1515777894', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-08 13:09:32', 'success'),
(356, 1, 'SyXJ7ebdDY9aWgEBPCd41516170993', '<span class=\"text-primary\">Daniel Kimeli</span> sent a signing reminder to <span class=\"text-primary\">andre@cssto.com</span>', '2018-02-08 13:35:57', 'default'),
(357, 1, 'OOKhhyJkmOGdzB59B4C91517893258', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-09 08:22:01', 'success'),
(358, 1, '9MTFN4vgSKhBD3UbaA7s1518164632', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-09 08:23:52', 'default'),
(359, 1, '9MTFN4vgSKhBD3UbaA7s1518164632', 'Signing request sent to <span class=\"text-primary\">gmods11@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-09 08:24:10', 'default'),
(360, 1, '9MTFN4vgSKhBD3UbaA7s1518164632', 'Signing request sent to <span class=\"text-primary\">gmods11@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-09 08:27:37', 'default'),
(361, 1, '9MTFN4vgSKhBD3UbaA7s1518164632', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-09 08:28:12', 'success'),
(362, 1, '9MTFN4vgSKhBD3UbaA7s1518164632', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-09 08:28:22', 'success'),
(363, 1, 'OOKhhyJkmOGdzB59B4C91517893258', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-02-10 06:03:37', 'success'),
(364, 1, 'OOKhhyJkmOGdzB59B4C91517893258', 'Signing request sent to <span class=\"text-primary\">troy@blaqclouds.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-10 06:04:39', 'default'),
(365, 1, 'OOKhhyJkmOGdzB59B4C91517893258', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-10 06:06:10', 'success'),
(366, 1, 'OOKhhyJkmOGdzB59B4C91517893258', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-10 06:06:43', 'success'),
(367, 1, '9MTFN4vgSKhBD3UbaA7s1518164632', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-10 19:31:10', 'success'),
(368, 1, '9MTFN4vgSKhBD3UbaA7s1518164632', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-10 22:44:01', 'success'),
(369, 1, 'OOKhhyJkmOGdzB59B4C91517893258', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-11 16:40:47', 'success'),
(370, 1, 'VHySCu6EZd1UboPMtpsG1517400483', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-11 19:35:35', 'success'),
(371, 1, 'GLM5O5GmoTBMAPYZVUzz1517203862', 'Signing request sent to <span class=\"text-primary\">chase.fox1997@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-12 08:42:40', 'default'),
(372, 1, 'GLM5O5GmoTBMAPYZVUzz1517203862', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-12 08:43:14', 'success'),
(373, 1, '9MTFN4vgSKhBD3UbaA7s1518164632', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-12 11:34:31', 'success'),
(374, 1, '9MTFN4vgSKhBD3UbaA7s1518164632', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-02-12 11:34:47', 'success'),
(375, 1, '9MTFN4vgSKhBD3UbaA7s1518164632', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-12 11:34:57', 'success'),
(376, 1, 'TdhMMJQq6UbuEWhVqRiI1517902257', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-12 11:38:35', 'success'),
(377, 1, 'TdhMMJQq6UbuEWhVqRiI1517902257', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-12 11:38:45', 'success'),
(378, 1, '9MTFN4vgSKhBD3UbaA7s1518164632', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-12 11:39:32', 'success'),
(379, 1, 'sJQhClxDvBbeXQHpWWqd1516727096', '<span class=\"text-primary\">Daniel Kimeli</span> sent a signing reminder to <span class=\"text-primary\">sleekandstylish@icloud.com</span>', '2018-02-12 12:22:07', 'default'),
(380, 1, '9MTFN4vgSKhBD3UbaA7s1518164632', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-02-12 12:33:35', 'success'),
(381, 1, '9MTFN4vgSKhBD3UbaA7s1518164632', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-02-12 12:34:03', 'success'),
(382, 1, 'OOKhhyJkmOGdzB59B4C91517893258', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-12 19:29:49', 'success'),
(383, 1, 'OOKhhyJkmOGdzB59B4C91517893258', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-13 15:31:38', 'success'),
(384, 1, '9MTFN4vgSKhBD3UbaA7s1518164632', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-14 03:38:07', 'success'),
(385, 1, '9MTFN4vgSKhBD3UbaA7s1518164632', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-14 09:03:02', 'success'),
(386, 12, 'V6VybY08Ie2wqI2izODo1518681837', 'File Uploaded by <span class=\"text-primary\">abc def</span>.', '2018-02-15 08:03:57', 'default'),
(387, 1, 'TdhMMJQq6UbuEWhVqRiI1517902257', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-02-15 13:31:31', 'success'),
(388, 1, '9MTFN4vgSKhBD3UbaA7s1518164632', '<span class=\"text-primary\">Daniel Kimeli</span> sent a signing reminder to <span class=\"text-primary\">gmods11@gmail.com</span>', '2018-02-15 13:32:44', 'default'),
(389, 1, '9MTFN4vgSKhBD3UbaA7s1518164632', '<span class=\"text-primary\">Daniel Kimeli</span> sent a signing reminder to <span class=\"text-primary\">gmods11@gmail.com</span>', '2018-02-15 13:33:02', 'default'),
(390, 1, 'gnLxDkRPKyQQVAFSVEio1518701704', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-15 13:35:04', 'default'),
(391, 1, '9MTFN4vgSKhBD3UbaA7s1518164632', '<span class=\"text-primary\">Daniel Kimeli</span> sent a signing reminder to <span class=\"text-primary\">gmods11@gmail.com</span>', '2018-02-15 13:36:34', 'default'),
(392, 1, '9MTFN4vgSKhBD3UbaA7s1518164632', '<span class=\"text-primary\">test test</span> sent a signing reminder to <span class=\"text-primary\">gmods11@gmail.com</span>', '2018-02-15 13:41:59', 'default'),
(393, 1, 'gnLxDkRPKyQQVAFSVEio1518701704', 'Signing request sent to <span class=\"text-primary\">rassouldev@icloud.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-15 13:45:21', 'default'),
(394, 1, 'gnLxDkRPKyQQVAFSVEio1518701704', '<span class=\"text-primary\">Daniel Kimeli</span> sent a signing reminder to <span class=\"text-primary\">rassouldev@icloud.com</span>', '2018-02-15 13:46:50', 'default'),
(395, 1, 'gnLxDkRPKyQQVAFSVEio1518701704', '<span class=\"text-primary\">test test</span> signed the document.', '2018-02-15 13:48:06', 'success'),
(396, 1, '9MTFN4vgSKhBD3UbaA7s1518164632', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-02-16 01:55:35', 'success'),
(397, 1, 'gnLxDkRPKyQQVAFSVEio1518701704', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-16 06:34:21', 'success'),
(398, 1, '9MTFN4vgSKhBD3UbaA7s1518164632', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-16 06:35:31', 'success'),
(399, 1, 'LE3sS7nGo4B88rJkCeWo1518763703', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-16 06:48:23', 'default'),
(400, 1, 'LE3sS7nGo4B88rJkCeWo1518763703', 'Signing request sent to <span class=\"text-primary\">maninder.pal19@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-16 07:09:21', 'default'),
(401, 1, 'LE3sS7nGo4B88rJkCeWo1518763703', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-16 07:14:35', 'success'),
(402, 1, 'LE3sS7nGo4B88rJkCeWo1518763703', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-16 15:33:29', 'success'),
(403, 1, '9MTFN4vgSKhBD3UbaA7s1518164632', '<span class=\"text-primary\">Daniel Kimeli</span> sent a signing reminder to <span class=\"text-primary\">gmods11@gmail.com</span>', '2018-02-18 00:56:42', 'default'),
(404, 1, 'gnLxDkRPKyQQVAFSVEio1518701704', 'Signing request sent to <span class=\"text-primary\">osvin315@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-19 13:29:32', 'default'),
(405, 1, 'gnLxDkRPKyQQVAFSVEio1518701704', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-19 13:30:28', 'success'),
(406, 1, '9MTFN4vgSKhBD3UbaA7s1518164632', 'Signing request sent to <span class=\"text-primary\">eder101@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-20 02:29:48', 'default'),
(407, 1, '9MTFN4vgSKhBD3UbaA7s1518164632', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-20 02:30:56', 'success'),
(408, 1, 'TdhMMJQq6UbuEWhVqRiI1517902257', 'Signing request sent to <span class=\"text-primary\">osvin315@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-20 04:49:11', 'default'),
(409, 1, 'TdhMMJQq6UbuEWhVqRiI1517902257', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-20 04:49:57', 'success'),
(410, 1, 'gnLxDkRPKyQQVAFSVEio1518701704', 'Signing request sent to <span class=\"text-primary\">osvin315@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-20 04:51:11', 'default'),
(411, 1, 'gnLxDkRPKyQQVAFSVEio1518701704', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-20 04:51:32', 'success'),
(412, 1, 'LE3sS7nGo4B88rJkCeWo1518763703', 'Signing request sent to <span class=\"text-primary\">realestate@jeffcatalano.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-20 04:55:15', 'default'),
(413, 1, 'LE3sS7nGo4B88rJkCeWo1518763703', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-20 04:59:42', 'success'),
(414, 1, 'LE3sS7nGo4B88rJkCeWo1518763703', 'Signing request sent to <span class=\"text-primary\">osvin315@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-20 05:01:38', 'default'),
(415, 1, 'LE3sS7nGo4B88rJkCeWo1518763703', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-20 05:01:58', 'success'),
(416, 1, 'rOptGoYDbOWIVEH15szT1519150214', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-20 18:10:14', 'default'),
(417, 1, 'rOptGoYDbOWIVEH15szT1519150214', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-02-20 18:10:45', 'success'),
(418, 1, 'rOptGoYDbOWIVEH15szT1519150214', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-20 18:11:07', 'success'),
(419, 1, 'rOptGoYDbOWIVEH15szT1519150214', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-20 18:11:49', 'success'),
(420, 15, 'E7gHir2jILyEbEUVpeOL1519151003', 'File Uploaded by <span class=\"text-primary\">pippo pippa</span>.', '2018-02-20 18:23:23', 'default'),
(421, 15, 'E7gHir2jILyEbEUVpeOL1519151003', '<span class=\"text-primary\">pippo pippa</span> signed the document.', '2018-02-20 18:23:35', 'success'),
(422, 15, '6Zq8kgL5EiiEDxTikmxw1519151054', 'File Uploaded by <span class=\"text-primary\">pippo pippa</span>.', '2018-02-20 18:24:14', 'default'),
(423, 1, 'gnLxDkRPKyQQVAFSVEio1518701704', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-02-20 21:20:57', 'success'),
(424, 1, 'xFBoKPLjO2GUXPnh8vv01519162087', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-20 21:28:07', 'default'),
(425, 1, 'xFBoKPLjO2GUXPnh8vv01519162087', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-20 21:28:21', 'success'),
(426, 1, 'qEyLO0DIhVievKBMa7FN1519195645', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-21 06:47:25', 'default'),
(427, 1, 'qEyLO0DIhVievKBMa7FN1519195645', 'Signing request sent to <span class=\"text-primary\">joe@joe.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-21 06:49:49', 'default'),
(428, 15, 'E7gHir2jILyEbEUVpeOL1519151003', '<span class=\"text-primary\">pippo pippa</span> wrote on the document.', '2018-02-21 07:01:39', 'success'),
(429, 15, 'E7gHir2jILyEbEUVpeOL1519151003', '<span class=\"text-primary\">pippo pippa</span> signed the document.', '2018-02-21 07:01:55', 'success'),
(430, 1, 'xFBoKPLjO2GUXPnh8vv01519162087', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-02-21 09:00:28', 'success'),
(431, 1, 'O9BK7JSehTKrsRCsqtc01519215965', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-21 12:26:05', 'default'),
(432, 1, 'qEyLO0DIhVievKBMa7FN1519195645', '<span class=\"text-primary\">Daniel Kimeli</span> sent a signing reminder to <span class=\"text-primary\">joe@joe.com</span>', '2018-02-22 06:11:35', 'default'),
(433, 1, 'O9BK7JSehTKrsRCsqtc01519215965', 'Signing request sent to <span class=\"text-primary\">hiteshmprajapati@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-22 06:14:12', 'default'),
(434, 1, 'xG8KIp86pEMeqIpXJfSd1515777894', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-02-22 07:33:41', 'success'),
(435, 1, 'xG8KIp86pEMeqIpXJfSd1515777894', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-02-22 07:34:06', 'success'),
(436, 1, 'xG8KIp86pEMeqIpXJfSd1515777894', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-02-22 07:34:26', 'success'),
(437, 1, 'xG8KIp86pEMeqIpXJfSd1515777894', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-22 07:34:40', 'success'),
(438, 1, 'xG8KIp86pEMeqIpXJfSd1515777894', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-02-22 07:34:52', 'success'),
(439, 1, 'xG8KIp86pEMeqIpXJfSd1515777894', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-22 07:35:04', 'success'),
(440, 1, 'xG8KIp86pEMeqIpXJfSd1515777894', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-22 07:35:38', 'success'),
(441, 1, 'xG8KIp86pEMeqIpXJfSd1515777894', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-22 07:35:54', 'success'),
(442, 1, 'xG8KIp86pEMeqIpXJfSd1515777894', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-22 07:36:16', 'success'),
(443, 1, 'xG8KIp86pEMeqIpXJfSd1515777894', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-22 07:36:39', 'success'),
(444, 1, 'xG8KIp86pEMeqIpXJfSd1515777894', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-02-22 07:37:04', 'success'),
(445, 1, 'TdhMMJQq6UbuEWhVqRiI1517902257', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-22 07:38:42', 'success'),
(446, 1, 'TdhMMJQq6UbuEWhVqRiI1517902257', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-22 07:38:54', 'success'),
(447, 1, 'OOKhhyJkmOGdzB59B4C91517893258', 'Signing request sent to <span class=\"text-primary\">osvinhybrid@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-22 07:41:03', 'default'),
(448, 1, 'OOKhhyJkmOGdzB59B4C91517893258', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-22 07:41:31', 'success'),
(449, 1, 'VHySCu6EZd1UboPMtpsG1517400483', 'Signing request sent to <span class=\"text-primary\">f</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-22 07:44:51', 'default'),
(450, 1, 'VHySCu6EZd1UboPMtpsG1517400483', 'Signing request sent to <span class=\"text-primary\">f</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-22 07:44:58', 'default'),
(451, 1, 'VHySCu6EZd1UboPMtpsG1517400483', 'Signing request sent to <span class=\"text-primary\">f</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-22 07:45:03', 'default'),
(452, 1, 'VHySCu6EZd1UboPMtpsG1517400483', 'Signing request sent to <span class=\"text-primary\">f</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-22 07:45:08', 'default'),
(453, 1, '9MTFN4vgSKhBD3UbaA7s1518164632', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-22 10:03:46', 'success'),
(454, 1, '9MTFN4vgSKhBD3UbaA7s1518164632', 'Signing request sent to <span class=\"text-primary\">osvinphp@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-22 10:04:16', 'default'),
(455, 1, 'sJQhClxDvBbeXQHpWWqd1516727096', 'Signing request sent to <span class=\"text-primary\">osvinphp@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-22 10:06:43', 'default'),
(456, 1, 'sJQhClxDvBbeXQHpWWqd1516727096', 'Signing request sent to <span class=\"text-primary\">osvinphp@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-22 10:09:08', 'default'),
(457, 1, 'TdhMMJQq6UbuEWhVqRiI1517902257', 'Signing request sent to <span class=\"text-primary\">osvinphp@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-22 10:13:00', 'default'),
(458, 1, '1oer8wNxI7ggtzaEMOmw1516367504', 'Signing request sent to <span class=\"text-primary\">osvinphp@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-22 10:17:29', 'default'),
(459, 16, '1oer8wNxI7ggtzaEMOmw1516367504', '<span class=\"text-primary\">boriss pazinn</span> signed the document.', '2018-02-22 10:19:09', 'success'),
(460, 1, 'VHySCu6EZd1UboPMtpsG1517400483', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-22 10:23:50', 'success'),
(461, 1, 'VHySCu6EZd1UboPMtpsG1517400483', 'Signing request sent to <span class=\"text-primary\">osvinphp@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-22 10:24:12', 'default'),
(462, 16, 'VHySCu6EZd1UboPMtpsG1517400483', '<span class=\"text-primary\">boriss pazinn</span> signed the document.', '2018-02-22 10:24:41', 'success'),
(463, 1, 'VHySCu6EZd1UboPMtpsG1517400483', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-22 10:25:28', 'success'),
(464, 1, 'VHySCu6EZd1UboPMtpsG1517400483', 'Signing request sent to <span class=\"text-primary\">osvinphp@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-22 10:25:54', 'default'),
(465, 16, 'VHySCu6EZd1UboPMtpsG1517400483', '<span class=\"text-primary\">boriss pazinn</span> signed the document.', '2018-02-22 10:26:13', 'success'),
(466, 1, 'VHySCu6EZd1UboPMtpsG1517400483', 'Signing request sent to <span class=\"text-primary\">osvinphp@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-22 10:28:11', 'default'),
(467, 16, 'VHySCu6EZd1UboPMtpsG1517400483', '<span class=\"text-primary\">boriss pazinn</span> signed the document.', '2018-02-22 10:28:43', 'success'),
(468, 16, '1oer8wNxI7ggtzaEMOmw1516367504', '<span class=\"text-primary\">boriss pazinn</span> signed the document.', '2018-02-22 10:40:31', 'success'),
(469, 16, '1oer8wNxI7ggtzaEMOmw1516367504', '<span class=\"text-primary\">boriss pazinn</span> signed the document.', '2018-02-22 10:40:40', 'success'),
(470, 16, '1oer8wNxI7ggtzaEMOmw1516367504', '<span class=\"text-primary\">boriss pazinn</span> signed the document.', '2018-02-22 10:45:16', 'success'),
(471, 16, '1oer8wNxI7ggtzaEMOmw1516367504', 'Signing request sent to <span class=\"text-primary\">osvinandroid@gmail.com</span> by <span class=\"text-primary\">boriss pazinn</span>.', '2018-02-22 10:45:43', 'default'),
(472, 16, '1oer8wNxI7ggtzaEMOmw1516367504', '<span class=\"text-primary\">boriss pazinn</span> signed the document.', '2018-02-22 10:46:47', 'success'),
(473, 1, 'wQAHEilSKWORWvTP1z0t1516722390', 'Signing request sent to <span class=\"text-primary\">rassouldev@icloud.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-22 11:54:22', 'default'),
(474, 1, 'wQAHEilSKWORWvTP1z0t1516722390', '<span class=\"text-primary\">Daniel Kimeli</span> sent a signing reminder to <span class=\"text-primary\">rassouldev@icloud.com</span>', '2018-02-22 11:54:58', 'default'),
(475, 1, 'wQAHEilSKWORWvTP1z0t1516722390', '<span class=\"text-primary\">test test</span> signed the document.', '2018-02-22 11:55:39', 'success'),
(476, 1, 'qEyLO0DIhVievKBMa7FN1519195645', '<span class=\"text-primary\">test test</span> signed the document.', '2018-02-22 11:58:14', 'success'),
(477, 1, 'wQAHEilSKWORWvTP1z0t1516722390', '<span class=\"text-primary\">test test</span> signed the document.', '2018-02-22 11:59:56', 'success'),
(478, 1, 'xG8KIp86pEMeqIpXJfSd1515777894', '<span class=\"text-primary\">test test</span> signed the document.', '2018-02-22 12:00:48', 'success'),
(479, 1, '9MTFN4vgSKhBD3UbaA7s1518164632', 'Signing request sent to <span class=\"text-primary\">osvinhybrid@gmail.com</span> by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-22 12:33:02', 'default'),
(480, 1, '9MTFN4vgSKhBD3UbaA7s1518164632', '<span class=\"text-primary\">Daniel Kimeli</span> signed the document.', '2018-02-22 12:33:33', 'success'),
(481, 1, '9MTFN4vgSKhBD3UbaA7s1518164632', '<span class=\"text-primary\">Daniel Kimeli</span> wrote on the document.', '2018-02-22 12:35:02', 'success'),
(482, 1, '7SfKKFLKp6FvKiuVmVsW1519324050', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-22 18:27:30', 'default'),
(483, 1, 'WjbCJOHq3vWeC2Kk9LFu1519330867', 'File Uploaded by <span class=\"text-primary\">Daniel Kimeli</span>.', '2018-02-22 20:21:07', 'default'),
(484, 17, 'fsNVrERuA5BcQm9r3RXS1519373062', 'File Uploaded by <span class=\"text-primary\">AA AAA</span>.', '2018-02-23 08:04:22', 'default'),
(485, 17, 'fsNVrERuA5BcQm9r3RXS1519373062', '<span class=\"text-primary\">AA AAA</span> signed the document.', '2018-02-23 08:04:59', 'success'),
(486, 17, 'fsNVrERuA5BcQm9r3RXS1519373062', '<span class=\"text-primary\">AA AAA</span> signed the document.', '2018-02-23 08:06:21', 'success'),
(487, 18, 'C5ntAUNVkpbTunaf7qdC1519383737', 'File Uploaded by <span class=\"text-primary\">Test Name</span>.', '2018-02-23 11:02:17', 'default'),
(488, 18, 'C5ntAUNVkpbTunaf7qdC1519383737', '<span class=\"text-primary\">Test Name</span> signed the document.', '2018-02-23 11:02:42', 'success'),
(489, 18, 'C5ntAUNVkpbTunaf7qdC1519383737', '<span class=\"text-primary\">Test Name</span> signed the document.', '2018-02-23 11:03:29', 'success'),
(490, 21, 'D25vVQ0jxQIoDVBod6LX1519447650', 'File Uploaded by <span class=\"text-primary\">111 111</span>.', '2018-02-24 04:47:30', 'default'),
(491, 21, 'D25vVQ0jxQIoDVBod6LX1519447650', 'Signing request sent to <span class=\"text-primary\">rr@sss.com</span> by <span class=\"text-primary\">111 111</span>.', '2018-02-24 04:48:15', 'default'),
(492, 21, 'D25vVQ0jxQIoDVBod6LX1519447650', 'Signing request sent to <span class=\"text-primary\">marineu@gmail.com</span> by <span class=\"text-primary\">111 111</span>.', '2018-02-24 04:49:02', 'default'),
(493, 1, 'WjbCJOHq3vWeC2Kk9LFu1519330867', '<span class=\"text-primary\">Test Test</span> signed the document.', '2018-02-24 11:53:45', 'success'),
(494, 1, '7SfKKFLKp6FvKiuVmVsW1519324050', '<span class=\"text-primary\">Test Test</span> signed the document.', '2018-02-24 22:23:58', 'success'),
(495, 1, 'rgqQaaksD7EdlMUxRqoB1516866242', '<span class=\"text-primary\">Test Test</span> signed the document.', '2018-02-26 06:47:51', 'success'),
(496, 1, '7SfKKFLKp6FvKiuVmVsW1519324050', '<span class=\"text-primary\">Test Test</span> signed the document.', '2018-02-26 09:29:01', 'success'),
(497, 1, '7SfKKFLKp6FvKiuVmVsW1519324050', '<span class=\"text-primary\">Test Test</span> signed the document.', '2018-02-26 09:52:21', 'success'),
(498, 1, '76Atp9VAPstaWYoY6OPk1519638820', 'File Uploaded by <span class=\"text-primary\">Test Test</span>.', '2018-02-26 09:53:40', 'default'),
(499, 1, '6mgChfVWl7l9aMgDiSoH1519638934', 'File Uploaded by <span class=\"text-primary\">Test Test</span>.', '2018-02-26 09:55:34', 'default'),
(500, 1, '6mgChfVWl7l9aMgDiSoH1519638934', '<span class=\"text-primary\">Test Test</span> signed the document.', '2018-02-26 09:56:39', 'success'),
(501, 1, '9MTFN4vgSKhBD3UbaA7s1518164632', '<span class=\"text-primary\">Test Test</span> signed the document.', '2018-02-26 10:02:42', 'success'),
(502, 24, 'y8XFOdSqRqPimlSZ9SnS1519649743', 'File Uploaded by <span class=\"text-primary\">sds sad</span>.', '2018-02-26 12:55:43', 'default'),
(503, 1, '7SfKKFLKp6FvKiuVmVsW1519324050', 'Signing request sent to <span class=\"text-primary\">parekhjp@gmail.com</span> by <span class=\"text-primary\">Test Test</span>.', '2018-02-26 14:53:59', 'default'),
(504, 1, '7SfKKFLKp6FvKiuVmVsW1519324050', '<span class=\"text-primary\">Test Test</span> declined to sign the document', '2018-02-26 14:55:24', 'danger'),
(505, 1, 'LE3sS7nGo4B88rJkCeWo1518763703', '<span class=\"text-primary\">Test Test</span> signed the document.', '2018-02-27 11:44:02', 'success'),
(506, 1, '6mgChfVWl7l9aMgDiSoH1519638934', '<span class=\"text-primary\">Test Test</span> wrote on the document.', '2018-02-28 09:38:51', 'success'),
(507, 1, '6mgChfVWl7l9aMgDiSoH1519638934', '<span class=\"text-primary\">Test Test</span> wrote on the document.', '2018-02-28 10:53:40', 'success'),
(508, 1, '7SfKKFLKp6FvKiuVmVsW1519324050', '<span class=\"text-primary\">Test Test</span> signed the document.', '2018-02-28 21:04:19', 'success'),
(509, 1, 'TdhMMJQq6UbuEWhVqRiI1517902257', '<span class=\"text-primary\">Test Test</span> <span class=\"text-danger\">cancelled</span> a signing request sent to <span class=\"text-primary\">osvinphp@gmail.com</span>.', '2018-02-28 21:05:46', 'danger'),
(510, 1, '9MTFN4vgSKhBD3UbaA7s1518164632', '<span class=\"text-primary\">Test Test</span> signed the document.', '2018-03-01 08:57:05', 'success'),
(511, 1, 'LE3sS7nGo4B88rJkCeWo1518763703', '<span class=\"text-primary\">Test Test</span> signed the document.', '2018-03-01 09:04:41', 'success'),
(512, 1, '6mgChfVWl7l9aMgDiSoH1519638934', '<span class=\"text-primary\">Test Test</span> signed the document.', '2018-03-02 21:01:52', 'success'),
(513, 1, '6mgChfVWl7l9aMgDiSoH1519638934', '<span class=\"text-primary\">Test Test</span> signed the document.', '2018-03-03 08:23:01', 'success'),
(514, 1, '76Atp9VAPstaWYoY6OPk1519638820', '<span class=\"text-primary\">Test Test</span> signed the document.', '2018-03-03 09:37:16', 'success'),
(515, 1, 'rOptGoYDbOWIVEH15szT1519150214', '<span class=\"text-primary\">Test Test</span> signed the document.', '2018-03-03 13:18:30', 'success'),
(516, 1, '3VzievEHANJy0IrPN5hO1520229818', 'File Uploaded by <span class=\"text-primary\">Test Test</span>.', '2018-03-05 06:03:38', 'default'),
(517, 1, '6ZCNnQLQ09eXFgfI8t5F1520244047', 'File Uploaded by <span class=\"text-primary\">John Doe</span>.', '2018-03-05 10:00:47', 'default'),
(518, 1, 'GuLQR08s2NQgS8CXnCPt1520244108', 'File Uploaded by <span class=\"text-primary\">John Doe</span>.', '2018-03-05 10:01:48', 'default'),
(519, 1, 'GuLQR08s2NQgS8CXnCPt1520244108', '<span class=\"text-primary\">John Doe</span> signed the document.', '2018-03-05 10:02:04', 'success');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `company` int(11) NOT NULL,
  `message` text NOT NULL,
  `time_` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `user` int(11) NOT NULL,
  `type` enum('decline','accept','warning') NOT NULL,
  `email` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `reminders`
--

CREATE TABLE `reminders` (
  `id` int(11) NOT NULL,
  `company` int(11) NOT NULL,
  `subject` varchar(256) NOT NULL,
  `days` int(11) NOT NULL,
  `message` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `reminders`
--

INSERT INTO `reminders` (`id`, `company`, `subject`, `days`, `message`) VALUES
(122, 1, 'Signing invitation reminder ', 3, 'Hello there, \r\n\r\nI hope you are doing well.\r\nI am writing to remind you about the signing request I had sent earlier.\r\n\r\nCheers!\r\nDaniel Kimeli\r\n'),
(123, 1, 'Signing invitation reminder ', 7, 'Hello there, \r\n\r\nI hope you are doing well.\r\nI am writing to remind you about the signing request I had sent earlier.\r\n\r\nCheers!\r\nDaniel Kimeli\r\n'),
(124, 1, 'Signing invitation reminder', 14, 'Hello there,\r\n\r\nI hope you are doing well.\r\nI am writing to remind you about the signing request I had sent earlier.Cheers!\r\n\r\nDaniel Kimeli'),
(125, 1, 'Signing invitation reminder', 8, 'Hello there,\r\n\r\nI hope you are doing well.\r\nI am writing to remind you about the signing request I had sent earlier.\r\n\r\nCheers!\r\nDaniel Kimeli\r\n');

-- --------------------------------------------------------

--
-- Table structure for table `requests`
--

CREATE TABLE `requests` (
  `id` int(11) NOT NULL,
  `signingkey` varchar(256) NOT NULL,
  `file` varchar(256) NOT NULL,
  `positions` varchar(500) NOT NULL,
  `restricted` enum('1','0') NOT NULL,
  `company` int(11) NOT NULL,
  `time_` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `actiontime_` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `email` varchar(128) NOT NULL,
  `status` enum('0','1','2','3') NOT NULL,
  `sender` varchar(64) NOT NULL,
  `user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(11) NOT NULL,
  `name` varchar(64) NOT NULL,
  `logo` text NOT NULL,
  `favicon` varchar(256) NOT NULL,
  `smtp_host` varchar(64) NOT NULL,
  `smtp_username` varchar(64) NOT NULL,
  `smtp_password` varchar(64) NOT NULL,
  `smtp_port` int(11) NOT NULL,
  `smtp_secure` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `name`, `logo`, `favicon`, `smtp_host`, `smtp_username`, `smtp_password`, `smtp_port`, `smtp_secure`) VALUES
(1, 'Signer', '149996908140312logo.png', '149996969781360Favicon.png', 'mail.simcycreative.com', 'demo@simcycreative.com', 'Simcy@#101', 465, 'ssl');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `fname` varchar(16) NOT NULL,
  `lname` varchar(16) NOT NULL,
  `email` varchar(64) NOT NULL,
  `phone` varchar(16) DEFAULT NULL,
  `password` varchar(256) NOT NULL,
  `avatar` varchar(256) DEFAULT NULL,
  `token` varchar(256) DEFAULT NULL,
  `company` int(11) NOT NULL,
  `role` enum('admin','staff','superadmin') NOT NULL,
  `permissions` varchar(256) NOT NULL DEFAULT '["upload","sign","delete"]',
  `signature` varchar(500) DEFAULT NULL,
  `lastnotification` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `hiddenfiles` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `fname`, `lname`, `email`, `phone`, `password`, `avatar`, `token`, `company`, `role`, `permissions`, `signature`, `lastnotification`, `hiddenfiles`) VALUES
(1, 'John', 'Doe', 'demo@simcycreative.comg', '12345678', '4f3487272846fa2d25d7fed97457273f355b24cdd925417b88c2d4e74c320c10', '1520243492675784e6c6fb2-300x300.jpg', '', 1, 'superadmin', '[\"upload\",\"sign\",\"delete\"]', '1b214726d362840cf6847d29dcfc2a28.png', '2018-03-05 10:02:28', '[\"50\",\"KFqpe7DH5quW981BA91o1515009791\"]');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `chat`
--
ALTER TABLE `chat`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender` (`sender`),
  ADD KEY `sender_2` (`sender`),
  ADD KEY `file` (`file`);

--
-- Indexes for table `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `files`
--
ALTER TABLE `files`
  ADD UNIQUE KEY `id` (`id`),
  ADD UNIQUE KEY `sharing_key` (`sharing_key`),
  ADD KEY `company` (`company`),
  ADD KEY `uploaded_by` (`uploaded_by`),
  ADD KEY `folder` (`folder`);

--
-- Indexes for table `folders`
--
ALTER TABLE `folders`
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `created_by` (`created_by`),
  ADD KEY `company` (`company`);

--
-- Indexes for table `history`
--
ALTER TABLE `history`
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `company` (`company`),
  ADD KEY `file` (`file`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `company` (`company`),
  ADD KEY `user` (`user`);

--
-- Indexes for table `reminders`
--
ALTER TABLE `reminders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `company` (`company`);

--
-- Indexes for table `requests`
--
ALTER TABLE `requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `file` (`file`),
  ADD KEY `company` (`company`),
  ADD KEY `user` (`user`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `company` (`company`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `chat`
--
ALTER TABLE `chat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT for table `companies`
--
ALTER TABLE `companies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `files`
--
ALTER TABLE `files`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=108;

--
-- AUTO_INCREMENT for table `folders`
--
ALTER TABLE `folders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `history`
--
ALTER TABLE `history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=520;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT for table `reminders`
--
ALTER TABLE `reminders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=126;

--
-- AUTO_INCREMENT for table `requests`
--
ALTER TABLE `requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `chat`
--
ALTER TABLE `chat`
  ADD CONSTRAINT `chat_ibfk_1` FOREIGN KEY (`file`) REFERENCES `files` (`sharing_key`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `chat_ibfk_2` FOREIGN KEY (`sender`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `files`
--
ALTER TABLE `files`
  ADD CONSTRAINT `files_ibfk_1` FOREIGN KEY (`uploaded_by`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE,
  ADD CONSTRAINT `files_ibfk_2` FOREIGN KEY (`company`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `files_ibfk_3` FOREIGN KEY (`folder`) REFERENCES `folders` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `folders`
--
ALTER TABLE `folders`
  ADD CONSTRAINT `folders_ibfk_1` FOREIGN KEY (`company`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `folders_ibfk_2` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE CASCADE;

--
-- Constraints for table `notifications`
--
ALTER TABLE `notifications`
  ADD CONSTRAINT `notifications_ibfk_1` FOREIGN KEY (`company`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `notifications_ibfk_2` FOREIGN KEY (`user`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `reminders`
--
ALTER TABLE `reminders`
  ADD CONSTRAINT `reminders_ibfk_1` FOREIGN KEY (`company`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `requests`
--
ALTER TABLE `requests`
  ADD CONSTRAINT `requests_ibfk_1` FOREIGN KEY (`file`) REFERENCES `files` (`sharing_key`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `requests_ibfk_2` FOREIGN KEY (`company`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`company`) REFERENCES `companies` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
