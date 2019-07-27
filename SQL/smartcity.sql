-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th7 27, 2019 lúc 07:44 AM
-- Phiên bản máy phục vụ: 10.1.40-MariaDB
-- Phiên bản PHP: 7.1.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `smartcity`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `account`
--

CREATE TABLE `account` (
  `username` varchar(100) NOT NULL,
  `password` varchar(40) NOT NULL,
  `nameAc` varchar(100) NOT NULL,
  `id_auth` int(11) NOT NULL,
  `count_acc` smallint(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `account`
--

INSERT INTO `account` (`username`, `password`, `nameAc`, `id_auth`, `count_acc`) VALUES
('hieptan', 'hieptan123', 'Phường Hiệp Tân', 2, 10),
('hoathanh', 'hoathanh123', 'Phường Hòa Thạnh', 2, 7),
('phuthanh', 'phuthanh123', 'Phường Phú Thạnh', 2, 8),
('phuthohoa', 'phuthohoa123', 'Phường Phú Thọ Hòa', 2, 6),
('phutrung', 'phutrung123', 'Phường Phú Trung', 2, 9),
('sonky', 'sonky123', 'Phường Sơn Kỳ', 2, 2),
('tanphu', 'tanphu123', 'Quận Tân Phú', 1, NULL),
('tanquy', 'tanquy123', 'Phường Tân Quý', 2, 3),
('tansonnhi', 'tansonnhi123', 'Phường Tân Sơn Nhì', 2, 4),
('tanthanh', 'tanthanh123', 'Phường Tân Thành', 2, 5),
('tanthoihoa', 'tanthoihoa123', 'Phường Tân Thới Hòa', 2, 11),
('taythanh', 'taythanh123', 'Phường Tây Thạnh', 2, 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `auth`
--

CREATE TABLE `auth` (
  `id` int(11) NOT NULL,
  `role` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `auth`
--

INSERT INTO `auth` (`id`, `role`) VALUES
(1, 'admin'),
(2, 'user');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `content`
--

CREATE TABLE `content` (
  `id` int(11) NOT NULL,
  `noidung` varchar(255) NOT NULL,
  `id_violation` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `content`
--

INSERT INTO `content` (`id`, `noidung`, `id_violation`) VALUES
(1, '1. Tăng diện tích sử dụng tại tầng lửng: 26,4m2, kết cấu lót tôn đổ bê tông', 1),
(2, '2. Tăng diện tích sử dụng ban công tạo thành phòng tại tầng 2, 3, 4, 5 và sân thượng: 56m2', 1),
(3, '3. Tăng diện tích sử dụng tại sân thượng: Tại khoảng lùi trước, diện tích 16m2; tại khoảng lùi sau: 28,56m2, kết cấu mái lót tôn đổ bê tông', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `docs`
--

CREATE TABLE `docs` (
  `id` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `id_violation` int(10) NOT NULL,
  `count_views` int(4) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `docs`
--

INSERT INTO `docs` (`id`, `url`, `id_violation`, `count_views`) VALUES
('1ChH5zDjBqAE2FPzbbn6DwAvJ2SsTpEEN', 'https://docs.google.com/document/d/1ChH5zDjBqAE2FPzbbn6DwAvJ2SsTpEEN/edit', 1, 3),
('1CuQQzqnKGxfl3cvJ2vfH062p_N2ZOnVZ', 'https://docs.google.com/document/d/1CuQQzqnKGxfl3cvJ2vfH062p_N2ZOnVZ/edit', 1, 1),
('1DJw85nUSJejoycuk-tC-L2EHC2vash7s', 'https://docs.google.com/document/d/1DJw85nUSJejoycuk-tC-L2EHC2vash7s/edit', 1, 6),
('1fjqNL7cHK6ZuIV1-XgP7Ldy0PFNwHdS9', 'https://docs.google.com/document/d/1fjqNL7cHK6ZuIV1-XgP7Ldy0PFNwHdS9/edit', 1, 0),
('1OuZpwYszbmLix9nQFX3fxfOkeAw1EXcH', 'https://docs.google.com/document/d/1OuZpwYszbmLix9nQFX3fxfOkeAw1EXcH/edit', 1, 4),
('1zjzb5RdiEp7WlkTvYwFnTZAUMgCIAdNa', 'https://docs.google.com/document/d/1zjzb5RdiEp7WlkTvYwFnTZAUMgCIAdNa/edit', 1, 5),
('1ZLZgBN_5ljp7qpnw-jdht8_RuzlEK0A6', 'https://docs.google.com/document/d/1ZLZgBN_5ljp7qpnw-jdht8_RuzlEK0A6/edit', 1, 2);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `images`
--

CREATE TABLE `images` (
  `id` varchar(255) NOT NULL,
  `url` varchar(255) NOT NULL,
  `id_WD` int(10) DEFAULT NULL,
  `id_Vi` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `land_owner`
--

CREATE TABLE `land_owner` (
  `hoten` varchar(100) NOT NULL,
  `cmnd` varchar(40) NOT NULL,
  `ngaycap` date NOT NULL,
  `diachicap` varchar(100) NOT NULL,
  `ngaysinh` date NOT NULL,
  `gioitinh` tinyint(1) NOT NULL,
  `quoctich` varchar(100) NOT NULL,
  `diachiTT` varchar(255) NOT NULL,
  `nghenghiep` varchar(255) DEFAULT NULL,
  `sdt` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `land_owner`
--

INSERT INTO `land_owner` (`hoten`, `cmnd`, `ngaycap`, `diachicap`, `ngaysinh`, `gioitinh`, `quoctich`, `diachiTT`, `nghenghiep`, `sdt`) VALUES
('Nguyễn Khánh Lâm', '025029130', '2015-03-03', 'Công an Thành phố Hồ Chí Minh', '1978-11-10', 1, 'Việt Nam', '249 đường Gò Dầu, phường Tân Quý, quận Tân Phú', NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `land_violation`
--

CREATE TABLE `land_violation` (
  `id` int(11) NOT NULL,
  `diachiVP` varchar(255) NOT NULL,
  `thoigianVP` date NOT NULL,
  `thoigianLBB` date NOT NULL,
  `tienphat` bigint(11) NOT NULL,
  `tinhtrang` tinyint(1) NOT NULL,
  `id_chudat` varchar(40) NOT NULL,
  `id_acc` varchar(100) NOT NULL,
  `thoigianthucVi` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `gioLBB` varchar(100) DEFAULT NULL,
  `soBB` int(10) DEFAULT NULL,
  `hientrangCT` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Đang đổ dữ liệu cho bảng `land_violation`
--

INSERT INTO `land_violation` (`id`, `diachiVP`, `thoigianVP`, `thoigianLBB`, `tienphat`, `tinhtrang`, `id_chudat`, `id_acc`, `thoigianthucVi`, `gioLBB`, `soBB`, `hientrangCT`) VALUES
(1, 'Một phần nhà 55 đường Lê Thúc Hoạch, phường Phú Thọ Hoà, quận Tân Phú', '2019-04-01', '2019-07-01', 0, 1, '025029130', 'phuthohoa', '2019-07-17 22:57:10', '14:00', 233, 'Công trình đã hoàn thành và đưa vào sử dụng. Quy mô: trệt + lửng + 04 lầu + sân thượng, kết cấu tường gạch sàn lót tôn đổ bê tông, mái tôn lót tôn đổ bê tông.');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `work_daily`
--

CREATE TABLE `work_daily` (
  `id` int(11) NOT NULL,
  `ngayTT` date NOT NULL,
  `diachiCT` varchar(255) NOT NULL,
  `hientrangCT` varchar(255) NOT NULL,
  `canboPH` varchar(100) NOT NULL,
  `canboTN` varchar(100) NOT NULL,
  `xacnhan` tinyint(1) DEFAULT NULL,
  `ghichu` varchar(255) DEFAULT NULL,
  `thoigianthuc` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `id_acc` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`username`),
  ADD KEY `id_auth` (`id_auth`);

--
-- Chỉ mục cho bảng `auth`
--
ALTER TABLE `auth`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `content`
--
ALTER TABLE `content`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_violation` (`id_violation`);

--
-- Chỉ mục cho bảng `docs`
--
ALTER TABLE `docs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_violation` (`id_violation`);

--
-- Chỉ mục cho bảng `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_WD` (`id_WD`),
  ADD KEY `id_Vi` (`id_Vi`);

--
-- Chỉ mục cho bảng `land_owner`
--
ALTER TABLE `land_owner`
  ADD PRIMARY KEY (`cmnd`);

--
-- Chỉ mục cho bảng `land_violation`
--
ALTER TABLE `land_violation`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_chudat` (`id_chudat`),
  ADD KEY `id_acc` (`id_acc`);

--
-- Chỉ mục cho bảng `work_daily`
--
ALTER TABLE `work_daily`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_acc` (`id_acc`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `content`
--
ALTER TABLE `content`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT cho bảng `land_violation`
--
ALTER TABLE `land_violation`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT cho bảng `work_daily`
--
ALTER TABLE `work_daily`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `account`
--
ALTER TABLE `account`
  ADD CONSTRAINT `account_ibfk_1` FOREIGN KEY (`id_auth`) REFERENCES `auth` (`id`);

--
-- Các ràng buộc cho bảng `content`
--
ALTER TABLE `content`
  ADD CONSTRAINT `content_ibfk_1` FOREIGN KEY (`id_violation`) REFERENCES `land_violation` (`id`);

--
-- Các ràng buộc cho bảng `docs`
--
ALTER TABLE `docs`
  ADD CONSTRAINT `docs_ibfk_1` FOREIGN KEY (`id_violation`) REFERENCES `land_violation` (`id`);

--
-- Các ràng buộc cho bảng `images`
--
ALTER TABLE `images`
  ADD CONSTRAINT `images_ibfk_1` FOREIGN KEY (`id_WD`) REFERENCES `work_daily` (`id`),
  ADD CONSTRAINT `images_ibfk_2` FOREIGN KEY (`id_Vi`) REFERENCES `land_violation` (`id`);

--
-- Các ràng buộc cho bảng `land_violation`
--
ALTER TABLE `land_violation`
  ADD CONSTRAINT `land_violation_ibfk_1` FOREIGN KEY (`id_chudat`) REFERENCES `land_owner` (`cmnd`),
  ADD CONSTRAINT `land_violation_ibfk_2` FOREIGN KEY (`id_acc`) REFERENCES `account` (`username`);

--
-- Các ràng buộc cho bảng `work_daily`
--
ALTER TABLE `work_daily`
  ADD CONSTRAINT `work_daily_ibfk_1` FOREIGN KEY (`id_acc`) REFERENCES `account` (`username`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
