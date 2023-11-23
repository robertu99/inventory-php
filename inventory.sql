-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 23, 2023 at 06:52 PM
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
-- Database: `inventory`
--

-- --------------------------------------------------------

--
-- Table structure for table `employee`
--

CREATE TABLE `employee` (
  `employee_id` int(11) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `store_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `employee`
--

INSERT INTO `employee` (`employee_id`, `username`, `password`, `store_id`) VALUES
(1, 'john_doe', 'hashed_password1', 1),
(2, 'jane_smith', 'hashed_password2', 2),
(3, 'admin', '123', 3),
(4, 'alice', 'hashed_password4', 4),
(5, 'bob', 'hashed_password5', 5),
(6, 'charlie', 'hashed_password6', 6),
(7, 'diana', 'hashed_password7', 7),
(8, 'edward', 'hashed_password8', 8),
(9, 'frank', 'hashed_password9', 9),
(10, 'grace', 'hashed_password10', 10);

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `inventory_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `store_id` int(11) DEFAULT NULL,
  `purchase_quantity` int(11) DEFAULT NULL,
  `order_quantity` int(11) DEFAULT NULL,
  `current_stock` int(11) GENERATED ALWAYS AS (`purchase_quantity` - `order_quantity`) STORED
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`inventory_id`, `product_id`, `store_id`, `purchase_quantity`, `order_quantity`) VALUES
(1, 1, 1, 20, 5),
(2, 2, 1, 15, 0),
(3, 3, 1, 25, 0),
(4, 4, 1, 18, 0),
(5, 5, 1, 30, 0),
(6, 6, 2, 22, 0),
(7, 7, 2, 28, 0),
(8, 8, 3, 12, 0),
(9, 9, 3, 35, 0),
(10, 10, 4, 17, 0),
(11, 2, 2, 0, 3),
(12, 3, 3, 0, 8),
(13, 4, 4, 0, 6),
(14, 5, 5, 0, 10),
(15, 6, 6, 0, 7),
(16, 7, 7, 0, 12),
(17, 8, 8, 0, 4),
(18, 9, 9, 0, 15),
(19, 10, 10, 0, 9);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `ordered_quantity` int(11) DEFAULT NULL,
  `order_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `store_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `product_id`, `ordered_quantity`, `order_date`, `store_id`) VALUES
(21, 1, 5, '2023-11-14 03:12:34', 1),
(22, 2, 3, '2023-11-14 03:12:34', 2),
(23, 3, 8, '2023-11-14 03:12:34', 3),
(24, 4, 6, '2023-11-14 03:12:34', 4),
(25, 5, 10, '2023-11-14 03:12:34', 5),
(26, 6, 7, '2023-11-14 03:12:34', 6),
(27, 7, 12, '2023-11-14 03:12:34', 7),
(28, 8, 4, '2023-11-14 03:12:34', 8),
(29, 9, 15, '2023-11-14 03:12:34', 9),
(30, 10, 9, '2023-11-14 03:12:34', 10);

--
-- Triggers `orders`
--
DELIMITER $$
CREATE TRIGGER `update_order_quantity` AFTER INSERT ON `orders` FOR EACH ROW BEGIN
    UPDATE Inventory
    SET order_quantity = order_quantity + NEW.ordered_quantity
    WHERE product_id = NEW.product_id AND store_id = NEW.store_id;
    
    -- If the combination of product_id and store_id doesn't exist, insert a new row
    IF ROW_COUNT() = 0 THEN
        INSERT INTO Inventory (product_id, store_id, purchase_quantity, order_quantity)
        VALUES (NEW.product_id, NEW.store_id, 0, NEW.ordered_quantity);
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

CREATE TABLE `product` (
  `product_id` int(11) NOT NULL,
  `product_name` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `brand` varchar(255) DEFAULT NULL,
  `size` varchar(10) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL,
  `material` varchar(255) DEFAULT NULL,
  `shoe_type` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`product_id`, `product_name`, `price`, `brand`, `size`, `color`, `material`, `shoe_type`) VALUES
(1, 'Vans Old Skool', 59.99, 'Vans', '9', 'Black', 'Canvas', 'Sneakers'),
(2, 'Vans Authentic', 49.99, 'Vans', '8', 'Red', 'Leather', 'Sneakers'),
(3, 'Vans Classic Slip-On', 54.99, 'Vans', '8.5', 'Checkerboard', 'Canvas', 'Slip-On'),
(4, 'Vans Era', 49.99, 'Vans', '10', 'Blue', 'Canvas', 'Skate Shoes'),
(5, 'Vans SK8-Hi', 64.99, 'Vans', '9.5', 'White', 'Suede', 'High Top'),
(6, 'Vans Ultrarange', 79.99, 'Vans', '11', 'Gray', 'Mesh', 'Athletic Shoes'),
(7, 'Vans Old Skool Platform', 69.99, 'Vans', '8', 'Pink', 'Canvas', 'Platform Sneakers'),
(8, 'Vans Slip-On Pro', 59.99, 'Vans', '7.5', 'Green', 'Suede', 'Pro Skate'),
(9, 'Vans SK8-Mid', 59.99, 'Vans', '8', 'Purple', 'Canvas', 'Mid Top'),
(10, 'Vans ComfyCush Era', 74.99, 'Vans', '9', 'Yellow', 'Textile', 'Comfort Skate Shoes');

