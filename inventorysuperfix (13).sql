-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 04, 2024 at 08:02 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `inventorysuperfix`
--

-- --------------------------------------------------------

--
-- Table structure for table `history_kerusakan`
--

CREATE TABLE `history_kerusakan` (
  `id` varchar(191) NOT NULL,
  `id_pemakaian` varchar(20) NOT NULL,
  `tanggal_kerusakan` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `history_pemakaian`
--

CREATE TABLE `history_pemakaian` (
  `id` bigint(20) NOT NULL,
  `nomor_induk_old` varchar(45) DEFAULT NULL,
  `nomor_induk_new` varchar(45) DEFAULT NULL,
  `tanggal` longtext DEFAULT NULL,
  `ruangan_old` varchar(20) DEFAULT NULL,
  `ruangan_new` varchar(20) DEFAULT NULL,
  `created_at` longtext DEFAULT NULL,
  `updated_at` longtext DEFAULT NULL,
  `id_pemakaian` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `history_pemakaian`
--

INSERT INTO `history_pemakaian` (`id`, `nomor_induk_old`, `nomor_induk_new`, `tanggal`, `ruangan_old`, `ruangan_new`, `created_at`, `updated_at`, `id_pemakaian`) VALUES
(63, '', '23456789012345678901', '2023-10-26 08:49:58', '', 'HRD_01', '2023-12-18 13:54:12', '2023-12-18 13:54:12', 'PC-001'),
(64, '', '12345678901234567890', '2023-10-26 08:49:58', '', 'CTV_01', '2023-12-18 13:54:28', '2023-12-18 13:54:28', 'LP-001'),
(65, '', '34567890123456789012', '2023-10-26 08:49:58', '', 'MKG_01', '2023-12-18 13:54:52', '2023-12-18 13:54:52', 'STV-001'),
(66, '', '45678901234567890123', '2023-10-26 08:49:58', '', 'PRG_01', '2023-12-18 13:55:01', '2023-12-18 13:55:01', 'CPU-001'),
(67, '', '56789012345678901234', '2023-10-26 08:49:58', '', 'PRG_02', '2023-12-18 13:55:09', '2023-12-18 13:55:09', 'MS-001');

-- --------------------------------------------------------

--
-- Table structure for table `history_perbaikan`
--

CREATE TABLE `history_perbaikan` (
  `id_perbaikan` bigint(20) NOT NULL,
  `tanggal_perbaikan` longtext DEFAULT NULL,
  `biaya` bigint(20) DEFAULT NULL,
  `deskripsi` varchar(255) DEFAULT NULL,
  `tanggal_kerusakan` longtext DEFAULT NULL,
  `tanggal_selesai_perbaikan` longtext DEFAULT NULL,
  `created_at` longtext DEFAULT NULL,
  `updated_at` longtext DEFAULT NULL,
  `tempat_perbaikan` longtext DEFAULT NULL,
  `id` varchar(191) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `kode_aset` varchar(20) NOT NULL,
  `merk` varchar(45) DEFAULT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `tanggal` longtext DEFAULT NULL,
  `harga` bigint(20) DEFAULT NULL,
  `nilai_residu` bigint(20) DEFAULT NULL,
  `masa_manfaat` bigint(20) DEFAULT NULL,
  `depresiasi` bigint(20) DEFAULT NULL,
  `deskripsi` varchar(255) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `id_kategori` varchar(3) DEFAULT NULL,
  `tahun_1` bigint(20) DEFAULT NULL,
  `tahun_2` bigint(20) DEFAULT NULL,
  `tahun_3` bigint(20) DEFAULT NULL,
  `tahun_4` bigint(20) DEFAULT NULL,
  `img_url` varchar(255) DEFAULT NULL,
  `vendor` varchar(100) DEFAULT NULL,
  `created_at` longtext DEFAULT NULL,
  `updated_at` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`kode_aset`, `merk`, `nama`, `tanggal`, `harga`, `nilai_residu`, `masa_manfaat`, `depresiasi`, `deskripsi`, `status`, `id_kategori`, `tahun_1`, `tahun_2`, `tahun_3`, `tahun_4`, `img_url`, `vendor`, `created_at`, `updated_at`) VALUES
('A123', 'Dell', 'Laptop Inspiron', '2023-01-15', 12000000, 2000000, 3, 3000000, 'Laptop ringan untuk pekerjaan sehari-hari', NULL, 'LP', 9000000, 6000000, 3000000, 0, '', 'Dell Store', '2023-12-18T00:00:00Z', '2023-12-18T00:00:00Z'),
('B456', 'HP', 'PC Workstation', '2023-02-20', 25000000, 5000000, 5, 3750000, 'PC kuat untuk tugas berat desain grafis', NULL, 'PC', 21250000, 17500000, 13750000, 10000000, '', 'HP Outlet', '2023-12-18T00:00:00Z', '2023-12-18T00:00:00Z'),
('C789', 'Sony', 'LED TV 42inch', '2023-03-10', 8000000, 1000000, 6, 1000000, 'TV dengan kualitas gambar tajam', NULL, 'STV', 7000000, 6000000, 5000000, 4000000, '', 'Electro Mart', '2023-12-18T00:00:00Z', '2023-12-18T00:00:00Z'),
('D012', 'Lenovo', 'Desktop Computer', '2023-04-05', 15000000, 3000000, 4, 2812500, 'Komputer desktop dengan performa tinggi', NULL, 'CPU', 12187500, 9375000, 6562500, 3750000, '', 'Lenovo Store', '2023-12-18T00:00:00Z', '2023-12-18T00:00:00Z'),
('E345', 'Samsung', 'Printer Laser', '2023-05-12', 5000000, 1000000, 5, 750000, 'Printer untuk mencetak dokumen berkualitas tinggi', NULL, 'MS', 4250000, 3500000, 2750000, 2000000, '', 'Samsung Outlet', '2023-12-18T00:00:00Z', '2023-12-18T00:00:00Z'),
('F678', 'Logitech', 'Wireless Mouse', '2023-06-08', 500000, 100000, 2, 187500, 'Mouse tanpa kabel dengan desain ergonomis', NULL, 'KY', 312500, 125000, -62500, -250000, '', 'Logitech Store', '2023-12-18T00:00:00Z', '2023-12-18T00:00:00Z');

-- --------------------------------------------------------

--
-- Table structure for table `karyawan`
--

CREATE TABLE `karyawan` (
  `nomor_induk` varchar(20) NOT NULL,
  `gambar` varchar(255) DEFAULT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `gender` tinyint(1) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `telepon` varchar(20) DEFAULT NULL,
  `jabatan` varchar(20) DEFAULT NULL,
  `divisi` varchar(20) DEFAULT NULL,
  `alamat` varchar(255) DEFAULT NULL,
  `created_at` longtext DEFAULT NULL,
  `updated_at` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `karyawan`
--

INSERT INTO `karyawan` (`nomor_induk`, `gambar`, `nama`, `gender`, `email`, `telepon`, `jabatan`, `divisi`, `alamat`, `created_at`, `updated_at`) VALUES
('01234567890123456789', 'Pegawai10.jpg', 'Anita Wijaya', 0, 'anita.wijaya@email.com', '0812-9998-8777', 'Analisis', 'Keuangan', 'Jl. Pine No. 123, Kota J', NULL, NULL),
('12345678901234567890', 'Pegawai1.jpg', 'Budi Santoso', 1, 'budi.santoso@email.com', '0812-3456-7890', 'Manajer', 'IT', 'Jl. Utama No. 123, Kota A', NULL, NULL),
('23456789012345678901', 'Pegawai2.jpg', 'Dewi Lestari', 0, 'dewi.lestari@email.com', '0812-9876-5432', 'Insinyur', 'HR', 'Jl. Oak No. 456, Kota B', NULL, NULL),
('34567890123456789012', 'Pegawai3.jpg', 'Adi Nugroho', 1, 'adi.nugroho@email.com', '0812-5551-2345', 'Analisis', 'Keuangan', 'Jl. Pinus No. 789, Kota C', NULL, NULL),
('45678901234567890123', 'Pegawai4.jpg', 'Ratna Wulandari', 0, 'ratna.wulandari@email.com', '0812-3339-8888', 'Supervisor', 'Pemasaran', 'Jl. Cedar No. 567, Kota D', NULL, NULL),
('56789012345678901234', 'Pegawai5.jpg', 'Eko Prasetyo', 1, 'eko.prasetyo@email.com', '0812-7775-5544', 'Pengembang', 'R&D', 'Jl. Birch No. 890, Kota E', NULL, NULL),
('67890123456789012345', 'Pegawai6.jpg', 'Sri Rahayu', 0, 'sri.rahayu@email.com', '0812-1112-2233', 'Koordinator', 'Operasional', 'Jl. Nanas No. 234, Kota F', NULL, NULL),
('78901234567890123456', 'Pegawai7.jpg', 'Muhammad Iqbal', 1, 'muhammad.iqbal@email.com', '0812-6667-7788', 'Perancang', 'Desain', 'Jl. Jeruk No. 901, Kota G', NULL, NULL),
('89012345678901234567', 'Pegawai8.jpg', 'Diana Susanti', 0, 'diana.susanti@email.com', '0812-4443-3222', 'Administrator', 'Admin', 'Jl. Maple No. 345, Kota H', NULL, NULL),
('90123456789012345678', 'Pegawai9.jpg', 'Faisal Abdullah', 1, 'faisal.abdullah@email.com', '0812-2221-1100', 'Spesialis', 'Penjualan', 'Jl. Pine No. 678, Kota I', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `kategori`
--

CREATE TABLE `kategori` (
  `id_kategori` varchar(3) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `created_at` longtext DEFAULT NULL,
  `updated_at` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kategori`
--

INSERT INTO `kategori` (`id_kategori`, `nama`, `created_at`, `updated_at`) VALUES
('CPU', 'Control Processing Unit', '2023-10-26 04:12:43', '2023-10-26 04:12:43'),
('KY', 'Keyboard', '2023-10-26 04:12:43', '2023-10-26 04:12:43'),
('LP', 'Laptop', '2023-10-26 04:12:43', '2023-10-26 04:12:43'),
('MS', 'Mouse', '2023-10-26 04:12:43', '2023-10-26 04:12:43'),
('PC', 'Personal Computer', '2023-10-26 04:12:43', '2023-10-26 04:12:43'),
('STV', 'Smart TV', '2023-10-26 04:12:43', '2023-10-26 04:12:43');

-- --------------------------------------------------------

--
-- Table structure for table `keahlian`
--

CREATE TABLE `keahlian` (
  `id_skill` varchar(6) NOT NULL,
  `nama` longtext DEFAULT NULL,
  `level` longtext DEFAULT NULL,
  `notes` longtext DEFAULT NULL,
  `created_at` longtext DEFAULT NULL,
  `updated_at` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `keahlian`
--

INSERT INTO `keahlian` (`id_skill`, `nama`, `level`, `notes`, `created_at`, `updated_at`) VALUES
('SK001', 'Programming', 'Advanced', 'Strong programming skills', '2024-01-04 14:00:00', '2024-01-04 14:00:00'),
('SK002', 'Database Management', 'Intermediate', 'Experience with SQL databases', '2024-01-04 14:15:00', '2024-01-04 14:15:00'),
('SK003', 'Web Development', 'Advanced', 'Frontend and backend development', '2024-01-04 14:30:00', '2024-01-04 14:30:00'),
('SK004', 'Data Analysis', 'Intermediate', 'Analyzing and interpreting data', '2024-01-04 14:45:00', '2024-01-04 14:45:00'),
('SK005', 'Network Administration', 'Intermediate', 'Managing network infrastructure', '2024-01-04 15:00:00', '2024-01-04 15:00:00'),
('SK006', 'Cybersecurity', 'Advanced', 'Ensuring system security', '2024-01-04 15:15:00', '2024-01-04 15:15:00'),
('SK007', 'Mobile App Development', 'Intermediate', 'Creating mobile applications', '2024-01-04 15:30:00', '2024-01-04 15:30:00'),
('SK008', 'Machine Learning', 'Advanced', 'Implementing ML algorithms', '2024-01-04 15:45:00', '2024-01-04 15:45:00'),
('SK009', 'UI/UX Design', 'Intermediate', 'Designing user interfaces', '2024-01-04 16:00:00', '2024-01-04 16:00:00'),
('SK010', 'Project Management', 'Advanced', 'Managing software development projects', '2024-01-04 16:15:00', '2024-01-04 16:15:00');

-- --------------------------------------------------------

--
-- Table structure for table `keahlian_karyawan`
--

CREATE TABLE `keahlian_karyawan` (
  `id_skill_karyawan` varchar(6) NOT NULL,
  `id_skill` varchar(10) DEFAULT NULL,
  `nomor_induk` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `keahlian_karyawan`
--

INSERT INTO `keahlian_karyawan` (`id_skill_karyawan`, `id_skill`, `nomor_induk`) VALUES
('SKK001', 'SK001', '01234567890123456789'),
('SKK002', 'SK002', '12345678901234567890'),
('SKK003', 'SK003', '23456789012345678901'),
('SKK004', 'SK004', '34567890123456789012'),
('SKK005', 'SK005', '45678901234567890123'),
('SKK006', 'SK006', '56789012345678901234'),
('SKK007', 'SK007', '67890123456789012345'),
('SKK008', 'SK008', '78901234567890123456'),
('SKK009', 'SK009', '89012345678901234567'),
('SKK010', 'SK010', '90123456789012345678'),
('SKK011', 'SK003', '90123456789012345678'),
('SKK012', 'SK006', '56789012345678901234'),
('SKK013', 'SK004', '01234567890123456789'),
('SKK014', 'SK009', '34567890123456789012'),
('SKK015', 'SK007', '12345678901234567890'),
('SKK016', 'SK002', '23456789012345678901'),
('SKK017', 'SK010', '56789012345678901234'),
('SKK018', 'SK005', '67890123456789012345'),
('SKK019', 'SK008', '78901234567890123456'),
('SKK020', 'SK001', '89012345678901234567');

-- --------------------------------------------------------

--
-- Table structure for table `log_kerusakan`
--

CREATE TABLE `log_kerusakan` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `id_pemakaian` varchar(20) NOT NULL,
  `tanggal_kerusakan` varchar(20) DEFAULT NULL,
  `id_history` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `log_kerusakan`
--

INSERT INTO `log_kerusakan` (`id`, `id_pemakaian`, `tanggal_kerusakan`, `id_history`) VALUES
(3, 'CPU-001', '2023-12-09T14:40', 'CPU-001-001'),
(4, 'CPU-001', '2023-12-27T14:41', 'CPU-001-001'),
(5, 'CPU-001', '2023-12-27T14:48', 'CPU-001-001'),
(6, 'CPU-001', '2023-12-27T14:49', 'CPU-001-001'),
(7, 'CPU-001', '2023-12-27T14:50', 'CPU-001-001'),
(8, 'LP-001', '2023-12-27T14:59', 'LP-001-001');

-- --------------------------------------------------------

--
-- Table structure for table `lokasi`
--

CREATE TABLE `lokasi` (
  `id_lokasi` varchar(10) NOT NULL,
  `nama` varchar(100) DEFAULT NULL,
  `alamat` varchar(100) DEFAULT NULL,
  `created_at` longtext DEFAULT NULL,
  `updated_at` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lokasi`
--

INSERT INTO `lokasi` (`id_lokasi`, `nama`, `alamat`, `created_at`, `updated_at`) VALUES
('BDG_001', 'Bandung - Workshop & Studio', 'Sukakarya II No 40', '2023-10-26 04:12:43', '2023-10-26 04:12:43'),
('BDG_002', 'Bandung - WIT Building', 'Otto Iskandardinata No 458', '2023-10-26 04:12:43', '2023-10-26 04:12:43'),
('JKT_001', 'Jakarta Office', 'Rukan Permata Senayan Blok B25', '2023-10-26 04:12:43', '2023-10-26 04:12:43'),
('SBY_001', 'Surabaya - Surabaya Office', 'Arief Rahman Hakim No. 187', '2023-10-26 04:12:43', '2023-10-26 04:12:43');

-- --------------------------------------------------------

--
-- Table structure for table `pemakaian`
--

CREATE TABLE `pemakaian` (
  `id_pemakaian` varchar(20) NOT NULL,
  `kode_aset` varchar(20) DEFAULT NULL,
  `nomor_induk` varchar(20) DEFAULT NULL,
  `id_ruangan` varchar(6) DEFAULT NULL,
  `created_at` longtext DEFAULT NULL,
  `updated_at` longtext DEFAULT NULL,
  `status` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pemakaian`
--

INSERT INTO `pemakaian` (`id_pemakaian`, `kode_aset`, `nomor_induk`, `id_ruangan`, `created_at`, `updated_at`, `status`) VALUES
('CPU-001', 'D012', '45678901234567890123', 'PRG_01', '2023-10-26 04:17:32', '2023-10-26 08:49:58', 'baik'),
('LP-001', 'A123', '12345678901234567890', 'CTV_01', '2023-10-26 04:17:32', '2023-10-26 08:49:58', 'baik'),
('MS-001', 'E345', '56789012345678901234', 'PRG_02', '2023-10-26 04:17:32', '2023-10-26 08:49:58', 'baik'),
('PC-001', 'B456', '23456789012345678901', 'HRD_01', '2023-10-26 04:17:32', '2023-10-26 08:49:58', 'baik'),
('STV-001', 'C789', '34567890123456789012', 'MKG_01', '2023-10-26 04:17:32', '2023-10-26 08:49:58', 'baik');

-- --------------------------------------------------------

--
-- Table structure for table `portfolio`
--

CREATE TABLE `portfolio` (
  `id_portfolio` varchar(6) NOT NULL,
  `nama` longtext DEFAULT NULL,
  `tanggal` varchar(20) DEFAULT NULL,
  `deskripsi` longtext DEFAULT NULL,
  `role` longtext DEFAULT NULL,
  `technology` longtext DEFAULT NULL,
  `created_at` longtext DEFAULT NULL,
  `updated_at` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `portfolio`
--

INSERT INTO `portfolio` (`id_portfolio`, `nama`, `tanggal`, `deskripsi`, `role`, `technology`, `created_at`, `updated_at`) VALUES
('PF001', 'Project X', '2024-01-04', 'A software development project', 'Developer', 'Java, Spring Boot', '2024-01-04 14:00:00', '2024-01-04 14:00:00'),
('PF002', 'E-commerce Website', '2024-01-05', 'Building an online shopping platform', 'Frontend Developer', 'React, Node.js', '2024-01-04 14:15:00', '2024-01-04 14:15:00'),
('PF003', 'Data Analytics Dashboard', '2024-01-06', 'Analyzing and visualizing data', 'Data Scientist', 'Python, Pandas', '2024-01-04 14:30:00', '2024-01-04 14:30:00'),
('PF004', 'Mobile App Launch', '2024-01-07', 'Launching a new mobile application', 'Mobile App Developer', 'Flutter, Dart', '2024-01-04 14:45:00', '2024-01-04 14:45:00'),
('PF005', 'AI Chatbot Integration', '2024-01-08', 'Integrating an AI-powered chatbot', 'AI Developer', 'TensorFlow, Python', '2024-01-04 15:00:00', '2024-01-04 15:00:00'),
('PF006', 'Website Redesign', '2024-01-09', 'Redesigning the company website', 'UI/UX Designer', 'Figma, Sketch', '2024-01-04 15:15:00', '2024-01-04 15:15:00'),
('PF007', 'Cybersecurity Audit', '2024-01-10', 'Conducting a cybersecurity audit', 'Cybersecurity Analyst', 'Kali Linux, Wireshark', '2024-01-04 15:30:00', '2024-01-04 15:30:00'),
('PF008', 'Blockchain Implementation', '2024-01-11', 'Implementing blockchain technology', 'Blockchain Developer', 'Solidity, Ethereum', '2024-01-04 15:45:00', '2024-01-04 15:45:00'),
('PF009', 'Content Management System', '2024-01-12', 'Developing a custom CMS', 'Full Stack Developer', 'PHP, Laravel', '2024-01-04 16:00:00', '2024-01-04 16:00:00'),
('PF010', 'Cloud Migration', '2024-01-13', 'Migrating to cloud infrastructure', 'Cloud Engineer', 'AWS, Azure', '2024-01-04 16:15:00', '2024-01-04 16:15:00');

-- --------------------------------------------------------

--
-- Table structure for table `portfolio_karyawan`
--

CREATE TABLE `portfolio_karyawan` (
  `id_portfolio_karyawan` varchar(6) NOT NULL,
  `id_portfolio` varchar(10) DEFAULT NULL,
  `nomor_induk` varchar(191) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `portfolio_karyawan`
--

INSERT INTO `portfolio_karyawan` (`id_portfolio_karyawan`, `id_portfolio`, `nomor_induk`) VALUES
('PFK001', 'PF001', '01234567890123456789'),
('PFK020', 'PF001', '89012345678901234567'),
('PFK002', 'PF002', '12345678901234567890'),
('PFK016', 'PF002', '23456789012345678901'),
('PFK003', 'PF003', '23456789012345678901'),
('PFK011', 'PF003', '90123456789012345678'),
('PFK004', 'PF004', '34567890123456789012'),
('PFK013', 'PF004', '01234567890123456789'),
('PFK005', 'PF005', '45678901234567890123'),
('PFK018', 'PF005', '67890123456789012345'),
('PFK006', 'PF006', '56789012345678901234'),
('PFK012', 'PF006', '56789012345678901234'),
('PFK007', 'PF007', '67890123456789012345'),
('PFK015', 'PF007', '12345678901234567890'),
('PFK008', 'PF008', '78901234567890123456'),
('PFK019', 'PF008', '78901234567890123456'),
('PFK009', 'PF009', '89012345678901234567'),
('PFK014', 'PF009', '34567890123456789012'),
('PFK010', 'PF010', '90123456789012345678'),
('PFK017', 'PF010', '56789012345678901234');

-- --------------------------------------------------------

--
-- Table structure for table `ruangan`
--

CREATE TABLE `ruangan` (
  `id_ruangan` varchar(6) NOT NULL,
  `nama` longtext DEFAULT NULL,
  `created_at` longtext DEFAULT NULL,
  `updated_at` longtext DEFAULT NULL,
  `id_lokasi` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ruangan`
--

INSERT INTO `ruangan` (`id_ruangan`, `nama`, `created_at`, `updated_at`, `id_lokasi`) VALUES
('CTV_01', 'Creative Room 01', '2023-10-26 04:12:43', '2023-10-26 04:12:43', 'BDG_002'),
('HRD_01', 'Human Resources Development Room 01', '2023-10-26 04:12:43', '2023-10-26 04:12:43', 'BDG_002'),
('MKG_01', 'Marketing Room 01', '2023-10-26 04:12:43', '2023-10-26 04:12:43', 'BDG_001'),
('PRG_01', 'Programming Room 01', '2023-10-26 04:12:43', '2023-10-26 04:12:43', 'BDG_002'),
('PRG_02', 'Programming Room 02', '2023-10-26 04:12:43', '2023-10-26 04:12:43', 'BDG_002');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `nama` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `status`, `nama`) VALUES
(6, '2172003@maranatha.ac.id', '$2a$10$V7yPjt3XZ5DIuRBIPGWYUea9Tm838E1821qn3q2dyFnA72Wqc2BIO', 'Aktif', 'Yehezkiel David Setiawan');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `history_kerusakan`
--
ALTER TABLE `history_kerusakan`
  ADD PRIMARY KEY (`id`,`id_pemakaian`),
  ADD KEY `fk_historyKerusakan_pemakaian` (`id_pemakaian`);

--
-- Indexes for table `history_pemakaian`
--
ALTER TABLE `history_pemakaian`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_historyPemakaian_pemakaian` (`id_pemakaian`);

--
-- Indexes for table `history_perbaikan`
--
ALTER TABLE `history_perbaikan`
  ADD PRIMARY KEY (`id_perbaikan`) USING BTREE,
  ADD KEY `fk_history_perbaikan_report_history_kerusakan` (`id`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`kode_aset`),
  ADD KEY `fk_inventory_category` (`id_kategori`);

--
-- Indexes for table `karyawan`
--
ALTER TABLE `karyawan`
  ADD PRIMARY KEY (`nomor_induk`);

--
-- Indexes for table `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`id_kategori`);

--
-- Indexes for table `keahlian`
--
ALTER TABLE `keahlian`
  ADD PRIMARY KEY (`id_skill`);

--
-- Indexes for table `keahlian_karyawan`
--
ALTER TABLE `keahlian_karyawan`
  ADD PRIMARY KEY (`id_skill_karyawan`),
  ADD KEY `fk_keahlian_detail` (`id_skill`);

--
-- Indexes for table `log_kerusakan`
--
ALTER TABLE `log_kerusakan`
  ADD PRIMARY KEY (`id`,`id_pemakaian`),
  ADD KEY `idx_log_kerusakan_id_pemakaian` (`id_pemakaian`);

--
-- Indexes for table `lokasi`
--
ALTER TABLE `lokasi`
  ADD PRIMARY KEY (`id_lokasi`);

--
-- Indexes for table `pemakaian`
--
ALTER TABLE `pemakaian`
  ADD PRIMARY KEY (`id_pemakaian`),
  ADD KEY `fk_pemakaian_ruangan` (`id_ruangan`),
  ADD KEY `fk_pemakaian_karyawan` (`nomor_induk`),
  ADD KEY `fk_pemakaian_inventaris` (`kode_aset`);

--
-- Indexes for table `portfolio`
--
ALTER TABLE `portfolio`
  ADD PRIMARY KEY (`id_portfolio`);

--
-- Indexes for table `portfolio_karyawan`
--
ALTER TABLE `portfolio_karyawan`
  ADD PRIMARY KEY (`id_portfolio_karyawan`,`nomor_induk`),
  ADD KEY `fk_portfolio_detail` (`id_portfolio`),
  ADD KEY `fk_portfolio_karyawan` (`nomor_induk`);

--
-- Indexes for table `ruangan`
--
ALTER TABLE `ruangan`
  ADD PRIMARY KEY (`id_ruangan`),
  ADD KEY `fk_ruangan_lokasi` (`id_lokasi`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `history_pemakaian`
--
ALTER TABLE `history_pemakaian`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=68;

--
-- AUTO_INCREMENT for table `history_perbaikan`
--
ALTER TABLE `history_perbaikan`
  MODIFY `id_perbaikan` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `log_kerusakan`
--
ALTER TABLE `log_kerusakan`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `history_kerusakan`
--
ALTER TABLE `history_kerusakan`
  ADD CONSTRAINT `fk_historyKerusakan_pemakaian` FOREIGN KEY (`id_pemakaian`) REFERENCES `pemakaian` (`id_pemakaian`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `history_pemakaian`
--
ALTER TABLE `history_pemakaian`
  ADD CONSTRAINT `fk_historyPemakaian_pemakaian` FOREIGN KEY (`id_pemakaian`) REFERENCES `pemakaian` (`id_pemakaian`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `history_perbaikan`
--
ALTER TABLE `history_perbaikan`
  ADD CONSTRAINT `fk_historyPerbaikan_kerusakan` FOREIGN KEY (`id`) REFERENCES `history_kerusakan` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_history_perbaikan_report_history_kerusakan` FOREIGN KEY (`id`) REFERENCES `history_kerusakan` (`id`);

--
-- Constraints for table `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `fk_inventory_category` FOREIGN KEY (`id_kategori`) REFERENCES `kategori` (`id_kategori`);

--
-- Constraints for table `keahlian_karyawan`
--
ALTER TABLE `keahlian_karyawan`
  ADD CONSTRAINT `fk_keahlian_detail` FOREIGN KEY (`id_skill`) REFERENCES `keahlian` (`id_skill`);

--
-- Constraints for table `pemakaian`
--
ALTER TABLE `pemakaian`
  ADD CONSTRAINT `fk_pemakaian_employee` FOREIGN KEY (`nomor_induk`) REFERENCES `karyawan` (`nomor_induk`),
  ADD CONSTRAINT `fk_pemakaian_inventaris` FOREIGN KEY (`kode_aset`) REFERENCES `inventory` (`kode_aset`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_pemakaian_inventory` FOREIGN KEY (`kode_aset`) REFERENCES `inventory` (`kode_aset`),
  ADD CONSTRAINT `fk_pemakaian_karyawan` FOREIGN KEY (`nomor_induk`) REFERENCES `karyawan` (`nomor_induk`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_pemakaian_room` FOREIGN KEY (`id_ruangan`) REFERENCES `ruangan` (`id_ruangan`),
  ADD CONSTRAINT `fk_pemakaian_ruangan` FOREIGN KEY (`id_ruangan`) REFERENCES `ruangan` (`id_ruangan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `portfolio_karyawan`
--
ALTER TABLE `portfolio_karyawan`
  ADD CONSTRAINT `fk_portfolio_detail` FOREIGN KEY (`id_portfolio`) REFERENCES `portfolio` (`id_portfolio`),
  ADD CONSTRAINT `fk_portfolio_karyawan` FOREIGN KEY (`nomor_induk`) REFERENCES `karyawan` (`nomor_induk`);

--
-- Constraints for table `ruangan`
--
ALTER TABLE `ruangan`
  ADD CONSTRAINT `fk_ruangan_lokasi` FOREIGN KEY (`id_lokasi`) REFERENCES `lokasi` (`id_lokasi`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
