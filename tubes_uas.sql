-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 15, 2021 at 11:58 AM
-- Server version: 10.4.19-MariaDB
-- PHP Version: 7.4.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tubes_uas`
--

-- --------------------------------------------------------

--
-- Table structure for table `carts`
--

CREATE TABLE `carts` (
  `id` int(10) UNSIGNED NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `variance` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subtotal` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(10) UNSIGNED NOT NULL,
  `parent_id` int(10) UNSIGNED DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `image` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `parent_id`, `name`, `slug`, `created_at`, `updated_at`, `image`, `icon`) VALUES
(3, NULL, 'WOMAN', 'woman', '2020-12-04 05:10:52', '2020-12-04 05:10:52', '[{\"download_link\":\"categories\\\\December2020\\\\Y5UxLrhjQ4G3numIgyWS.jpg\",\"original_name\":\"326x400_WOMEN.jpg\"}]', 'mdi-woman'),
(4, NULL, 'MAN', 'man', '2020-12-04 05:11:06', '2020-12-04 05:11:06', '[{\"download_link\":\"categories\\\\December2020\\\\vKvetavu4Nq6HecV7g25.jpg\",\"original_name\":\"326x400_MEN.jpg\"}]', NULL),
(5, NULL, 'KIDS', 'kids', '2020-12-04 05:11:15', '2020-12-04 05:11:15', '[{\"download_link\":\"categories\\\\December2020\\\\d90tu9vUKiG6X1MwX8iZ.jpg\",\"original_name\":\"326x400_KIDS.jpg\"}]', NULL),
(6, NULL, 'Jacket Pria', 'jacket-pria', '2020-12-04 05:47:40', '2020-12-04 05:47:40', '[{\"download_link\":\"categories\\\\December2020\\\\69n8oBG3D4X8FWc51y0m.jpg\",\"original_name\":\"326x400_MEN.jpg\"}]', 'mdi-jacket'),
(7, NULL, 'SPORTS', 'sports', '2020-12-04 05:11:23', '2020-12-04 05:11:23', '[{\"download_link\":\"categories\\\\December2020\\\\7UKcjN5rrZtUmxJlKjVw.jpg\",\"original_name\":\"326x304_SPORTS.jpg\"}]', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `confirm_payments`
--

CREATE TABLE `confirm_payments` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `image` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'menunggu konfirmasi',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `confirm_payments`
--

INSERT INTO `confirm_payments` (`id`, `user_id`, `order_id`, `image`, `status`, `created_at`, `updated_at`) VALUES
(1, 2, 1, 'confirm-payments/June2021/Screenshot 2021-05-03 221014.png', 'menunggu konfirmasi', '2021-06-15 02:14:50', '2021-06-15 02:14:50'),
(2, 2, 2, 'confirm-payments/June2021/Screenshot 2021-05-03 221014.png', 'menunggu konfirmasi', '2021-06-15 02:16:04', '2021-06-15 02:16:04'),
(3, 2, 4, 'confirm-payments/June2021/logo.png', 'menunggu konfirmasi', '2021-06-15 02:29:00', '2021-06-15 02:29:00'),
(4, 2, 5, 'confirm-payments/June2021/logo.png', 'menunggu konfirmasi', '2021-06-15 02:32:27', '2021-06-15 02:32:27');

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `discount` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `coupons`
--

INSERT INTO `coupons` (`id`, `name`, `description`, `discount`, `created_at`, `updated_at`) VALUES
(1, 'opening', 'opening program', 58000, '2020-12-04 05:48:00', '2021-06-15 02:37:50'),
(2, '10ribu', '10 ribupotongan', 10000, '2020-12-04 05:48:00', '2021-06-15 02:19:58');

-- --------------------------------------------------------

--
-- Table structure for table `data_rows`
--

CREATE TABLE `data_rows` (
  `id` int(10) UNSIGNED NOT NULL,
  `data_type_id` int(10) UNSIGNED NOT NULL,
  `field` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT 0,
  `browse` tinyint(1) NOT NULL DEFAULT 1,
  `read` tinyint(1) NOT NULL DEFAULT 1,
  `edit` tinyint(1) NOT NULL DEFAULT 1,
  `add` tinyint(1) NOT NULL DEFAULT 1,
  `delete` tinyint(1) NOT NULL DEFAULT 1,
  `details` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `data_rows`
--

INSERT INTO `data_rows` (`id`, `data_type_id`, `field`, `type`, `display_name`, `required`, `browse`, `read`, `edit`, `add`, `delete`, `details`, `order`) VALUES
(1, 1, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, '{}', 1),
(2, 1, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, '{}', 2),
(3, 1, 'email', 'text', 'Email', 1, 1, 1, 1, 1, 1, '{}', 3),
(4, 1, 'password', 'password', 'Password', 1, 0, 0, 1, 1, 0, '{}', 6),
(5, 1, 'remember_token', 'text', 'Remember Token', 0, 0, 0, 0, 0, 0, '{}', 7),
(6, 1, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 0, 0, 0, '{}', 8),
(7, 1, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 10),
(8, 1, 'avatar', 'image', 'Avatar', 0, 1, 1, 1, 1, 1, '{}', 11),
(9, 1, 'user_belongsto_role_relationship', 'relationship', 'Role', 0, 1, 1, 1, 1, 0, '{\"model\":\"TCG\\\\Voyager\\\\Models\\\\Role\",\"table\":\"roles\",\"type\":\"belongsTo\",\"column\":\"role_id\",\"key\":\"id\",\"label\":\"display_name\",\"pivot_table\":\"roles\",\"pivot\":\"0\",\"taggable\":\"0\"}', 13),
(10, 1, 'user_belongstomany_role_relationship', 'relationship', 'Roles', 0, 1, 1, 1, 1, 0, '{\"model\":\"TCG\\\\Voyager\\\\Models\\\\Role\",\"table\":\"roles\",\"type\":\"belongsToMany\",\"column\":\"id\",\"key\":\"id\",\"label\":\"display_name\",\"pivot_table\":\"user_roles\",\"pivot\":\"1\",\"taggable\":\"0\"}', 14),
(11, 1, 'settings', 'hidden', 'Settings', 0, 0, 0, 0, 0, 0, '{}', 15),
(12, 2, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
(13, 2, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, NULL, 2),
(14, 2, 'created_at', 'timestamp', 'Created At', 0, 0, 0, 0, 0, 0, NULL, 3),
(15, 2, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, NULL, 4),
(16, 3, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, NULL, 1),
(17, 3, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, NULL, 2),
(18, 3, 'created_at', 'timestamp', 'Created At', 0, 0, 0, 0, 0, 0, NULL, 3),
(19, 3, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, NULL, 4),
(20, 3, 'display_name', 'text', 'Display Name', 1, 1, 1, 1, 1, 1, NULL, 5),
(21, 1, 'role_id', 'text', 'Role', 0, 1, 1, 1, 1, 1, '{}', 12),
(22, 4, 'id', 'number', 'ID', 1, 0, 0, 0, 0, 0, '{}', 1),
(23, 4, 'parent_id', 'select_dropdown', 'Parent', 0, 0, 1, 1, 1, 1, '{\"default\":\"\",\"null\":\"\",\"options\":{\"\":\"-- None --\"},\"relationship\":{\"key\":\"id\",\"label\":\"name\"}}', 2),
(25, 4, 'name', 'text', 'Name', 1, 1, 1, 1, 1, 1, '{}', 4),
(26, 4, 'slug', 'text', 'Slug', 1, 1, 1, 1, 1, 1, '{\"slugify\":{\"origin\":\"name\"}}', 5),
(27, 4, 'created_at', 'timestamp', 'Created At', 0, 0, 1, 0, 0, 0, '{}', 8),
(28, 4, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 9),
(56, 4, 'image', 'file', 'Image', 0, 1, 1, 1, 1, 1, '{}', 7),
(57, 4, 'icon', 'text', 'Icon (mdi-icon)', 0, 1, 1, 1, 1, 1, '{}', 6),
(58, 1, 'email_verified_at', 'timestamp', 'Email Verified At', 0, 1, 1, 1, 1, 1, '{}', 9),
(59, 1, 'address', 'text', 'Address', 0, 1, 1, 1, 1, 1, '{}', 4),
(60, 1, 'phoneNumber', 'text', 'PhoneNumber', 0, 1, 1, 1, 1, 1, '{}', 5),
(61, 7, 'id', 'text', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(62, 7, 'name', 'text', 'Name', 0, 1, 1, 1, 1, 1, '{}', 2),
(63, 7, 'description', 'text', 'Description', 0, 1, 1, 1, 1, 1, '{}', 3),
(64, 7, 'discount', 'number', 'Discount', 0, 1, 1, 1, 1, 1, '{}', 4),
(65, 7, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 1, 0, 1, '{}', 5),
(66, 7, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 6),
(67, 8, 'id', 'text', 'Id', 1, 0, 0, 0, 0, 0, '{}', 0),
(68, 8, 'user_id', 'text', 'User Id', 1, 1, 1, 1, 1, 1, '{}', 2),
(69, 8, 'order_id', 'text', 'Order Id', 1, 1, 1, 1, 1, 1, '{}', 3),
(70, 8, 'image', 'file', 'Image', 0, 1, 1, 1, 1, 1, '{}', 4),
(71, 8, 'status', 'select_dropdown', 'Status', 0, 1, 1, 1, 1, 1, '{\"default\":\"menunggu konfrimasi\",\"options\":{\"menunggu konfrimasi\":\"menunggu konfrimasi\",\"diterima\":\"diterima\",\"ditolak\":\"ditolak\"}}', 5),
(72, 8, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 1, 0, 1, '{}', 6),
(73, 8, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 7),
(74, 8, 'confirm_payment_belongsto_user_relationship', 'relationship', 'users', 0, 1, 1, 1, 1, 1, '{\"model\":\"App\\\\User\",\"table\":\"users\",\"type\":\"belongsTo\",\"column\":\"user_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"categories\",\"pivot\":\"0\",\"taggable\":\"0\"}', 8),
(75, 9, 'id', 'text', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(76, 9, 'product_id', 'text', 'Product Id', 0, 1, 1, 1, 1, 1, '{}', 2),
(77, 9, 'user_id', 'text', 'User Id', 0, 1, 1, 1, 1, 1, '{}', 3),
(78, 9, 'quantity', 'number', 'Quantity', 0, 1, 1, 1, 1, 1, '{}', 4),
(79, 9, 'variance', 'text', 'Variance', 0, 1, 1, 1, 1, 1, '{}', 5),
(80, 9, 'subtotal', 'number', 'Subtotal', 0, 1, 1, 1, 1, 1, '{}', 6),
(81, 9, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 1, 0, 1, '{}', 7),
(82, 9, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 8),
(83, 10, 'id', 'text', 'Id', 1, 0, 0, 0, 0, 0, '{}', 0),
(84, 10, 'order_id', 'text', 'Order Id', 0, 1, 1, 1, 1, 1, '{}', 2),
(85, 10, 'product_id', 'text', 'Product Id', 0, 1, 1, 1, 1, 1, '{}', 3),
(87, 10, 'variance', 'text', 'Variance', 0, 1, 1, 1, 1, 1, '{}', 5),
(88, 10, 'subtotal', 'number', 'Subtotal', 0, 1, 1, 1, 1, 1, '{}', 6),
(89, 10, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 1, 0, 1, '{}', 7),
(90, 10, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 8),
(91, 11, 'id', 'text', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(92, 11, 'no_order', 'text', 'No Order', 0, 1, 1, 1, 1, 1, '{}', 2),
(93, 11, 'grandtotal', 'number', 'Grandtotal', 0, 1, 1, 1, 1, 1, '{}', 3),
(94, 11, 'user_id', 'text', 'User Id', 0, 1, 1, 1, 1, 1, '{}', 4),
(95, 11, 'status', 'select_dropdown', 'Status', 0, 1, 1, 1, 1, 1, '{\"default\":\"menunggu pembayaran\",\"options\":{\"menunggu pembayaran\":\"menunggu pembayaran\",\"pesanan diproses\":\"pesanan diproses\",\"pesanan selesai\":\"pesanan selesai\"}}', 5),
(96, 11, 'address', 'text', 'Address', 0, 1, 1, 1, 1, 1, '{}', 6),
(97, 11, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 1, 0, 1, '{}', 7),
(98, 11, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 8),
(99, 12, 'id', 'text', 'Id', 1, 0, 0, 0, 0, 0, '{}', 1),
(100, 12, 'name', 'text', 'Name', 0, 1, 1, 1, 1, 1, '{}', 2),
(101, 12, 'description', 'text_area', 'Description', 0, 1, 1, 1, 1, 1, '{}', 3),
(102, 12, 'image', 'file', 'Image', 0, 1, 1, 1, 1, 1, '{}', 4),
(103, 12, 'category_id', 'radio_btn', 'Category Id', 0, 1, 1, 1, 1, 1, '{}', 5),
(104, 12, 'price', 'number', 'Price', 0, 1, 1, 1, 1, 1, '{}', 6),
(105, 12, 'stock', 'number', 'Stock', 0, 1, 1, 1, 1, 1, '{}', 7),
(106, 12, 'created_at', 'timestamp', 'Created At', 0, 1, 1, 1, 0, 1, '{}', 8),
(107, 12, 'updated_at', 'timestamp', 'Updated At', 0, 0, 0, 0, 0, 0, '{}', 9),
(108, 12, 'product_belongsto_category_relationship', 'relationship', 'categories', 0, 1, 1, 1, 1, 1, '{\"model\":\"App\\\\Category\",\"table\":\"categories\",\"type\":\"belongsTo\",\"column\":\"category_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"carts\",\"pivot\":\"0\",\"taggable\":\"0\"}', 10),
(109, 9, 'cart_belongsto_product_relationship', 'relationship', 'products', 0, 1, 1, 1, 1, 1, '{\"model\":\"App\\\\Product\",\"table\":\"products\",\"type\":\"belongsTo\",\"column\":\"product_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"carts\",\"pivot\":\"0\",\"taggable\":\"0\"}', 9),
(110, 9, 'cart_belongsto_user_relationship', 'relationship', 'users', 0, 1, 1, 1, 1, 1, '{\"model\":\"App\\\\User\",\"table\":\"users\",\"type\":\"belongsTo\",\"column\":\"id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"carts\",\"pivot\":\"0\",\"taggable\":\"0\"}', 10),
(111, 8, 'confirm_payment_belongsto_order_relationship', 'relationship', 'orders', 0, 1, 1, 1, 1, 1, '{\"model\":\"App\\\\Order\",\"table\":\"orders\",\"type\":\"belongsTo\",\"column\":\"order_id\",\"key\":\"id\",\"label\":\"no_order\",\"pivot_table\":\"carts\",\"pivot\":\"0\",\"taggable\":\"0\"}', 9),
(112, 10, 'order_detail_belongsto_product_relationship', 'relationship', 'products', 0, 1, 1, 1, 1, 1, '{\"model\":\"App\\\\Product\",\"table\":\"products\",\"type\":\"belongsTo\",\"column\":\"product_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"carts\",\"pivot\":\"0\",\"taggable\":\"0\"}', 9),
(113, 10, 'order_detail_belongsto_order_relationship', 'relationship', 'orders', 0, 1, 1, 1, 1, 1, '{\"model\":\"App\\\\Order\",\"table\":\"orders\",\"type\":\"belongsTo\",\"column\":\"order_id\",\"key\":\"id\",\"label\":\"no_order\",\"pivot_table\":\"carts\",\"pivot\":\"0\",\"taggable\":\"0\"}', 10),
(114, 11, 'order_belongsto_user_relationship', 'relationship', 'users', 0, 1, 1, 1, 1, 1, '{\"model\":\"App\\\\User\",\"table\":\"users\",\"type\":\"belongsTo\",\"column\":\"user_id\",\"key\":\"id\",\"label\":\"name\",\"pivot_table\":\"carts\",\"pivot\":\"0\",\"taggable\":\"0\"}', 9),
(115, 10, 'quantity', 'number', 'Quantity', 0, 1, 1, 1, 1, 1, '{}', 4);

-- --------------------------------------------------------

--
-- Table structure for table `data_types`
--

CREATE TABLE `data_types` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name_singular` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name_plural` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `model_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `policy_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `controller` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `generate_permissions` tinyint(1) NOT NULL DEFAULT 0,
  `server_side` tinyint(4) NOT NULL DEFAULT 0,
  `details` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `data_types`
--

INSERT INTO `data_types` (`id`, `name`, `slug`, `display_name_singular`, `display_name_plural`, `icon`, `model_name`, `policy_name`, `controller`, `description`, `generate_permissions`, `server_side`, `details`, `created_at`, `updated_at`) VALUES
(1, 'users', 'users', 'User', 'Users', 'voyager-person', 'TCG\\Voyager\\Models\\User', 'TCG\\Voyager\\Policies\\UserPolicy', 'TCG\\Voyager\\Http\\Controllers\\VoyagerUserController', NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"desc\",\"default_search_key\":null,\"scope\":null}', '2020-12-04 05:06:53', '2020-12-04 05:15:05'),
(2, 'menus', 'menus', 'Menu', 'Menus', 'voyager-list', 'TCG\\Voyager\\Models\\Menu', NULL, '', '', 1, 0, NULL, '2020-12-04 05:06:53', '2020-12-04 05:06:53'),
(3, 'roles', 'roles', 'Role', 'Roles', 'voyager-lock', 'TCG\\Voyager\\Models\\Role', NULL, 'TCG\\Voyager\\Http\\Controllers\\VoyagerRoleController', '', 1, 0, NULL, '2020-12-04 05:06:53', '2020-12-04 05:06:53'),
(4, 'categories', 'categories', 'Category', 'Categories', 'voyager-categories', 'App\\Category', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"desc\",\"default_search_key\":null,\"scope\":null}', '2020-12-04 05:06:53', '2020-12-04 10:07:33'),
(7, 'coupons', 'coupons', 'Coupon', 'Coupons', NULL, 'App\\Coupon', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null}', '2020-12-04 05:16:58', '2020-12-04 05:16:58'),
(8, 'confirm_payments', 'confirm-payments', 'Confirm Payment', 'Confirm Payments', NULL, 'App\\ConfirmPayment', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2020-12-04 05:18:20', '2020-12-04 05:35:26'),
(9, 'carts', 'carts', 'Cart', 'Carts', NULL, 'App\\Cart', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2020-12-04 05:25:05', '2020-12-04 05:33:53'),
(10, 'order_details', 'order-details', 'Order Detail', 'Order Details', NULL, 'App\\OrderDetail', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2020-12-04 05:25:14', '2020-12-04 05:35:52'),
(11, 'orders', 'orders', 'Order', 'Orders', NULL, 'App\\Order', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2020-12-04 05:25:21', '2020-12-04 05:36:56'),
(12, 'products', 'products', 'Product', 'Products', NULL, 'App\\Product', NULL, NULL, NULL, 1, 0, '{\"order_column\":null,\"order_display_column\":null,\"order_direction\":\"asc\",\"default_search_key\":null,\"scope\":null}', '2020-12-04 05:25:28', '2021-06-15 01:21:07');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

CREATE TABLE `menus` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`id`, `name`, `created_at`, `updated_at`) VALUES
(1, 'admin', '2020-12-04 05:06:53', '2020-12-04 05:06:53');

-- --------------------------------------------------------

--
-- Table structure for table `menu_items`
--

CREATE TABLE `menu_items` (
  `id` int(10) UNSIGNED NOT NULL,
  `menu_id` int(10) UNSIGNED DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `target` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '_self',
  `icon_class` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `color` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `order` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `route` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `parameters` text COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menu_items`
--

INSERT INTO `menu_items` (`id`, `menu_id`, `title`, `url`, `target`, `icon_class`, `color`, `parent_id`, `order`, `created_at`, `updated_at`, `route`, `parameters`) VALUES
(1, 1, 'Dashboard', '', '_self', 'voyager-boat', NULL, NULL, 1, '2020-12-04 05:06:53', '2020-12-04 05:06:53', 'voyager.dashboard', NULL),
(2, 1, 'Media', '', '_self', 'voyager-images', NULL, NULL, 3, '2020-12-04 05:06:53', '2020-12-04 05:33:01', 'voyager.media.index', NULL),
(3, 1, 'Users', '', '_self', 'voyager-person', NULL, NULL, 2, '2020-12-04 05:06:53', '2020-12-04 05:33:01', 'voyager.users.index', NULL),
(4, 1, 'Roles', '', '_self', 'voyager-lock', NULL, NULL, 11, '2020-12-04 05:06:53', '2020-12-04 05:33:02', 'voyager.roles.index', NULL),
(5, 1, 'Tools', '', '_self', 'voyager-tools', NULL, NULL, 12, '2020-12-04 05:06:53', '2020-12-04 05:32:42', NULL, NULL),
(6, 1, 'Menu Builder', '', '_self', 'voyager-list', NULL, 5, 1, '2020-12-04 05:06:53', '2020-12-04 05:32:12', 'voyager.menus.index', NULL),
(7, 1, 'Database', '', '_self', 'voyager-data', NULL, 5, 2, '2020-12-04 05:06:53', '2020-12-04 05:32:13', 'voyager.database.index', NULL),
(8, 1, 'Compass', '', '_self', 'voyager-compass', NULL, 5, 3, '2020-12-04 05:06:53', '2020-12-04 05:32:13', 'voyager.compass.index', NULL),
(9, 1, 'BREAD', '', '_self', 'voyager-bread', NULL, 5, 4, '2020-12-04 05:06:53', '2020-12-04 05:32:13', 'voyager.bread.index', NULL),
(10, 1, 'Settings', '', '_self', 'voyager-settings', NULL, NULL, 13, '2020-12-04 05:06:53', '2020-12-04 05:32:42', 'voyager.settings.index', NULL),
(11, 1, 'Categories', '', '_self', 'voyager-categories', NULL, NULL, 4, '2020-12-04 05:06:53', '2020-12-04 05:33:01', 'voyager.categories.index', NULL),
(14, 1, 'Hooks', '', '_self', 'voyager-hook', NULL, 5, 5, '2020-12-04 05:06:54', '2020-12-04 05:32:13', 'voyager.hooks', NULL),
(15, 1, 'Coupons', '', '_self', NULL, NULL, NULL, 5, '2020-12-04 05:16:58', '2020-12-04 05:33:01', 'voyager.coupons.index', NULL),
(16, 1, 'Confirm Payments', '', '_self', NULL, NULL, NULL, 6, '2020-12-04 05:18:20', '2020-12-04 05:33:01', 'voyager.confirm-payments.index', NULL),
(17, 1, 'Carts', '', '_self', NULL, NULL, NULL, 7, '2020-12-04 05:25:05', '2020-12-04 05:33:01', 'voyager.carts.index', NULL),
(18, 1, 'Order Details', '', '_self', NULL, NULL, NULL, 8, '2020-12-04 05:25:14', '2020-12-04 05:33:02', 'voyager.order-details.index', NULL),
(19, 1, 'Orders', '', '_self', NULL, NULL, NULL, 9, '2020-12-04 05:25:21', '2020-12-04 05:33:02', 'voyager.orders.index', NULL),
(20, 1, 'Products', '', '_self', NULL, NULL, NULL, 10, '2020-12-04 05:25:28', '2020-12-04 05:33:02', 'voyager.products.index', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2014_10_12_000000_create_users_table', 1),
(2, '2014_10_12_100000_create_password_resets_table', 1),
(3, '2016_01_01_000000_add_voyager_user_fields', 1),
(4, '2016_01_01_000000_create_data_types_table', 1),
(5, '2016_01_01_000000_create_pages_table', 1),
(6, '2016_01_01_000000_create_posts_table', 1),
(7, '2016_02_15_204651_create_categories_table', 1),
(8, '2016_05_19_173453_create_menu_table', 1),
(9, '2016_06_01_000001_create_oauth_auth_codes_table', 1),
(10, '2016_06_01_000002_create_oauth_access_tokens_table', 1),
(11, '2016_06_01_000003_create_oauth_refresh_tokens_table', 1),
(12, '2016_06_01_000004_create_oauth_clients_table', 1),
(13, '2016_06_01_000005_create_oauth_personal_access_clients_table', 1),
(14, '2016_10_21_190000_create_roles_table', 1),
(15, '2016_10_21_190000_create_settings_table', 1),
(16, '2016_11_30_135954_create_permission_table', 1),
(17, '2016_11_30_141208_create_permission_role_table', 1),
(18, '2016_12_26_201236_data_types__add__server_side', 1),
(19, '2017_01_13_000000_add_route_to_menu_items_table', 1),
(20, '2017_01_14_005015_create_translations_table', 1),
(21, '2017_01_15_000000_make_table_name_nullable_in_permissions_table', 1),
(22, '2017_03_06_000000_add_controller_to_data_types_table', 1),
(23, '2017_04_11_000000_alter_post_nullable_fields_table', 1),
(24, '2017_04_21_000000_add_order_to_data_rows_table', 1),
(25, '2017_07_05_210000_add_policyname_to_data_types_table', 1),
(26, '2017_08_05_000000_add_group_to_settings_table', 1),
(27, '2017_11_26_013050_add_user_role_relationship', 1),
(28, '2017_11_26_015000_create_user_roles_table', 1),
(29, '2018_03_11_000000_add_user_settings', 1),
(30, '2018_03_14_000000_add_details_to_data_types_table', 1),
(31, '2018_03_16_000000_make_settings_value_nullable', 1),
(32, '2019_08_19_000000_create_failed_jobs_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `oauth_access_tokens`
--

CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_access_tokens`
--

INSERT INTO `oauth_access_tokens` (`id`, `user_id`, `client_id`, `name`, `scopes`, `revoked`, `created_at`, `updated_at`, `expires_at`) VALUES
('140f4e8ee061103ac39f2fca468f7d0ca16aa3886caefacdb1134b8fcffb6699c678f3034f656a5d', 2, 1, 'Authentication Token', '[]', 0, '2021-06-15 01:55:56', '2021-06-15 01:55:56', '2022-06-15 08:55:56'),
('1f1c465017bd905432aca4026a55db7c461f4784aa4380ecd55ecad26081b97bfef7a71c10bfb533', 2, 1, 'Authentication Token', '[]', 0, '2021-06-15 02:21:02', '2021-06-15 02:21:02', '2022-06-15 09:21:02'),
('570e9ae3a3dbe1d78fa027ef7a68fc3c9d03569f8077781b791a268735bb86df8db9f44284c1597f', 2, 1, 'Authentication Token', '[]', 0, '2021-06-15 02:30:54', '2021-06-15 02:30:54', '2022-06-15 09:30:54'),
('65feca3248a2c16294997c0c21ec43f5d1f49c8d0e62659ca3be5c18b49c550a6c802dbb7dec1e1d', 2, 1, 'Authentication Token', '[]', 0, '2020-12-05 11:01:32', '2020-12-05 11:01:32', '2021-12-05 18:01:32'),
('ae54ebdc5d89f066dfc6be959dcaef5eecafd9830864d317d7345405a7777bbcf4e726085605b9cc', 2, 1, 'Authentication Token', '[]', 0, '2021-06-15 01:56:28', '2021-06-15 01:56:28', '2022-06-15 08:56:28'),
('c8c7101b94d1f95775728df23f09aaa46711d4142bbe64a5ad27e8761dc0404aebe37aaaf0cfc692', 2, 1, 'Authentication Token', '[]', 1, '2020-12-04 05:55:33', '2020-12-04 05:55:33', '2021-12-04 12:55:33'),
('f1f53fa8c555fc6e0792a4902e7b7ff47152a6a7cd57efc537e61c8b5fdec09dd48a629cc74337d0', 2, 1, 'Authentication Token', '[]', 0, '2020-12-04 05:57:53', '2020-12-04 05:57:53', '2021-12-04 12:57:53'),
('f4b1943aa71f780f3f4b688b5ff82655339f9ff3f0c3abec4f6936d7a7290a77d741f3914d79b27c', 2, 1, 'Authentication Token', '[]', 0, '2021-06-15 02:27:40', '2021-06-15 02:27:40', '2022-06-15 09:27:40');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_auth_codes`
--

CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `oauth_clients`
--

CREATE TABLE `oauth_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `provider` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_clients`
--

INSERT INTO `oauth_clients` (`id`, `user_id`, `name`, `secret`, `provider`, `redirect`, `personal_access_client`, `password_client`, `revoked`, `created_at`, `updated_at`) VALUES
(1, NULL, 'BRAND_NAME Personal Access Client', 'rFlPMQ4RYnlv3Hkih1r86tTWM7QsW2CameQfGqcI', NULL, 'http://localhost', 1, 0, 0, '2020-12-04 05:55:27', '2020-12-04 05:55:27'),
(2, NULL, 'BRAND_NAME Password Grant Client', 'dOwl4nbk8LJ6qTtbgMasjXZJZ7GhdCAveHovyWMn', 'users', 'http://localhost', 0, 1, 0, '2020-12-04 05:55:27', '2020-12-04 05:55:27');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_personal_access_clients`
--

CREATE TABLE `oauth_personal_access_clients` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `client_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `oauth_personal_access_clients`
--

INSERT INTO `oauth_personal_access_clients` (`id`, `client_id`, `created_at`, `updated_at`) VALUES
(1, 1, '2020-12-04 05:55:27', '2020-12-04 05:55:27');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_refresh_tokens`
--

CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(10) UNSIGNED NOT NULL,
  `no_order` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `grandtotal` double DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `status` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'menunggu pembayaran',
  `address` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `no_order`, `grandtotal`, `user_id`, `status`, `address`, `created_at`, `updated_at`) VALUES
(1, '2021-06-15 09:12:414912', 359000, 2, 'pesanan selesai', 'User - 08982866621<br>Jl. Mawar no 8 , Jakarta Barat, DKI Jakarta 14045', '2021-06-15 02:12:00', '2021-06-15 02:15:20'),
(2, '2021-06-15 09:15:533829', 168000, 2, 'pesanan diproses', 'User - 08982866621<br>Jl. Mawar no 8 , Jakarta Barat, DKI Jakarta 14045', '2021-06-15 02:15:00', '2021-06-15 02:16:23'),
(3, '2021-06-15 09:20:182919', 169000, 2, 'pesanan diproses', 'User - 08982866621<br>Jl. Mawar no 8 , Jakarta Barat, DKI Jakarta 14045', '2021-06-15 02:20:00', '2021-06-15 02:38:26'),
(4, '2021-06-15 09:28:387445', 150000, 2, 'menunggu pembayaran', 'User - 08982866621<br>Jl. Mawar no 8 , Jakarta Barat, DKI Jakarta 14045', '2021-06-15 02:28:38', '2021-06-15 02:28:38'),
(5, '2021-06-15 09:31:465537', 91000, 2, 'menunggu pembayaran', 'User - 08982866621<br>Jl. Mawar no 8 , Jakarta Barat, DKI Jakarta 14045', '2021-06-15 02:31:46', '2021-06-15 02:31:46');

-- --------------------------------------------------------

--
-- Table structure for table `order_details`
--

CREATE TABLE `order_details` (
  `id` int(10) UNSIGNED NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `variance` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subtotal` double DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `order_details`
--

INSERT INTO `order_details` (`id`, `order_id`, `product_id`, `quantity`, `variance`, `subtotal`, `created_at`, `updated_at`) VALUES
(1, 1, 14, 1, 'XL', 359000, '2021-06-15 02:12:41', NULL),
(2, 2, 12, 2, 'S', 178000, '2021-06-15 02:15:53', NULL),
(3, 3, 11, 1, 'M', 89000, '2021-06-15 02:20:18', NULL),
(4, 3, 13, 1, 'M', 90000, '2021-06-15 02:20:18', NULL),
(5, 4, 10, 1, 'M', 159000, '2021-06-15 02:28:38', NULL),
(6, 4, 12, 1, 'S', 89000, '2021-06-15 02:28:38', NULL),
(7, 5, 16, 1, 'S', 189000, '2021-06-15 02:31:46', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `permissions`
--

CREATE TABLE `permissions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `table_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permissions`
--

INSERT INTO `permissions` (`id`, `key`, `table_name`, `created_at`, `updated_at`) VALUES
(1, 'browse_admin', NULL, '2020-12-04 05:06:53', '2020-12-04 05:06:53'),
(2, 'browse_bread', NULL, '2020-12-04 05:06:53', '2020-12-04 05:06:53'),
(3, 'browse_database', NULL, '2020-12-04 05:06:53', '2020-12-04 05:06:53'),
(4, 'browse_media', NULL, '2020-12-04 05:06:53', '2020-12-04 05:06:53'),
(5, 'browse_compass', NULL, '2020-12-04 05:06:53', '2020-12-04 05:06:53'),
(6, 'browse_menus', 'menus', '2020-12-04 05:06:53', '2020-12-04 05:06:53'),
(7, 'read_menus', 'menus', '2020-12-04 05:06:53', '2020-12-04 05:06:53'),
(8, 'edit_menus', 'menus', '2020-12-04 05:06:53', '2020-12-04 05:06:53'),
(9, 'add_menus', 'menus', '2020-12-04 05:06:53', '2020-12-04 05:06:53'),
(10, 'delete_menus', 'menus', '2020-12-04 05:06:53', '2020-12-04 05:06:53'),
(11, 'browse_roles', 'roles', '2020-12-04 05:06:53', '2020-12-04 05:06:53'),
(12, 'read_roles', 'roles', '2020-12-04 05:06:53', '2020-12-04 05:06:53'),
(13, 'edit_roles', 'roles', '2020-12-04 05:06:53', '2020-12-04 05:06:53'),
(14, 'add_roles', 'roles', '2020-12-04 05:06:53', '2020-12-04 05:06:53'),
(15, 'delete_roles', 'roles', '2020-12-04 05:06:53', '2020-12-04 05:06:53'),
(16, 'browse_users', 'users', '2020-12-04 05:06:53', '2020-12-04 05:06:53'),
(17, 'read_users', 'users', '2020-12-04 05:06:53', '2020-12-04 05:06:53'),
(18, 'edit_users', 'users', '2020-12-04 05:06:53', '2020-12-04 05:06:53'),
(19, 'add_users', 'users', '2020-12-04 05:06:53', '2020-12-04 05:06:53'),
(20, 'delete_users', 'users', '2020-12-04 05:06:53', '2020-12-04 05:06:53'),
(21, 'browse_settings', 'settings', '2020-12-04 05:06:53', '2020-12-04 05:06:53'),
(22, 'read_settings', 'settings', '2020-12-04 05:06:53', '2020-12-04 05:06:53'),
(23, 'edit_settings', 'settings', '2020-12-04 05:06:53', '2020-12-04 05:06:53'),
(24, 'add_settings', 'settings', '2020-12-04 05:06:53', '2020-12-04 05:06:53'),
(25, 'delete_settings', 'settings', '2020-12-04 05:06:53', '2020-12-04 05:06:53'),
(26, 'browse_categories', 'categories', '2020-12-04 05:06:53', '2020-12-04 05:06:53'),
(27, 'read_categories', 'categories', '2020-12-04 05:06:53', '2020-12-04 05:06:53'),
(28, 'edit_categories', 'categories', '2020-12-04 05:06:53', '2020-12-04 05:06:53'),
(29, 'add_categories', 'categories', '2020-12-04 05:06:53', '2020-12-04 05:06:53'),
(30, 'delete_categories', 'categories', '2020-12-04 05:06:53', '2020-12-04 05:06:53'),
(41, 'browse_hooks', NULL, '2020-12-04 05:06:54', '2020-12-04 05:06:54'),
(42, 'browse_coupons', 'coupons', '2020-12-04 05:16:58', '2020-12-04 05:16:58'),
(43, 'read_coupons', 'coupons', '2020-12-04 05:16:58', '2020-12-04 05:16:58'),
(44, 'edit_coupons', 'coupons', '2020-12-04 05:16:58', '2020-12-04 05:16:58'),
(45, 'add_coupons', 'coupons', '2020-12-04 05:16:58', '2020-12-04 05:16:58'),
(46, 'delete_coupons', 'coupons', '2020-12-04 05:16:58', '2020-12-04 05:16:58'),
(47, 'browse_confirm_payments', 'confirm_payments', '2020-12-04 05:18:20', '2020-12-04 05:18:20'),
(48, 'read_confirm_payments', 'confirm_payments', '2020-12-04 05:18:20', '2020-12-04 05:18:20'),
(49, 'edit_confirm_payments', 'confirm_payments', '2020-12-04 05:18:20', '2020-12-04 05:18:20'),
(50, 'add_confirm_payments', 'confirm_payments', '2020-12-04 05:18:20', '2020-12-04 05:18:20'),
(51, 'delete_confirm_payments', 'confirm_payments', '2020-12-04 05:18:20', '2020-12-04 05:18:20'),
(52, 'browse_carts', 'carts', '2020-12-04 05:25:05', '2020-12-04 05:25:05'),
(53, 'read_carts', 'carts', '2020-12-04 05:25:05', '2020-12-04 05:25:05'),
(54, 'edit_carts', 'carts', '2020-12-04 05:25:05', '2020-12-04 05:25:05'),
(55, 'add_carts', 'carts', '2020-12-04 05:25:05', '2020-12-04 05:25:05'),
(56, 'delete_carts', 'carts', '2020-12-04 05:25:05', '2020-12-04 05:25:05'),
(57, 'browse_order_details', 'order_details', '2020-12-04 05:25:14', '2020-12-04 05:25:14'),
(58, 'read_order_details', 'order_details', '2020-12-04 05:25:14', '2020-12-04 05:25:14'),
(59, 'edit_order_details', 'order_details', '2020-12-04 05:25:14', '2020-12-04 05:25:14'),
(60, 'add_order_details', 'order_details', '2020-12-04 05:25:14', '2020-12-04 05:25:14'),
(61, 'delete_order_details', 'order_details', '2020-12-04 05:25:14', '2020-12-04 05:25:14'),
(62, 'browse_orders', 'orders', '2020-12-04 05:25:21', '2020-12-04 05:25:21'),
(63, 'read_orders', 'orders', '2020-12-04 05:25:21', '2020-12-04 05:25:21'),
(64, 'edit_orders', 'orders', '2020-12-04 05:25:21', '2020-12-04 05:25:21'),
(65, 'add_orders', 'orders', '2020-12-04 05:25:21', '2020-12-04 05:25:21'),
(66, 'delete_orders', 'orders', '2020-12-04 05:25:21', '2020-12-04 05:25:21'),
(67, 'browse_products', 'products', '2020-12-04 05:25:28', '2020-12-04 05:25:28'),
(68, 'read_products', 'products', '2020-12-04 05:25:28', '2020-12-04 05:25:28'),
(69, 'edit_products', 'products', '2020-12-04 05:25:28', '2020-12-04 05:25:28'),
(70, 'add_products', 'products', '2020-12-04 05:25:28', '2020-12-04 05:25:28'),
(71, 'delete_products', 'products', '2020-12-04 05:25:28', '2020-12-04 05:25:28');

-- --------------------------------------------------------

--
-- Table structure for table `permission_role`
--

CREATE TABLE `permission_role` (
  `permission_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `permission_role`
--

INSERT INTO `permission_role` (`permission_id`, `role_id`) VALUES
(1, 1),
(2, 1),
(3, 1),
(4, 1),
(5, 1),
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(15, 1),
(16, 1),
(17, 1),
(18, 1),
(19, 1),
(20, 1),
(21, 1),
(22, 1),
(23, 1),
(24, 1),
(25, 1),
(26, 1),
(27, 1),
(28, 1),
(29, 1),
(30, 1),
(41, 1),
(42, 1),
(43, 1),
(44, 1),
(45, 1),
(46, 1),
(47, 1),
(48, 1),
(49, 1),
(50, 1),
(51, 1),
(52, 1),
(53, 1),
(54, 1),
(55, 1),
(56, 1),
(57, 1),
(58, 1),
(59, 1),
(60, 1),
(61, 1),
(62, 1),
(63, 1),
(64, 1),
(65, 1),
(66, 1),
(67, 1),
(68, 1),
(69, 1),
(70, 1),
(71, 1);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `price` double DEFAULT NULL,
  `stock` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `image`, `category_id`, `price`, `stock`, `created_at`, `updated_at`) VALUES
(4, 'With Rouge Short Sleeve Tee', 'Berat : 300 gr, Design By LIPHOP', '[{\"download_link\":\"products\\\\June2021\\\\S1zGz7MeZiIKuxANIIGw.jpg\",\"original_name\":\"LH 210603_037.jpg\"}]', 3, 79000, 12, '2021-06-15 01:18:00', '2021-06-15 01:21:20'),
(6, 'Jordan Jumpman Air Hoodie ', 'Berat : 500 gr\r\n(CK6679-010)\r\nsource : https://www.thefepi.com/product/detail/104252/jordan-jumpman-air-hoodie-ck6679-010-#;', '[{\"download_link\":\"products\\\\June2021\\\\WsxFBE4Ap0W6Ezjce6FG.jpg\",\"original_name\":\"img406506_big.jpg\"}]', 7, 380000, 5, '2021-06-15 01:22:38', '2021-06-15 01:22:38'),
(7, 'Vintage Label Swearshirt ', 'Berat : 400 gr\r\n\r\nsweatshirt dengan model basik oversize fit\r\n\r\ndetail graphic yang berkesan vintage di bagian punggung sebagai poin\r\n\r\nterbuat dari bahan katun yang nyaman saat dipakai', '[{\"download_link\":\"products\\\\June2021\\\\vScmF4GmxoNGREwHbZPw.jpg\",\"original_name\":\"1.jpg\"}]', 6, 190000, 19, '2021-06-15 01:23:20', '2021-06-15 01:23:20'),
(8, 'Every Rouge Short Sleeve Tee', 'Berat : 300 gr', '[{\"download_link\":\"products\\\\June2021\\\\tHrIjE3LuXQXDcup7QYg.jpg\",\"original_name\":\"LH 210611_001.jpg\"}]', 3, 69000, 33, '2021-06-15 01:24:04', '2021-06-15 01:24:04'),
(9, 'Daily cotton long dress', 'Berat : 600 gr\r\nby secret label', '[{\"download_link\":\"products\\\\June2021\\\\Nks3eVHFMyX5Kchq6U1w.jpg\",\"original_name\":\"SL191222_1061 (1).jpg\"}]', 3, 209000, 21, '2021-06-15 01:24:48', '2021-06-15 01:24:48'),
(10, 'Chucky Double Check Shirt', 'Berat : 300 gr', '[{\"download_link\":\"products\\\\June2021\\\\caHmdyJBHyAxDlcjSjdJ.jpg\",\"original_name\":\"JO210302_028.jpg\"}]', 3, 159000, 15, '2021-06-15 01:25:24', '2021-06-15 01:25:24'),
(11, 'DISNEY Mickey Mouse Ball Cap New York Yankees', 'Berat : 300 gr\r\nhttps://www.thefepi.com/product/detail/102797/#;', '[{\"download_link\":\"products\\\\June2021\\\\ZhQZ7YGs2GLPT3GiXxf5.PNG\",\"original_name\":\"a.PNG\"}]', 5, 89000, 5, '2021-06-15 01:26:27', '2021-06-15 01:26:27'),
(12, 'jellymallow. Cactus Dress_Kids', 'Berat : 300 gr\r\n\r\nFABRIC', '[{\"download_link\":\"products\\\\June2021\\\\exwQUaFPI8038B8Las2m.PNG\",\"original_name\":\"2.PNG\"}]', 5, 89000, 8, '2021-06-15 01:27:05', '2021-06-15 01:27:05'),
(13, 'Ambler Two Head Bear Overfit T-shirt Black', '(AS722_BLACK)\r\nBerat : 300 gr\r\n\r\nkaos dengan detail karakter teddy bear di bagian dada\r\n\r\ndesain kaos basik lengan pendek yang terbuat dari bahan yang nyaman dipakai\r\n\r\ncocok untuk dipakai sehari-hari dan dipadukan dengan jeans', '[{\"download_link\":\"products\\\\June2021\\\\xWvnjJrBDxjk1zXO3SLp.jpg\",\"original_name\":\"AR 200528_014.jpg\"}]', 4, 90000, 9, '2021-06-15 01:28:05', '2021-06-15 01:28:05'),
(14, 'Jordan 23 Engineered Hoodie', '(CV2768-875)\r\nBerat : 500 gr\r\nFABRIC', '[{\"download_link\":\"products\\\\June2021\\\\rXk3bp3645yxWfhismJF.jpg\",\"original_name\":\"JRD_014.jpg\"}]', 6, 359000, 9, '2021-06-15 01:29:06', '2021-06-15 01:29:06'),
(15, 'BIG SWOOSH Sweatshirt', '(AR3088)\r\nBerat : 400 gr\r\n\r\nFABRIC\r\n- cotton 82 , polyester 18', '[{\"download_link\":\"products\\\\June2021\\\\gQrKTrvyZ9X0yBMOwdGJ.jpg\",\"original_name\":\"NK191212_109.jpg\"}]', 7, 109990, 19, '2021-06-15 01:29:56', '2021-06-15 01:29:56'),
(16, 'Mega Logo Back Overfit Hoodie NY', '(31HD02111-50K)\r\nBerat : 500 gr\r\n\r\natasan hoodie dengan model basik overfit lengan panjang\r\n\r\nterdapat detail bordir logo team di bagian dada dan logo big team besar di punggung\r\n\r\nterbuat dari bahan katun yang nyaman saat dipakai', '[{\"download_link\":\"products\\\\June2021\\\\hooI9jAhLE4MlLfVmSig.jpg\",\"original_name\":\"MLB210223_225.jpg\"}]', 5, 189000, 12, '2021-06-15 01:30:39', '2021-06-15 01:30:39'),
(17, 'Produk Baru', 'Deskripsi produk baru', '[{\"download_link\":\"products\\\\June2021\\\\IIsNq21C1gXmRABd1g3I.png\",\"original_name\":\"logo.png\"}]', 3, 45000, 45, '2021-06-15 02:38:56', '2021-06-15 02:38:56');

-- --------------------------------------------------------

--
-- Table structure for table `roles`
--

CREATE TABLE `roles` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `roles`
--

INSERT INTO `roles` (`id`, `name`, `display_name`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'Administrator', '2020-12-04 05:06:53', '2020-12-04 05:06:53'),
(2, 'user', 'Normal User', '2020-12-04 05:06:53', '2020-12-04 05:06:53');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `display_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `details` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `order` int(11) NOT NULL DEFAULT 1,
  `group` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `key`, `display_name`, `value`, `details`, `type`, `order`, `group`) VALUES
(1, 'site.title', 'Site Title', 'Site Title', '', 'text', 1, 'Site'),
(2, 'site.description', 'Site Description', 'Site Description', '', 'text', 2, 'Site'),
(3, 'site.logo', 'Site Logo', '', '', 'image', 3, 'Site'),
(4, 'site.google_analytics_tracking_id', 'Google Analytics Tracking ID', '', '', 'text', 4, 'Site'),
(5, 'admin.bg_image', 'Admin Background Image', '', '', 'image', 5, 'Admin'),
(6, 'admin.title', 'Admin Title', 'Voyager', '', 'text', 1, 'Admin'),
(7, 'admin.description', 'Admin Description', 'Welcome to Voyager. The Missing Admin for Laravel', '', 'text', 2, 'Admin'),
(8, 'admin.loader', 'Admin Loader', '', '', 'image', 3, 'Admin'),
(9, 'admin.icon_image', 'Admin Icon Image', '', '', 'image', 4, 'Admin'),
(10, 'admin.google_analytics_client_id', 'Google Analytics Client ID (used for admin dashboard)', '', '', 'text', 1, 'Admin');

-- --------------------------------------------------------

--
-- Table structure for table `translations`
--

CREATE TABLE `translations` (
  `id` int(10) UNSIGNED NOT NULL,
  `table_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `column_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `foreign_key` int(10) UNSIGNED NOT NULL,
  `locale` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `translations`
--

INSERT INTO `translations` (`id`, `table_name`, `column_name`, `foreign_key`, `locale`, `value`, `created_at`, `updated_at`) VALUES
(1, 'data_types', 'display_name_singular', 5, 'pt', 'Post', '2020-12-04 05:06:54', '2020-12-04 05:06:54'),
(2, 'data_types', 'display_name_singular', 6, 'pt', 'Página', '2020-12-04 05:06:54', '2020-12-04 05:06:54'),
(3, 'data_types', 'display_name_singular', 1, 'pt', 'Utilizador', '2020-12-04 05:06:54', '2020-12-04 05:06:54'),
(4, 'data_types', 'display_name_singular', 4, 'pt', 'Categoria', '2020-12-04 05:06:54', '2020-12-04 05:06:54'),
(5, 'data_types', 'display_name_singular', 2, 'pt', 'Menu', '2020-12-04 05:06:54', '2020-12-04 05:06:54'),
(6, 'data_types', 'display_name_singular', 3, 'pt', 'Função', '2020-12-04 05:06:54', '2020-12-04 05:06:54'),
(7, 'data_types', 'display_name_plural', 5, 'pt', 'Posts', '2020-12-04 05:06:54', '2020-12-04 05:06:54'),
(8, 'data_types', 'display_name_plural', 6, 'pt', 'Páginas', '2020-12-04 05:06:54', '2020-12-04 05:06:54'),
(9, 'data_types', 'display_name_plural', 1, 'pt', 'Utilizadores', '2020-12-04 05:06:54', '2020-12-04 05:06:54'),
(10, 'data_types', 'display_name_plural', 4, 'pt', 'Categorias', '2020-12-04 05:06:54', '2020-12-04 05:06:54'),
(11, 'data_types', 'display_name_plural', 2, 'pt', 'Menus', '2020-12-04 05:06:54', '2020-12-04 05:06:54'),
(12, 'data_types', 'display_name_plural', 3, 'pt', 'Funções', '2020-12-04 05:06:54', '2020-12-04 05:06:54'),
(13, 'categories', 'slug', 1, 'pt', 'categoria-1', '2020-12-04 05:06:54', '2020-12-04 05:06:54'),
(14, 'categories', 'name', 1, 'pt', 'Categoria 1', '2020-12-04 05:06:54', '2020-12-04 05:06:54'),
(15, 'categories', 'slug', 2, 'pt', 'categoria-2', '2020-12-04 05:06:54', '2020-12-04 05:06:54'),
(16, 'categories', 'name', 2, 'pt', 'Categoria 2', '2020-12-04 05:06:54', '2020-12-04 05:06:54'),
(17, 'pages', 'title', 1, 'pt', 'Olá Mundo', '2020-12-04 05:06:54', '2020-12-04 05:06:54'),
(18, 'pages', 'slug', 1, 'pt', 'ola-mundo', '2020-12-04 05:06:54', '2020-12-04 05:06:54'),
(19, 'pages', 'body', 1, 'pt', '<p>Olá Mundo. Scallywag grog swab Cat o\'nine tails scuttle rigging hardtack cable nipper Yellow Jack. Handsomely spirits knave lad killick landlubber or just lubber deadlights chantey pinnace crack Jennys tea cup. Provost long clothes black spot Yellow Jack bilged on her anchor league lateen sail case shot lee tackle.</p>\r\n<p>Ballast spirits fluke topmast me quarterdeck schooner landlubber or just lubber gabion belaying pin. Pinnace stern galleon starboard warp carouser to go on account dance the hempen jig jolly boat measured fer yer chains. Man-of-war fire in the hole nipperkin handsomely doubloon barkadeer Brethren of the Coast gibbet driver squiffy.</p>', '2020-12-04 05:06:54', '2020-12-04 05:06:54'),
(20, 'menu_items', 'title', 1, 'pt', 'Painel de Controle', '2020-12-04 05:06:54', '2020-12-04 05:06:54'),
(21, 'menu_items', 'title', 2, 'pt', 'Media', '2020-12-04 05:06:54', '2020-12-04 05:06:54'),
(22, 'menu_items', 'title', 12, 'pt', 'Publicações', '2020-12-04 05:06:54', '2020-12-04 05:06:54'),
(23, 'menu_items', 'title', 3, 'pt', 'Utilizadores', '2020-12-04 05:06:54', '2020-12-04 05:06:54'),
(24, 'menu_items', 'title', 11, 'pt', 'Categorias', '2020-12-04 05:06:54', '2020-12-04 05:06:54'),
(25, 'menu_items', 'title', 13, 'pt', 'Páginas', '2020-12-04 05:06:54', '2020-12-04 05:06:54'),
(26, 'menu_items', 'title', 4, 'pt', 'Funções', '2020-12-04 05:06:54', '2020-12-04 05:06:54'),
(27, 'menu_items', 'title', 5, 'pt', 'Ferramentas', '2020-12-04 05:06:54', '2020-12-04 05:06:54'),
(28, 'menu_items', 'title', 6, 'pt', 'Menus', '2020-12-04 05:06:54', '2020-12-04 05:06:54'),
(29, 'menu_items', 'title', 7, 'pt', 'Base de dados', '2020-12-04 05:06:54', '2020-12-04 05:06:54'),
(30, 'menu_items', 'title', 10, 'pt', 'Configurações', '2020-12-04 05:06:54', '2020-12-04 05:06:54');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'users/default.png',
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `settings` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `phoneNumber` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `role_id`, `name`, `email`, `avatar`, `email_verified_at`, `password`, `remember_token`, `settings`, `created_at`, `updated_at`, `address`, `phoneNumber`) VALUES
(1, 1, 'Admin', 'admin@admin.com', 'users/default.png', NULL, '$2y$10$CW3gJ/t7khehqoyVcKakT.dv48sZyFA.z2vJyEf.Ni807DT0kWd.G', 'Ft8eUMcxqDeqNAi1Gn38MyexTK1U7gK28FPZ4TE4juGZmYDWyStXfgqW8xzS', NULL, '2020-12-04 05:06:54', '2020-12-04 05:06:54', NULL, NULL),
(2, 2, 'User', 'user@user.com', 'users/default.png', '2020-12-04 05:54:55', '$2y$10$Yd6GaMtg2Pq1HE1XM1ngTemTPJdmHpCHdOpEOF38hBp4VN9KJzraq', NULL, NULL, '2020-12-04 05:52:14', '2021-06-15 02:12:26', 'Jl. Mawar no 8 , Jakarta Barat, DKI Jakarta 14045', '08982866621'),
(4, 2, 'User', 'user@gail.com', 'users/default.png', '2021-06-15 01:54:57', '$2y$10$h9PG6k7Xvo2HNxG8fNekceGUovFxJ70fiTj17r4ieZyUpi17QOxuu', NULL, NULL, '2021-06-15 01:54:36', '2021-06-15 01:54:57', NULL, '08982866621');

-- --------------------------------------------------------

--
-- Table structure for table `user_roles`
--

CREATE TABLE `user_roles` (
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `role_id` bigint(20) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `carts`
--
ALTER TABLE `carts`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `categories_slug_unique` (`slug`),
  ADD KEY `categories_parent_id_foreign` (`parent_id`);

--
-- Indexes for table `confirm_payments`
--
ALTER TABLE `confirm_payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `data_rows`
--
ALTER TABLE `data_rows`
  ADD PRIMARY KEY (`id`),
  ADD KEY `data_rows_data_type_id_foreign` (`data_type_id`);

--
-- Indexes for table `data_types`
--
ALTER TABLE `data_types`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `data_types_name_unique` (`name`),
  ADD UNIQUE KEY `data_types_slug_unique` (`slug`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `menus_name_unique` (`name`);

--
-- Indexes for table `menu_items`
--
ALTER TABLE `menu_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `menu_items_menu_id_foreign` (`menu_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_access_tokens`
--
ALTER TABLE `oauth_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_access_tokens_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_auth_codes`
--
ALTER TABLE `oauth_auth_codes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_auth_codes_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_clients_user_id_index` (`user_id`);

--
-- Indexes for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `oauth_refresh_tokens`
--
ALTER TABLE `oauth_refresh_tokens`
  ADD PRIMARY KEY (`id`),
  ADD KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_details`
--
ALTER TABLE `order_details`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `permissions`
--
ALTER TABLE `permissions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `permissions_key_index` (`key`);

--
-- Indexes for table `permission_role`
--
ALTER TABLE `permission_role`
  ADD PRIMARY KEY (`permission_id`,`role_id`),
  ADD KEY `permission_role_permission_id_index` (`permission_id`),
  ADD KEY `permission_role_role_id_index` (`role_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `roles`
--
ALTER TABLE `roles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `roles_name_unique` (`name`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `settings_key_unique` (`key`);

--
-- Indexes for table `translations`
--
ALTER TABLE `translations`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `translations_table_name_column_name_foreign_key_locale_unique` (`table_name`,`column_name`,`foreign_key`,`locale`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`),
  ADD KEY `users_role_id_foreign` (`role_id`);

--
-- Indexes for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD PRIMARY KEY (`user_id`,`role_id`),
  ADD KEY `user_roles_user_id_index` (`user_id`),
  ADD KEY `user_roles_role_id_index` (`role_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `carts`
--
ALTER TABLE `carts`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `confirm_payments`
--
ALTER TABLE `confirm_payments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `data_rows`
--
ALTER TABLE `data_rows`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=116;

--
-- AUTO_INCREMENT for table `data_types`
--
ALTER TABLE `data_types`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `menu_items`
--
ALTER TABLE `menu_items`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `oauth_clients`
--
ALTER TABLE `oauth_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `oauth_personal_access_clients`
--
ALTER TABLE `oauth_personal_access_clients`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `order_details`
--
ALTER TABLE `order_details`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `permissions`
--
ALTER TABLE `permissions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=72;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `roles`
--
ALTER TABLE `roles`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `translations`
--
ALTER TABLE `translations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `categories`
--
ALTER TABLE `categories`
  ADD CONSTRAINT `categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `data_rows`
--
ALTER TABLE `data_rows`
  ADD CONSTRAINT `data_rows_data_type_id_foreign` FOREIGN KEY (`data_type_id`) REFERENCES `data_types` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `menu_items`
--
ALTER TABLE `menu_items`
  ADD CONSTRAINT `menu_items_menu_id_foreign` FOREIGN KEY (`menu_id`) REFERENCES `menus` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `permission_role`
--
ALTER TABLE `permission_role`
  ADD CONSTRAINT `permission_role_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `permission_role_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`);

--
-- Constraints for table `user_roles`
--
ALTER TABLE `user_roles`
  ADD CONSTRAINT `user_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `user_roles_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
