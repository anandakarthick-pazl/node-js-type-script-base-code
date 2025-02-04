-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 04, 2025 at 04:06 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tickets`
--

-- --------------------------------------------------------

--
-- Table structure for table `api_logs`
--

CREATE TABLE `api_logs` (
  `id` int(11) NOT NULL COMMENT 'Primary key of the table',
  `userId` int(11) DEFAULT NULL COMMENT 'Foreign key referencing the users table',
  `method` varchar(255) NOT NULL COMMENT 'HTTP method of the API request',
  `url` varchar(255) NOT NULL COMMENT 'URL of the API request',
  `statusCode` int(11) NOT NULL COMMENT 'HTTP status code of the API response',
  `requestBody` text DEFAULT NULL COMMENT 'Request body of the API request',
  `requestHeaders` text DEFAULT NULL COMMENT 'Header of the API request',
  `responseBody` text DEFAULT NULL COMMENT 'Response body of the API response',
  `errorMessage` text DEFAULT NULL COMMENT 'Error message if the API request failed',
  `stackTrace` text DEFAULT NULL COMMENT 'Stack trace if the API request failed',
  `duration` int(11) DEFAULT NULL COMMENT 'Duration of the API request in milliseconds',
  `createdAt` datetime NOT NULL DEFAULT current_timestamp() COMMENT 'Timestamp when the record was created',
  `updatedAt` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Timestamp when the record was last updated'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Table containing logs of API requests and responses';

-- --------------------------------------------------------

--
-- Table structure for table `companies`
--

CREATE TABLE `companies` (
  `id` int(11) NOT NULL COMMENT 'Primary Key',
  `name` varchar(255) NOT NULL COMMENT 'Company name',
  `email` varchar(255) NOT NULL COMMENT 'Company email',
  `phone` varchar(20) DEFAULT NULL COMMENT 'Company phone number',
  `website` varchar(255) DEFAULT NULL COMMENT 'Company website',
  `address` varchar(255) DEFAULT NULL COMMENT 'Company address',
  `city` varchar(100) DEFAULT NULL COMMENT 'City',
  `state` varchar(100) DEFAULT NULL COMMENT 'State',
  `country` varchar(100) DEFAULT NULL COMMENT 'Country',
  `zip` varchar(20) DEFAULT NULL COMMENT 'ZIP code',
  `countryCode` varchar(3) DEFAULT NULL COMMENT 'Country code',
  `logo` varchar(255) DEFAULT NULL COMMENT 'Company logo URL',
  `timezone` varchar(100) DEFAULT NULL COMMENT 'Timezone',
  `date_format` varchar(100) DEFAULT NULL COMMENT 'Date format',
  `time_format` varchar(100) DEFAULT NULL COMMENT 'Time format',
  `latitude` varchar(100) DEFAULT NULL COMMENT 'Latitude',
  `longitude` varchar(100) DEFAULT NULL COMMENT 'Longitude',
  `ticket_count` int(11) DEFAULT NULL COMMENT 'Number of tickets',
  `user_count` int(11) DEFAULT NULL COMMENT 'Number of users',
  `status` enum('active','inactive') NOT NULL DEFAULT 'active' COMMENT 'Company status',
  `valid_from` timestamp NULL DEFAULT NULL COMMENT 'Validity start date',
  `valid_till` timestamp NULL DEFAULT NULL COMMENT 'Validity end date',
  `login` enum('enable','disable') NOT NULL DEFAULT 'enable' COMMENT 'Login status',
  `email_notifications` enum('enable','disable') NOT NULL DEFAULT 'enable' COMMENT 'Email notifications status',
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp() COMMENT 'Creation date',
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'Last update date'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `companies`
--

INSERT INTO `companies` (`id`, `name`, `email`, `phone`, `website`, `address`, `city`, `state`, `country`, `zip`, `countryCode`, `logo`, `timezone`, `date_format`, `time_format`, `latitude`, `longitude`, `ticket_count`, `user_count`, `status`, `valid_from`, `valid_till`, `login`, `email_notifications`, `createdAt`, `updatedAt`) VALUES
(1, 'Pacx work', 'pacx@pazl.info', NULL, NULL, '123 Main St, New York', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, NULL, 'enable', 'enable', '2025-02-03 16:31:34', '2025-02-03 16:48:32'),
(2, 'Tech Corp', 'contact@techcorp.com', NULL, NULL, '123 Main St, New York', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'active', NULL, NULL, 'enable', 'enable', '2025-02-03 16:51:06', '2025-02-03 16:51:06');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `company_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phoneNumber` varchar(10) DEFAULT NULL,
  `role` varchar(50) NOT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `login` enum('enable','disable') NOT NULL DEFAULT 'enable',
  `email_notifications` enum('enable','disable') NOT NULL DEFAULT 'enable',
  `last_login` timestamp NULL DEFAULT NULL,
  `gender` enum('male','female','other') NOT NULL DEFAULT 'male',
  `dob` date DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `state` varchar(100) DEFAULT NULL,
  `country` varchar(100) DEFAULT NULL,
  `zip` varchar(20) DEFAULT NULL,
  `countryCode` varchar(3) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `company_id`, `name`, `email`, `password`, `phoneNumber`, `role`, `status`, `login`, `email_notifications`, `last_login`, `gender`, `dob`, `address`, `city`, `state`, `country`, `zip`, `countryCode`, `image`, `createdAt`, `updatedAt`) VALUES
(1, 1, 'Kathick', 'ananda.s@pazl.info', '$2b$10$S3VzRzWAetvQifzSHrMB3OTrY25Vn2zUnVzyiS6lMiZiSyf4uGFEu', NULL, '', 'active', 'enable', 'enable', NULL, 'male', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-02-03 18:46:55', '2025-02-03 18:46:55'),
(2, 1, 'Kathick', 'anandas.s@pazl.info', '$2b$10$yxRXIDHw2O.wEmjBXu1GJuhSmN9lhUDTxSM9vIdQEKP3vDUeOLgBK', NULL, '', 'active', 'enable', 'enable', NULL, 'male', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '2025-02-03 18:47:52', '2025-02-03 18:47:52');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `api_logs`
--
ALTER TABLE `api_logs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `api_logs_userId_idx` (`userId`),
  ADD KEY `api_logs_statusCode_idx` (`statusCode`),
  ADD KEY `api_logs_createdAt_idx` (`createdAt`);

--
-- Indexes for table `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`,`phone`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phoneNumber` (`phoneNumber`),
  ADD KEY `idx_users_email` (`email`),
  ADD KEY `idx_users_phoneNumber` (`phoneNumber`),
  ADD KEY `idx_users_status` (`status`),
  ADD KEY `idx_users_company_id` (`company_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `api_logs`
--
ALTER TABLE `api_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary key of the table';

--
-- AUTO_INCREMENT for table `companies`
--
ALTER TABLE `companies`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Primary Key', AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `api_logs`
--
ALTER TABLE `api_logs`
  ADD CONSTRAINT `fk_api_logs_users` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`company_id`) REFERENCES `companies` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