-- --------------------------------------------------------

--
-- Table structure for table `purchase`
--

CREATE TABLE `purchase` (
  `purchase_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `purchased_quantity` int(11) DEFAULT NULL,
  `purchase_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `store_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `purchase`
--

INSERT INTO `purchase` (`purchase_id`, `product_id`, `purchased_quantity`, `purchase_date`, `store_id`) VALUES
(21, 1, 20, '2023-11-14 03:12:17', 1),
(22, 2, 15, '2023-11-14 03:12:17', 1),
(23, 3, 25, '2023-11-14 03:12:17', 1),
(24, 4, 18, '2023-11-14 03:12:17', 1),
(25, 5, 30, '2023-11-14 03:12:17', 1),
(26, 6, 22, '2023-11-14 03:12:17', 2),
(27, 7, 28, '2023-11-14 03:12:17', 2),
(28, 8, 12, '2023-11-14 03:12:17', 3),
(29, 9, 35, '2023-11-14 03:12:17', 3),
(30, 10, 17, '2023-11-14 03:12:17', 4);

--
-- Triggers `purchase`
--
DELIMITER $$
CREATE TRIGGER `update_purchase_quantity` AFTER INSERT ON `purchase` FOR EACH ROW BEGIN
    UPDATE Inventory
    SET purchase_quantity = purchase_quantity + NEW.purchased_quantity
    WHERE product_id = NEW.product_id AND store_id = NEW.store_id;
    
    -- If the combination of product_id and store_id doesn't exist, insert a new row
    IF ROW_COUNT() = 0 THEN
        INSERT INTO Inventory (product_id, store_id, purchase_quantity, order_quantity)
        VALUES (NEW.product_id, NEW.store_id, NEW.purchased_quantity, 0);
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `store`
--

CREATE TABLE `store` (
  `store_id` int(11) NOT NULL,
  `store_name` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `store`
--

INSERT INTO `store` (`store_id`, `store_name`, `location`) VALUES
(1, 'Main Store', '123 Main Street, Cityville'),
(2, 'Branch Store 1', '456 Branch Avenue, Townsville'),
(3, 'Branch Store 2', '789 Secondary Road, Villagetown'),
(4, 'Mega Outlet', '101 Super Road, Megatown'),
(5, 'Urban Fashion Hub', '22 Trendy Street, Urbancity'),
(6, 'Sporty Paradise', '5 Active Lane, Fitville'),
(7, 'Tech Haven', '8 Digital Street, Techburg'),
(8, 'Cosmetic Corner', '33 Beauty Blvd, Glamville'),
(9, 'Home Decor Emporium', '44 Stylish Street, Decorcity'),
(10, 'Book Nook', '77 Literary Lane, Booksville');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `employee`
--
ALTER TABLE `employee`
  ADD PRIMARY KEY (`employee_id`),
  ADD KEY `store_id` (`store_id`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`inventory_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `store_id` (`store_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `store_id` (`store_id`);

--
-- Indexes for table `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`product_id`);

--
-- Indexes for table `purchase`
--
ALTER TABLE `purchase`
  ADD PRIMARY KEY (`purchase_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `store_id` (`store_id`);

--
-- Indexes for table `store`
--
ALTER TABLE `store`
  ADD PRIMARY KEY (`store_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `employee`
--
ALTER TABLE `employee`
  MODIFY `employee_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `inventory_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `product`
--
ALTER TABLE `product`
  MODIFY `product_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `purchase`
--
ALTER TABLE `purchase`
  MODIFY `purchase_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `store`
--
ALTER TABLE `store`
  MODIFY `store_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `employee`
--
ALTER TABLE `employee`
  ADD CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`);

--
-- Constraints for table `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  ADD CONSTRAINT `inventory_ibfk_2` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`);

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`);

--
-- Constraints for table `purchase`
--
ALTER TABLE `purchase`
  ADD CONSTRAINT `purchase_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `product` (`product_id`),
  ADD CONSTRAINT `purchase_ibfk_2` FOREIGN KEY (`store_id`) REFERENCES `store` (`store_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
