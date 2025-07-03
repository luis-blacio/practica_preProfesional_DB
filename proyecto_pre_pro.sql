--
-- MySQL database dump converted from PostgreSQL
--

SET FOREIGN_KEY_CHECKS = 0;
SET AUTOCOMMIT = 0;
SET SQL_MODE = 'NO_AUTO_VALUE_ON_ZERO';
SET time_zone = '+00:00';

--
-- Database: `proyecto_pre_pro`
--

-- --------------------------------------------------------

--
-- Table structure for table `usuario`
--

CREATE TABLE `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `rol` varchar(50) NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `clave_acceso` varchar(255) NOT NULL,
  `correo` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `usuario_correo_key` (`correo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tipo`
--

CREATE TABLE `tipo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `proyecto`
--

CREATE TABLE `proyecto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `nombre` varchar(100) NOT NULL,
  `idusuario` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `proyecto_idusuario_fkey` (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `requisito`
--

CREATE TABLE `requisito` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` text NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `prioridad` varchar(20) NOT NULL,
  `idproyecto` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `requisito_idproyecto_fkey` (`idproyecto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `caso_prueba`
--

CREATE TABLE `caso_prueba` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `prioridad` varchar(20) NOT NULL,
  `titulo` varchar(100) NOT NULL,
  `estado` varchar(20) NOT NULL,
  `idrequisito` int(11) NOT NULL,
  `idtipo` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `caso_prueba_idrequisito_fkey` (`idrequisito`),
  KEY `caso_prueba_idtipo_fkey` (`idtipo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `comentario`
--

CREATE TABLE `comentario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `texto` text NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `idrequisito` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `comentario_idrequisito_fkey` (`idrequisito`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `historial_ejecucion`
--

CREATE TABLE `historial_ejecucion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `observaciones` text,
  `resultado` varchar(20) NOT NULL,
  `idcaso_prueba` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `historial_ejecucion_idcaso_prueba_fkey` (`idcaso_prueba`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `matriz_trazabilidad`
--

CREATE TABLE `matriz_trazabilidad` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_requisito` int(11) NOT NULL,
  `estado` varchar(20) NOT NULL,
  `observaciones` text,
  `idcaso_prueba` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `matriz_trazabilidad_id_requisito_fkey` (`id_requisito`),
  KEY `matriz_trazabilidad_idcaso_prueba_fkey` (`idcaso_prueba`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notificacion`
--

CREATE TABLE `notificacion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(50) NOT NULL,
  `fecha` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estado` varchar(20) NOT NULL,
  `idcaso_prueba` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `notificacion_idcaso_prueba_fkey` (`idcaso_prueba`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Foreign Key Constraints
--

ALTER TABLE `proyecto`
  ADD CONSTRAINT `proyecto_idusuario_fkey` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`id`) ON DELETE CASCADE;

ALTER TABLE `requisito`
  ADD CONSTRAINT `requisito_idproyecto_fkey` FOREIGN KEY (`idproyecto`) REFERENCES `proyecto` (`id`) ON DELETE CASCADE;

ALTER TABLE `caso_prueba`
  ADD CONSTRAINT `caso_prueba_idrequisito_fkey` FOREIGN KEY (`idrequisito`) REFERENCES `requisito` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `caso_prueba_idtipo_fkey` FOREIGN KEY (`idtipo`) REFERENCES `tipo` (`id`);

ALTER TABLE `comentario`
  ADD CONSTRAINT `comentario_idrequisito_fkey` FOREIGN KEY (`idrequisito`) REFERENCES `requisito` (`id`) ON DELETE CASCADE;

ALTER TABLE `historial_ejecucion`
  ADD CONSTRAINT `historial_ejecucion_idcaso_prueba_fkey` FOREIGN KEY (`idcaso_prueba`) REFERENCES `caso_prueba` (`id`) ON DELETE CASCADE;

ALTER TABLE `matriz_trazabilidad`
  ADD CONSTRAINT `matriz_trazabilidad_id_requisito_fkey` FOREIGN KEY (`id_requisito`) REFERENCES `requisito` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `matriz_trazabilidad_idcaso_prueba_fkey` FOREIGN KEY (`idcaso_prueba`) REFERENCES `caso_prueba` (`id`) ON DELETE CASCADE;

ALTER TABLE `notificacion`
  ADD CONSTRAINT `notificacion_idcaso_prueba_fkey` FOREIGN KEY (`idcaso_prueba`) REFERENCES `caso_prueba` (`id`) ON DELETE CASCADE;

-- --------------------------------------------------------

--
-- Set AUTO_INCREMENT for dumped tables
--

ALTER TABLE `usuario` AUTO_INCREMENT = 1;
ALTER TABLE `tipo` AUTO_INCREMENT = 1;
ALTER TABLE `proyecto` AUTO_INCREMENT = 1;
ALTER TABLE `requisito` AUTO_INCREMENT = 1;
ALTER TABLE `caso_prueba` AUTO_INCREMENT = 1;
ALTER TABLE `comentario` AUTO_INCREMENT = 1;
ALTER TABLE `historial_ejecucion` AUTO_INCREMENT = 1;
ALTER TABLE `matriz_trazabilidad` AUTO_INCREMENT = 1;
ALTER TABLE `notificacion` AUTO_INCREMENT = 1;

SET FOREIGN_KEY_CHECKS = 1;
COMMIT;
