-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Waktu pembuatan: 16 Jul 2022 pada 18.40
-- Versi server: 10.4.22-MariaDB
-- Versi PHP: 7.3.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `oxymeter2`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `t_data`
--

CREATE TABLE `t_data` (
  `id` int(11) NOT NULL,
  `heart` int(11) NOT NULL,
  `spo` int(11) NOT NULL,
  `temp` float NOT NULL,
  `value_r` int(11) NOT NULL,
  `value_g` int(11) NOT NULL,
  `value_b` int(11) NOT NULL,
  `update_time` char(25) NOT NULL,
  `s_kondisi` char(35) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `t_data`
--

INSERT INTO `t_data` (`id`, `heart`, `spo`, `temp`, `value_r`, `value_g`, `value_b`, `update_time`, `s_kondisi`) VALUES
(1, 78, 98, 36, 88, 89, 77, '2022-16-Jul 18:44:49', 'ssssss'),
(2, 20, 0, -127, 122, 93, 59, '2022-16-Jul 18:45:44', 'asdasd'),
(3, 7, 0, 31, 645, 270, 185, '2022-16-Jul 23:30:31', 'asdasd'),
(4, 0, 0, 33.44, 611, 264, 179, '2022-16-Jul 23:31:01', 'asdasd'),
(5, 18, 0, 34, 121, 92, 57, '2022-16-Jul 23:35:06', 'asdasd'),
(6, 18, 0, 34.69, 121, 92, 58, '2022-16-Jul 23:35:30', 'asdasd');

-- --------------------------------------------------------

--
-- Struktur dari tabel `t_setting`
--

CREATE TABLE `t_setting` (
  `id` int(11) NOT NULL,
  `counter` int(11) NOT NULL,
  `millis` int(11) NOT NULL,
  `status_cek` char(25) NOT NULL,
  `status_normal` char(25) NOT NULL,
  `parameter1` float NOT NULL,
  `parameter2` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `t_setting`
--

INSERT INTO `t_setting` (`id`, `counter`, `millis`, `status_cek`, `status_normal`, `parameter1`, `parameter2`) VALUES
(1, 2, 2, 'asdasd', 'asdasd', 33, 33);

-- --------------------------------------------------------

--
-- Struktur dari tabel `t_user`
--

CREATE TABLE `t_user` (
  `id` int(11) NOT NULL,
  `first_name` char(20) NOT NULL,
  `last_name` char(20) NOT NULL,
  `email` char(35) NOT NULL,
  `school` char(35) NOT NULL,
  `prodi` char(20) NOT NULL,
  `about` text NOT NULL,
  `nim` char(14) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `t_user`
--

INSERT INTO `t_user` (`id`, `first_name`, `last_name`, `email`, `school`, `prodi`, `about`, `nim`) VALUES
(1, 'ahmadllll', 'wijaya', 'ahmadwijaya.te@gmail.com', 'umt', 'kkkkelektro', 'ssss', '1620201085');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `t_data`
--
ALTER TABLE `t_data`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `t_setting`
--
ALTER TABLE `t_setting`
  ADD PRIMARY KEY (`id`);

--
-- Indeks untuk tabel `t_user`
--
ALTER TABLE `t_user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `t_data`
--
ALTER TABLE `t_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT untuk tabel `t_setting`
--
ALTER TABLE `t_setting`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT untuk tabel `t_user`
--
ALTER TABLE `t_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
