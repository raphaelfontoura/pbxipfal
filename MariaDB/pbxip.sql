-- phpMyAdmin SQL Dump
-- version 3.4.11.1deb2+deb7u1
-- http://www.phpmyadmin.net
--
-- Máquina: localhost
-- Data de Criação: 01-Jan-2015 às 14:35
-- Versão do servidor: 5.5.40
-- versão do PHP: 5.4.4-14+deb7u14

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de Dados: `pbxip`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `TRG_AtualizaCusto`( `uniqueid` varchar(32), `custo` double(10,2))
BEGIN
    declare identificador varchar(32);

    SELECT count(*) into identificador FROM pbxip_custo WHERE uniqueid = uniqueid;

    IF identificador > 0 THEN
        UPDATE pbxip_cdr SET custo=custo
        WHERE uniqueid = uniqueid;
    ELSE
        INSERT INTO pbxip_cdr (uniqueid, custo) values (uniqueid, custo);
    END IF;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `log_acesso`
--

CREATE TABLE IF NOT EXISTS `log_acesso` (
  `id_log_acesso` int(11) NOT NULL AUTO_INCREMENT,
  `ip` varchar(20) NOT NULL DEFAULT '000.000.000.000',
  `data_acao` datetime NOT NULL,
  `acao` text NOT NULL,
  `id_usuario` int(11) NOT NULL,
  PRIMARY KEY (`id_log_acesso`),
  KEY `fk_log_acesso_usuario1` (`id_usuario`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `pbxip_agentes`
--

CREATE TABLE IF NOT EXISTS `pbxip_agentes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) DEFAULT NULL,
  `nome_usuario` varchar(45) DEFAULT NULL,
  `nome_agente` varchar(45) DEFAULT NULL,
  `ramal` varchar(45) DEFAULT NULL,
  `IP` varchar(45) DEFAULT NULL,
  `token` varchar(45) DEFAULT NULL,
  `fg_pausa` char(1) DEFAULT 'N',
  `motivo` varchar(45) DEFAULT NULL,
  `status_ligacao` char(1) DEFAULT 'L',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `pbxip_agentes_pausa`
--

CREATE TABLE IF NOT EXISTS `pbxip_agentes_pausa` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `id_agente` int(6) NOT NULL,
  `data_hora` datetime NOT NULL,
  `situacao` char(1) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_agente` (`id_agente`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `pbxip_agente_campanha`
--

CREATE TABLE IF NOT EXISTS `pbxip_agente_campanha` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_agente` int(11) DEFAULT NULL,
  `id_campanha` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `pbxip_blacklist`
--

CREATE TABLE IF NOT EXISTS `pbxip_blacklist` (
  `id` int(4) NOT NULL AUTO_INCREMENT,
  `telefone` varchar(20) NOT NULL,
  `data_cadastro` datetime NOT NULL,
  `obs` text,
  `id_usuario` int(11) DEFAULT NULL,
  `entrada` char(1) NOT NULL DEFAULT 'N',
  `saida` char(1) NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=13 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `pbxip_campanha`
--

CREATE TABLE IF NOT EXISTS `pbxip_campanha` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_titulo` int(11) DEFAULT NULL,
  `descricao` varchar(120) DEFAULT NULL,
  `conf_tentativas_ocupado` int(11) DEFAULT NULL,
  `conf_tentativa_naoatente` int(11) DEFAULT NULL,
  `conf_ligacoes_simult` int(11) DEFAULT NULL,
  `fg_status` char(1) DEFAULT 'N',
  `fg_periodo` char(1) DEFAULT 'N',
  `inicio_campanha` date DEFAULT NULL,
  `fim_campanha` date DEFAULT NULL,
  `segunda` varchar(45) DEFAULT NULL,
  `terca` varchar(45) DEFAULT NULL,
  `quarta` varchar(45) DEFAULT NULL,
  `quinta` varchar(45) DEFAULT NULL,
  `sexta` varchar(45) DEFAULT NULL,
  `sabado` varchar(45) DEFAULT NULL,
  `domingo` varchar(45) DEFAULT NULL,
  `exibir_contador` char(1) DEFAULT NULL,
  `contagem_regressiva` int(3) DEFAULT NULL,
  `prender_registro` int(3) DEFAULT NULL,
  `observacoes` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `pbxip_cdr`
--

CREATE TABLE IF NOT EXISTS `pbxip_cdr` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `calldate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `clid` varchar(80) NOT NULL DEFAULT '',
  `src` varchar(80) NOT NULL DEFAULT '',
  `dst` varchar(80) NOT NULL DEFAULT '',
  `dcontext` varchar(80) NOT NULL DEFAULT '',
  `channel` varchar(80) NOT NULL DEFAULT '',
  `dstchannel` varchar(80) NOT NULL DEFAULT '',
  `lastapp` varchar(80) NOT NULL DEFAULT '',
  `lastdata` varchar(80) NOT NULL DEFAULT '',
  `duration` int(11) NOT NULL DEFAULT '0',
  `billsec` int(11) NOT NULL DEFAULT '0',
  `disposition` varchar(45) NOT NULL DEFAULT '',
  `amaflags` int(11) NOT NULL DEFAULT '0',
  `accountcode` varchar(20) NOT NULL DEFAULT '',
  `userfield` varchar(255) NOT NULL DEFAULT '',
  `enviado` char(1) NOT NULL DEFAULT 'N',
  `uniqueid` varchar(60) NOT NULL DEFAULT '',
  `fluxo` varchar(100) DEFAULT NULL,
  `custo` double(10,2) DEFAULT '0.00',
  `id_tlmkt` int(9) DEFAULT NULL,
  `nif` varchar(20) DEFAULT NULL,
  `audiofile` varchar(500) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `calldate` (`calldate`),
  KEY `dst` (`dst`),
  KEY `accountcode` (`accountcode`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=462 ;

--
-- Extraindo dados da tabela `pbxip_cdr`
--

INSERT INTO `pbxip_cdr` (`id`, `calldate`, `clid`, `src`, `dst`, `dcontext`, `channel`, `dstchannel`, `lastapp`, `lastdata`, `duration`, `billsec`, `disposition`, `amaflags`, `accountcode`, `userfield`, `enviado`, `uniqueid`, `fluxo`, `custo`, `id_tlmkt`, `nif`, `audiofile`) VALUES
(14, '2014-09-02 11:44:14', '"2002" <2002>', '2002', '2003', 'externo', 'SIP/2002-00000004', 'SIP/2003-00000005', 'Dial', 'SIP/2003,,rtTwWkK', 36, 33, 'ANSWERED', 3, '', '', 'N', '1409669054.4', 'Chamada Interna', 0.00, NULL, NULL, '2002-to-2003-1409669054.4'),
(15, '2014-09-02 14:20:24', '"2002" <2002>', '2002', '600', 'externo', 'SIP/2002-00000006', '', 'Hangup', '', 0, 0, 'ANSWERED', 3, '', '', 'N', '1409678424.6', NULL, 0.00, NULL, NULL, NULL),
(16, '2014-09-02 14:32:39', '"2002" <2002>', '2002', '600', 'externo', 'SIP/2002-00000007', '', 'Hangup', '', 0, 0, 'ANSWERED', 3, '', '', 'N', '1409679159.7', NULL, 0.00, NULL, NULL, NULL),
(17, '2014-09-02 14:33:38', '"2002" <2002>', '2002', '600', 'externo', 'SIP/2002-00000008', '', 'Hangup', '', 2, 2, 'ANSWERED', 3, '', '', 'N', '1409679218.8', NULL, 0.00, NULL, NULL, NULL),
(18, '2014-09-02 14:44:47', '"2002" <2002>', '2002', '600', 'externo', 'SIP/2002-00000009', '', 'Hangup', '', 0, 0, 'ANSWERED', 3, '', '', 'N', '1409679887.9', NULL, 0.00, NULL, NULL, NULL),
(19, '2014-09-02 15:00:31', '"2002" <2002>', '2002', '600', 'externo', 'SIP/2002-0000000a', '', 'Hangup', '', 97, 97, 'ANSWERED', 3, '', '', 'N', '1409680831.10', NULL, 0.00, NULL, NULL, NULL),
(20, '2014-09-02 15:00:58', '"2003" <2003>', '2003', '600', 'externo', 'SIP/2003-0000000b', '', 'Hangup', '', 97, 97, 'ANSWERED', 3, '', '', 'N', '1409680858.11', NULL, 0.00, NULL, NULL, NULL),
(21, '2014-09-02 15:08:48', '"2002" <2002>', '2002', '600', 'externo', 'SIP/2002-0000000c', '', 'Hangup', '', 0, 0, 'ANSWERED', 3, '', '', 'N', '1409681328.12', NULL, 0.00, NULL, NULL, NULL),
(22, '2014-09-02 15:09:12', '"2002" <2002>', '2002', '600', 'externo', 'SIP/2002-0000000d', '', 'Hangup', '', 0, 0, 'ANSWERED', 3, '', '', 'N', '1409681352.13', NULL, 0.00, NULL, NULL, NULL),
(23, '2014-09-02 15:13:50', '"2002" <2002>', '2002', '600', 'externo', 'SIP/2002-0000000e', '', 'Hangup', '', 0, 0, 'ANSWERED', 3, '', '', 'N', '1409681630.14', NULL, 0.00, NULL, NULL, NULL),
(24, '2014-09-02 15:14:13', '"2002" <2002>', '2002', '600', 'externo', 'SIP/2002-0000000f', '', 'Hangup', '', 97, 97, 'ANSWERED', 3, '', '', 'N', '1409681653.15', NULL, 0.00, NULL, NULL, NULL),
(25, '2014-09-02 15:30:47', '"2002" <2002>', '2002', '600', 'externo', 'SIP/2002-00000010', '', 'Hangup', '', 1, 1, 'ANSWERED', 3, '', '', 'N', '1409682647.16', NULL, 0.00, NULL, NULL, NULL),
(26, '2014-09-02 15:30:59', '"2002" <2002>', '2002', '600', 'externo', 'SIP/2002-00000011', '', 'Hangup', '', 0, 0, 'ANSWERED', 3, '', '', 'N', '1409682659.17', NULL, 0.00, NULL, NULL, NULL),
(27, '2014-09-02 15:31:32', '"2002" <2002>', '2002', '600', 'externo', 'SIP/2002-00000012', '', 'Playback', 'asterisk', 24, 24, 'ANSWERED', 3, '', '', 'N', '1409682692.18', NULL, 0.00, NULL, NULL, NULL),
(28, '2014-09-02 15:32:00', '"2002" <2002>', '2002', '601', 'externo', 'SIP/2002-00000013', '', 'Hangup', '', 46, 46, 'ANSWERED', 3, '', '', 'N', '1409682720.19', NULL, 0.00, NULL, NULL, NULL),
(29, '2014-09-02 15:32:52', '"2002" <2002>', '2002', '602', 'externo', 'SIP/2002-00000015', '', 'VoiceMailMain', '602@contexto', 17, 17, 'ANSWERED', 3, '', '', 'N', '1409682772.21', NULL, 0.00, NULL, NULL, NULL),
(30, '2014-09-02 15:32:38', '"2003" <2003>', '2003', '601', 'externo', 'SIP/2003-00000014', '', 'Echo', '', 36, 36, 'ANSWERED', 3, '', '', 'N', '1409682758.20', NULL, 0.00, NULL, NULL, NULL),
(31, '2014-09-02 15:34:04', '"2002" <2002>', '2002', '604', 'externo', 'SIP/2002-00000016', '', 'MusicOnHold', 'espera', 38, 38, 'ANSWERED', 3, '', '', 'N', '1409682844.22', NULL, 0.00, NULL, NULL, NULL),
(32, '2014-09-02 15:34:14', '"2003" <2003>', '2003', '604', 'externo', 'SIP/2003-00000017', '', 'MusicOnHold', 'espera', 36, 36, 'ANSWERED', 3, '', '', 'N', '1409682854.23', NULL, 0.00, NULL, NULL, NULL),
(33, '2014-09-02 15:34:49', '"2002" <2002>', '2002', '605', 'externo', 'SIP/2002-00000018', '', 'MusicOnHold', 'mohgsm', 7, 7, 'ANSWERED', 3, '', '', 'N', '1409682889.24', NULL, 0.00, NULL, NULL, NULL),
(34, '2014-09-02 15:34:58', '"2003" <2003>', '2003', '605', 'externo', 'SIP/2003-00000019', '', 'MusicOnHold', 'mohgsm', 21, 21, 'ANSWERED', 3, '', '', 'N', '1409682898.25', NULL, 0.00, NULL, NULL, NULL),
(35, '2014-09-02 16:48:37', '"2002" <2002>', '2002', '601', 'externo', 'SIP/2002-0000001a', '', 'Hangup', '', 176, 176, 'ANSWERED', 3, '', '', 'N', '1409687317.26', NULL, 0.00, NULL, NULL, NULL),
(36, '2014-09-02 17:01:10', '"2003" <2003>', '2003', '2003', 'externo', 'SIP/2003-0000001b', 'SIP/2003-0000001c', 'Congestion', '3000', 0, 0, 'FAILED', 3, '', '', 'N', '1409688070.27', 'Chamada Interna', 0.00, NULL, NULL, '2003-to-2003-1409688070.27'),
(37, '2014-09-02 17:01:19', '"2003" <2003>', '2003', '2003', 'externo', 'SIP/2003-0000001d', 'SIP/2003-0000001e', 'Congestion', '3000', 0, 0, 'FAILED', 3, '', '', 'N', '1409688079.29', 'Chamada Interna', 0.00, NULL, NULL, '2003-to-2003-1409688079.29'),
(38, '2014-09-02 17:01:24', '"2003" <2003>', '2003', '2003', 'externo', 'SIP/2003-0000001f', 'SIP/2003-00000020', 'Congestion', '3000', 0, 0, 'FAILED', 3, '', '', 'N', '1409688084.31', 'Chamada Interna', 0.00, NULL, NULL, '2003-to-2003-1409688084.31'),
(39, '2014-09-02 17:01:36', '"2003" <2003>', '2003', '2003', 'externo', 'SIP/2003-00000021', 'SIP/2003-00000022', 'Congestion', '3000', 0, 0, 'FAILED', 3, '', '', 'N', '1409688096.33', 'Chamada Interna', 0.00, NULL, NULL, '2003-to-2003-1409688096.33'),
(40, '2014-09-02 17:01:53', '"2003" <2003>', '2003', '802', 'externo', 'SIP/2003-00000023', '', 'MeetMe', '802,iDM(filas),1234', 4, 4, 'ANSWERED', 3, '', '', 'N', '1409688113.35', NULL, 0.00, NULL, NULL, NULL),
(41, '2014-09-02 17:02:27', '"2003" <2003>', '2003', '802', 'externo', 'SIP/2003-00000024', '', 'MeetMe', '802,iDM(filas),1234', 4, 4, 'ANSWERED', 3, '', '', 'N', '1409688147.37', NULL, 0.00, NULL, NULL, NULL),
(42, '2014-09-02 17:02:49', '"2003" <2003>', '2003', '803', 'externo', 'SIP/2003-00000025', '', 'MeetMe', '803,iDM(filas),1234', 4, 4, 'ANSWERED', 3, '', '', 'N', '1409688169.39', NULL, 0.00, NULL, NULL, NULL),
(43, '2014-09-02 17:03:01', '"2002" <2002>', '2002', '800', 'externo', 'SIP/2002-00000026', '', 'MeetMe', '800,iDM(filas),', 7, 7, 'ANSWERED', 3, '', '', 'N', '1409688181.41', NULL, 0.00, NULL, NULL, NULL),
(44, '2014-09-02 17:03:17', '"2002" <2002>', '2002', '800', 'externo', 'SIP/2002-00000027', '', 'MeetMe', '800,iDM(filas),', 17, 17, 'ANSWERED', 3, '', '', 'N', '1409688197.42', NULL, 0.00, NULL, NULL, NULL),
(45, '2014-09-02 17:04:29', '"2002" <2002>', '2002', '802', 'externo', 'SIP/2002-00000028', '', 'MeetMe', '802,iDM(filas),1234', 4, 4, 'ANSWERED', 3, '', '', 'N', '1409688269.44', NULL, 0.00, NULL, NULL, NULL),
(46, '2014-09-02 17:04:51', '"2003" <2003>', '2003', '802', 'externo', 'SIP/2003-00000029', '', 'MeetMe', '802,iDM(filas),1234', 4, 4, 'ANSWERED', 3, '', '', 'N', '1409688291.46', NULL, 0.00, NULL, NULL, NULL),
(47, '2014-09-02 17:05:15', '"2003" <2003>', '2003', '802', 'externo', 'SIP/2003-0000002a', '', 'MeetMe', '802,iDM(filas),1234', 4, 4, 'ANSWERED', 3, '', '', 'N', '1409688315.48', NULL, 0.00, NULL, NULL, NULL),
(48, '2014-09-02 17:08:32', '"2003" <2003>', '2003', '600', 'externo', 'SIP/2003-0000002b', '', 'Playback', 'asterisk', 7, 7, 'ANSWERED', 3, '', '', 'N', '1409688512.50', NULL, 0.00, NULL, NULL, NULL),
(49, '2014-09-02 17:08:42', '"2003" <2003>', '2003', '601', 'externo', 'SIP/2003-0000002c', '', 'Playback', 'demo-echotest', 4, 4, 'ANSWERED', 3, '', '', 'N', '1409688522.51', NULL, 0.00, NULL, NULL, NULL),
(50, '2014-09-02 17:08:48', '"2003" <2003>', '2003', '602', 'externo', 'SIP/2003-0000002d', '', 'MusicOnHold', 'espera', 12, 12, 'ANSWERED', 3, '', '', 'N', '1409688528.52', NULL, 0.00, NULL, NULL, NULL),
(51, '2014-09-02 17:09:08', '"2003" <2003>', '2003', '603', 'externo', 'SIP/2003-0000002e', '', 'MusicOnHold', 'filas', 6, 6, 'ANSWERED', 3, '', '', 'N', '1409688548.53', NULL, 0.00, NULL, NULL, NULL),
(52, '2014-09-02 17:09:16', '"2003" <2003>', '2003', '603', 'externo', 'SIP/2003-0000002f', '', 'MusicOnHold', 'filas', 6, 6, 'ANSWERED', 3, '', '', 'N', '1409688556.54', NULL, 0.00, NULL, NULL, NULL),
(53, '2014-09-02 17:09:25', '"2003" <2003>', '2003', '603', 'externo', 'SIP/2003-00000030', '', 'MusicOnHold', 'filas', 3, 3, 'ANSWERED', 3, '', '', 'N', '1409688565.55', NULL, 0.00, NULL, NULL, NULL),
(54, '2014-09-02 17:09:31', '"2003" <2003>', '2003', '603', 'externo', 'SIP/2003-00000031', '', 'MusicOnHold', 'filas', 3, 3, 'ANSWERED', 3, '', '', 'N', '1409688571.56', NULL, 0.00, NULL, NULL, NULL),
(55, '2014-11-04 15:13:04', '3137692035', '3137692035', '99', 'externo', 'IAX2/srvpbx-7100', '', 'Hangup', '', 4, 4, 'ANSWERED', 3, '', '', 'N', '1415121184.0', NULL, 0.00, NULL, NULL, NULL),
(56, '2014-11-04 15:13:23', '3137692002', '3137692002', '99', 'externo', 'IAX2/srvpbx-175', '', 'Hangup', '', 3, 3, 'ANSWERED', 3, '', '', 'N', '1415121203.1', NULL, 0.00, NULL, NULL, NULL),
(57, '2014-11-04 15:13:34', '3137692035', '3137692035', '99', 'externo', 'IAX2/srvpbx-5695', '', 'Hangup', '', 3, 3, 'ANSWERED', 3, '', '', 'N', '1415121214.2', NULL, 0.00, NULL, NULL, NULL),
(58, '2014-11-04 15:13:58', '3137692000', '3137692000', '99', 'externo', 'IAX2/srvpbx-1199', '', 'Hangup', '', 4, 4, 'ANSWERED', 3, '', '', 'N', '1415121238.3', NULL, 0.00, NULL, NULL, NULL),
(59, '2014-11-04 15:20:17', '3137692035', '3137692035', '99', 'externo', 'IAX2/srvpbx-2936', '', 'Hangup', '', 5, 5, 'ANSWERED', 3, '', '', 'N', '1415121617.4', NULL, 0.00, NULL, NULL, NULL),
(60, '2014-11-04 15:20:46', '3137692035', '3137692035', '99', 'externo', 'IAX2/srvpbx-283', '', 'Hangup', '', 5, 4, 'ANSWERED', 3, '', '', 'N', '1415121646.5', NULL, 0.00, NULL, NULL, NULL),
(61, '2014-11-04 15:21:31', '3137692035', '3137692035', '99', 'externo', 'IAX2/srvpbx-1404', '', 'Hangup', '', 4, 4, 'ANSWERED', 3, '', '', 'N', '1415121691.6', NULL, 0.00, NULL, NULL, NULL),
(62, '2014-11-04 15:22:03', '3137692002', '3137692002', '99', 'externo', 'IAX2/srvpbx-3302', '', 'Playback', 'one-moment-please&Minas-Gerais&vm-goodbye', 3, 3, 'ANSWERED', 3, '', '', 'N', '1415121723.7', NULL, 0.00, NULL, NULL, NULL),
(63, '2014-11-04 15:22:26', '3137692002', '3137692002', '99', 'externo', 'IAX2/srvpbx-12522', '', 'Playback', 'one-moment-please&Minas-Gerais&vm-goodbye', 3, 3, 'ANSWERED', 3, '', '', 'N', '1415121746.8', NULL, 0.00, NULL, NULL, NULL),
(64, '2014-11-04 15:23:31', '3137692002', '3137692002', '99', 'externo', 'IAX2/srvpbx-1173', '', 'Hangup', '', 4, 4, 'ANSWERED', 3, '', '', 'N', '1415121811.9', NULL, 0.00, NULL, NULL, NULL),
(65, '2014-11-04 15:23:44', '3137692035', '3137692035', '99', 'externo', 'IAX2/srvpbx-1326', '', 'Hangup', '', 5, 5, 'ANSWERED', 3, '', '', 'N', '1415121824.10', NULL, 0.00, NULL, NULL, NULL),
(66, '2014-11-04 15:25:48', '3137692002', '3137692002', '99', 'externo', 'IAX2/srvpbx-4395', '', 'Playback', 'one-moment-please&Minas-Gerais&vm-goodbye', 3, 3, 'ANSWERED', 3, '', '', 'N', '1415121948.11', NULL, 0.00, NULL, NULL, NULL),
(67, '2014-11-04 15:28:21', '3137692002', '3137692002', '99', 'externo', 'IAX2/srvpbx-8189', '', 'Hangup', '', 4, 4, 'ANSWERED', 3, '', '', 'N', '1415122101.12', NULL, 0.00, NULL, NULL, NULL),
(68, '2014-11-04 15:29:01', '3137692000', '3137692000', '99', 'externo', 'IAX2/srvpbx-273', '', 'Hangup', '', 4, 4, 'ANSWERED', 3, '', '', 'N', '1415122141.13', NULL, 0.00, NULL, NULL, NULL),
(69, '2014-11-04 15:34:56', '3137692000', '3137692000', '99', 'externo', 'IAX2/srvpbx-715', '', 'Hangup', '', 4, 4, 'ANSWERED', 3, '', '', 'N', '1415122496.14', NULL, 0.00, NULL, NULL, NULL),
(70, '2014-11-04 15:35:50', '3137692000', '3137692000', '99', 'externo', 'IAX2/srvpbx-225', '', 'Hangup', '', 4, 4, 'ANSWERED', 3, '', '', 'N', '1415122550.15', NULL, 0.00, NULL, NULL, NULL),
(71, '2014-11-04 15:40:46', '3137692002', '3137692002', '99', 'externo', 'IAX2/srvpbx-271', '', 'Hangup', '', 16, 16, 'ANSWERED', 3, '', '', 'N', '1415122846.16', NULL, 0.00, NULL, NULL, NULL),
(72, '2014-11-04 16:08:01', '"CALLERID(num)" <2002>', '2002', '99', 'externo', 'IAX2/srvpbx-3337', '', 'Hangup', '', 17, 17, 'ANSWERED', 3, '', '', 'N', '1415124481.17', NULL, 0.00, NULL, NULL, NULL),
(73, '2014-11-04 16:08:24', '"CALLERID(num)" <2101>', '2101', '99', 'externo', 'IAX2/srvpbx-387', '', 'Playback', 'lots-o-monkeys', 11, 11, 'ANSWERED', 3, '', '', 'N', '1415124504.18', NULL, 0.00, NULL, NULL, NULL),
(74, '2014-11-04 16:10:08', '"CALLERID(num)" <2101>', '2101', '99', 'externo', 'IAX2/srvpbx-650', '', 'Playback', 'lots-o-monkeys', 5, 5, 'ANSWERED', 3, '', '', 'N', '1415124608.19', NULL, 0.00, NULL, NULL, NULL),
(75, '2014-11-04 16:12:27', '"CALLERID(num)" <2002>', '2002', '99', 'externo', 'IAX2/srvpbx-826', '', 'Playback', 'lots-o-monkeys', 12, 12, 'ANSWERED', 3, '', '', 'N', '1415124747.20', NULL, 0.00, NULL, NULL, NULL),
(76, '2014-11-04 16:12:59', '"CALLERID(num)" <2101>', '2101', '99', 'externo', 'IAX2/srvpbx-261', '', 'Hangup', '', 16, 16, 'ANSWERED', 3, '', '', 'N', '1415124779.21', NULL, 0.00, NULL, NULL, NULL),
(77, '2014-11-04 16:20:53', '"CALLERID(num)" <2101>', '2101', '99', 'externo', 'IAX2/srvpbx-88', '', 'Playback', 'lots-o-monkeys', 7, 7, 'ANSWERED', 3, '', '', 'N', '1415125253.22', NULL, 0.00, NULL, NULL, NULL),
(78, '2014-11-04 16:22:11', '"CALLERID(num)" <2039>', '2039', '99', 'externo', 'IAX2/srvpbx-11778', '', 'Playback', 'lots-o-monkeys', 10, 10, 'ANSWERED', 3, '', '', 'N', '1415125331.23', NULL, 0.00, NULL, NULL, NULL),
(79, '2014-11-04 16:23:53', '"CALLERID(num)" <2039>', '2039', '99', 'externo', 'IAX2/srvpbx-4025', '', 'Playback', 'lots-o-monkeys', 8, 8, 'ANSWERED', 3, '', '', 'N', '1415125433.24', NULL, 0.00, NULL, NULL, NULL),
(80, '2014-11-04 16:24:11', '"CALLERID(num)" <2101>', '2101', '99', 'externo', 'IAX2/srvpbx-4792', '', 'Playback', 'lots-o-monkeys', 5, 5, 'ANSWERED', 3, '', '', 'N', '1415125451.25', NULL, 0.00, NULL, NULL, NULL),
(81, '2014-11-04 16:31:42', '"CALLERID(num)" <2039>', '2039', '99', 'externo', 'IAX2/srvpbx-5860', '', 'Goto', 'ivrpt,s,7', 21, 21, 'ANSWERED', 3, '', '', 'N', '1415125902.27', NULL, 0.00, NULL, NULL, NULL),
(82, '2014-11-04 16:32:39', '"CALLERID(num)" <2039>', '2039', '99', 'externo', 'IAX2/srvpbx-4251', '', 'Goto', 'ivrpt,s,7', 21, 21, 'ANSWERED', 3, '', '', 'N', '1415125959.28', NULL, 0.00, NULL, NULL, NULL),
(83, '2014-11-04 16:33:13', '"CALLERID(num)" <2039>', '2039', '99', 'externo', 'IAX2/srvpbx-953', '', 'Goto', 'ivrpt,s,7', 21, 21, 'ANSWERED', 3, '', '', 'N', '1415125993.29', NULL, 0.00, NULL, NULL, NULL),
(84, '2014-11-04 16:34:50', '"CALLERID(num)" <2039>', '2039', '99', 'externo', 'IAX2/srvpbx-3997', '', 'Goto', 'ivrpt,s,7', 21, 21, 'ANSWERED', 3, '', '', 'N', '1415126090.30', NULL, 0.00, NULL, NULL, NULL),
(85, '2014-11-04 16:35:45', '"CALLERID(num)" <2039>', '2039', '99', 'externo', 'IAX2/srvpbx-4125', '', 'Goto', 'ivrpt,s,7', 21, 21, 'ANSWERED', 3, '', '', 'N', '1415126145.31', NULL, 0.00, NULL, NULL, NULL),
(86, '2014-11-04 16:43:10', '"CALLERID(num)" <2039>', '2039', 't', 'psa', 'IAX2/srvpbx-2522', '', 'Hangup', '', 72, 72, 'ANSWERED', 3, '', '', 'N', '1415126590.32', NULL, 0.00, NULL, NULL, NULL),
(87, '2014-11-04 16:46:20', '"CALLERID(num)" <2039>', '2039', '3', 'psa', 'IAX2/srvpbx-6344', '', 'Goto', 'vrt,s,1', 46, 46, 'ANSWERED', 3, '', '', 'N', '1415126780.33', NULL, 0.00, NULL, NULL, NULL),
(88, '2014-11-04 16:49:32', '"CALLERID(num)" <2039>', '2039', 't', 'psa', 'IAX2/srvpbx-7831', '', 'Hangup', '', 84, 84, 'ANSWERED', 3, '', '', 'N', '1415126972.34', NULL, 0.00, NULL, NULL, NULL),
(89, '2014-11-04 16:51:39', '"CALLERID(num)" <2039>', '2039', 't', 'psa', 'IAX2/srvpbx-244', '', 'Hangup', '', 84, 84, 'ANSWERED', 3, '', '', 'N', '1415127099.35', NULL, 0.00, NULL, NULL, NULL),
(90, '2014-11-04 16:53:19', '"CALLERID(num)" <2039>', '2039', 't', 'psa', 'IAX2/srvpbx-12302', '', 'Hangup', '', 63, 63, 'ANSWERED', 3, '', '', 'N', '1415127199.36', NULL, 0.00, NULL, NULL, NULL),
(91, '2014-11-04 16:54:28', '"CALLERID(num)" <2039>', '2039', 'i', 'psa', 'IAX2/srvpbx-6295', '', 'Hangup', '', 49, 49, 'ANSWERED', 3, '', '', 'N', '1415127268.37', NULL, 0.00, NULL, NULL, NULL),
(92, '2014-11-04 16:57:18', '"CALLERID(num)" <2039>', '2039', 's', 'psa', 'IAX2/srvpbx-1050', '', 'WaitExten', '5', 32, 32, 'ANSWERED', 3, '', '', 'N', '1415127438.38', NULL, 0.00, NULL, NULL, NULL),
(93, '2014-11-04 16:59:54', '"CALLERID(num)" <2039>', '2039', 't', 'psa', 'IAX2/srvpbx-4324', '', 'Hangup', '', 60, 60, 'ANSWERED', 3, '', '', 'N', '1415127594.39', NULL, 0.00, NULL, NULL, NULL),
(94, '2014-11-04 17:02:14', '"CALLERID(num)" <2039>', '2039', 's', 'psa', 'IAX2/srvpbx-6059', '', 'WaitExten', '5', 14, 14, 'ANSWERED', 3, '', '', 'N', '1415127734.40', NULL, 0.00, NULL, NULL, NULL),
(95, '2014-11-04 17:10:59', '"CALLERID(num)" <2039>', '2039', 's', 'psa', 'IAX2/srvpbx-10906', '', 'WaitExten', '5', 15, 15, 'ANSWERED', 3, '', '', 'N', '1415128259.41', NULL, 0.00, NULL, NULL, NULL),
(96, '2014-11-04 17:21:14', '"CALLERID(num)" <2039>', '2039', 't', 'psa', 'IAX2/srvpbx-6983', '', 'Hangup', '', 61, 61, 'ANSWERED', 3, '', '', 'N', '1415128874.42', NULL, 0.00, NULL, NULL, NULL),
(97, '2014-11-04 17:28:59', '"CALLERID(num)" <2039>', '2039', 's', 'psa', 'IAX2/srvpbx-6283', '', 'BackGround', 'br/custom/res/avaliacao_atendente_res', 12, 12, 'ANSWERED', 3, '', '', 'N', '1415129339.43', NULL, 0.00, NULL, NULL, NULL),
(98, '2014-11-04 17:30:32', '"CALLERID(num)" <2039>', '2039', 't', 'psa', 'IAX2/srvpbx-7768', '', 'Hangup', '', 60, 60, 'ANSWERED', 3, '', '', 'N', '1415129432.44', NULL, 0.00, NULL, NULL, NULL),
(99, '2014-11-04 17:42:52', '"CALLERID(num)" <2039>', '2039', '1', 'psa', 'IAX2/srvpbx-5651', '', 'Goto', 'vrt,s,1', 12, 12, 'ANSWERED', 3, '', '', 'N', '1415130172.45', NULL, 0.00, NULL, NULL, NULL),
(100, '2014-11-04 17:43:56', '"CALLERID(num)" <2039>', '2039', 'i', 'psa', 'IAX2/srvpbx-1937', '', 'Hangup', '', 61, 61, 'ANSWERED', 3, '', '', 'N', '1415130236.46', NULL, 0.00, NULL, NULL, NULL),
(101, '2014-11-05 08:25:44', '"CALLERID(num)" <2039>', '2039', 'i', 'psa', 'IAX2/srvpbx-4873', '', 'Hangup', '', 82, 82, 'ANSWERED', 3, '', '', 'N', '1415183144.47', NULL, 0.00, NULL, NULL, NULL),
(102, '2014-11-05 08:32:49', '"CALLERID(num)" <2039>', '2039', '5', 'vrt', 'IAX2/srvpbx-8963', '', 'Hangup', '', 30, 30, 'ANSWERED', 3, '', '', 'N', '1415183569.48', NULL, 0.00, NULL, NULL, NULL),
(103, '2014-11-05 15:26:50', '"CALLERID(num)" <2039>', '2039', '2', 'vrt', 'IAX2/srvpbx-11095', '', 'Hangup', '', 21, 21, 'ANSWERED', 3, '', '', 'N', '1415208410.49', NULL, 0.00, NULL, NULL, '2039-to-1-1415208410.49'),
(104, '2014-11-05 15:28:07', '"CALLERID(num)" <2039>', '2039', '1', 'vrt', 'IAX2/srvpbx-2109', '', 'Hangup', '', 21, 21, 'ANSWERED', 3, '', '', 'N', '1415208487.50', NULL, 0.00, NULL, NULL, NULL),
(105, '2014-11-05 15:32:23', '"CALLERID(num)" <2039>', '2039', '1', 'vrt', 'IAX2/srvpbx-13759', '', 'Playback', 'br/custom/res/via_real_agradece_ligacao_res&br/custom/res/obrigado_res', 14, 14, 'ANSWERED', 3, '', '', 'N', '1415208743.51', NULL, 0.00, NULL, NULL, NULL),
(106, '2014-11-05 15:35:16', '"CALLERID(num)" <2039>', '2039', '1', 'vrt', 'IAX2/srvpbx-15062', '', 'Hangup', '', 12, 12, 'ANSWERED', 3, '', '', 'N', '1415208916.52', NULL, 0.00, NULL, NULL, NULL),
(107, '2014-11-05 15:36:40', '"CALLERID(num)" <2039>', '2039', '1', 'vrt', 'IAX2/srvpbx-13718', '', 'Hangup', '', 8, 8, 'ANSWERED', 3, '', '', 'N', '1415209000.53', NULL, 0.00, NULL, NULL, NULL),
(108, '2014-11-05 15:42:14', '"CALLERID(num)" <2039>', '2039', '1', 'vrt', 'IAX2/srvpbx-2776', '', 'Hangup', '', 12, 12, 'ANSWERED', 3, '', '', 'N', '1415209334.54', NULL, 0.00, NULL, NULL, NULL),
(109, '2014-11-05 15:47:11', '"CALLERID(num)" <2039>', '2039', '3', 'vrt', 'IAX2/srvpbx-1703', '', 'Playback', 'br/custom/res/via_real_agradece_ligacao_res&br/custom/res/obrigado_res', 10, 10, 'ANSWERED', 3, '', '', 'N', '1415209631.55', NULL, 0.00, NULL, NULL, NULL),
(110, '2014-11-05 15:47:32', '"CALLERID(num)" <2039>', '2039', '1', 'vrt', 'IAX2/srvpbx-7483', '', 'Hangup', '', 15, 15, 'ANSWERED', 3, '', '', 'N', '1415209652.56', NULL, 0.00, NULL, NULL, NULL),
(111, '2014-11-05 15:49:37', '"CALLERID(num)" <2039>', '2039', '1', 'vrt', 'IAX2/srvpbx-15696', '', 'Hangup', '', 11, 11, 'ANSWERED', 3, '', '', 'N', '1415209777.57', NULL, 0.00, NULL, NULL, NULL),
(112, '2014-11-05 15:50:57', '"CALLERID(num)" <2039>', '2039', '2', 'vrt', 'IAX2/srvpbx-13769', '', 'Playback', 'br/custom/res/via_real_agradece_ligacao_res&br/custom/res/obrigado_res', 9, 9, 'ANSWERED', 3, '', '', 'N', '1415209857.58', NULL, 0.00, NULL, NULL, NULL),
(113, '2014-11-05 15:51:26', '"CALLERID(num)" <2039>', '2039', '1', 'vrt', 'IAX2/srvpbx-14439', '', 'Hangup', '', 8, 8, 'ANSWERED', 3, '', '', 'N', '1415209886.59', NULL, 0.00, NULL, NULL, NULL),
(114, '2014-11-05 15:53:12', '"CALLERID(num)" <2039>', '2039', '1', 'vrt', 'IAX2/srvpbx-2859', '', 'Hangup', '', 8, 8, 'ANSWERED', 3, '', '', 'N', '1415209992.60', NULL, 0.00, NULL, NULL, NULL),
(115, '2014-11-05 15:55:10', '"CALLERID(num)" <2039>', '2039', '1', 'vrt', 'IAX2/srvpbx-11463', '', 'Hangup', '', 9, 9, 'ANSWERED', 3, '', '', 'N', '1415210110.61', NULL, 0.00, NULL, NULL, NULL),
(116, '2014-11-05 16:03:16', '"CALLERID(num)" <2039>', '2039', '1', 'vrt', 'IAX2/srvpbx-12783', '', 'Hangup', '', 10, 10, 'ANSWERED', 3, '', '', 'N', '1415210596.62', NULL, 0.00, NULL, NULL, NULL),
(117, '2014-11-05 16:09:02', '"CALLERID(num)" <2039>', '2039', '1', 'vrt', 'IAX2/srvpbx-2776', '', 'Hangup', '', 11, 11, 'ANSWERED', 3, '', '', 'N', '1415210942.63', NULL, 0.00, NULL, NULL, NULL),
(118, '2014-11-05 16:10:55', '"CALLERID(num)" <2039>', '2039', '1', 'vrt', 'IAX2/srvpbx-5510', '', 'Hangup', '', 8, 8, 'ANSWERED', 3, '', '', 'N', '1415211055.64', NULL, 0.00, NULL, NULL, NULL),
(119, '2014-11-05 16:17:31', '"CALLERID(num)" <2039>', '2039', '1', 'vrt', 'IAX2/srvpbx-8757', '', 'Hangup', '', 11, 11, 'ANSWERED', 3, '', '', 'N', '1415211451.65', NULL, 0.00, NULL, NULL, NULL),
(120, '2014-11-05 16:19:21', '"CALLERID(num)" <2039>', '2039', '1', 'vrt', 'IAX2/srvpbx-12882', '', 'Hangup', '', 9, 9, 'ANSWERED', 3, '', '', 'N', '1415211561.66', NULL, 0.00, NULL, NULL, NULL),
(121, '2014-11-05 17:01:35', '"CALLERID(num)" <2039>', '2039', '1', 'vrt', 'IAX2/srvpbx-9775', '', 'Hangup', '', 12, 12, 'ANSWERED', 3, '', '', 'N', '1415214095.67', NULL, 0.00, NULL, NULL, NULL),
(122, '2014-11-05 17:04:01', '"CALLERID(num)" <2039>', '2039', '1', 'vrt', 'IAX2/srvpbx-13694', '', 'Hangup', '', 13, 13, 'ANSWERED', 3, '', '', 'N', '1415214241.68', NULL, 0.00, NULL, NULL, NULL),
(123, '2014-11-05 17:10:28', '"CALLERID(num)" <2039>', '2039', '1', 'vrt', 'IAX2/srvpbx-9878', '', 'Hangup', '', 8, 8, 'ANSWERED', 3, '', '', 'N', '1415214628.69', NULL, 0.00, NULL, NULL, NULL),
(124, '2014-11-05 17:10:55', '"CALLERID(num)" <2035>', '2035', '1', 'vrt', 'IAX2/srvpbx-13383', '', 'Hangup', '', 14, 14, 'ANSWERED', 3, '', '', 'N', '1415214655.70', NULL, 0.00, NULL, NULL, NULL),
(125, '2014-11-05 17:11:40', '"CALLERID(num)" <2035>', '2035', '1', 'vrt', 'IAX2/srvpbx-6621', '', 'Hangup', '', 13, 13, 'ANSWERED', 3, '', '', 'N', '1415214700.71', NULL, 0.00, NULL, NULL, NULL),
(126, '2014-11-05 17:11:53', '"CALLERID(num)" <2101>', '2101', '1', 'vrt', 'IAX2/srvpbx-197', '', 'Playback', 'br/custom/res/via_real_agradece_ligacao_res&br/custom/res/obrigado_res', 8, 8, 'ANSWERED', 3, '', '', 'N', '1415214713.72', NULL, 0.00, NULL, NULL, NULL),
(127, '2014-11-05 17:18:50', '"CALLERID(num)" <2039>', '2039', '1', 'vrt', 'IAX2/srvpbx-6493', '', 'Hangup', '', 13, 13, 'ANSWERED', 3, '', '', 'N', '1415215130.73', NULL, 0.00, NULL, NULL, NULL),
(128, '2014-11-05 17:19:31', '"CALLERID(num)" <2002>', '2002', '3', 'vrt', 'IAX2/srvpbx-243', '', 'Playback', 'br/custom/res/via_real_agradece_ligacao_res&br/custom/res/obrigado_res', 6, 6, 'ANSWERED', 3, '', '', 'N', '1415215171.74', NULL, 0.00, NULL, NULL, NULL),
(129, '2014-11-05 17:19:39', '"CALLERID(num)" <2002>', '2002', '4', 'vrt', 'IAX2/srvpbx-12884', '', 'Playback', 'br/custom/res/via_real_agradece_ligacao_res&br/custom/res/obrigado_res', 4, 4, 'ANSWERED', 3, '', '', 'N', '1415215179.75', NULL, 0.00, NULL, NULL, NULL),
(130, '2014-11-05 17:19:45', '"CALLERID(num)" <2002>', '2002', '5', 'vrt', 'IAX2/srvpbx-12845', '', 'Playback', 'br/custom/res/via_real_agradece_ligacao_res&br/custom/res/obrigado_res', 5, 5, 'ANSWERED', 3, '', '', 'N', '1415215185.76', NULL, 0.00, NULL, NULL, NULL),
(131, '2014-11-05 17:32:10', '"CALLERID(num)" <2039>', '2039', '3', 'vrt', 'IAX2/srvpbx-4895', '', 'Hangup', '', 26, 26, 'ANSWERED', 3, '', '', 'N', '1415215930.77', NULL, 0.00, NULL, NULL, NULL),
(132, '2014-11-05 17:32:48', '"CALLERID(num)" <2039>', '2039', '1', 'vrt', 'IAX2/srvpbx-12715', '', 'Hangup', '', 19, 19, 'ANSWERED', 3, '', '', 'N', '1415215968.78', NULL, 0.00, NULL, NULL, NULL),
(133, '2014-11-05 17:42:32', '"CALLERID(num)" <2039>', '2039', '1', 'vrt', 'IAX2/srvpbx-5620', '', 'Hangup', '', 17, 17, 'ANSWERED', 3, '', '', 'N', '1415216552.79', NULL, 0.00, NULL, NULL, NULL),
(134, '2014-11-05 17:46:26', '"CALLERID(num)" <2039>', '2039', '5', 'vrt', 'IAX2/srvpbx-13266', '', 'Hangup', '', 14, 14, 'ANSWERED', 3, '', '', 'N', '1415216786.80', NULL, 0.00, NULL, NULL, NULL),
(135, '2014-11-05 17:46:50', '"CALLERID(num)" <2039>', '2039', '5', 'vrt', 'IAX2/srvpbx-8197', '', 'Hangup', '', 14, 14, 'ANSWERED', 3, '', '', 'N', '1415216810.81', NULL, 0.00, NULL, NULL, NULL),
(136, '2014-11-05 17:49:24', '"CALLERID(num)" <2039>', '2039', '4', 'vrt', 'IAX2/srvpbx-2509', '', 'Hangup', '', 20, 20, 'ANSWERED', 3, '', '', 'N', '1415216964.82', NULL, 0.00, NULL, NULL, NULL),
(137, '2014-11-05 17:52:39', '"CALLERID(num)" <2014>', '2014', '5', 'vrt', 'IAX2/srvpbx-11206', '', 'Hangup', '', 32, 32, 'ANSWERED', 3, '', '', 'N', '1415217159.83', NULL, 0.00, NULL, NULL, NULL),
(138, '2014-11-05 17:57:18', '"CALLERID(num)" <2014>', '2014', '5', 'vrt', 'IAX2/srvpbx-4394', '', 'Hangup', '', 39, 39, 'ANSWERED', 3, '', '', 'N', '1415217438.84', NULL, 0.00, NULL, NULL, NULL),
(139, '2014-11-05 18:04:03', '"CALLERID(num)" <2039>', '2039', '2', 'vrt', 'IAX2/srvpbx-11124', '', 'Hangup', '', 34, 34, 'ANSWERED', 3, '', '', 'N', '1415217843.85', NULL, 0.00, NULL, NULL, NULL),
(140, '2014-11-05 18:10:27', '"CALLERID(num)" <2039>', '2039', '4', 'vrt', 'IAX2/srvpbx-4374', '', 'Hangup', '', 23, 23, 'ANSWERED', 3, '', '', 'N', '1415218227.86', NULL, 0.00, NULL, NULL, NULL),
(141, '2014-11-05 18:10:59', '"CALLERID(num)" <2002>', '2002', 's', 'psa', 'IAX2/srvpbx-7303', '', 'BackGround', 'br/custom/res/avaliacao_atendente_res', 12, 12, 'ANSWERED', 3, '', '', 'N', '1415218259.87', NULL, 0.00, NULL, NULL, NULL),
(142, '2014-11-06 09:35:43', '"CALLERID(num)" <2039>', '2039', 's', 'psa', 'IAX2/srvpbx-14537', '', 'WaitExten', '5', 18, 18, 'ANSWERED', 3, '', '', 'N', '1415273743.88', NULL, 0.00, NULL, NULL, NULL),
(143, '2014-11-06 09:38:32', '"CALLERID(num)" <2039>', '2039', '2', 'vrt', 'IAX2/srvpbx-1863', '', 'Hangup', '', 28, 28, 'ANSWERED', 3, '', '', 'N', '1415273912.89', NULL, 0.00, NULL, NULL, NULL),
(144, '2014-11-06 09:40:29', '"CALLERID(num)" <2039>', '2039', '4', 'vrt', 'IAX2/srvpbx-2134', '', 'Hangup', '', 22, 22, 'ANSWERED', 3, '', '', 'N', '1415274029.90', NULL, 0.00, NULL, NULL, NULL),
(145, '2014-11-06 09:47:36', '"CALLERID(num)" <2039>', '2039', '1', 'vrt', 'IAX2/srvpbx-11600', '', 'Hangup', '', 23, 23, 'ANSWERED', 3, '', '', 'N', '1415274456.91', NULL, 0.00, NULL, NULL, NULL),
(146, '2014-11-06 09:49:04', '"CALLERID(num)" <2039>', '2039', '3', 'vrt', 'IAX2/srvpbx-4123', '', 'Hangup', '', 16, 16, 'ANSWERED', 3, '', '', 'N', '1415274544.92', NULL, 0.00, NULL, NULL, NULL),
(147, '2014-11-06 09:55:15', '"CALLERID(num)" <2002>', '2002', '5', 'vrt', 'IAX2/srvpbx-6242', '', 'Hangup', '', 19, 19, 'ANSWERED', 3, '', '', 'N', '1415274915.93', NULL, 0.00, NULL, NULL, NULL),
(148, '2014-11-06 10:22:44', '"CALLERID(num)" <2021>', '2021', 's', 'psa', 'IAX2/srvpbx-8096', '', 'WaitExten', '5', 17, 17, 'ANSWERED', 3, '', '', 'N', '1415276564.94', NULL, 0.00, NULL, NULL, NULL),
(149, '2014-11-06 10:23:11', '"CALLERID(num)" <2021>', '2021', 's', 'vrt', 'IAX2/srvpbx-4452', '', 'BackGround', 'br/custom/res/avaliacao_servico_res', 26, 26, 'ANSWERED', 3, '', '', 'N', '1415276591.95', NULL, 0.00, NULL, NULL, NULL),
(150, '2014-11-06 14:14:34', '"CALLERID(num)" <3137692000>', '3137692000', 's', 'psa', 'IAX2/srvpbx-4829', '', 'BackGround', 'br/custom/res/avaliacao_atendente_res', 43, 43, 'ANSWERED', 3, '', '', 'N', '1415290474.96', NULL, 0.00, NULL, NULL, NULL),
(151, '2014-11-06 14:47:22', '"CALLERID(num)" <2064>', '2064', 's', 'vrt', 'IAX2/srvpbx-1859', '', 'WaitExten', '5', 30, 30, 'ANSWERED', 3, '', '', 'N', '1415292442.97', NULL, 0.00, NULL, NULL, NULL),
(152, '2014-11-06 15:12:09', '"CALLERID(num)" <553139392199>', '553139392199', '4', 'vrt', 'IAX2/srvpbx-1906', '', 'Hangup', '', 42, 42, 'ANSWERED', 3, '', '', 'N', '1415293929.98', NULL, 0.00, NULL, NULL, NULL),
(153, '2014-11-06 17:39:57', '"CALLERID(num)" <3137692000>', '3137692000', 's', 'psa', 'IAX2/srvpbx-5584', '', 'BackGround', 'br/custom/res/avaliacao_atendente_res', 9, 9, 'ANSWERED', 3, '', '', 'N', '1415302797.99', NULL, 0.00, NULL, NULL, NULL),
(154, '2014-11-06 17:40:14', '"CALLERID(num)" <2096>', '2096', 's', 'psa', 'IAX2/srvpbx-2843', '', 'WaitExten', '5', 37, 37, 'ANSWERED', 3, '', '', 'N', '1415302814.100', NULL, 0.00, NULL, NULL, NULL),
(155, '2014-11-06 18:34:05', '"CALLERID(num)" <3137692000>', '3137692000', '5', 'vrt', 'IAX2/srvpbx-9832', '', 'Hangup', '', 26, 26, 'ANSWERED', 3, '', '', 'N', '1415306045.101', NULL, 0.00, NULL, NULL, NULL),
(156, '2014-11-06 19:35:30', '"CALLERID(num)" <3137692000>', '3137692000', '3', 'vrt', 'IAX2/srvpbx-15882', '', 'Hangup', '', 52, 52, 'ANSWERED', 3, '', '', 'N', '1415309730.102', NULL, 0.00, NULL, NULL, NULL),
(157, '2014-11-06 19:54:17', '"CALLERID(num)" <3137692000>', '3137692000', 't', 'psa', 'IAX2/srvpbx-9982', '', 'Hangup', '', 63, 63, 'ANSWERED', 3, '', '', 'N', '1415310857.103', NULL, 0.00, NULL, NULL, NULL),
(158, '2014-11-06 19:56:38', '"CALLERID(num)" <3137692000>', '3137692000', '2', 'vrt', 'IAX2/srvpbx-7815', '', 'Hangup', '', 34, 34, 'ANSWERED', 3, '', '', 'N', '1415310998.104', NULL, 0.00, NULL, NULL, NULL),
(159, '2014-11-06 19:59:44', '"CALLERID(num)" <2064>', '2064', '5', 'vrt', 'IAX2/srvpbx-7393', '', 'Hangup', '', 37, 37, 'ANSWERED', 3, '', '', 'N', '1415311184.105', NULL, 0.00, NULL, NULL, NULL),
(160, '2014-11-06 20:32:03', '"CALLERID(num)" <3137692000>', '3137692000', 't', 'psa', 'IAX2/srvpbx-12691', '', 'Hangup', '', 63, 63, 'ANSWERED', 3, '', '', 'N', '1415313123.106', NULL, 0.00, NULL, NULL, NULL),
(161, '2014-11-06 20:41:45', '"CALLERID(num)" <2051>', '2051', '3', 'vrt', 'IAX2/srvpbx-13279', '', 'Hangup', '', 38, 38, 'ANSWERED', 3, '', '', 'N', '1415313705.107', NULL, 0.00, NULL, NULL, NULL),
(162, '2014-11-07 14:49:29', '"CALLERID(num)" <2061>', '2061', '2', 'vrt', 'IAX2/srvpbx-14054', '', 'Hangup', '', 36, 36, 'ANSWERED', 3, '', '', 'N', '1415378969.108', NULL, 0.00, NULL, NULL, NULL),
(163, '2014-11-07 15:50:59', '"CALLERID(num)" <2063>', '2063', '3', 'vrt', 'IAX2/srvpbx-5247', '', 'Hangup', '', 33, 33, 'ANSWERED', 3, '', '', 'N', '1415382659.109', NULL, 0.00, NULL, NULL, NULL),
(164, '2014-11-07 15:58:46', '"CALLERID(num)" <2101>', '2101', '4', 'vrt', 'IAX2/srvpbx-9', '', 'Hangup', '', 23, 23, 'ANSWERED', 3, '', '', 'N', '1415383126.110', NULL, 0.00, NULL, NULL, NULL),
(165, '2014-11-07 19:20:54', '"CALLERID(num)" <553139392199>', '553139392199', '2', 'vrt', 'IAX2/srvpbx-1689', '', 'Hangup', '', 36, 36, 'ANSWERED', 3, '', '', 'N', '1415395254.111', NULL, 0.00, NULL, NULL, NULL),
(166, '2014-11-07 20:12:06', '"CALLERID(num)" <3137692000>', '3137692000', 't', 'psa', 'IAX2/srvpbx-2018', '', 'Hangup', '', 63, 63, 'ANSWERED', 3, '', '', 'N', '1415398326.112', NULL, 0.00, NULL, NULL, NULL),
(167, '2014-11-07 21:06:00', '"CALLERID(num)" <3137692000>', '3137692000', 's', 'psa', 'IAX2/srvpbx-12239', '', 'BackGround', 'br/custom/res/avaliacao_atendente_res', 43, 43, 'ANSWERED', 3, '', '', 'N', '1415401560.113', NULL, 0.00, NULL, NULL, NULL),
(168, '2014-11-07 21:53:44', '"CALLERID(num)" <2064>', '2064', '3', 'vrt', 'IAX2/srvpbx-6760', '', 'Hangup', '', 37, 37, 'ANSWERED', 3, '', '', 'N', '1415404424.114', NULL, 0.00, NULL, NULL, NULL),
(169, '2014-11-07 21:54:54', '"CALLERID(num)" <2051>', '2051', '5', 'vrt', 'IAX2/srvpbx-3058', '', 'Hangup', '', 38, 38, 'ANSWERED', 3, '', '', 'N', '1415404494.115', NULL, 0.00, NULL, NULL, NULL),
(170, '2014-11-08 08:55:31', '"CALLERID(num)" <2086>', '2086', 'i', 'psa', 'IAX2/srvpbx-15207', '', 'Playback', 'br/custom/res/opcao_invalida_res', 5, 5, 'ANSWERED', 3, '', '', 'N', '1415444131.117', NULL, 0.00, NULL, NULL, NULL),
(171, '2014-11-08 08:55:37', '"CALLERID(num)" <2096>', '2096', 's', 'psa', 'IAX2/srvpbx-4616', '', 'WaitExten', '5', 17, 17, 'ANSWERED', 3, '', '', 'N', '1415444136.118', NULL, 0.00, NULL, NULL, NULL),
(172, '2014-11-08 08:55:38', '"CALLERID(num)" <2086>', '2086', 's', 'vrt', 'IAX2/srvpbx-15860', '', 'BackGround', 'br/custom/res/avaliacao_servico_res', 29, 29, 'ANSWERED', 3, '', '', 'N', '1415444138.119', NULL, 0.00, NULL, NULL, NULL),
(173, '2014-11-08 08:55:43', '"CALLERID(num)" <2095>', '2095', 's', 'vrt', 'IAX2/srvpbx-13772', '', 'WaitExten', '5', 32, 32, 'ANSWERED', 3, '', '', 'N', '1415444143.120', NULL, 0.00, NULL, NULL, NULL),
(174, '2014-11-08 08:55:55', '"CALLERID(num)" <2102>', '2102', 't', 'psa', 'IAX2/srvpbx-12422', '', 'Playback', 'br/custom/res/opcao_invalida_res', 22, 22, 'ANSWERED', 3, '', '', 'N', '1415444155.122', NULL, 0.00, NULL, NULL, NULL),
(175, '2014-11-08 08:55:27', '"CALLERID(num)" <2064>', '2064', '5', 'vrt', 'IAX2/srvpbx-7101', '', 'Hangup', '', 57, 57, 'ANSWERED', 3, '', '', 'N', '1415444127.116', NULL, 0.00, NULL, NULL, NULL),
(176, '2014-11-08 08:55:46', '"CALLERID(num)" <2085>', '2085', '5', 'vrt', 'IAX2/srvpbx-5116', '', 'Hangup', '', 38, 38, 'ANSWERED', 3, '', '', 'N', '1415444146.121', NULL, 0.00, NULL, NULL, NULL),
(177, '2014-11-08 09:41:33', '"CALLERID(num)" <3137692000>', '3137692000', 's', 'psa', 'IAX2/srvpbx-9978', '', 'BackGround', 'br/custom/res/avaliacao_atendente_res', 23, 23, 'ANSWERED', 3, '', '', 'N', '1415446893.123', NULL, 0.00, NULL, NULL, NULL),
(178, '2014-11-08 09:59:14', '"CALLERID(num)" <2079>', '2079', '2', 'vrt', 'IAX2/srvpbx-4543', '', 'Hangup', '', 38, 38, 'ANSWERED', 3, '', '', 'N', '1415447954.124', NULL, 0.00, NULL, NULL, NULL),
(179, '2014-11-08 10:08:35', '"CALLERID(num)" <3137692000>', '3137692000', '4', 'vrt', 'IAX2/srvpbx-9432', '', 'Hangup', '', 58, 58, 'ANSWERED', 3, '', '', 'N', '1415448515.125', NULL, 0.00, NULL, NULL, NULL),
(180, '2014-11-08 10:14:12', '"CALLERID(num)" <3137692000>', '3137692000', '5', 'vrt', 'IAX2/srvpbx-11070', '', 'Hangup', '', 54, 54, 'ANSWERED', 3, '', '', 'N', '1415448852.126', NULL, 0.00, NULL, NULL, NULL),
(181, '2014-11-08 10:26:17', '"CALLERID(num)" <553139392199>', '553139392199', '4', 'vrt', 'IAX2/srvpbx-1985', '', 'Hangup', '', 57, 57, 'ANSWERED', 3, '', '', 'N', '1415449577.127', NULL, 0.00, NULL, NULL, NULL),
(182, '2014-11-08 10:35:20', '"CALLERID(num)" <3137692000>', '3137692000', 't', 'psa', 'IAX2/srvpbx-14942', '', 'Hangup', '', 63, 63, 'ANSWERED', 3, '', '', 'N', '1415450120.128', NULL, 0.00, NULL, NULL, NULL),
(183, '2014-11-08 10:58:11', '"CALLERID(num)" <2082>', '2082', 's', 'psa', 'IAX2/srvpbx-13311', '', 'BackGround', 'br/custom/res/avaliacao_atendente_res', 22, 22, 'ANSWERED', 3, '', '', 'N', '1415451491.130', NULL, 0.00, NULL, NULL, NULL),
(184, '2014-11-08 10:57:47', '"CALLERID(num)" <3137692000>', '3137692000', 't', 'psa', 'IAX2/srvpbx-6626', '', 'Hangup', '', 63, 63, 'ANSWERED', 3, '', '', 'N', '1415451467.129', NULL, 0.00, NULL, NULL, NULL),
(185, '2014-11-08 11:01:30', '"CALLERID(num)" <3137692000>', '3137692000', '3', 'vrt', 'IAX2/srvpbx-12635', '', 'Hangup', '', 75, 75, 'ANSWERED', 3, '', '', 'N', '1415451690.131', NULL, 0.00, NULL, NULL, NULL),
(186, '2014-11-08 11:02:08', '"CALLERID(num)" <3137692000>', '3137692000', 't', 'psa', 'IAX2/srvpbx-14878', '', 'Hangup', '', 63, 63, 'ANSWERED', 3, '', '', 'N', '1415451728.132', NULL, 0.00, NULL, NULL, NULL),
(187, '2014-11-08 11:03:41', '"CALLERID(num)" <3137692000>', '3137692000', '2', 'vrt', 'IAX2/srvpbx-10082', '', 'Hangup', '', 43, 43, 'ANSWERED', 3, '', '', 'N', '1415451821.133', NULL, 0.00, NULL, NULL, NULL),
(188, '2014-11-08 11:05:22', '"CALLERID(num)" <3137692000>', '3137692000', '2', 'vrt', 'IAX2/srvpbx-10815', '', 'Hangup', '', 40, 40, 'ANSWERED', 3, '', '', 'N', '1415451922.134', NULL, 0.00, NULL, NULL, NULL),
(189, '2014-11-08 11:06:35', '"CALLERID(num)" <3137692000>', '3137692000', '5', 'vrt', 'IAX2/srvpbx-778', '', 'Hangup', '', 85, 85, 'ANSWERED', 3, '', '', 'N', '1415451995.135', NULL, 0.00, NULL, NULL, NULL),
(190, '2014-11-08 11:18:31', '"CALLERID(num)" <553139392199>', '553139392199', '4', 'vrt', 'IAX2/srvpbx-11394', '', 'Hangup', '', 37, 37, 'ANSWERED', 3, '', '', 'N', '1415452711.136', NULL, 0.00, NULL, NULL, NULL),
(191, '2014-11-08 11:27:25', '"CALLERID(num)" <3137692000>', '3137692000', '4', 'vrt', 'IAX2/srvpbx-10884', '', 'Hangup', '', 58, 58, 'ANSWERED', 3, '', '', 'N', '1415453245.137', NULL, 0.00, NULL, NULL, NULL),
(192, '2014-11-08 11:28:43', '"CALLERID(num)" <553139392199>', '553139392199', '5', 'vrt', 'IAX2/srvpbx-13947', '', 'Hangup', '', 36, 36, 'ANSWERED', 3, '', '', 'N', '1415453323.138', NULL, 0.00, NULL, NULL, NULL),
(193, '2014-11-08 11:31:18', '"CALLERID(num)" <3137692000>', '3137692000', '4', 'vrt', 'IAX2/srvpbx-14665', '', 'Hangup', '', 41, 41, 'ANSWERED', 3, '', '', 'N', '1415453478.139', NULL, 0.00, NULL, NULL, NULL),
(194, '2014-11-08 11:31:40', '"CALLERID(num)" <2088>', '2088', '5', 'vrt', 'IAX2/srvpbx-1427', '', 'Hangup', '', 35, 35, 'ANSWERED', 3, '', '', 'N', '1415453500.140', NULL, 0.00, NULL, NULL, NULL),
(195, '2014-11-08 11:32:57', '"CALLERID(num)" <3137692000>', '3137692000', '4', 'vrt', 'IAX2/srvpbx-6171', '', 'Hangup', '', 41, 41, 'ANSWERED', 3, '', '', 'N', '1415453577.141', NULL, 0.00, NULL, NULL, NULL),
(196, '2014-11-08 11:36:00', '"CALLERID(num)" <3137692000>', '3137692000', '4', 'vrt', 'IAX2/srvpbx-8536', '', 'Hangup', '', 51, 51, 'ANSWERED', 3, '', '', 'N', '1415453760.142', NULL, 0.00, NULL, NULL, NULL),
(197, '2014-11-08 11:38:05', '"CALLERID(num)" <3137692000>', '3137692000', 's', 'psa', 'IAX2/srvpbx-7523', '', 'WaitExten', '5', 54, 54, 'ANSWERED', 3, '', '', 'N', '1415453885.143', NULL, 0.00, NULL, NULL, NULL),
(198, '2014-11-08 11:40:16', '"CALLERID(num)" <3137692000>', '3137692000', 's', 'psa', 'IAX2/srvpbx-8481', '', 'BackGround', 'br/custom/res/avaliacao_atendente_res', 48, 48, 'ANSWERED', 3, '', '', 'N', '1415454016.144', NULL, 0.00, NULL, NULL, NULL),
(199, '2014-11-08 11:45:10', '"CALLERID(num)" <3137692000>', '3137692000', '4', 'vrt', 'IAX2/srvpbx-11423', '', 'Hangup', '', 57, 57, 'ANSWERED', 3, '', '', 'N', '1415454310.145', NULL, 0.00, NULL, NULL, NULL),
(200, '2014-11-08 11:45:59', '"CALLERID(num)" <3137692000>', '3137692000', 't', 'psa', 'IAX2/srvpbx-12467', '', 'Hangup', '', 63, 63, 'ANSWERED', 3, '', '', 'N', '1415454359.146', NULL, 0.00, NULL, NULL, NULL),
(201, '2014-11-08 11:51:52', '"CALLERID(num)" <553139392199>', '553139392199', '4', 'vrt', 'IAX2/srvpbx-2369', '', 'Hangup', '', 35, 35, 'ANSWERED', 3, '', '', 'N', '1415454712.147', NULL, 0.00, NULL, NULL, NULL),
(202, '2014-11-08 12:55:27', '"CALLERID(num)" <553139392199>', '553139392199', '3', 'vrt', 'IAX2/srvpbx-109', '', 'Hangup', '', 45, 45, 'ANSWERED', 3, '', '', 'N', '1415458527.148', NULL, 0.00, NULL, NULL, NULL),
(203, '2014-11-08 12:57:34', '"CALLERID(num)" <3137692000>', '3137692000', 's', 'psa', 'IAX2/srvpbx-1046', '', 'BackGround', 'br/custom/res/avaliacao_atendente_res', 43, 43, 'ANSWERED', 3, '', '', 'N', '1415458654.149', NULL, 0.00, NULL, NULL, NULL),
(204, '2014-11-08 13:19:31', '"CALLERID(num)" <553139392199>', '553139392199', '5', 'vrt', 'IAX2/srvpbx-3610', '', 'Hangup', '', 37, 37, 'ANSWERED', 3, '', '', 'N', '1415459971.150', NULL, 0.00, NULL, NULL, NULL),
(205, '2014-11-08 13:31:23', '"CALLERID(num)" <3137692000>', '3137692000', 't', 'psa', 'IAX2/srvpbx-9788', '', 'Hangup', '', 63, 63, 'ANSWERED', 3, '', '', 'N', '1415460683.151', NULL, 0.00, NULL, NULL, NULL),
(206, '2014-11-08 13:35:35', '"CALLERID(num)" <3137692000>', '3137692000', 's', 'psa', 'IAX2/srvpbx-5832', '', 'WaitExten', '5', 54, 54, 'ANSWERED', 3, '', '', 'N', '1415460935.152', NULL, 0.00, NULL, NULL, NULL),
(207, '2014-11-08 13:36:20', '"CALLERID(num)" <553139392199>', '553139392199', '5', 'vrt', 'IAX2/srvpbx-2066', '', 'Hangup', '', 37, 37, 'ANSWERED', 3, '', '', 'N', '1415460980.153', NULL, 0.00, NULL, NULL, NULL),
(208, '2014-11-08 13:50:48', '"CALLERID(num)" <3137692000>', '3137692000', 't', 'psa', 'IAX2/srvpbx-5174', '', 'Hangup', '', 63, 63, 'ANSWERED', 3, '', '', 'N', '1415461848.154', NULL, 0.00, NULL, NULL, NULL),
(209, '2014-11-08 13:53:39', '"CALLERID(num)" <553139392199>', '553139392199', '3', 'vrt', 'IAX2/srvpbx-944', '', 'Hangup', '', 53, 53, 'ANSWERED', 3, '', '', 'N', '1415462019.155', NULL, 0.00, NULL, NULL, NULL),
(210, '2014-11-08 13:54:27', '"CALLERID(num)" <3137692000>', '3137692000', '5', 'vrt', 'IAX2/srvpbx-16010', '', 'Hangup', '', 51, 51, 'ANSWERED', 3, '', '', 'N', '1415462067.156', NULL, 0.00, NULL, NULL, NULL),
(211, '2014-11-08 14:00:07', '"CALLERID(num)" <3137692000>', '3137692000', 's', 'psa', 'IAX2/srvpbx-14165', '', 'BackGround', 'br/custom/res/avaliacao_atendente_res', 8, 8, 'ANSWERED', 3, '', '', 'N', '1415462407.157', NULL, 0.00, NULL, NULL, NULL),
(212, '2014-11-08 14:06:05', '"CALLERID(num)" <3137692000>', '3137692000', 't', 'psa', 'IAX2/srvpbx-4529', '', 'Hangup', '', 63, 63, 'ANSWERED', 3, '', '', 'N', '1415462765.158', NULL, 0.00, NULL, NULL, NULL),
(213, '2014-11-09 19:15:04', '"CALLERID(num)" <3137692000>', '3137692000', '5', 'vrt', 'IAX2/srvpbx-15116', '', 'Hangup', '', 57, 57, 'ANSWERED', 3, '', '', 'N', '1415567704.159', NULL, 0.00, NULL, NULL, NULL),
(214, '2014-11-10 14:34:26', '"CALLERID(num)" <2060>', '2060', '5', 'vrt', 'IAX2/srvpbx-1953', '', 'Hangup', '', 31, 31, 'ANSWERED', 3, '', '', 'N', '1415637266.160', NULL, 0.00, NULL, NULL, NULL),
(215, '2014-11-10 14:43:53', '"CALLERID(num)" <2063>', '2063', '3', 'vrt', 'IAX2/srvpbx-5998', '', 'Hangup', '', 37, 37, 'ANSWERED', 3, '', '', 'N', '1415637833.161', NULL, 0.00, NULL, NULL, NULL),
(216, '2014-11-10 17:16:15', '"CALLERID(num)" <3137692000>', '3137692000', '3', 'vrt', 'IAX2/srvpbx-5800', '', 'Hangup', '', 73, 73, 'ANSWERED', 3, '', '', 'N', '1415646975.162', NULL, 0.00, NULL, NULL, NULL),
(217, '2014-11-10 19:05:30', '"CALLERID(num)" <3137692000>', '3137692000', '4', 'vrt', 'IAX2/srvpbx-2237', '', 'Hangup', '', 40, 40, 'ANSWERED', 3, '', '', 'N', '1415653530.163', NULL, 0.00, NULL, NULL, NULL),
(218, '2014-11-10 19:12:14', '"CALLERID(num)" <2051>', '2051', '3', 'vrt', 'IAX2/srvpbx-13762', '', 'Hangup', '', 45, 45, 'ANSWERED', 3, '', '', 'N', '1415653934.164', NULL, 0.00, NULL, NULL, NULL),
(219, '2014-11-10 19:35:11', '"CALLERID(num)" <3137692000>', '3137692000', 's', 'psa', 'IAX2/srvpbx-99', '', 'BackGround', 'br/custom/res/avaliacao_atendente_res', 42, 42, 'ANSWERED', 3, '', '', 'N', '1415655311.165', NULL, 0.00, NULL, NULL, NULL),
(220, '2014-11-10 19:48:07', '"CALLERID(num)" <2078>', '2078', '2', 'vrt', 'IAX2/srvpbx-13078', '', 'Hangup', '', 32, 32, 'ANSWERED', 3, '', '', 'N', '1415656087.166', NULL, 0.00, NULL, NULL, NULL),
(221, '2014-11-10 20:10:32', '"CALLERID(num)" <553139392199>', '553139392199', '4', 'vrt', 'IAX2/srvpbx-1481', '', 'Hangup', '', 39, 39, 'ANSWERED', 3, '', '', 'N', '1415657432.167', NULL, 0.00, NULL, NULL, NULL),
(222, '2014-11-10 20:25:31', '"CALLERID(num)" <3137692000>', '3137692000', 's', 'psa', 'IAX2/srvpbx-15898', '', 'BackGround', 'br/custom/res/avaliacao_atendente_res', 4, 4, 'ANSWERED', 3, '', '', 'N', '1415658331.168', NULL, 0.00, NULL, NULL, NULL),
(223, '2014-11-10 20:55:32', '"CALLERID(num)" <2051>', '2051', '3', 'vrt', 'IAX2/srvpbx-16299', '', 'Hangup', '', 40, 40, 'ANSWERED', 3, '', '', 'N', '1415660132.169', NULL, 0.00, NULL, NULL, NULL),
(224, '2014-11-14 09:09:17', '"CALLERID(num)" <2039>', '2039', 's', 'psa', 'IAX2/srvpbx-5299', '', 'WaitExten', '5', 16, 16, 'ANSWERED', 3, '', '', 'N', '1415963357.0', NULL, 0.00, NULL, NULL, NULL),
(225, '2014-11-14 09:30:24', '"CALLERID(num)" <2039>', '2039', '5', 'vrt', 'IAX2/srvpbx-106', '', 'Hangup', '', 39, 39, 'ANSWERED', 3, '', '', 'N', '1415964624.1', NULL, 0.00, NULL, NULL, NULL),
(226, '2014-11-14 09:33:59', '"CALLERID(num)" <2039>', '2039', '3', 'vrt', 'IAX2/srvpbx-3963', '', 'Hangup', '', 38, 38, 'ANSWERED', 3, '', '', 'N', '1415964839.2', NULL, 0.00, NULL, NULL, NULL),
(227, '2014-11-14 09:55:52', '"CALLERID(num)" <2039>', '2039', 's', 'psa', 'IAX2/srvpbx-3831', '', 'BackGround', 'br/custom/res/avaliacao_atendente_res', 8, 8, 'ANSWERED', 3, '', '', 'N', '1415966152.3', NULL, 0.00, NULL, NULL, NULL),
(228, '2014-11-14 09:56:08', '"CALLERID(num)" <2039>', '2039', '99', 'externo', 'IAX2/srvpbx-1859', '', 'BackGround', 'br/agent-user', 7, 7, 'ANSWERED', 3, '', '', 'N', '1415966168.4', NULL, 0.00, NULL, NULL, NULL),
(229, '2014-11-14 10:52:41', '"CALLERID(num)" <2039>', '2039', '2', 'vrt', 'IAX2/srvpbx-1801', '', 'Hangup', '', 63, 63, 'ANSWERED', 3, '', '', 'N', '1415969561.5', NULL, 0.00, NULL, NULL, NULL),
(230, '2014-11-14 10:58:27', '"CALLERID(num)" <2039>', '2039', '99', 'externo', 'IAX2/srvpbx-11550', '', 'Read', 'AGID,br/agent-user,3,,1,5', 10, 10, 'ANSWERED', 3, '', '', 'N', '1415969907.6', NULL, 0.00, NULL, NULL, NULL),
(231, '2014-11-14 11:00:31', '"CALLERID(num)" <2039>', '2039', '99', 'externo', 'IAX2/srvpbx-4201', '', 'NoOp', 'Agente numero: 666', 10, 10, 'ANSWERED', 3, '', '', 'N', '1415970031.7', NULL, 0.00, NULL, NULL, NULL),
(232, '2014-11-14 11:02:40', '"CALLERID(num)" <2039>', '2039', '99', 'externo', 'IAX2/srvpbx-7330', '', 'NoOp', 'Agente numero: 666', 9, 9, 'ANSWERED', 3, '', '', 'N', '1415970160.8', NULL, 0.00, NULL, NULL, NULL),
(233, '2014-11-14 11:05:02', '"CALLERID(num)" <2039>', '2039', '99', 'externo', 'IAX2/srvpbx-7015', '', 'NoOp', 'Agente numero: 666', 11, 11, 'ANSWERED', 3, '', '', 'N', '1415970302.9', NULL, 0.00, NULL, NULL, NULL),
(234, '2014-11-14 11:09:29', '"CALLERID(num)" <2039>', '2039', '5', 'vrt', 'IAX2/srvpbx-417', '', 'Hangup', '', 42, 42, 'ANSWERED', 3, '', '', 'N', '1415970569.10', NULL, 0.00, NULL, NULL, NULL),
(235, '2014-11-14 11:35:19', '"CALLERID(num)" <2039>', '2039', '5', 'vrt', 'IAX2/srvpbx-8385', '', 'Hangup', '', 42, 42, 'ANSWERED', 3, '', '', 'N', '1415972119.11', NULL, 0.00, NULL, NULL, NULL),
(236, '2014-11-14 11:38:19', '"CALLERID(num)" <2101>', '2101', 'i', 'psa', 'IAX2/srvpbx-5864', '', 'Hangup', '', 27, 27, 'ANSWERED', 3, '', '', 'N', '1415972299.12', NULL, 0.00, NULL, NULL, NULL),
(237, '2014-11-14 11:39:27', '"CALLERID(num)" <2101>', '2101', 's', 'psa', 'IAX2/srvpbx-1557', '', 'WaitExten', '2', 1, 1, 'ANSWERED', 3, '', '', 'N', '1415972367.13', NULL, 0.00, NULL, NULL, NULL),
(238, '2014-11-14 11:39:31', '"CALLERID(num)" <2101>', '2101', '3', 'vrt', 'IAX2/srvpbx-3525', '', 'Hangup', '', 24, 24, 'ANSWERED', 3, '', '', 'N', '1415972371.14', NULL, 0.00, NULL, NULL, NULL),
(239, '2014-11-14 11:41:14', '"CALLERID(num)" <2079>', '2079', '99', 'externo', 'IAX2/srvpbx-2169', '', 'Read', 'AGID,br/agent-user,4,2,0', 6, 6, 'ANSWERED', 3, '', '', 'N', '1415972474.16', NULL, 0.00, NULL, NULL, NULL),
(240, '2014-11-14 11:40:47', '"CALLERID(num)" <2097>', '2097', '3', 'vrt', 'IAX2/srvpbx-3193', '', 'Hangup', '', 44, 44, 'ANSWERED', 3, '', '', 'N', '1415972447.15', NULL, 0.00, NULL, NULL, NULL),
(241, '2014-11-14 11:42:10', '"CALLERID(num)" <2051>', '2051', '4', 'vrt', 'IAX2/srvpbx-103', '', 'Hangup', '', 42, 42, 'ANSWERED', 3, '', '', 'N', '1415972530.17', NULL, 0.00, NULL, NULL, NULL),
(242, '2014-11-14 11:47:07', '"CALLERID(num)" <2079>', '2079', '5', 'vrt', 'IAX2/srvpbx-253', '', 'Hangup', '', 44, 44, 'ANSWERED', 3, '', '', 'N', '1415972827.18', NULL, 0.00, NULL, NULL, NULL),
(243, '2014-11-14 11:48:21', '"CALLERID(num)" <2051>', '2051', '99', 'externo', 'IAX2/srvpbx-6087', '', 'Read', 'AGID,br/agent-user,4,2,0', 7, 7, 'ANSWERED', 3, '', '', 'N', '1415972901.19', NULL, 0.00, NULL, NULL, NULL),
(244, '2014-11-14 11:49:06', '"CALLERID(num)" <2051>', '2051', 's', 'psa', 'IAX2/srvpbx-2402', '', 'BackGround', 'br/custom/res/avaliacao_atendente_res', 7, 7, 'ANSWERED', 3, '', '', 'N', '1415972946.20', NULL, 0.00, NULL, NULL, NULL),
(245, '2014-11-14 11:49:22', '"CALLERID(num)" <2051>', '2051', 's', 'psa', 'IAX2/srvpbx-4450', '', 'BackGround', 'br/custom/res/avaliacao_atendente_res', 10, 10, 'ANSWERED', 3, '', '', 'N', '1415972962.21', NULL, 0.00, NULL, NULL, NULL),
(246, '2014-11-14 11:56:00', '"CALLERID(num)" <2020>', '2020', 'i', 'psa', 'IAX2/srvpbx-4158', '', 'Playback', 'br/custom/res/opcao_invalida_res', 20, 20, 'ANSWERED', 3, '', '', 'N', '1415973360.22', NULL, 0.00, NULL, NULL, NULL),
(247, '2014-11-14 11:56:33', '"CALLERID(num)" <2020>', '2020', 's', 'psa', 'IAX2/srvpbx-4494', '', 'WaitExten', '5', 26, 26, 'ANSWERED', 3, '', '', 'N', '1415973393.23', NULL, 0.00, NULL, NULL, NULL),
(248, '2014-11-14 13:04:39', '"CALLERID(num)" <2079>', '2079', 's', 'psa', 'IAX2/srvpbx-2796', '', 'WaitExten', '5', 27, 27, 'ANSWERED', 3, '', '', 'N', '1415977479.24', NULL, 0.00, NULL, NULL, NULL),
(249, '2014-11-14 14:11:21', '"CALLERID(num)" <2039>', '2039', '2', 'vrt', 'IAX2/srvpbx-1094', '', 'Hangup', '', 22, 22, 'ANSWERED', 3, '', '', 'N', '1415981481.25', NULL, 0.00, NULL, NULL, NULL),
(250, '2014-11-14 14:13:26', '"CALLERID(num)" <2039>', '2039', '1', 'vrt', 'IAX2/srvpbx-1622', '', 'Hangup', '', 23, 23, 'ANSWERED', 3, '', '', 'N', '1415981606.26', NULL, 0.00, NULL, NULL, NULL),
(251, '2014-11-14 17:41:07', '"CALLERID(num)" <2002>', '2002', 's', 'psa', 'IAX2/srvpbx-14663', '', 'BackGround', 'br/custom/res/avaliacao_atendente_res', 19, 19, 'ANSWERED', 3, '', '', 'N', '1415994067.27', NULL, 0.00, NULL, NULL, NULL),
(252, '2014-11-14 17:42:36', '"CALLERID(num)" <2002>', '2002', 's', 'psa', 'IAX2/srvpbx-1781', '', 'BackGround', 'br/custom/res/avaliacao_atendente_res', 9, 9, 'ANSWERED', 3, '', '', 'N', '1415994156.28', NULL, 0.00, NULL, NULL, NULL);
INSERT INTO `pbxip_cdr` (`id`, `calldate`, `clid`, `src`, `dst`, `dcontext`, `channel`, `dstchannel`, `lastapp`, `lastdata`, `duration`, `billsec`, `disposition`, `amaflags`, `accountcode`, `userfield`, `enviado`, `uniqueid`, `fluxo`, `custo`, `id_tlmkt`, `nif`, `audiofile`) VALUES
(253, '2014-11-14 18:04:25', '"CALLERID(num)" <2064>', '2064', '5', 'vrt', 'IAX2/srvpbx-11663', '', 'Playback', 'br/custom/res/via_real_agradece_ligacao_res&br/custom/res/obrigado_res', 19, 19, 'ANSWERED', 3, '', '', 'N', '1415995465.29', NULL, 0.00, NULL, NULL, NULL),
(254, '2014-11-14 18:05:21', '"CALLERID(num)" <2063>', '2063', 's', 'psa', 'IAX2/srvpbx-5964', '', 'BackGround', 'br/custom/res/avaliacao_atendente_res', 16, 16, 'ANSWERED', 3, '', '', 'N', '1415995521.30', NULL, 0.00, NULL, NULL, NULL),
(255, '2014-11-14 18:20:05', '"CALLERID(num)" <2079>', '2079', 'i', 'psa', 'IAX2/srvpbx-1542', '', 'Hangup', '', 33, 33, 'ANSWERED', 3, '', '', 'N', '1415996405.31', NULL, 0.00, NULL, NULL, NULL),
(256, '2014-11-14 19:38:47', '"CALLERID(num)" <553139392199>', '553139392199', '4', 'vrt', 'IAX2/srvpbx-10224', '', 'Hangup', '', 43, 43, 'ANSWERED', 3, '', '', 'N', '1416001127.32', NULL, 0.00, NULL, NULL, NULL),
(257, '2014-11-14 19:46:48', '"CALLERID(num)" <3137692000>', '3137692000', '4', 'vrt', 'IAX2/srvpbx-684', '', 'Hangup', '', 93, 93, 'ANSWERED', 3, '', '', 'N', '1416001608.33', NULL, 0.00, NULL, NULL, NULL),
(258, '2014-11-18 09:22:30', '"2039" <2039>', '2039', '*11', 'externo', 'SIP/2039-00000000', '', 'AGI', 'HANGUP', 4, 4, 'ANSWERED', 3, '', '', 'N', '1416309750.34', NULL, 0.00, NULL, NULL, NULL),
(259, '2014-11-18 09:23:05', '"2039" <2039>', '2039', '*11', 'externo', 'SIP/2039-00000001', '', 'AGI', 'HANGUP', 3, 3, 'ANSWERED', 3, '', '', 'N', '1416309785.35', NULL, 0.00, NULL, NULL, NULL),
(260, '2014-11-18 09:27:45', '"2039" <2039>', '2039', '*11', 'externo', 'SIP/2039-00000002', '', 'AGI', 'HANGUP', 4, 4, 'ANSWERED', 3, '', '', 'N', '1416310065.36', NULL, 0.00, NULL, NULL, NULL),
(261, '2014-11-18 10:59:37', '"2039" <2039>', '2039', '*11', 'externo', 'SIP/2039-00000003', '', 'AGI', 'HANGUP', 3, 3, 'ANSWERED', 3, '', '', 'N', '1416315577.37', NULL, 0.00, NULL, NULL, NULL),
(262, '2014-11-18 11:04:04', '"2039" <2039>', '2039', '*11', 'externo', 'SIP/2039-00000004', '', 'AGI', 'HANGUP', 6, 5, 'ANSWERED', 3, '', '', 'N', '1416315844.38', NULL, 0.00, NULL, NULL, NULL),
(263, '2014-11-18 11:07:44', '"2039" <2039>', '2039', '*11', 'externo', 'SIP/2039-00000005', '', 'AGI', 'HANGUP', 5, 4, 'ANSWERED', 3, '', '', 'N', '1416316064.39', NULL, 0.00, NULL, NULL, NULL),
(264, '2014-11-18 11:08:21', '"2039" <2039>', '2039', '*11', 'externo', 'SIP/2039-00000006', '', 'AGI', 'HANGUP', 5, 5, 'ANSWERED', 3, '', '', 'N', '1416316101.40', NULL, 0.00, NULL, NULL, NULL),
(265, '2014-11-18 11:10:26', '"2039" <2039>', '2039', '*11', 'externo', 'SIP/2039-00000007', '', 'AGI', 'HANGUP', 4, 4, 'ANSWERED', 3, '', '', 'N', '1416316226.41', NULL, 0.00, NULL, NULL, NULL),
(266, '2014-11-18 11:11:36', '"2039" <2039>', '2039', '*11', 'externo', 'SIP/2039-00000008', '', 'AGI', 'HANGUP', 5, 5, 'ANSWERED', 3, '', '', 'N', '1416316296.42', NULL, 0.00, NULL, NULL, NULL),
(267, '2014-11-18 11:14:37', '"2039" <2039>', '2039', '*11', 'externo', 'SIP/2039-00000009', '', 'AGI', 'HANGUP', 5, 5, 'ANSWERED', 3, '', '', 'N', '1416316477.43', NULL, 0.00, NULL, NULL, NULL),
(268, '2014-11-18 11:18:01', '"2039" <2039>', '2039', '*11', 'externo', 'SIP/2039-0000000a', '', 'AGI', 'HANGUP', 5, 5, 'ANSWERED', 3, '', '', 'N', '1416316681.44', NULL, 0.00, NULL, NULL, NULL),
(269, '2014-11-18 11:27:46', '"CALLERID(num)" <2002>', '2002', 's', 'psa', 'IAX2/srvpbx-6299', '', 'WaitExten', '2', 2, 2, 'ANSWERED', 3, '', '', 'N', '1416317266.45', NULL, 0.00, NULL, NULL, NULL),
(270, '2014-11-18 11:28:09', '"CALLERID(num)" <2002>', '2002', '5', 'vrt', 'IAX2/srvpbx-15468', '', 'Hangup', '', 42, 42, 'ANSWERED', 3, '', '', 'N', '1416317289.46', NULL, 0.00, NULL, NULL, NULL),
(271, '2014-11-18 11:30:49', '"CALLERID(num)" <2002>', '2002', 's', 'vrt', 'IAX2/srvpbx-6395', '', 'BackGround', 'br/custom/res/avaliacao_servico_res', 28, 28, 'ANSWERED', 3, '', '', 'N', '1416317449.47', NULL, 0.00, NULL, NULL, NULL),
(272, '2014-11-18 11:31:31', '"CALLERID(num)" <2002>', '2002', '5', 'vrt', 'IAX2/srvpbx-4269', '', 'Hangup', '', 34, 34, 'ANSWERED', 3, '', '', 'N', '1416317491.48', NULL, 0.00, NULL, NULL, NULL),
(273, '2014-11-18 11:32:25', '"CALLERID(num)" <2046>', '2046', '99', 'externo', 'IAX2/srvpbx-8973', '', 'Read', 'AGID,br/agent-user,4,2,0', 7, 7, 'ANSWERED', 3, '', '', 'N', '1416317545.50', NULL, 0.00, NULL, NULL, NULL),
(274, '2014-11-18 11:32:12', '"2039" <2039>', '2039', 't', 'psa', 'SIP/2039-0000000b', '', 'Hangup', '', 108, 108, 'ANSWERED', 3, '', '', 'N', '1416317532.49', NULL, 0.00, NULL, NULL, NULL),
(275, '2014-11-18 11:34:42', '"2039" <2039>', '2039', '5', 'vrt', 'SIP/2039-0000000c', '', 'Hangup', '', 62, 62, 'ANSWERED', 3, '', '', 'N', '1416317682.51', NULL, 0.00, NULL, NULL, NULL),
(276, '2014-11-18 18:09:24', '"2039" <2039>', '2039', 's', 'psa', 'SIP/2039-0000000d', '', 'WaitExten', '5', 38, 38, 'ANSWERED', 3, '', '', 'N', '1416341364.52', NULL, 0.00, NULL, NULL, NULL),
(277, '2014-11-18 18:10:07', '"2039" <2039>', '2039', '99', 'externo', 'SIP/2039-0000000e', '', 'Read', 'AGID,br/agent-user,4,2,0', 14, 14, 'ANSWERED', 3, '', '', 'N', '1416341407.53', NULL, 0.00, NULL, NULL, NULL),
(278, '2014-11-18 18:10:52', '"CALLERID(num)" <2064>', '2064', '3', 'vrt', 'IAX2/srvpbx-13836', '', 'Hangup', '', 50, 50, 'ANSWERED', 3, '', '', 'N', '1416341452.54', NULL, 0.00, NULL, NULL, NULL),
(279, '2014-11-18 19:17:16', '"CALLERID(num)" <3137692000>', '3137692000', 't', 'psa', 'IAX2/srvpbx-13682', '', 'Hangup', '', 75, 75, 'ANSWERED', 3, '', '', 'N', '1416345436.55', NULL, 0.00, NULL, NULL, NULL),
(280, '2014-11-18 19:59:26', '"CALLERID(num)" <2086>', '2086', 's', 'psa', 'IAX2/srvpbx-5317', '', 'WaitExten', '2', 0, 0, 'ANSWERED', 3, '', '', 'N', '1416347966.56', NULL, 0.00, NULL, NULL, NULL),
(281, '2014-11-18 21:26:43', '"CALLERID(num)" <3137692000>', '3137692000', '3', 'vrt', 'IAX2/srvpbx-2391', '', 'Hangup', '', 70, 70, 'ANSWERED', 3, '', '', 'N', '1416353203.57', NULL, 0.00, NULL, NULL, NULL),
(282, '2014-11-18 21:46:30', '"CALLERID(num)" <2065>', '2065', '3', 'vrt', 'IAX2/srvpbx-5217', '', 'Hangup', '', 41, 41, 'ANSWERED', 3, '', '', 'N', '1416354390.58', NULL, 0.00, NULL, NULL, NULL),
(283, '2014-11-18 22:10:02', '"CALLERID(num)" <553139392199>', '553139392199', '3', 'vrt', 'IAX2/srvpbx-1232', '', 'Hangup', '', 50, 50, 'ANSWERED', 3, '', '', 'N', '1416355802.59', NULL, 0.00, NULL, NULL, NULL),
(284, '2014-11-18 22:25:27', '"CALLERID(num)" <3137692000>', '3137692000', 't', 'psa', 'IAX2/srvpbx-9014', '', 'Hangup', '', 73, 73, 'ANSWERED', 3, '', '', 'N', '1416356727.60', NULL, 0.00, NULL, NULL, NULL),
(285, '2014-11-19 11:11:15', '"2002" <2002>', '2002', '2039', 'externo', 'SIP/2002-0000000f', 'SIP/2039-00000010', 'Dial', 'SIP/2039,,rtTwWkK', 84, 0, 'NO ANSWER', 3, '', '', 'N', '1416402675.61', 'Chamada Interna', 0.00, NULL, NULL, '2002-to-2039-1416402675.61'),
(286, '2014-11-19 11:50:30', '"2039" <2039>', '2039', '2002', 'externo', 'SIP/2039-00000011', 'SIP/2002-00000012', 'Dial', 'SIP/2002,,rtTwWkK', 51, 45, 'ANSWERED', 3, '', '', 'N', '1416405030.63', 'Chamada Interna', 0.00, NULL, NULL, '2039-to-2002-1416405030.63'),
(287, '2014-11-19 11:55:58', '"2000" <2000>', '2000', '2039', 'externo', 'SIP/2000-00000013', '', 'Congestion', '3000', 0, 0, 'FAILED', 3, '', '', 'N', '1416405358.65', 'Chamada Interna', 0.00, NULL, NULL, '2000-to-2039-1416405358.65'),
(288, '2014-11-19 11:56:06', '"2000" <2000>', '2000', '2039', 'externo', 'SIP/2000-00000014', '', 'Congestion', '3000', 0, 0, 'FAILED', 3, '', '', 'N', '1416405366.66', 'Chamada Interna', 0.00, NULL, NULL, '2000-to-2039-1416405366.66'),
(289, '2014-11-19 11:56:23', '"2039" <2039>', '2039', '2000', 'externo', 'SIP/2039-00000015', 'SIP/2000-00000016', 'Dial', 'SIP/2000,,rtTwWkK', 12, 6, 'ANSWERED', 3, '', '', 'N', '1416405383.67', 'Chamada Interna', 0.00, NULL, NULL, '2039-to-2000-1416405383.67'),
(290, '2014-11-19 12:05:57', '"2039" <2039>', '2039', '2002', 'externo', 'SIP/2039-00000017', 'SIP/2002-00000018', 'Dial', 'SIP/2002,,rtTwWkK', 22, 17, 'ANSWERED', 3, '', '', 'N', '1416405957.69', 'Chamada Interna', 0.00, NULL, NULL, '2039-to-2002-1416405957.69'),
(291, '2014-11-19 12:07:36', '"2000" <2000>', '2000', '*11', 'externo', 'SIP/2000-00000019', '', 'AGI', 'HANGUP', 4, 4, 'ANSWERED', 3, '', '', 'N', '1416406056.71', NULL, 0.00, NULL, NULL, NULL),
(292, '2014-11-19 12:08:07', '"2000" <2000>', '2000', '*11', 'externo', 'SIP/2000-0000001a', '', 'AGI', 'HANGUP', 5, 5, 'ANSWERED', 3, '', '', 'N', '1416406087.72', NULL, 0.00, NULL, NULL, NULL),
(293, '2014-11-19 12:08:25', '"2039" <2039>', '2039', '2000', 'externo', 'SIP/2039-0000001b', 'SIP/2000-0000001c', 'Congestion', '3000', 12, 0, 'FAILED', 3, '', '', 'N', '1416406105.73', 'Chamada Interna', 0.00, NULL, NULL, '2039-to-2000-1416406105.73'),
(294, '2014-11-19 12:08:50', '"2000" <2000>', '2000', '2002', 'externo', 'SIP/2000-0000001d', 'SIP/2002-0000001e', 'Dial', 'SIP/2002,,rtTwWkK', 16, 0, 'NO ANSWER', 3, '', '', 'N', '1416406130.75', 'Chamada Interna', 0.00, NULL, NULL, '2000-to-2002-1416406130.75'),
(295, '2014-11-19 12:09:08', '"2000" <2000>', '2000', '2039', 'externo', 'SIP/2000-0000001f', 'SIP/2039-00000020', 'Dial', 'SIP/2039,,rtTwWkK', 3, 0, 'NO ANSWER', 3, '', '', 'N', '1416406148.77', 'Chamada Interna', 0.00, NULL, NULL, '2000-to-2039-1416406148.77'),
(296, '2014-11-19 12:14:50', '"2039" <2039>', '2039', '2002', 'externo', 'SIP/2039-00000021', 'SIP/2002-00000022', 'Dial', 'SIP/2002,,rtTwWkK', 23, 0, 'NO ANSWER', 3, '', '', 'N', '1416406490.79', 'Chamada Interna', 0.00, NULL, NULL, '2039-to-2002-1416406490.79'),
(297, '2014-11-19 12:18:29', '"2000" <2000>', '2000', '2039', 'externo', 'SIP/2000-00000023', 'SIP/2039-00000024', 'Dial', 'SIP/2039,,rtTwWkK', 5, 0, 'NO ANSWER', 3, '', '', 'N', '1416406709.81', 'Chamada Interna', 0.00, NULL, NULL, '2000-to-2039-1416406709.81'),
(298, '2014-11-19 12:35:41', '"2039" <2039>', '2039', '2000', 'externo', 'SIP/2039-00000025', 'SIP/2000-00000026', 'Dial', 'SIP/2000,,rtTwWkK', 7, 0, 'NO ANSWER', 3, '', '', 'N', '1416407741.83', 'Chamada Interna', 0.00, NULL, NULL, '2039-to-2000-1416407741.83'),
(299, '2014-11-19 12:38:09', '"2000" <2000>', '2000', '2002', 'externo', 'SIP/2000-00000027', 'SIP/2002-00000028', 'Dial', 'SIP/2002,,rtTwWkK', 2, 0, 'NO ANSWER', 3, '', '', 'N', '1416407889.85', 'Chamada Interna', 0.00, NULL, NULL, '2000-to-2002-1416407889.85'),
(300, '2014-11-19 12:38:11', '"2000" <2000>', '2000', '2002', 'externo', 'SIP/2000-00000029', 'SIP/2002-0000002a', 'Dial', 'SIP/2002,,rtTwWkK', 4, 0, 'NO ANSWER', 3, '', '', 'N', '1416407891.87', 'Chamada Interna', 0.00, NULL, NULL, '2000-to-2002-1416407891.87'),
(301, '2014-11-19 12:42:11', '"2039" <2039>', '2039', '2002', 'externo', 'SIP/2039-0000002b', 'SIP/2002-0000002c', 'Dial', 'SIP/2002,,rtTwWkK', 46, 28, 'ANSWERED', 3, '', '', 'N', '1416408131.89', 'Chamada Interna', 0.00, NULL, NULL, '2039-to-2002-1416408131.89'),
(302, '2014-11-19 13:29:46', '"CALLERID(num)" <3137692000>', '3137692000', 't', 'psa', 'IAX2/srvpbx-7723', '', 'Hangup', '', 73, 73, 'ANSWERED', 3, '', '', 'N', '1416410986.91', NULL, 0.00, NULL, NULL, NULL),
(303, '2014-11-19 17:37:38', '"CALLERID(num)" <3137692000>', '3137692000', 't', 'psa', 'IAX2/srvpbx-857', '', 'Hangup', '', 73, 73, 'ANSWERED', 3, '', '', 'N', '1416425858.92', NULL, 0.00, NULL, NULL, NULL),
(304, '2014-11-19 18:05:28', '"CALLERID(num)" <2023>', '2023', 's', 'psa', 'IAX2/srvpbx-5783', '', 'WaitExten', '2', 2, 2, 'ANSWERED', 3, '', '', 'N', '1416427528.93', NULL, 0.00, NULL, NULL, NULL),
(305, '2014-11-19 19:47:30', '"CALLERID(num)" <553139392199>', '553139392199', 't', 'psa', 'IAX2/srvpbx-1704', '', 'Hangup', '', 73, 73, 'ANSWERED', 3, '', '', 'N', '1416433650.94', NULL, 0.00, NULL, NULL, NULL),
(306, '2014-11-19 20:22:28', '"CALLERID(num)" <3137692000>', '3137692000', 't', 'psa', 'IAX2/srvpbx-4452', '', 'Playback', 'br/custom/res/opcao_invalida_res', 52, 52, 'ANSWERED', 3, '', '', 'N', '1416435748.95', NULL, 0.00, NULL, NULL, NULL),
(307, '2014-11-19 21:19:15', '"CALLERID(num)" <2079>', '2079', '3', 'vrt', 'IAX2/srvpbx-10608', '', 'Playback', 'br/custom/res/via_real_agradece_ligacao_res&br/custom/res/obrigado_res', 66, 66, 'ANSWERED', 3, '', '', 'N', '1416439155.96', NULL, 0.00, NULL, NULL, NULL),
(308, '2014-11-19 22:07:29', '"CALLERID(num)" <2051>', '2051', '2', 'vrt', 'IAX2/srvpbx-13464', '', 'Hangup', '', 46, 46, 'ANSWERED', 3, '', '', 'N', '1416442049.97', NULL, 0.00, NULL, NULL, NULL),
(309, '2014-11-20 14:45:01', '"CALLERID(num)" <2063>', '2063', '3', 'vrt', 'IAX2/srvpbx-9866', '', 'Hangup', '', 51, 51, 'ANSWERED', 3, '', '', 'N', '1416501901.98', NULL, 0.00, NULL, NULL, NULL),
(310, '2014-11-20 15:32:46', '"CALLERID(num)" <553139392199>', '553139392199', '2', 'vrt', 'IAX2/srvpbx-13943', '', 'Hangup', '', 50, 50, 'ANSWERED', 3, '', '', 'N', '1416504766.99', NULL, 0.00, NULL, NULL, NULL),
(311, '2014-11-20 16:07:45', '"CALLERID(num)" <2063>', '2063', '2', 'vrt', 'IAX2/srvpbx-15562', '', 'Hangup', '', 41, 41, 'ANSWERED', 3, '', '', 'N', '1416506865.100', NULL, 0.00, NULL, NULL, NULL),
(312, '2014-11-20 19:38:03', '"CALLERID(num)" <3137692000>', '3137692000', 't', 'psa', 'IAX2/srvpbx-601', '', 'Hangup', '', 73, 73, 'ANSWERED', 3, '', '', 'N', '1416519483.101', NULL, 0.00, NULL, NULL, NULL),
(313, '2014-11-20 20:34:23', '"CALLERID(num)" <3137692000>', '3137692000', 's', 'psa', 'IAX2/srvpbx-1767', '', 'BackGround', 'br/custom/res/avaliacao_atendente_res', 53, 53, 'ANSWERED', 3, '', '', 'N', '1416522863.102', NULL, 0.00, NULL, NULL, NULL),
(314, '2014-11-20 20:56:13', '"CALLERID(num)" <2060>', '2060', '3', 'vrt', 'IAX2/srvpbx-4208', '', 'Hangup', '', 49, 49, 'ANSWERED', 3, '', '', 'N', '1416524173.103', NULL, 0.00, NULL, NULL, NULL),
(315, '2014-11-20 22:15:01', '"CALLERID(num)" <3137692000>', '3137692000', 't', 'psa', 'IAX2/srvpbx-10874', '', 'Hangup', '', 73, 73, 'ANSWERED', 3, '', '', 'N', '1416528901.104', NULL, 0.00, NULL, NULL, NULL),
(316, '2014-11-20 22:19:43', '"CALLERID(num)" <2065>', '2065', 's', 'psa', 'IAX2/srvpbx-7969', '', 'BackGround', 'br/custom/res/avaliacao_atendente_res', 25, 25, 'ANSWERED', 3, '', '', 'N', '1416529183.106', NULL, 0.00, NULL, NULL, NULL),
(317, '2014-11-20 22:19:24', '"CALLERID(num)" <3137692000>', '3137692000', '2', 'vrt', 'IAX2/srvpbx-11652', '', 'Hangup', '', 48, 48, 'ANSWERED', 3, '', '', 'N', '1416529164.105', NULL, 0.00, NULL, NULL, NULL),
(318, '2014-11-21 16:18:39', '"CALLERID(num)" <3137692000>', '3137692000', '2', 'vrt', 'IAX2/srvpbx-15903', '', 'Hangup', '', 49, 49, 'ANSWERED', 3, '', '', 'N', '1416593919.107', NULL, 0.00, NULL, NULL, NULL),
(319, '2014-11-21 19:06:40', '"CALLERID(num)" <3137692000>', '3137692000', '5', 'vrt', 'IAX2/srvpbx-15174', '', 'Hangup', '', 51, 51, 'ANSWERED', 3, '', '', 'N', '1416604000.108', NULL, 0.00, NULL, NULL, NULL),
(320, '2014-11-21 19:27:15', '"CALLERID(num)" <3137692000>', '3137692000', 's', 'psa', 'IAX2/srvpbx-2619', '', 'BackGround', 'br/custom/res/avaliacao_atendente_res', 38, 38, 'ANSWERED', 3, '', '', 'N', '1416605235.109', NULL, 0.00, NULL, NULL, NULL),
(321, '2014-11-21 21:43:58', '"CALLERID(num)" <2079>', '2079', '3', 'vrt', 'IAX2/srvpbx-11664', '', 'Hangup', '', 49, 49, 'ANSWERED', 3, '', '', 'N', '1416613438.110', NULL, 0.00, NULL, NULL, NULL),
(322, '2014-11-21 22:35:47', '"CALLERID(num)" <3137692000>', '3137692000', '3', 'vrt', 'IAX2/srvpbx-4958', '', 'Hangup', '', 49, 49, 'ANSWERED', 3, '', '', 'N', '1416616547.111', NULL, 0.00, NULL, NULL, NULL),
(323, '2014-11-21 22:48:36', '"CALLERID(num)" <3137692000>', '3137692000', 's', 'psa', 'IAX2/srvpbx-8442', '', 'BackGround', 'br/custom/res/avaliacao_atendente_res', 15, 15, 'ANSWERED', 3, '', '', 'N', '1416617316.112', NULL, 0.00, NULL, NULL, NULL),
(324, '2014-11-22 16:23:25', '"CALLERID(num)" <3137692000>', '3137692000', 't', 'psa', 'IAX2/srvpbx-11109', '', 'Hangup', '', 73, 73, 'ANSWERED', 3, '', '', 'N', '1416680605.113', NULL, 0.00, NULL, NULL, NULL),
(325, '2014-11-22 16:35:44', '"CALLERID(num)" <3137692000>', '3137692000', 's', 'psa', 'IAX2/srvpbx-10785', '', 'BackGround', 'br/custom/res/avaliacao_atendente_res', 53, 53, 'ANSWERED', 3, '', '', 'N', '1416681344.114', NULL, 0.00, NULL, NULL, NULL),
(326, '2014-11-22 17:40:10', '"CALLERID(num)" <2064>', '2064', '4', 'vrt', 'IAX2/srvpbx-11879', '', 'Hangup', '', 70, 70, 'ANSWERED', 3, '', '', 'N', '1416685210.115', NULL, 0.00, NULL, NULL, NULL),
(327, '2014-11-26 13:30:51', '"CALLERID(num)" <2064>', '2064', '4', 'vrt', 'IAX2/srvpbx-15481', '', 'Hangup', '', 49, 49, 'ANSWERED', 3, '', '', 'N', '1417015851.116', NULL, 0.00, NULL, NULL, NULL),
(328, '2014-11-26 14:16:39', '"CALLERID(num)" <3137692000>', '3137692000', '1', 'vrt', 'IAX2/srvpbx-6611', '', 'Hangup', '', 66, 66, 'ANSWERED', 3, '', '', 'N', '1417018599.117', NULL, 0.00, NULL, NULL, NULL),
(329, '2014-11-26 18:04:49', '"CALLERID(num)" <2064>', '2064', '4', 'vrt', 'IAX2/srvpbx-189', '', 'Hangup', '', 46, 46, 'ANSWERED', 3, '', '', 'N', '1417032289.118', NULL, 0.00, NULL, NULL, NULL),
(330, '2014-11-26 18:18:42', '"CALLERID(num)" <3137692000>', '3137692000', 't', 'psa', 'IAX2/srvpbx-936', '', 'Hangup', '', 74, 74, 'ANSWERED', 3, '', '', 'N', '1417033122.119', NULL, 0.00, NULL, NULL, NULL),
(331, '2014-11-26 20:53:01', '"CALLERID(num)" <553139392199>', '553139392199', '3', 'vrt', 'IAX2/srvpbx-10567', '', 'Hangup', '', 51, 51, 'ANSWERED', 3, '', '', 'N', '1417042381.120', NULL, 0.00, NULL, NULL, NULL),
(332, '2014-11-26 21:19:33', '"CALLERID(num)" <3137692000>', '3137692000', '2', 'vrt', 'IAX2/srvpbx-755', '', 'Hangup', '', 68, 68, 'ANSWERED', 3, '', '', 'N', '1417043973.121', NULL, 0.00, NULL, NULL, NULL),
(333, '2014-11-26 22:48:05', '"CALLERID(num)" <3137692000>', '3137692000', 's', 'psa', 'IAX2/srvpbx-991', '', 'BackGround', 'br/custom/res/avaliacao_atendente_res', 34, 34, 'ANSWERED', 3, '', '', 'N', '1417049285.122', NULL, 0.00, NULL, NULL, NULL),
(334, '2014-11-26 22:51:55', '"CALLERID(num)" <2065>', '2065', '5', 'vrt', 'IAX2/srvpbx-8923', '', 'Hangup', '', 51, 51, 'ANSWERED', 3, '', '', 'N', '1417049515.123', NULL, 0.00, NULL, NULL, NULL),
(335, '2014-11-27 12:27:03', '"2039" <2039>', '2039', '2002', 'externo', 'SIP/2039-0000002d', '', 'Congestion', '3000', 0, 0, 'FAILED', 3, '', '', 'N', '1417098423.124', 'D0', 0.00, NULL, NULL, '2039-to-2002-1417098423.124'),
(336, '2014-11-27 12:29:20', '"2039" <2039>', '2039', '2035', 'externo', 'SIP/2039-0000002e', 'SIP/2035-0000002f', 'Dial', 'SIP/2035,,rtTwWkK', 80, 75, 'ANSWERED', 3, '', '', 'N', '1417098560.125', 'D0', 0.00, NULL, NULL, '2039-to-2035-1417098560.125'),
(337, '2014-11-27 12:31:29', '"2039" <2039>', '2039', '2035', 'externo', 'SIP/2039-00000030', 'SIP/2035-00000031', 'Dial', 'SIP/2035,,rtTwWkK', 16, 13, 'ANSWERED', 3, '', '', 'N', '1417098689.127', 'D0', 0.00, NULL, NULL, '2039-to-2035-1417098689.127'),
(338, '2014-11-27 12:33:38', '"2039" <2039>', '2039', '2035', 'externo', 'SIP/2039-00000032', 'SIP/2035-00000033', 'Dial', 'SIP/2035,,rtTwWkK', 14, 8, 'ANSWERED', 3, '', '', 'N', '1417098818.129', 'D0', 0.00, NULL, NULL, '2039-to-2035-1417098818.129'),
(339, '2014-11-27 12:38:44', '"2039" <2039>', '2039', '2035', 'externo', 'SIP/2039-00000034', 'SIP/2035-00000035', 'Dial', 'SIP/2035,,rtTwWkK', 14, 11, 'ANSWERED', 3, '', '', 'N', '1417099124.131', 'D0', 0.00, NULL, NULL, '2039-to-2035-1417099124.131'),
(340, '2014-11-27 12:46:12', '"2039" <2039>', '2039', '2035', 'externo', 'SIP/2039-00000036', 'SIP/2035-00000037', 'Dial', 'SIP/2035,,rtTwWkK', 48, 44, 'ANSWERED', 3, '', '', 'N', '1417099572.133', 'D0', 0.00, NULL, NULL, '2039-to-2035-1417099572.133'),
(341, '2014-11-27 12:55:08', '"2039" <2039>', '2039', '2035', 'externo', 'SIP/2039-00000038', 'SIP/2035-00000039', 'Dial', 'SIP/2035,,rtTwWkK', 12, 8, 'ANSWERED', 3, '', '', 'N', '1417100108.135', 'D0', 0.00, NULL, NULL, '2039-to-2035-1417100108.135'),
(342, '2014-11-27 12:55:38', '"2039" <2039>', '2039', '*11', 'externo', 'SIP/2039-0000003a', '', 'AGI', 'HANGUP', 6, 5, 'ANSWERED', 3, '', '', 'N', '1417100138.137', NULL, 0.00, NULL, NULL, NULL),
(343, '2014-11-27 12:59:34', '"2039" <2039>', '2039', '2035', 'externo', 'SIP/2039-0000003b', 'SIP/2035-0000003c', 'Dial', 'SIP/2035,,rtTwWkK', 10, 6, 'ANSWERED', 3, '', '', 'N', '1417100374.138', 'D0', 0.00, NULL, NULL, '2039-to-2035-1417100374.138'),
(344, '2014-11-27 13:00:13', '"2039" <2039>', '2039', '2035', 'externo', 'SIP/2039-0000003d', 'SIP/2035-0000003e', 'Dial', 'SIP/2035,,rtTwWkK', 7, 4, 'ANSWERED', 3, '', '', 'N', '1417100413.140', 'D0', 0.00, NULL, NULL, '2039-to-2035-1417100413.140'),
(345, '2014-11-27 13:02:26', '"2039" <2039>', '2039', '2035', 'externo', 'SIP/2039-0000003f', 'SIP/2035-00000040', 'Dial', 'SIP/2035,,rtTwWkK', 9, 6, 'ANSWERED', 3, '', '', 'N', '1417100546.142', 'D0', 0.00, NULL, NULL, '2039-to-2035-1417100546.142'),
(346, '2014-11-27 13:28:10', '"2039" <2039>', '2039', '2035', 'externo', 'SIP/2039-00000041', 'SIP/2035-00000042', 'Dial', 'SIP/2035,,rtTwWkK', 9, 6, 'ANSWERED', 3, '', '', 'N', '1417102090.144', 'D0', 0.00, NULL, NULL, '2039-to-2035-1417102090.144'),
(347, '2014-11-27 14:49:08', '"2039" <2039>', '2039', '2035', 'externo', 'SIP/2039-00000043', 'SIP/2035-00000044', 'Dial', 'SIP/2035,,rtTwWkK', 42, 38, 'ANSWERED', 3, '', '', 'N', '1417106948.146', 'D0', 0.00, NULL, NULL, '2039-to-2035-1417106948.146'),
(348, '2014-11-27 14:50:45', '"2039" <2039>', '2039', '2035', 'externo', 'SIP/2039-00000045', 'SIP/2035-00000046', 'Dial', 'SIP/2035,,rtTwWkK', 47, 43, 'ANSWERED', 3, '', '', 'N', '1417107045.148', 'D0', 0.00, NULL, NULL, '2039-to-2035-1417107045.148'),
(349, '2014-11-27 15:12:17', '"2039" <2039>', '2039', '2035', 'externo', 'SIP/2039-00000047', 'SIP/2035-00000048', 'Dial', 'SIP/2035,,rtTwWkK', 41, 37, 'ANSWERED', 3, '', '', 'N', '1417108337.150', 'D0', 0.00, NULL, NULL, '2039-to-2035-1417108337.150'),
(350, '2014-11-27 15:16:17', '"2039" <2039>', '2039', '2035', 'externo', 'SIP/2039-00000049', 'SIP/2035-0000004a', 'Dial', 'SIP/2035,,rtTwWkK', 53, 38, 'ANSWERED', 3, '', '', 'N', '1417108577.152', 'D0', 0.00, NULL, NULL, '2039-to-2035-1417108577.152'),
(351, '2014-11-27 15:19:02', '"2039" <2039>', '2039', '2035', 'externo', 'SIP/2039-0000004b', 'SIP/2035-0000004c', 'Dial', 'SIP/2035,,rtTwWkK', 71, 56, 'ANSWERED', 3, '', '', 'N', '1417108742.154', 'D0', 0.00, NULL, NULL, '2039-to-2035-1417108742.154'),
(352, '2014-11-27 15:25:50', '"2039" <2039>', '2039', '2035', 'externo', 'SIP/2039-0000004d', 'SIP/2035-0000004e', 'Dial', 'SIP/2035,,rtTwWkK', 60, 52, 'ANSWERED', 3, '', '', 'N', '1417109150.156', 'D0', 0.00, NULL, NULL, '2039-to-2035-1417109150.156'),
(353, '2014-11-27 15:27:47', '"CALLERID(num)" <3137692000>', '3137692000', 't', 'psa', 'IAX2/srvpbx-9445', '', 'Hangup', '', 73, 73, 'ANSWERED', 3, '', '', 'N', '1417109267.158', NULL, 0.00, NULL, NULL, NULL),
(354, '2014-11-27 15:28:57', '"2039" <2039>', '2039', '2035', 'externo', 'SIP/2039-0000004f', 'SIP/2035-00000050', 'Dial', 'SIP/2035,,rtTwWkK', 100, 97, 'ANSWERED', 3, '', '', 'N', '1417109337.159', 'D0', 15.00, NULL, NULL, '2039-to-2035-1417109337.159'),
(355, '2014-11-27 15:37:35', '"2039" <2039>', '2039', '2035', 'externo', 'SIP/2039-00000051', 'SIP/2035-00000052', 'Dial', 'SIP/2035,,rtTwWkK', 38, 35, 'ANSWERED', 3, '', '', 'N', '1417109855.161', 'D0', 0.00, NULL, NULL, '2039-to-2035-1417109855.161'),
(356, '2014-11-27 15:42:18', '"2039" <2039>', '2039', '2035', 'externo', 'SIP/2039-00000053', 'SIP/2035-00000054', 'Dial', 'SIP/2035,,rtTwWkK', 79, 76, 'ANSWERED', 3, '', '', 'N', '1417110138.163', 'D0', 0.00, NULL, NULL, '2039-to-2035-1417110138.163'),
(357, '2014-11-27 15:48:20', '"2039" <2039>', '2039', '2035', 'externo', 'SIP/2039-00000055', 'SIP/2035-00000056', 'Dial', 'SIP/2035,,rtTwWkK', 90, 85, 'ANSWERED', 3, '', '', 'N', '1417110500.165', 'D0', 0.00, NULL, NULL, '2039-to-2035-1417110500.165'),
(358, '2014-11-27 15:55:14', '"2039" <2039>', '2039', '2035', 'externo', 'SIP/2039-00000057', 'SIP/2035-00000058', 'Dial', 'SIP/2035,,rtTwWkK', 84, 73, 'ANSWERED', 3, '', '', 'N', '1417110914.167', 'D0', 0.00, NULL, NULL, '2039-to-2035-1417110914.167'),
(359, '2014-11-27 15:59:27', '"2039" <2039>', '2039', '2035', 'externo', 'SIP/2039-00000059', 'SIP/2035-0000005a', 'Dial', 'SIP/2035,,rtTwWkK', 44, 41, 'ANSWERED', 3, '', '', 'N', '1417111167.169', 'D0', 0.00, NULL, NULL, '2039-to-2035-1417111167.169'),
(360, '2014-11-27 16:12:33', '"2039" <2039>', '2039', '2035', 'externo', 'SIP/2039-0000005b', 'SIP/2035-0000005c', 'Dial', 'SIP/2035,,rtTwWkK', 52, 46, 'ANSWERED', 3, '', '', 'N', '1417111953.171', 'D0', 0.00, NULL, NULL, '2039-to-2035-1417111953.171'),
(361, '2014-11-27 16:19:20', '"2039" <2039>', '2039', '2035', 'externo', 'SIP/2039-0000005d', 'SIP/2035-0000005e', 'Dial', 'SIP/2035,,rtTwWkK', 42, 39, 'ANSWERED', 3, '', '', 'N', '1417112360.173', 'D0', 0.00, NULL, NULL, '2039-to-2035-1417112360.173'),
(362, '2014-11-27 16:23:14', '"2039" <2039>', '2039', '2035', 'externo', 'SIP/2039-0000005f', 'SIP/2035-00000060', 'Dial', 'SIP/2035,,rtTwWkK', 45, 42, 'ANSWERED', 3, '', '', 'N', '1417112594.175', 'D0', 0.00, NULL, NULL, '2039-to-2035-1417112594.175'),
(363, '2014-11-27 16:32:29', '"2039" <2039>', '2039', '2035', 'externo', 'SIP/2039-00000061', 'SIP/2035-00000062', 'Dial', 'SIP/2035,,rtTwWkK', 162, 158, 'ANSWERED', 3, '', '', 'N', '1417113149.177', 'D0', 0.00, NULL, NULL, '2039-to-2035-1417113149.177'),
(364, '2014-11-27 16:40:27', '"2039" <2039>', '2039', '2035', 'externo', 'SIP/2039-00000063', 'SIP/2035-00000064', 'Dial', 'SIP/2035,,rtTwWkK', 45, 42, 'ANSWERED', 3, '', '', 'N', '1417113627.179', 'D0', 0.00, NULL, NULL, '2039-to-2035-1417113627.179'),
(365, '2014-11-27 16:43:14', '"2039" <2039>', '2039', '2035', 'externo', 'SIP/2039-00000065', 'SIP/2035-00000066', 'Dial', 'SIP/2035,,rtTwWkK', 46, 43, 'ANSWERED', 3, '', '', 'N', '1417113794.181', 'D0', 0.00, NULL, NULL, '2039-to-2035-1417113794.181'),
(366, '2014-11-27 16:48:44', '"2039" <2039>', '2039', '2035', 'externo', 'SIP/2039-00000067', 'SIP/2035-00000068', 'Dial', 'SIP/2035,,rtTwWkK', 124, 119, 'ANSWERED', 3, '', '', 'N', '1417114124.183', 'D0', 0.00, NULL, NULL, '2039-to-2035-1417114124.183'),
(367, '2014-11-27 17:55:25', '"2039" <2039>', '2039', '2035', 'externo', 'SIP/2039-00000069', 'SIP/2035-0000006a', 'Dial', 'SIP/2035,,rtTwWkK', 101, 98, 'ANSWERED', 3, '', '', 'N', '1417118125.185', 'D0', 0.00, NULL, NULL, '2039-to-2035-1417118125.185'),
(368, '2014-11-27 18:00:42', '"2039" <2039>', '2039', '2035', 'externo', 'SIP/2039-0000006b', 'SIP/2035-0000006c', 'Dial', 'SIP/2035,,rtTwWkK', 5, 0, 'NO ANSWER', 3, '', '', 'N', '1417118442.187', 'D0', 0.00, NULL, NULL, '2039-to-2035-1417118442.187'),
(369, '2014-11-27 18:00:56', '"2039" <2039>', '2039', '2035', 'externo', 'SIP/2039-0000006d', 'SIP/2035-0000006e', 'Dial', 'SIP/2035,,rtTwWkK', 45, 42, 'ANSWERED', 3, '', '', 'N', '1417118456.189', 'D0', 0.08, NULL, NULL, '2039-to-2035-1417118456.189'),
(370, '2014-11-27 18:46:32', '"CALLERID(num)" <3137692000>', '3137692000', 't', 'psa', 'IAX2/srvpbx-2749', '', 'Hangup', '', 74, 74, 'ANSWERED', 3, '', '', 'N', '1417121192.191', NULL, 0.00, NULL, NULL, NULL),
(371, '2014-11-27 19:02:50', '"CALLERID(num)" <2078>', '2078', '2', 'vrt', 'IAX2/srvpbx-2481', '', 'Hangup', '', 46, 46, 'ANSWERED', 3, '', '', 'N', '1417122170.192', NULL, 0.00, NULL, NULL, NULL),
(372, '2014-11-28 12:04:43', '"2039" <2039>', '2039', '2001', 'externo', 'SIP/2039-0000006f', 'SIP/2001-00000070', 'Dial', 'SIP/2001,,rtTwWkK', 50, 47, 'ANSWERED', 3, '', '', 'N', '1417183483.193', 'D0', 0.00, NULL, NULL, '2039-to-2001-1417183483.193'),
(373, '2014-11-28 12:08:35', '"2039" <2039>', '2039', '2001', 'externo', 'SIP/2039-00000071', 'SIP/2001-00000072', 'Dial', 'SIP/2001,,rtTwWkK', 62, 58, 'ANSWERED', 3, '', '', 'N', '1417183715.195', 'D0', 0.00, NULL, NULL, '2039-to-2001-1417183715.195'),
(374, '2014-11-28 12:12:44', '"2039" <2039>', '2039', '2001', 'externo', 'SIP/2039-00000073', 'SIP/2001-00000074', 'Dial', 'SIP/2001,,rtTwWkK', 53, 43, 'ANSWERED', 3, '', '', 'N', '1417183964.197', 'D0', 0.00, NULL, NULL, '2039-to-2001-1417183964.197'),
(375, '2014-11-28 12:26:00', '"2039" <2039>', '2039', '2001', 'externo', 'SIP/2039-00000075', 'SIP/2001-00000076', 'Dial', 'SIP/2001,,rtTwWkK', 38, 36, 'ANSWERED', 3, '', '', 'N', '1417184760.199', 'D0', 0.00, NULL, NULL, '2039-to-2001-1417184760.199'),
(376, '2014-11-28 12:36:27', '"2039" <2039>', '2039', '2001', 'externo', 'SIP/2039-00000077', 'SIP/2001-00000078', 'Dial', 'SIP/2001,,rtTwWkK', 39, 36, 'ANSWERED', 3, '', '', 'N', '1417185387.201', 'D0', 0.00, NULL, NULL, '2039-to-2001-1417185387.201'),
(377, '2014-11-28 12:41:12', '"2039" <2039>', '2039', '2038', 'externo', 'SIP/2039-00000079', 'SIP/2038-0000007a', 'Dial', 'SIP/2038,,rtTwWkK', 40, 35, 'ANSWERED', 3, '', '', 'N', '1417185672.203', 'D0', 0.00, NULL, NULL, '2039-to-2038-1417185672.203'),
(378, '2014-11-28 12:42:37', '"2039" <2039>', '2039', '2038', 'externo', 'SIP/2039-0000007b', 'SIP/2038-0000007c', 'Dial', 'SIP/2038,,rtTwWkK', 72, 69, 'ANSWERED', 3, '', '', 'N', '1417185757.205', 'D0', 0.00, NULL, NULL, '2039-to-2038-1417185757.205'),
(379, '2014-11-28 12:44:39', '"2039" <2039>', '2039', '2038', 'externo', 'SIP/2039-0000007d', 'SIP/2038-0000007e', 'Dial', 'SIP/2038,,rtTwWkK', 37, 33, 'ANSWERED', 3, '', '', 'N', '1417185879.207', 'D0', 0.06, NULL, NULL, '2039-to-2038-1417185879.207'),
(380, '2014-11-28 19:28:07', '"CALLERID(num)" <2079>', '2079', '5', 'vrt', 'IAX2/srvpbx-8693', '', 'Hangup', '', 46, 46, 'ANSWERED', 3, '', '', 'N', '1417210087.209', NULL, 0.00, NULL, NULL, NULL),
(381, '2014-11-28 19:35:28', '"CALLERID(num)" <3137692000>', '3137692000', 't', 'psa', 'IAX2/srvpbx-3972', '', 'Hangup', '', 73, 73, 'ANSWERED', 3, '', '', 'N', '1417210528.210', NULL, 0.00, NULL, NULL, NULL),
(385, '2014-12-01 08:29:21', '"2039" <2039>', '2039', '2035', 'externo', 'SIP/2039-00000083', 'SIP/2035-00000084', 'Dial', 'SIP/2035,,rtTwWkK', 19, 15, 'ANSWERED', 3, '', '', 'N', '1417429761.216', 'D0', 0.00, NULL, NULL, '2039-to-2035-1417429761.216'),
(386, '2014-12-01 08:29:58', '"2039" <2039>', '2039', '2038', 'externo', 'SIP/2039-00000085', 'SIP/2038-00000086', 'Dial', 'SIP/2038,,rtTwWkK', 127, 123, 'ANSWERED', 3, '', '', 'N', '1417429798.218', 'D0', 0.24, NULL, NULL, '2039-to-2038-1417429798.218'),
(388, '2014-12-01 08:44:40', '"2039" <2039>', '2039', '2038', 'externo', 'SIP/2039-00000089', 'SIP/2038-0000008a', 'Dial', 'SIP/2038,,rtTwWkK', 49, 45, 'ANSWERED', 3, '', '', 'N', '1417430680.222', 'D0', 0.00, NULL, NULL, '2039-to-2038-1417430680.222'),
(389, '2014-12-01 08:49:53', '"2039" <2039>', '2039', '2038', 'externo', 'SIP/2039-0000008b', 'SIP/2038-0000008c', 'Dial', 'SIP/2038,,rtTwWkK', 41, 37, 'ANSWERED', 3, '', '', 'N', '1417430993.224', 'D0', 0.00, NULL, NULL, '2039-to-2038-1417430993.224'),
(390, '2014-12-01 09:18:36', '"2039" <2039>', '2039', '2038', 'externo', 'SIP/2039-0000008d', 'SIP/2038-0000008e', 'Dial', 'SIP/2038,,rtTwWkK', 39, 34, 'ANSWERED', 3, '', '', 'N', '1417432716.226', 'D0', 0.00, NULL, NULL, '2039-to-2038-1417432716.226'),
(391, '2014-12-01 16:06:41', '"CALLERID(num)" <2050>', '2050', '3', 'vrt', 'IAX2/srvpbx-13745', '', 'Hangup', '', 49, 49, 'ANSWERED', 3, '', '', 'N', '1417457201.228', NULL, 0.00, NULL, NULL, NULL),
(392, '2014-12-02 19:36:31', '"CALLERID(num)" <3137692000>', '3137692000', 's', 'psa', 'IAX2/srvpbx-4548', '', 'BackGround', 'br/custom/res/avaliacao_atendente_res', 8, 8, 'ANSWERED', 3, '', '', 'N', '1417556191.229', NULL, 0.00, NULL, NULL, NULL),
(393, '2014-12-02 19:36:50', '"CALLERID(num)" <3137692000>', '3137692000', '3', 'vrt', 'IAX2/srvpbx-2196', '', 'Hangup', '', 51, 51, 'ANSWERED', 3, '', '', 'N', '1417556210.230', NULL, 0.00, NULL, NULL, NULL),
(394, '2014-12-03 17:25:38', '"2035" <2035>', '2035', '39392039', 'externo', 'SIP/2035-0000008f', '', 'Hangup', '', 1, 0, 'FAILED', 3, '', '', 'N', '1417634738.231', 'FIXO-LOCAL-OI', 0.00, NULL, NULL, NULL),
(395, '2014-12-03 18:36:55', '"CALLERID(num)" <2005>', '2005', '99', 'externo', 'IAX2/srvpbx-12906', '', 'Read', 'AGID,br/agent-user,4,2,0', 2, 2, 'ANSWERED', 3, '', '', 'N', '1417639015.232', NULL, 0.00, NULL, NULL, NULL),
(396, '2014-12-04 08:53:16', '"2039" <2039>', '2039', '2038', 'externo', 'SIP/2039-00000090', '', 'Congestion', '3000', 0, 0, 'FAILED', 3, '', '', 'N', '1417690396.233', 'D0', 0.00, NULL, NULL, '2039-to-2038-1417690396.233'),
(397, '2014-12-04 08:57:30', '"2039" <2039>', '2039', '2038', 'externo', 'SIP/2039-00000091', 'SIP/2038-00000092', 'Dial', 'SIP/2038,,rtTwWkK', 110, 107, 'ANSWERED', 3, '', '', 'N', '1417690650.234', 'D0', 0.00, NULL, NULL, '2039-to-2038-1417690650.234'),
(398, '2014-12-04 08:59:27', '"2035" <2035>', '2035', '2038', 'externo', 'SIP/2035-00000093', 'SIP/2038-00000094', 'Dial', 'SIP/2038,,rtTwWkK', 30, 28, 'ANSWERED', 3, '', '', 'N', '1417690767.236', 'D0', 0.00, NULL, NULL, '2035-to-2038-1417690767.236'),
(399, '2014-12-04 08:59:59', '"2035" <2035>', '2035', '2038', 'externo', 'SIP/2035-00000095', 'SIP/2038-00000096', 'Dial', 'SIP/2038,,rtTwWkK', 23, 20, 'ANSWERED', 3, '', '', 'N', '1417690799.238', 'D0', 0.00, NULL, NULL, '2035-to-2038-1417690799.238'),
(400, '2014-12-04 09:01:08', '"2035" <2035>', '2035', '2039', 'externo', 'SIP/2035-00000097', 'SIP/2039-00000098', 'Dial', 'SIP/2039,,rtTwWkK', 17, 12, 'ANSWERED', 3, '', '', 'N', '1417690868.240', 'D0', 0.00, NULL, NULL, '2035-to-2039-1417690868.240'),
(401, '2014-12-04 09:07:09', '"2035" <2035>', '2035', '2038', 'externo', 'SIP/2035-00000099', 'SIP/2038-0000009a', 'Dial', 'SIP/2038,,rtTwWkK', 29, 25, 'ANSWERED', 3, '', '', 'N', '1417691229.242', 'D0', 0.00, NULL, NULL, '2035-to-2038-1417691229.242'),
(402, '2014-12-04 09:16:19', '"2035" <2035>', '2035', '2038', 'externo', 'SIP/2035-0000009b', 'SIP/2038-0000009c', 'Dial', 'SIP/2038,,rtTwWkK', 20, 17, 'ANSWERED', 3, '', '', 'N', '1417691779.244', 'D0', 0.00, NULL, NULL, '2035-to-2038-1417691779.244'),
(403, '2014-12-04 09:16:46', '"2035" <2035>', '2035', '2039', 'externo', 'SIP/2035-0000009d', 'SIP/2039-0000009e', 'Dial', 'SIP/2039,,rtTwWkK', 13, 12, 'ANSWERED', 3, '', '', 'N', '1417691806.246', 'D0', 0.00, NULL, NULL, '2035-to-2039-1417691806.246'),
(404, '2014-12-04 09:40:58', '"2106" <2106>', '2106', '2038', 'externo', 'SIP/2106-0000009f', 'SIP/2038-000000a0', 'Dial', 'SIP/2038,,rtTwWkK', 58, 54, 'ANSWERED', 3, '', '', 'N', '1417693258.248', 'D0', 0.00, NULL, NULL, '2106-to-2038-1417693258.248'),
(405, '2014-12-04 09:52:19', '"2038" <2038>', '2038', '2035', 'externo', 'SIP/2038-000000a1', 'SIP/2035-000000a2', 'Dial', 'SIP/2035,,rtTwWkK', 88, 86, 'ANSWERED', 3, '', '', 'N', '1417693939.250', 'D0', 0.00, NULL, NULL, '2038-to-2035-1417693939.250'),
(406, '2014-12-04 15:16:40', '"2030" <2030>', '2030', '2038', 'externo', 'SIP/2030-000000a3', '', 'Congestion', '3000', 0, 0, 'FAILED', 3, '', '', 'N', '1417713400.252', 'D0', 0.00, NULL, NULL, '2030-to-2038-1417713400.252'),
(407, '2014-12-04 15:16:57', '"2030" <2030>', '2030', '2038', 'externo', 'SIP/2030-000000a4', '', 'Congestion', '3000', 0, 0, 'FAILED', 3, '', '', 'N', '1417713417.253', 'D0', 0.00, NULL, NULL, '2030-to-2038-1417713417.253'),
(408, '2014-12-04 15:18:03', '"2038" <2038>', '2038', '2030', 'externo', 'SIP/2038-000000a5', 'SIP/2030-000000a6', 'Dial', 'SIP/2030,,rtTwWkK', 23, 20, 'ANSWERED', 3, '', '', 'N', '1417713483.254', 'D0', 0.00, NULL, NULL, '2038-to-2030-1417713483.254'),
(409, '2014-12-04 15:19:17', '"2030" <2030>', '2030', '2038', 'externo', 'SIP/2030-000000a7', 'SIP/2038-000000a8', 'Dial', 'SIP/2038,,rtTwWkK', 27, 22, 'ANSWERED', 3, '', '', 'N', '1417713557.256', 'D0', 0.00, NULL, NULL, '2030-to-2038-1417713557.256'),
(410, '2014-12-04 15:23:59', '"2030" <2030>', '2030', '2038', 'externo', 'SIP/2030-000000a9', 'SIP/2038-000000aa', 'Dial', 'SIP/2038,,rtTwWkK', 16, 12, 'ANSWERED', 3, '', '', 'N', '1417713839.258', 'D0', 0.00, NULL, NULL, '2030-to-2038-1417713839.258'),
(411, '2014-12-04 15:26:10', '"2030" <2030>', '2030', '2038', 'externo', 'SIP/2030-000000ab', 'SIP/2038-000000ac', 'Dial', 'SIP/2038,,rtTwWkK', 58, 53, 'ANSWERED', 3, '', '', 'N', '1417713970.260', 'D0', 0.00, NULL, NULL, '2030-to-2038-1417713970.260'),
(412, '2014-12-05 09:15:19', '"2035" <2035>', '2035', '2035', 'externo', 'SIP/2035-000000ad', 'SIP/2035-000000ae', 'Congestion', '3000', 0, 0, 'FAILED', 3, '', '', 'N', '1417778119.262', 'D0', 0.00, NULL, NULL, '2035-to-2035-1417778119.262'),
(413, '2014-12-05 09:15:25', '"2035" <2035>', '2035', '2038', 'externo', 'SIP/2035-000000af', 'SIP/2038-000000b0', 'Dial', 'SIP/2038,,rtTwWkK', 116, 112, 'ANSWERED', 3, '', '', 'N', '1417778125.264', 'D0', 0.00, NULL, NULL, '2035-to-2038-1417778125.264'),
(414, '2014-12-05 09:23:00', '"2020" <2020>', '2020', '2038', 'externo', 'SIP/2020-000000b1', 'SIP/2038-000000b2', 'Dial', 'SIP/2038,,rtTwWkK', 49, 46, 'ANSWERED', 3, '', '', 'N', '1417778580.266', 'D0', 0.00, NULL, NULL, '2020-to-2038-1417778580.266'),
(415, '2014-12-05 09:23:55', '"2038" <2038>', '2038', '2020', 'externo', 'SIP/2038-000000b3', 'SIP/2020-000000b4', 'Dial', 'SIP/2020,,rtTwWkK', 44, 38, 'ANSWERED', 3, '', '', 'N', '1417778635.268', 'D0', 0.00, NULL, NULL, '2038-to-2020-1417778635.268'),
(416, '2014-12-05 09:24:55', '"2038" <2038>', '2038', '2020', 'externo', 'SIP/2038-000000b5', 'SIP/2020-000000b6', 'Dial', 'SIP/2020,,rtTwWkK', 22, 20, 'ANSWERED', 3, '', '', 'N', '1417778695.270', 'D0', 0.00, NULL, NULL, '2038-to-2020-1417778695.270'),
(417, '2014-12-05 09:25:56', '"2038" <2038>', '2038', '2020', 'externo', 'SIP/2038-000000b7', 'SIP/2020-000000b8', 'Dial', 'SIP/2020,,rtTwWkK', 97, 94, 'ANSWERED', 3, '', '', 'N', '1417778756.272', 'D0', 0.00, NULL, NULL, '2038-to-2020-1417778756.272'),
(418, '2014-12-05 09:30:29', '"2035" <2035>', '2035', '2038', 'externo', 'SIP/2035-000000b9', 'SIP/2038-000000ba', 'Dial', 'SIP/2038,,rtTwWkK', 43, 39, 'ANSWERED', 3, '', '', 'N', '1417779029.274', 'D0', 0.00, NULL, NULL, '2035-to-2038-1417779029.274'),
(419, '2014-12-05 09:31:42', '"2035" <2035>', '2035', '2038', 'externo', 'SIP/2035-000000bb', 'SIP/2038-000000bc', 'Dial', 'SIP/2038,,rtTwWkK', 21, 15, 'ANSWERED', 3, '', '', 'N', '1417779102.276', 'D0', 0.00, NULL, NULL, '2035-to-2038-1417779102.276'),
(420, '2014-12-05 09:32:13', '"2035" <2035>', '2035', '2038', 'externo', 'SIP/2035-000000bd', 'SIP/2038-000000be', 'Dial', 'SIP/2038,,rtTwWkK', 43, 41, 'ANSWERED', 3, '', '', 'N', '1417779133.278', 'D0', 0.00, NULL, NULL, '2035-to-2038-1417779133.278'),
(421, '2014-12-05 09:35:06', '"2035" <2035>', '2035', '2038', 'externo', 'SIP/2035-000000bf', 'SIP/2038-000000c0', 'Dial', 'SIP/2038,,rtTwWkK', 98, 94, 'ANSWERED', 3, '', '', 'N', '1417779306.280', 'D0', 0.00, NULL, NULL, '2035-to-2038-1417779306.280'),
(422, '2014-12-05 14:14:39', '"2101" <2101>', '2101', '2035', 'externo', 'SIP/2101-000000c1', 'SIP/2035-000000c2', 'Dial', 'SIP/2035,,rtTwWkK', 27, 24, 'ANSWERED', 3, '', '', 'N', '1417796079.282', 'D0', 0.00, NULL, NULL, '2101-to-2035-1417796079.282'),
(423, '2014-12-05 14:15:55', '"2101" <2101>', '2101', '2035', 'externo', 'SIP/2101-000000c3', 'SIP/2035-000000c4', 'Dial', 'SIP/2035,,rtTwWkK', 46, 41, 'ANSWERED', 3, '', '', 'N', '1417796155.284', 'D0', 0.00, NULL, NULL, '2101-to-2035-1417796155.284'),
(424, '2014-12-05 14:22:03', '"2101" <2101>', '2101', '2002', 'externo', 'SIP/2101-000000c5', 'SIP/2002-000000c6', 'Dial', 'SIP/2002,,rtTwWkK', 21, 17, 'ANSWERED', 3, '', '', 'N', '1417796523.286', 'D0', 0.00, NULL, NULL, '2101-to-2002-1417796523.286'),
(425, '2014-12-08 09:24:07', '"CALLERID(num)" <3137692000>', '3137692000', '5', 'vrt', 'IAX2/srvpbx-3723', '', 'Hangup', '', 72, 72, 'ANSWERED', 3, '', '', 'N', '1418037847.288', NULL, 0.00, NULL, NULL, NULL),
(426, '2014-12-08 16:16:01', '"CALLERID(num)" <2065>', '2065', '99', 'externo', 'IAX2/srvpbx-9126', '', 'Read', 'AGID,br/agent-user,4,2,0', 5, 5, 'ANSWERED', 3, '', '', 'N', '1418062561.289', NULL, 0.00, NULL, NULL, NULL),
(427, '2014-12-11 08:41:00', '"CALLERID(num)" <2051>', '2051', 's', 'psa', 'IAX2/srvpbx-5087', '', 'WaitExten', '2', 2, 2, 'ANSWERED', 3, '', '', 'N', '1418294460.290', NULL, 0.00, NULL, NULL, NULL),
(428, '2014-12-11 15:48:18', '"2101" <2101>', '2101', '2002', 'externo', 'SIP/2101-000000c7', 'SIP/2002-000000c8', 'Dial', 'SIP/2002,,rtTwWkK', 13, 8, 'ANSWERED', 3, '', '', 'N', '1418320098.291', 'D0', 0.00, NULL, NULL, '2101-to-2002-1418320098.291'),
(429, '2014-12-11 15:49:44', '"2101" <2101>', '2101', '2002', 'externo', 'SIP/2101-000000c9', 'SIP/2002-000000ca', 'Dial', 'SIP/2002,,rtTwWkK', 10, 6, 'ANSWERED', 3, '', '', 'N', '1418320184.293', 'D0', 0.00, NULL, NULL, '2101-to-2002-1418320184.293'),
(430, '2014-12-11 15:50:22', '"2101" <2101>', '2101', '2002', 'externo', 'SIP/2101-000000cb', 'SIP/2002-000000cc', 'Dial', 'SIP/2002,,rtTwWkK', 36, 30, 'ANSWERED', 3, '', '', 'N', '1418320222.295', 'D0', 0.00, NULL, NULL, '2101-to-2002-1418320222.295'),
(431, '2014-12-11 16:05:34', '"2039" <2039>', '2039', '2046', 'externo', 'SIP/2039-000000cd', '', 'Congestion', '3000', 0, 0, 'FAILED', 3, '', '', 'N', '1418321134.297', 'D0', 0.00, NULL, NULL, '2039-to-2046-1418321134.297'),
(432, '2014-12-11 16:30:07', '"2110" <2110>', '2110', '2001', 'externo', 'SIP/2110-000000ce', '', 'Congestion', '3000', 0, 0, 'FAILED', 3, '', '', 'N', '1418322607.298', 'D0', 0.00, NULL, NULL, '2110-to-2001-1418322607.298'),
(433, '2014-12-11 16:38:13', '"2110" <2110>', '2110', '*11', 'externo', 'SIP/2110-000000cf', '', 'AGI', 'HANGUP', 5, 5, 'ANSWERED', 3, '', '', 'N', '1418323093.299', NULL, 0.00, NULL, NULL, NULL),
(434, '2014-12-11 17:08:24', '"2101" <2101>', '2101', '2035', 'externo', 'SIP/2101-000000d0', 'SIP/2035-000000d1', 'Dial', 'SIP/2035,,rtTwWkK', 12, 7, 'ANSWERED', 3, '', '', 'N', '1418324904.300', 'D0', 0.00, NULL, NULL, '2101-to-2035-1418324904.300'),
(435, '2014-12-11 17:11:38', '"2035" <2035>', '2035', '2110', 'externo', 'SIP/2035-000000d2', 'SIP/2110-000000d3', 'Dial', 'SIP/2110,,rtTwWkK', 26, 23, 'ANSWERED', 3, '', '', 'N', '1418325098.302', 'D0', 0.00, NULL, NULL, '2035-to-2110-1418325098.302'),
(436, '2014-12-15 09:32:26', '"2035" <2035>', '2035', '2110', 'externo', 'SIP/2035-00000000', 'SIP/2110-00000001', 'Dial', 'SIP/2110,,rtTwWkK', 16, 14, 'ANSWERED', 3, '', '', 'N', '1418643146.0', 'D0', 0.00, NULL, NULL, '2035-to-2110-1418643146.0'),
(437, '2014-12-15 09:32:59', '"2110" <2110>', '2110', '2035', 'externo', 'SIP/2110-00000002', 'SIP/2035-00000003', 'Dial', 'SIP/2035,,rtTwWkK', 12, 7, 'ANSWERED', 3, '', '', 'N', '1418643179.2', 'D0', 0.00, NULL, NULL, '2110-to-2035-1418643179.2'),
(438, '2014-12-15 09:34:16', '"2110" <2110>', '2110', '*11', 'externo', 'SIP/2110-00000004', '', 'AGI', 'HANGUP', 5, 4, 'ANSWERED', 3, '', '', 'N', '1418643256.4', NULL, 0.00, NULL, NULL, NULL),
(439, '2014-12-15 15:26:01', '"2110" <2110>', '2110', '39393725', 'externo', 'SIP/2110-00000005', '', 'Hangup', '', 1, 0, 'FAILED', 3, '', '', 'N', '1418664361.5', 'FIXO-LOCAL-OI', 0.00, NULL, NULL, NULL),
(440, '2014-12-15 15:33:55', '"2110" <2110>', '2110', '39393725', 'externo', 'SIP/2110-00000006', '', 'Hangup', '', 6, 0, 'FAILED', 3, '', '', 'N', '1418664835.6', 'FIXO-LOCAL-OI', 0.00, NULL, NULL, NULL),
(441, '2014-12-18 12:17:06', '"2038" <2038>', '2038', '2020', 'externo', 'SIP/2038-00000007', 'SIP/2020-00000008', 'Busy', '3000', 8, 0, 'BUSY', 3, '', '', 'N', '1418912226.7', 'D0', 0.00, NULL, NULL, '2038-to-2020-1418912226.7'),
(442, '2014-12-18 14:53:16', '"2035" <2035>', '2035', '2038', 'externo', 'SIP/2035-00000009', 'SIP/2038-0000000a', 'Dial', 'SIP/2038,,rtTwWkK', 27, 22, 'ANSWERED', 3, '', '', 'N', '1418921596.9', 'D0', 0.00, NULL, NULL, '2035-to-2038-1418921596.9'),
(443, '2014-12-18 14:55:35', '"2035" <2035>', '2035', '2110', 'externo', 'SIP/2035-0000000b', 'SIP/2110-0000000c', 'Dial', 'SIP/2110,,rtTwWkK', 6, 4, 'ANSWERED', 3, '', '', 'N', '1418921735.11', 'D0', 0.00, NULL, NULL, '2035-to-2110-1418921735.11'),
(444, '2014-12-18 14:55:47', '"2035" <2035>', '2035', '2038', 'externo', 'SIP/2035-0000000d', 'SIP/2038-0000000e', 'Dial', 'SIP/2038,,rtTwWkK', 20, 12, 'ANSWERED', 3, '', '', 'N', '1418921747.13', 'D0', 0.00, NULL, NULL, '2035-to-2038-1418921747.13'),
(445, '2014-12-18 15:23:37', '"2041" <2041>', '2041', '2038', 'externo', 'SIP/2041-0000000f', 'SIP/2038-00000010', 'Dial', 'SIP/2038,,rtTwWkK', 32, 27, 'ANSWERED', 3, '', '', 'N', '1418923417.15', 'D0', 0.00, NULL, NULL, '2041-to-2038-1418923417.15'),
(446, '2014-12-18 15:25:17', '"2020" <2020>', '2020', '2041', 'externo', 'SIP/2020-00000011', 'SIP/2041-00000012', 'Dial', 'SIP/2041,,rtTwWkK', 11, 8, 'ANSWERED', 3, '', '', 'N', '1418923517.17', 'D0', 0.00, NULL, NULL, '2020-to-2041-1418923517.17'),
(447, '2014-12-18 15:25:39', '"2041" <2041>', '2041', '2038', 'externo', 'SIP/2041-00000013', 'SIP/2038-00000014', 'Dial', 'SIP/2038,,rtTwWkK', 91, 84, 'ANSWERED', 3, '', '', 'N', '1418923539.19', 'D0', 0.00, NULL, NULL, '2041-to-2038-1418923539.19'),
(448, '2014-12-18 15:27:52', '"2041" <2041>', '2041', '2038', 'externo', 'SIP/2041-00000015', 'SIP/2038-00000016', 'Dial', 'SIP/2038,,rtTwWkK', 170, 165, 'ANSWERED', 3, '', '', 'N', '1418923672.21', 'D0', 0.00, NULL, NULL, '2041-to-2038-1418923672.21'),
(449, '2014-12-19 09:30:50', '"2035" <2035>', '2035', '2038', 'externo', 'SIP/2035-00000017', '', 'Congestion', '3000', 0, 0, 'FAILED', 3, '', '', 'N', '1418988650.23', 'D0', 0.00, NULL, NULL, '2035-to-2038-1418988650.23'),
(450, '2014-12-19 09:30:54', '"2035" <2035>', '2035', '2038', 'externo', 'SIP/2035-00000018', '', 'Congestion', '3000', 0, 0, 'FAILED', 3, '', '', 'N', '1418988654.24', 'D0', 0.00, NULL, NULL, '2035-to-2038-1418988654.24'),
(451, '2014-12-19 09:31:48', '"2035" <2035>', '2035', '2038', 'externo', 'SIP/2035-00000019', 'SIP/2038-0000001a', 'Dial', 'SIP/2038,,rtTwWkK', 13, 9, 'ANSWERED', 3, '', '', 'N', '1418988708.25', 'D0', 0.00, NULL, NULL, '2035-to-2038-1418988708.25'),
(452, '2014-12-19 09:32:48', '"2038" <2038>', '2038', '2035', 'externo', 'SIP/2038-0000001b', 'SIP/2035-0000001c', 'Dial', 'SIP/2035,,rtTwWkK', 11, 9, 'ANSWERED', 3, '', '', 'N', '1418988768.27', 'D0', 0.00, NULL, NULL, '2038-to-2035-1418988768.27'),
(453, '2014-12-19 10:04:37', '"2017" <2017>', '2017', '2038', 'externo', 'SIP/2017-0000001d', 'SIP/2038-0000001e', 'Dial', 'SIP/2038,,rtTwWkK', 8, 4, 'ANSWERED', 3, '', '', 'N', '1418990677.29', 'D0', 0.00, NULL, NULL, '2017-to-2038-1418990677.29'),
(454, '2014-12-19 10:05:41', '"2017" <2017>', '2017', '2038', 'externo', 'SIP/2017-0000001f', 'SIP/2038-00000020', 'Dial', 'SIP/2038,,rtTwWkK', 37, 0, 'NO ANSWER', 3, '', '', 'N', '1418990741.31', 'D0', 0.00, NULL, NULL, '2017-to-2038-1418990741.31'),
(455, '2014-12-19 10:06:24', '"2017" <2017>', '2017', '2038', 'externo', 'SIP/2017-00000021', 'SIP/2038-00000022', 'Dial', 'SIP/2038,,rtTwWkK', 143, 107, 'ANSWERED', 3, '', '', 'N', '1418990784.33', 'D0', 0.00, NULL, NULL, '2017-to-2038-1418990784.33'),
(456, '2014-12-19 10:09:03', '"2017" <2017>', '2017', '2038', 'externo', 'SIP/2017-00000023', 'SIP/2038-00000024', 'Dial', 'SIP/2038,,rtTwWkK', 42, 35, 'ANSWERED', 3, '', '', 'N', '1418990943.35', 'D0', 0.00, NULL, NULL, '2017-to-2038-1418990943.35'),
(457, '2014-12-19 10:11:59', '"2017" <2017>', '2017', '2038', 'externo', 'SIP/2017-00000025', 'SIP/2038-00000026', 'Dial', 'SIP/2038,,rtTwWkK', 37, 31, 'ANSWERED', 3, '', '', 'N', '1418991119.37', 'D0', 0.00, NULL, NULL, '2017-to-2038-1418991119.37'),
(458, '2014-12-19 10:13:31', '"2017" <2017>', '2017', '2038', 'externo', 'SIP/2017-00000027', 'SIP/2038-00000028', 'Dial', 'SIP/2038,,rtTwWkK', 2, 0, 'NO ANSWER', 3, '', '', 'N', '1418991211.39', 'D0', 0.00, NULL, NULL, '2017-to-2038-1418991211.39'),
(459, '2014-12-19 10:13:52', '"2038" <2038>', '2038', '2017', 'externo', 'SIP/2038-00000029', 'SIP/2017-0000002a', 'Dial', 'SIP/2017,,rtTwWkK', 47, 43, 'ANSWERED', 3, '', '', 'N', '1418991232.41', 'D0', 0.00, NULL, NULL, '2038-to-2017-1418991232.41'),
(460, '2014-12-19 10:14:53', '"2017" <2017>', '2017', '2038', 'externo', 'SIP/2017-0000002b', 'SIP/2038-0000002c', 'Dial', 'SIP/2038,,rtTwWkK', 18, 15, 'ANSWERED', 3, '', '', 'N', '1418991293.43', 'D0', 0.00, NULL, NULL, '2017-to-2038-1418991293.43'),
(461, '2014-12-19 10:15:23', '"2038" <2038>', '2038', '2017', 'externo', 'SIP/2038-0000002d', 'SIP/2017-0000002e', 'Dial', 'SIP/2017,,rtTwWkK', 19, 17, 'ANSWERED', 3, '', '', 'N', '1418991323.45', 'D0', 0.00, NULL, NULL, '2038-to-2017-1418991323.45');

-- --------------------------------------------------------

--
-- Estrutura da tabela `pbxip_config_sip`
--

CREATE TABLE IF NOT EXISTS `pbxip_config_sip` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cat_metric` int(11) NOT NULL DEFAULT '0',
  `var_metric` int(11) NOT NULL DEFAULT '0',
  `commented` int(11) NOT NULL DEFAULT '0',
  `filename` varchar(128) NOT NULL DEFAULT '',
  `category` varchar(128) NOT NULL DEFAULT 'default',
  `var_name` varchar(128) NOT NULL DEFAULT '',
  `var_val` varchar(128) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `filename_comment` (`filename`,`commented`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `pbxip_custo`
--

CREATE TABLE IF NOT EXISTS `pbxip_custo` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `uniqueid` varchar(60) DEFAULT NULL,
  `custo` double(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=74 ;

--
-- Extraindo dados da tabela `pbxip_custo`
--

INSERT INTO `pbxip_custo` (`id`, `uniqueid`, `custo`) VALUES
(16, '1417118456.189', 0.08),
(17, '1417185879.207', 0.06),
(18, '1417271446.211', 0.13),
(19, '1417271576.213', 0.07),
(20, '1417429761.216', 0.00),
(21, '1417429798.218', 0.24),
(22, '1417430491.220', 0.00),
(23, '1417430680.222', 0.09),
(24, '1417430993.224', 0.07),
(25, '1417432716.226', 0.07),
(26, '1417690650.234', 0.21),
(27, '1417690767.236', 0.00),
(28, '1417690799.238', 0.00),
(29, '1417690868.240', 0.00),
(30, '1417691229.242', 0.00),
(31, '1417691779.244', 0.00),
(32, '1417691806.246', 0.00),
(33, '1417693258.248', 0.11),
(34, '1417693939.250', 0.17),
(35, '1417713483.254', 0.00),
(36, '1417713557.256', 0.00),
(37, '1417713839.258', 0.00),
(38, '1417713970.260', 0.10),
(39, '1417778125.264', 0.22),
(40, '1417778580.266', 0.09),
(41, '1417778635.268', 0.08),
(42, '1417778695.270', 0.00),
(43, '1417778756.272', 0.19),
(44, '1417779029.274', 0.08),
(45, '1417779102.276', 0.00),
(46, '1417779133.278', 0.08),
(47, '1417779306.280', 0.19),
(48, '1417796079.282', 0.00),
(49, '1417796155.284', 0.08),
(50, '1417796523.286', 0.00),
(51, '1418320098.291', 0.00),
(52, '1418320184.293', 0.00),
(53, '1418320222.295', 0.06),
(54, '1418324904.300', 0.00),
(55, '1418325098.302', 0.00),
(56, '1418643146.0', 0.00),
(57, '1418643179.2', 0.00),
(58, '1418921596.9', 0.00),
(59, '1418921735.11', 0.00),
(60, '1418921747.13', 0.00),
(61, '1418923417.15', 0.00),
(62, '1418923517.17', 0.00),
(63, '1418923539.19', 0.17),
(64, '1418923672.21', 0.33),
(65, '1418988708.25', 0.00),
(66, '1418988768.27', 0.00),
(67, '1418990677.29', 0.00),
(68, '1418990784.33', 0.21),
(69, '1418990943.35', 0.07),
(70, '1418991119.37', 0.06),
(71, '1418991232.41', 0.09),
(72, '1418991293.43', 0.00),
(73, '1418991323.45', 0.00);

-- --------------------------------------------------------

--
-- Estrutura da tabela `pbxip_dialplan`
--

CREATE TABLE IF NOT EXISTS `pbxip_dialplan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `context` varchar(20) NOT NULL,
  `exten` varchar(60) NOT NULL,
  `priority` tinyint(4) NOT NULL DEFAULT '1',
  `app` varchar(20) NOT NULL DEFAULT '',
  `appdata` varchar(128) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_contextextenpriority` (`context`,`exten`,`priority`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=80 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `pbxip_discador_campanhas`
--

CREATE TABLE IF NOT EXISTS `pbxip_discador_campanhas` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '			',
  `id_tlmkt` int(11) DEFAULT NULL,
  `id_agente` int(11) DEFAULT NULL,
  `id_campanha` int(11) DEFAULT NULL,
  `qtde_ocupado` int(11) DEFAULT '0',
  `qtde_nao_atente` int(11) DEFAULT '0',
  `qtde_discado` int(11) DEFAULT '0',
  `fg_invalido` char(1) DEFAULT 'N',
  `fg_tirar_campanha` char(1) DEFAULT 'N',
  `fg_falha_agente` char(1) DEFAULT 'N',
  `id_falha_agente` int(11) DEFAULT '0',
  `numero_1` varchar(45) DEFAULT NULL,
  `numero_2` varchar(45) DEFAULT NULL,
  `numero_3` varchar(45) DEFAULT NULL,
  `em_uso` char(1) DEFAULT 'N',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `pbxip_filas`
--

CREATE TABLE IF NOT EXISTS `pbxip_filas` (
  `name` varchar(128) NOT NULL,
  `musiconhold` varchar(128) DEFAULT NULL,
  `announce` varchar(128) DEFAULT NULL,
  `context` varchar(128) DEFAULT NULL,
  `timeout` int(11) DEFAULT NULL,
  `monitor_join` tinyint(1) DEFAULT NULL,
  `monitor_format` varchar(128) DEFAULT NULL,
  `queue_youarenext` varchar(128) DEFAULT NULL,
  `queue_thereare` varchar(128) DEFAULT NULL,
  `queue_callswaiting` varchar(128) DEFAULT NULL,
  `queue_holdtime` varchar(128) DEFAULT NULL,
  `queue_minutes` varchar(128) DEFAULT NULL,
  `queue_seconds` varchar(128) DEFAULT NULL,
  `queue_lessthan` varchar(128) DEFAULT NULL,
  `queue_thankyou` varchar(128) DEFAULT NULL,
  `queue_reporthold` varchar(128) DEFAULT NULL,
  `announce_frequency` int(11) DEFAULT NULL,
  `announce_round_seconds` int(11) DEFAULT NULL,
  `announce_holdtime` varchar(128) DEFAULT NULL,
  `retry` int(11) DEFAULT NULL,
  `wrapuptime` int(11) DEFAULT NULL,
  `maxlen` int(11) DEFAULT NULL,
  `servicelevel` int(11) DEFAULT NULL,
  `strategy` varchar(128) DEFAULT NULL,
  `joinempty` varchar(128) DEFAULT NULL,
  `leavewhenempty` varchar(128) DEFAULT NULL,
  `eventmemberstatus` tinyint(1) DEFAULT NULL,
  `eventwhencalled` tinyint(1) DEFAULT NULL,
  `reportholdtime` tinyint(1) DEFAULT NULL,
  `memberdelay` int(11) DEFAULT NULL,
  `weight` int(11) DEFAULT NULL,
  `timeoutrestart` tinyint(1) DEFAULT NULL,
  `periodic_announce` varchar(50) DEFAULT NULL,
  `periodic_announce_frequency` int(11) DEFAULT NULL,
  `ringinuse` tinyint(1) DEFAULT NULL,
  `setinterfacevar` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `pbxip_grupos`
--

CREATE TABLE IF NOT EXISTS `pbxip_grupos` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(80) NOT NULL,
  `status` char(1) NOT NULL DEFAULT 'S',
  `observacao` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `pbxip_membro_filas`
--

CREATE TABLE IF NOT EXISTS `pbxip_membro_filas` (
  `uniqueid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `membername` varchar(40) DEFAULT NULL,
  `queue_name` varchar(128) DEFAULT NULL,
  `interface` varchar(128) DEFAULT NULL,
  `penalty` int(11) DEFAULT NULL,
  `paused` int(11) DEFAULT NULL,
  PRIMARY KEY (`uniqueid`),
  UNIQUE KEY `queue_interface` (`queue_name`,`interface`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `pbxip_psa`
--

CREATE TABLE IF NOT EXISTS `pbxip_psa` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `id_chamada` varchar(150) DEFAULT NULL,
  `calldate` datetime DEFAULT '0000-00-00 00:00:00',
  `ramal` varchar(80) DEFAULT '',
  `nota1` varchar(80) DEFAULT '',
  `servico` varchar(80) DEFAULT '',
  `nota2` varchar(80) DEFAULT '',
  `agent_code` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `calldate` (`calldate`),
  KEY `ramal` (`ramal`),
  KEY `servico` (`servico`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=144 ;

--
-- Extraindo dados da tabela `pbxip_psa`
--

INSERT INTO `pbxip_psa` (`id`, `id_chamada`, `calldate`, `ramal`, `nota1`, `servico`, `nota2`, `agent_code`) VALUES
(37, '1415293929.98', '2014-11-06 15:12:28', '553139392199', '4', 'VRT', '4', ''),
(38, '1415306045.101', '2014-11-06 18:34:23', '3137692000', '5', 'VRT', '5', ''),
(39, '1415309730.102', '2014-11-06 19:35:59', '3137692000', '5', 'VRT', '3', ''),
(40, '1415310998.104', '2014-11-06 19:56:56', '3137692000', '5', 'VRT', '2', ''),
(41, '1415311184.105', '2014-11-06 20:00:00', '2064', '5', 'VRT', '5', ''),
(42, '1415313705.107', '2014-11-06 20:42:03', '2051', '4', 'VRT', '3', ''),
(43, '1415378969.108', '2014-11-07 14:49:46', '2061', '5', 'VRT', '2', ''),
(44, '1415382659.109', '2014-11-07 15:51:14', '2063', '3', 'VRT', '3', ''),
(45, '1415383126.110', '2014-11-07 15:58:56', '2101', '2', 'VRT', '4', ''),
(46, '1415395254.111', '2014-11-07 19:21:10', '553139392199', '5', 'VRT', '2', ''),
(47, '1415404424.114', '2014-11-07 21:54:01', '2064', '4', 'VRT', '3', ''),
(48, '1415404494.115', '2014-11-07 21:55:10', '2051', '5', 'VRT', '5', ''),
(49, '1415444138.119', '2014-11-08 08:55:54', '2086', '5', '', '', ''),
(50, '1415444138.119', '2014-11-08 08:55:59', 'VRT', '5', '', '', ''),
(51, '1415444143.120', '2014-11-08 08:56:00', '2095', '5', '', '', ''),
(52, '1415444127.116', '2014-11-08 08:56:03', '2064', '2', 'VRT', '5', ''),
(53, '1415444146.121', '2014-11-08 08:56:05', '2085', '5', 'VRT', '5', ''),
(54, '1415447954.124', '2014-11-08 09:59:31', '2079', '5', 'VRT', '2', ''),
(55, '1415448515.125', '2014-11-08 10:09:11', '3137692000', '5', 'VRT', '4', ''),
(56, '1415448852.126', '2014-11-08 10:14:47', '3137692000', '5', 'VRT', '5', ''),
(57, '1415449577.127', '2014-11-08 10:26:53', '553139392199', '4', 'VRT', '4', ''),
(58, '1415451690.131', '2014-11-08 11:02:23', '3137692000', '4', 'VRT', '3', ''),
(59, '1415451690.131', '2014-11-08 11:02:24', '3137692000', '4', 'VRT', '3', ''),
(60, '1415451821.133', '2014-11-08 11:04:15', '3137692000', '5', 'VRT', '2', ''),
(61, '1415451922.134', '2014-11-08 11:05:40', '3137692000', '2', 'VRT', '2', ''),
(62, '1415451922.134', '2014-11-08 11:05:40', '3137692000', '2', 'VRT', '2', ''),
(63, '1415451995.135', '2014-11-08 11:07:11', '3137692000', '5', 'VRT', '5', ''),
(64, '1415451995.135', '2014-11-08 11:07:39', 'VRT', '5', 'VRT', '5', ''),
(65, '1415452711.136', '2014-11-08 11:18:47', '553139392199', '4', 'VRT', '4', ''),
(66, '1415453245.137', '2014-11-08 11:28:02', '3137692000', '3', 'VRT', '4', ''),
(67, '1415453323.138', '2014-11-08 11:28:58', '553139392199', '5', 'VRT', '5', ''),
(68, '1415453478.139', '2014-11-08 11:31:37', '3137692000', '5', 'VRT', '4', ''),
(69, '1415453500.140', '2014-11-08 11:31:56', '2088', '5', 'VRT', '5', ''),
(70, '1415453577.141', '2014-11-08 11:33:15', '3137692000', '5', 'VRT', '4', ''),
(71, '1415453760.142', '2014-11-08 11:36:28', '3137692000', '5', 'VRT', '4', ''),
(72, '1415453760.142', '2014-11-08 11:36:28', '3137692000', '5', 'VRT', '4', ''),
(73, '1415454310.145', '2014-11-08 11:45:45', '3137692000', '5', 'VRT', '4', ''),
(74, '1415454712.147', '2014-11-08 11:52:08', '553139392199', '5', 'VRT', '4', ''),
(75, '1415458527.148', '2014-11-08 12:55:50', '553139392199', '4', 'VRT', '3', ''),
(76, '1415459971.150', '2014-11-08 13:19:47', '553139392199', '5', 'VRT', '5', ''),
(77, '1415460980.153', '2014-11-08 13:36:36', '553139392199', '5', 'VRT', '5', ''),
(78, '1415462019.155', '2014-11-08 13:54:14', '553139392199', '4', 'VRT', '3', ''),
(79, '1415462067.156', '2014-11-08 13:54:57', '3137692000', '5', 'VRT', '5', ''),
(80, '1415567704.159', '2014-11-09 19:15:42', '3137692000', '5', 'VRT', '5', ''),
(81, '1415637266.160', '2014-11-10 14:34:43', '2060', '5', 'VRT', '5', ''),
(82, '1415637833.161', '2014-11-10 14:44:12', '2063', '4', 'VRT', '3', ''),
(83, '1415646975.162', '2014-11-10 17:17:07', '3137692000', '4', 'VRT', '3', ''),
(84, '1415653530.163', '2014-11-10 19:05:46', '3137692000', '4', 'VRT', '4', ''),
(85, '1415653934.164', '2014-11-10 19:12:36', '2051', '5', 'VRT', '3', ''),
(86, '1415656087.166', '2014-11-10 19:48:23', '2078', '2', 'VRT', '2', ''),
(87, '1415657432.167', '2014-11-10 20:10:48', '553139392199', '5', 'VRT', '4', ''),
(88, '1415660132.169', '2014-11-10 20:55:50', '2051', '4', 'VRT', '3', ''),
(89, '1415964624.1', '2014-11-14 09:30:43', '2039', '5', 'VRT', '5', NULL),
(90, '1415964839.2', '2014-11-14 09:34:17', '2039', '4', 'VRT', '3', NULL),
(91, '700', '2014-11-14 10:53:35', '', '1415969561.5#2039', '', '', NULL),
(92, '1415970569.10', '2014-11-14 11:09:51', '2039', '5', 'VRT', '5', NULL),
(93, '1415972119.11', '2014-11-14 11:35:41', '2039', '3', 'VRT', '5', '666'),
(94, '1415972371.14', '2014-11-14 11:39:46', '2101', '4', 'VRT', '3', '444'),
(95, '1415972447.15', '2014-11-14 11:41:15', '2097', '3', 'VRT', '3', '129'),
(96, '1415972530.17', '2014-11-14 11:42:36', '2051', '5', 'VRT', '4', '162'),
(97, '1415972827.18', '2014-11-14 11:47:30', '2079', '5', 'VRT', '5', '175'),
(98, '1415973360.22', '2014-11-14 11:56:14', '2020', '5', '', '', '56'),
(99, '1415981481.25', '2014-11-14 14:11:34', '2039', '2', 'VRT', '2', '666'),
(100, '1415981606.26', '2014-11-14 14:13:41', '2039', '1', 'VRT', '1', '666'),
(101, '1415995465.29', '2014-11-14 18:04:39', '2064', '5', 'VRT', '5', '127'),
(102, '1416001127.32', '2014-11-14 19:39:08', '553139392199', '5', 'VRT', '4', '127'),
(103, '1416001608.33', '2014-11-14 19:47:10', '3137692000', '5', 'VRT', '4', '157'),
(104, '1416001608.33', '2014-11-14 19:47:59', 'VRT', '5', 'VRT', '4', '5'),
(105, '1416317289.46', '2014-11-18 11:28:31', '2002', '5', 'VRT', '5', '102'),
(106, '1416317449.47', '2014-11-18 11:31:13', '2002', '5', '', '', '102'),
(107, '1416317491.48', '2014-11-18 11:31:57', '2002', '5', 'VRT', '5', '102'),
(108, '1416317532.49', '2014-11-18 11:32:47', '2039', '4', '', '', '666'),
(109, '1416317682.51', '2014-11-18 11:35:07', '2039', '3', 'VRT', '5', '666'),
(110, '1416341452.54', '2014-11-18 18:11:23', '2064', '5', 'VRT', '3', '127'),
(111, '1416353203.57', '2014-11-18 21:27:32', '3137692000', '4', 'VRT', '3', '157'),
(112, '1416353203.57', '2014-11-18 21:27:32', '3137692000', '4', 'VRT', '3', '157'),
(113, '1416353203.57', '2014-11-18 21:27:33', '3137692000', '4', 'VRT', '3', '157'),
(114, '1416354390.58', '2014-11-18 21:46:55', '2065', '4', 'VRT', '3', '157'),
(115, '1416355802.59', '2014-11-18 22:10:29', '553139392199', '5', 'VRT', '3', '157'),
(116, '1416439155.96', '2014-11-19 21:20:00', '2079', '3', 'VRT', '3', '126'),
(117, '1416442049.97', '2014-11-19 22:07:58', '2051', '3', 'VRT', '2', '157'),
(118, '1416501901.98', '2014-11-20 14:45:28', '2063', '5', 'VRT', '3', '157'),
(119, '1416504766.99', '2014-11-20 15:33:14', '553139392199', '3', 'VRT', '2', '157'),
(120, '1416506865.100', '2014-11-20 16:08:11', '2063', '3', 'VRT', '2', '157'),
(121, '1416524173.103', '2014-11-20 20:56:40', '2060', '5', 'VRT', '3', '126'),
(122, '1416529164.105', '2014-11-20 22:19:53', '3137692000', '3', 'VRT', '2', '157'),
(123, '1416529164.105', '2014-11-20 22:19:53', '3137692000', '3', 'VRT', '2', '157'),
(124, '1416593919.107', '2014-11-21 16:19:07', '3137692000', '5', 'VRT', '2', '157'),
(125, '1416604000.108', '2014-11-21 19:07:09', '3137692000', '5', 'VRT', '5', '157'),
(126, '1416613438.110', '2014-11-21 21:44:25', '2079', '5', 'VRT', '3', '157'),
(127, '1416616547.111', '2014-11-21 22:36:14', '3137692000', '5', 'VRT', '3', '157'),
(128, '1416685210.115', '2014-11-22 17:40:58', '2064', '5', 'VRT', '4', '127'),
(129, '1417015851.116', '2014-11-26 13:31:19', '2064', '5', 'VRT', '4', '127'),
(130, '1417018599.117', '2014-11-26 14:17:24', '3137692000', '4', 'VRT', '1', '127'),
(131, '1417032289.118', '2014-11-26 18:05:16', '2064', '5', 'VRT', '4', '127'),
(132, '1417042381.120', '2014-11-26 20:53:29', '553139392199', '4', 'VRT', '3', '127'),
(133, '1417043973.121', '2014-11-26 21:20:21', '3137692000', '5', 'VRT', '2', '127'),
(134, '1417049515.123', '2014-11-26 22:52:24', '2065', '5', 'VRT', '5', '157'),
(135, '1417122170.192', '2014-11-27 19:03:18', '2078', '5', 'VRT', '2', '157'),
(136, '1417210087.209', '2014-11-28 19:28:34', '2079', '5', 'VRT', '5', '157'),
(137, '1417324442.215', '2014-11-30 03:14:32', '2051', '5', 'VRT', '5', '175'),
(138, '1417457201.228', '2014-12-01 16:07:10', '2050', '5', 'VRT', '3', '157'),
(139, '0000', '2014-12-02 19:36:32', '', '1', '', '', ''),
(140, '0000', '2014-12-02 19:36:32', '', '5', '', '', ''),
(141, '1417556210.230', '2014-12-02 19:37:18', '3137692000', '5', 'VRT', '3', '157'),
(142, '1417556210.230', '2014-12-02 19:37:18', '3137692000', '5', 'VRT', '3', '157'),
(143, '1418037847.288', '2014-12-08 09:24:57', '3137692000', '5', 'VRT', '5', '162');

-- --------------------------------------------------------

--
-- Estrutura da tabela `pbxip_ramais`
--

CREATE TABLE IF NOT EXISTS `pbxip_ramais` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `displayname` varchar(80) NOT NULL DEFAULT '',
  `context` varchar(80) DEFAULT 'ramais',
  `callingpres` enum('allowed_not_screened','allowed_passed_screen','allowed_failed_screen','allowed','prohib_not_screened','prohib_passed_screen','prohib_failed_screen','prohib','unavailable') DEFAULT 'allowed_not_screened',
  `deny` varchar(95) DEFAULT NULL,
  `permit` varchar(95) DEFAULT NULL,
  `secret` varchar(80) NOT NULL,
  `md5secret` varchar(80) DEFAULT NULL,
  `remotesecret` varchar(250) DEFAULT NULL,
  `transport` enum('tcp','udp','tcp,udp') DEFAULT NULL,
  `host` varchar(31) DEFAULT '',
  `nat` varchar(5) NOT NULL DEFAULT 'yes',
  `type` enum('user','peer','friend') NOT NULL DEFAULT 'friend',
  `accountcode` varchar(20) DEFAULT NULL,
  `amaflags` varchar(13) DEFAULT NULL,
  `callgroup` varchar(10) DEFAULT NULL,
  `callerid` varchar(80) NOT NULL,
  `defaultip` varchar(15) DEFAULT NULL,
  `dtmfmode` varchar(7) DEFAULT 'rfc2833',
  `fromuser` varchar(80) DEFAULT NULL,
  `fromdomain` varchar(80) DEFAULT NULL,
  `insecure` varchar(4) DEFAULT NULL,
  `language` char(2) DEFAULT 'br',
  `mailbox` varchar(50) NOT NULL,
  `pickupgroup` varchar(10) DEFAULT NULL,
  `qualify` char(3) DEFAULT 'yes',
  `regexten` varchar(80) DEFAULT NULL,
  `rtptimeout` char(3) DEFAULT NULL,
  `rtpholdtimeout` char(3) DEFAULT NULL,
  `setvar` varchar(100) DEFAULT NULL,
  `disallow` varchar(100) DEFAULT 'all',
  `allow` varchar(100) DEFAULT 'g729;ilbc;gsm;ulaw;alaw',
  `fullcontact` varchar(80) DEFAULT '',
  `ipaddr` varchar(15) DEFAULT '',
  `port` mediumint(5) unsigned DEFAULT '0',
  `username` varchar(80) NOT NULL,
  `defaultuser` varchar(80) DEFAULT '',
  `subscribecontext` varchar(80) NOT NULL,
  `directmedia` enum('yes','no') DEFAULT NULL,
  `trustrpid` enum('yes','no') DEFAULT NULL,
  `sendrpid` enum('yes','no') DEFAULT NULL,
  `progressinband` enum('never','yes','no') DEFAULT NULL,
  `promiscredir` enum('yes','no') DEFAULT NULL,
  `useclientcode` enum('yes','no') DEFAULT NULL,
  `callcounter` enum('yes','no') DEFAULT NULL,
  `busylevel` int(10) unsigned DEFAULT NULL,
  `allowoverlap` enum('yes','no') DEFAULT 'yes',
  `allowsubscribe` enum('yes','no') DEFAULT 'yes',
  `allowtransfer` enum('yes','no') DEFAULT 'yes',
  `ignoresdpversion` enum('yes','no') DEFAULT 'no',
  `template` varchar(100) DEFAULT NULL,
  `videosupport` enum('yes','no','always') DEFAULT 'no',
  `maxcallbitrate` int(10) unsigned DEFAULT NULL,
  `rfc2833compensate` enum('yes','no') DEFAULT 'yes',
  `session-timers` enum('originate','accept','refuse') DEFAULT 'accept',
  `session-expires` int(5) unsigned DEFAULT '1800',
  `session-minse` int(5) unsigned DEFAULT '90',
  `session-refresher` enum('uac','uas') DEFAULT 'uas',
  `t38pt_usertpsource` enum('yes','no') DEFAULT NULL,
  `outboundproxy` varchar(250) DEFAULT NULL,
  `callbackextension` varchar(250) DEFAULT NULL,
  `registertrying` enum('yes','no') DEFAULT 'yes',
  `timert1` int(5) unsigned DEFAULT '500',
  `timerb` int(8) unsigned DEFAULT NULL,
  `qualifyfreq` int(5) unsigned DEFAULT '120',
  `contactpermit` varchar(250) DEFAULT NULL,
  `contactdeny` varchar(250) DEFAULT NULL,
  `lastms` int(11) NOT NULL,
  `regserver` varchar(100) DEFAULT '',
  `regseconds` int(11) DEFAULT '0',
  `useragent` varchar(50) DEFAULT '',
  `call-limit` int(2) DEFAULT '1',
  `perfil` int(3) DEFAULT NULL,
  `heritage` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`displayname`),
  KEY `name_2` (`displayname`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC AUTO_INCREMENT=3 ;

--
-- Extraindo dados da tabela `pbxip_ramais`
--

INSERT INTO `pbxip_ramais` (`id`, `displayname`, `context`, `callingpres`, `deny`, `permit`, `secret`, `md5secret`, `remotesecret`, `transport`, `host`, `nat`, `type`, `accountcode`, `amaflags`, `callgroup`, `callerid`, `defaultip`, `dtmfmode`, `fromuser`, `fromdomain`, `insecure`, `language`, `mailbox`, `pickupgroup`, `qualify`, `regexten`, `rtptimeout`, `rtpholdtimeout`, `setvar`, `disallow`, `allow`, `fullcontact`, `ipaddr`, `port`, `username`, `defaultuser`, `subscribecontext`, `directmedia`, `trustrpid`, `sendrpid`, `progressinband`, `promiscredir`, `useclientcode`, `callcounter`, `busylevel`, `allowoverlap`, `allowsubscribe`, `allowtransfer`, `ignoresdpversion`, `template`, `videosupport`, `maxcallbitrate`, `rfc2833compensate`, `session-timers`, `session-expires`, `session-minse`, `session-refresher`, `t38pt_usertpsource`, `outboundproxy`, `callbackextension`, `registertrying`, `timert1`, `timerb`, `qualifyfreq`, `contactpermit`, `contactdeny`, `lastms`, `regserver`, `regseconds`, `useragent`, `call-limit`, `perfil`, `heritage`) VALUES
(2, '2101', 'ramais', 'allowed_not_screened', '2101', '2101', '2101', NULL, NULL, NULL, '', 'yes', 'friend', NULL, NULL, '2101', '2101', NULL, 'rfc2833', NULL, NULL, NULL, 'br', '2101', '2101', 'yes', NULL, NULL, NULL, NULL, 'all', 'g729;ilbc;gsm;ulaw;alaw', '', '', 0, '2101', '', '2101', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'yes', 'yes', 'yes', 'no', NULL, 'no', NULL, 'yes', 'accept', 1800, 90, 'uas', NULL, NULL, NULL, 'yes', 500, NULL, 120, NULL, NULL, 0, '', 0, '', 1, NULL, 'interno');

-- --------------------------------------------------------

--
-- Estrutura da tabela `pbxip_ramais_iax`
--

CREATE TABLE IF NOT EXISTS `pbxip_ramais_iax` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL DEFAULT '',
  `username` varchar(30) DEFAULT NULL,
  `type` varchar(6) NOT NULL DEFAULT '',
  `secret` varchar(50) DEFAULT NULL,
  `md5secret` varchar(32) DEFAULT NULL,
  `dbsecret` varchar(100) DEFAULT NULL,
  `notransfer` varchar(10) DEFAULT NULL,
  `inkeys` varchar(100) DEFAULT NULL,
  `outkeys` varchar(100) DEFAULT NULL,
  `auth` varchar(100) DEFAULT NULL,
  `accountcode` varchar(100) DEFAULT NULL,
  `amaflags` varchar(100) DEFAULT NULL,
  `callerid` varchar(100) DEFAULT NULL,
  `context` varchar(100) DEFAULT NULL,
  `defaultip` varchar(15) DEFAULT NULL,
  `host` varchar(31) NOT NULL DEFAULT 'dynamic',
  `language` varchar(5) DEFAULT NULL,
  `mailbox` varchar(50) DEFAULT NULL,
  `deny` varchar(95) DEFAULT NULL,
  `permit` varchar(95) DEFAULT NULL,
  `qualify` varchar(4) NOT NULL DEFAULT 'no',
  `disallow` varchar(100) DEFAULT NULL,
  `allow` varchar(100) DEFAULT NULL,
  `ipaddr` varchar(15) DEFAULT NULL,
  `port` int(11) DEFAULT '0',
  `regseconds` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `idx_name` (`name`),
  UNIQUE KEY `idx_username` (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `pbxip_tarifas`
--

CREATE TABLE IF NOT EXISTS `pbxip_tarifas` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `fluxo` varchar(20) DEFAULT NULL,
  `valor` double(10,2) NOT NULL DEFAULT '0.00',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=20 ;

--
-- Extraindo dados da tabela `pbxip_tarifas`
--

INSERT INTO `pbxip_tarifas` (`id`, `fluxo`, `valor`) VALUES
(10, 'D0', 0.12),
(11, 'D1', 0.15),
(14, 'D4', 0.17),
(16, 'VC2', 0.89),
(15, 'VC1', 0.65),
(12, 'D2', 0.15),
(13, 'D3', 0.17),
(17, 'VC3', 0.89);

-- --------------------------------------------------------

--
-- Estrutura da tabela `pbxip_voicemail`
--

CREATE TABLE IF NOT EXISTS `pbxip_voicemail` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` bigint(20) NOT NULL DEFAULT '0',
  `context` varchar(50) NOT NULL DEFAULT 'default',
  `mailbox` bigint(20) NOT NULL DEFAULT '0',
  `password` varchar(4) NOT NULL DEFAULT '0',
  `fullname` varchar(50) NOT NULL DEFAULT '',
  `email` varchar(50) NOT NULL DEFAULT '',
  `pager` varchar(50) NOT NULL DEFAULT '',
  `stamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`mailbox`,`context`),
  UNIQUE KEY `idx_id` (`id`),
  KEY `idx_customer_id` (`customer_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

--
-- Estrutura da tabela `webpbxip_perfil`
--

CREATE TABLE IF NOT EXISTS `webpbxip_perfil` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(40) NOT NULL,
  `status` char(1) NOT NULL DEFAULT 'S',
  `id_usuario_cad` int(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Extraindo dados da tabela `webpbxip_perfil`
--

INSERT INTO `webpbxip_perfil` (`id`, `descricao`, `status`, `id_usuario_cad`) VALUES
(5, 'ADMINISTRADOR', 'S', 1),
(6, 'SUPORTE', 'S', 1),
(7, 'GESTOR', 'S', 1),
(8, 'OPERADOR', 'S', 1);

-- --------------------------------------------------------

--
-- Estrutura da tabela `webpbxip_perfil_permissoes`
--

CREATE TABLE IF NOT EXISTS `webpbxip_perfil_permissoes` (
  `id` int(6) NOT NULL AUTO_INCREMENT,
  `id_perfil` int(3) NOT NULL,
  `id_permissao` int(3) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=54 ;

--
-- Extraindo dados da tabela `webpbxip_perfil_permissoes`
--

INSERT INTO `webpbxip_perfil_permissoes` (`id`, `id_perfil`, `id_permissao`) VALUES
(33, 5, 10),
(34, 5, 11),
(35, 5, 12),
(36, 5, 13),
(37, 5, 14),
(38, 5, 16),
(40, 5, 15),
(41, 5, 17),
(42, 6, 15),
(43, 5, 18),
(44, 5, 19),
(45, 7, 19),
(47, 8, 10),
(48, 8, 11),
(49, 8, 12),
(50, 8, 13),
(52, 5, 21),
(53, 5, 22);

-- --------------------------------------------------------

--
-- Estrutura da tabela `webpbxip_permissao`
--

CREATE TABLE IF NOT EXISTS `webpbxip_permissao` (
  `id` int(3) NOT NULL AUTO_INCREMENT,
  `descricao` varchar(40) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=23 ;

--
-- Extraindo dados da tabela `webpbxip_permissao`
--

INSERT INTO `webpbxip_permissao` (`id`, `descricao`) VALUES
(10, 'RELATORIO_CDR'),
(11, 'COMPARACAO'),
(12, 'TRAFEGO_MENSAL'),
(13, 'CARGA_DIARIA'),
(14, 'AUDIO'),
(15, 'ALTERACAO_DE_ANUNCIOS'),
(22, 'RAMAIS'),
(17, 'CONSULTA_LIGACOES'),
(18, 'USUARIOS'),
(19, 'AVALIACAO_PSA'),
(21, 'BLACKLIST');

-- --------------------------------------------------------

--
-- Estrutura da tabela `webpbxip_session`
--

CREATE TABLE IF NOT EXISTS `webpbxip_session` (
  `session_id` varchar(40) NOT NULL,
  `ip_address` varchar(16) NOT NULL,
  `user_agent` varchar(120) NOT NULL,
  `last_activity` int(11) NOT NULL DEFAULT '0',
  `user_data` text NOT NULL,
  PRIMARY KEY (`session_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Extraindo dados da tabela `webpbxip_session`
--

INSERT INTO `webpbxip_session` (`session_id`, `ip_address`, `user_agent`, `last_activity`, `user_data`) VALUES
('71e69c0e74c751cfe30ee52d4401ad86', '192.168.2.11', 'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/39.0.2171.95 Safari/537.36', 1420126243, 'a:3:{s:9:"user_data";s:0:"";s:6:"export";a:107:{i:0;O:8:"stdClass":8:{s:2:"id";s:3:"143";s:10:"id_chamada";s:14:"1418037847.288";s:8:"calldate";s:19:"2014-12-08 09:24:57";s:5:"ramal";s:10:"3137692000";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"5";s:10:"agent_code";s:3:"162";}i:1;O:8:"stdClass":8:{s:2:"id";s:3:"142";s:10:"id_chamada";s:14:"1417556210.230";s:8:"calldate";s:19:"2014-12-02 19:37:18";s:5:"ramal";s:10:"3137692000";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"3";s:10:"agent_code";s:3:"157";}i:2;O:8:"stdClass":8:{s:2:"id";s:3:"141";s:10:"id_chamada";s:14:"1417556210.230";s:8:"calldate";s:19:"2014-12-02 19:37:18";s:5:"ramal";s:10:"3137692000";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"3";s:10:"agent_code";s:3:"157";}i:3;O:8:"stdClass":8:{s:2:"id";s:3:"140";s:10:"id_chamada";s:4:"0000";s:8:"calldate";s:19:"2014-12-02 19:36:32";s:5:"ramal";s:0:"";s:5:"nota1";s:1:"5";s:7:"servico";s:0:"";s:5:"nota2";s:0:"";s:10:"agent_code";s:0:"";}i:4;O:8:"stdClass":8:{s:2:"id";s:3:"139";s:10:"id_chamada";s:4:"0000";s:8:"calldate";s:19:"2014-12-02 19:36:32";s:5:"ramal";s:0:"";s:5:"nota1";s:1:"1";s:7:"servico";s:0:"";s:5:"nota2";s:0:"";s:10:"agent_code";s:0:"";}i:5;O:8:"stdClass":8:{s:2:"id";s:3:"138";s:10:"id_chamada";s:14:"1417457201.228";s:8:"calldate";s:19:"2014-12-01 16:07:10";s:5:"ramal";s:4:"2050";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"3";s:10:"agent_code";s:3:"157";}i:6;O:8:"stdClass":8:{s:2:"id";s:3:"137";s:10:"id_chamada";s:14:"1417324442.215";s:8:"calldate";s:19:"2014-11-30 03:14:32";s:5:"ramal";s:4:"2051";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"5";s:10:"agent_code";s:3:"175";}i:7;O:8:"stdClass":8:{s:2:"id";s:3:"136";s:10:"id_chamada";s:14:"1417210087.209";s:8:"calldate";s:19:"2014-11-28 19:28:34";s:5:"ramal";s:4:"2079";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"5";s:10:"agent_code";s:3:"157";}i:8;O:8:"stdClass":8:{s:2:"id";s:3:"135";s:10:"id_chamada";s:14:"1417122170.192";s:8:"calldate";s:19:"2014-11-27 19:03:18";s:5:"ramal";s:4:"2078";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"2";s:10:"agent_code";s:3:"157";}i:9;O:8:"stdClass":8:{s:2:"id";s:3:"134";s:10:"id_chamada";s:14:"1417049515.123";s:8:"calldate";s:19:"2014-11-26 22:52:24";s:5:"ramal";s:4:"2065";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"5";s:10:"agent_code";s:3:"157";}i:10;O:8:"stdClass":8:{s:2:"id";s:3:"133";s:10:"id_chamada";s:14:"1417043973.121";s:8:"calldate";s:19:"2014-11-26 21:20:21";s:5:"ramal";s:10:"3137692000";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"2";s:10:"agent_code";s:3:"127";}i:11;O:8:"stdClass":8:{s:2:"id";s:3:"132";s:10:"id_chamada";s:14:"1417042381.120";s:8:"calldate";s:19:"2014-11-26 20:53:29";s:5:"ramal";s:12:"553139392199";s:5:"nota1";s:1:"4";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"3";s:10:"agent_code";s:3:"127";}i:12;O:8:"stdClass":8:{s:2:"id";s:3:"131";s:10:"id_chamada";s:14:"1417032289.118";s:8:"calldate";s:19:"2014-11-26 18:05:16";s:5:"ramal";s:4:"2064";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"4";s:10:"agent_code";s:3:"127";}i:13;O:8:"stdClass":8:{s:2:"id";s:3:"130";s:10:"id_chamada";s:14:"1417018599.117";s:8:"calldate";s:19:"2014-11-26 14:17:24";s:5:"ramal";s:10:"3137692000";s:5:"nota1";s:1:"4";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"1";s:10:"agent_code";s:3:"127";}i:14;O:8:"stdClass":8:{s:2:"id";s:3:"129";s:10:"id_chamada";s:14:"1417015851.116";s:8:"calldate";s:19:"2014-11-26 13:31:19";s:5:"ramal";s:4:"2064";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"4";s:10:"agent_code";s:3:"127";}i:15;O:8:"stdClass":8:{s:2:"id";s:3:"128";s:10:"id_chamada";s:14:"1416685210.115";s:8:"calldate";s:19:"2014-11-22 17:40:58";s:5:"ramal";s:4:"2064";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"4";s:10:"agent_code";s:3:"127";}i:16;O:8:"stdClass":8:{s:2:"id";s:3:"127";s:10:"id_chamada";s:14:"1416616547.111";s:8:"calldate";s:19:"2014-11-21 22:36:14";s:5:"ramal";s:10:"3137692000";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"3";s:10:"agent_code";s:3:"157";}i:17;O:8:"stdClass":8:{s:2:"id";s:3:"126";s:10:"id_chamada";s:14:"1416613438.110";s:8:"calldate";s:19:"2014-11-21 21:44:25";s:5:"ramal";s:4:"2079";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"3";s:10:"agent_code";s:3:"157";}i:18;O:8:"stdClass":8:{s:2:"id";s:3:"125";s:10:"id_chamada";s:14:"1416604000.108";s:8:"calldate";s:19:"2014-11-21 19:07:09";s:5:"ramal";s:10:"3137692000";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"5";s:10:"agent_code";s:3:"157";}i:19;O:8:"stdClass":8:{s:2:"id";s:3:"124";s:10:"id_chamada";s:14:"1416593919.107";s:8:"calldate";s:19:"2014-11-21 16:19:07";s:5:"ramal";s:10:"3137692000";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"2";s:10:"agent_code";s:3:"157";}i:20;O:8:"stdClass":8:{s:2:"id";s:3:"123";s:10:"id_chamada";s:14:"1416529164.105";s:8:"calldate";s:19:"2014-11-20 22:19:53";s:5:"ramal";s:10:"3137692000";s:5:"nota1";s:1:"3";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"2";s:10:"agent_code";s:3:"157";}i:21;O:8:"stdClass":8:{s:2:"id";s:3:"122";s:10:"id_chamada";s:14:"1416529164.105";s:8:"calldate";s:19:"2014-11-20 22:19:53";s:5:"ramal";s:10:"3137692000";s:5:"nota1";s:1:"3";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"2";s:10:"agent_code";s:3:"157";}i:22;O:8:"stdClass":8:{s:2:"id";s:3:"121";s:10:"id_chamada";s:14:"1416524173.103";s:8:"calldate";s:19:"2014-11-20 20:56:40";s:5:"ramal";s:4:"2060";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"3";s:10:"agent_code";s:3:"126";}i:23;O:8:"stdClass":8:{s:2:"id";s:3:"120";s:10:"id_chamada";s:14:"1416506865.100";s:8:"calldate";s:19:"2014-11-20 16:08:11";s:5:"ramal";s:4:"2063";s:5:"nota1";s:1:"3";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"2";s:10:"agent_code";s:3:"157";}i:24;O:8:"stdClass":8:{s:2:"id";s:3:"119";s:10:"id_chamada";s:13:"1416504766.99";s:8:"calldate";s:19:"2014-11-20 15:33:14";s:5:"ramal";s:12:"553139392199";s:5:"nota1";s:1:"3";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"2";s:10:"agent_code";s:3:"157";}i:25;O:8:"stdClass":8:{s:2:"id";s:3:"118";s:10:"id_chamada";s:13:"1416501901.98";s:8:"calldate";s:19:"2014-11-20 14:45:28";s:5:"ramal";s:4:"2063";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"3";s:10:"agent_code";s:3:"157";}i:26;O:8:"stdClass":8:{s:2:"id";s:3:"117";s:10:"id_chamada";s:13:"1416442049.97";s:8:"calldate";s:19:"2014-11-19 22:07:58";s:5:"ramal";s:4:"2051";s:5:"nota1";s:1:"3";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"2";s:10:"agent_code";s:3:"157";}i:27;O:8:"stdClass":8:{s:2:"id";s:3:"116";s:10:"id_chamada";s:13:"1416439155.96";s:8:"calldate";s:19:"2014-11-19 21:20:00";s:5:"ramal";s:4:"2079";s:5:"nota1";s:1:"3";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"3";s:10:"agent_code";s:3:"126";}i:28;O:8:"stdClass":8:{s:2:"id";s:3:"115";s:10:"id_chamada";s:13:"1416355802.59";s:8:"calldate";s:19:"2014-11-18 22:10:29";s:5:"ramal";s:12:"553139392199";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"3";s:10:"agent_code";s:3:"157";}i:29;O:8:"stdClass":8:{s:2:"id";s:3:"114";s:10:"id_chamada";s:13:"1416354390.58";s:8:"calldate";s:19:"2014-11-18 21:46:55";s:5:"ramal";s:4:"2065";s:5:"nota1";s:1:"4";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"3";s:10:"agent_code";s:3:"157";}i:30;O:8:"stdClass":8:{s:2:"id";s:3:"113";s:10:"id_chamada";s:13:"1416353203.57";s:8:"calldate";s:19:"2014-11-18 21:27:33";s:5:"ramal";s:10:"3137692000";s:5:"nota1";s:1:"4";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"3";s:10:"agent_code";s:3:"157";}i:31;O:8:"stdClass":8:{s:2:"id";s:3:"112";s:10:"id_chamada";s:13:"1416353203.57";s:8:"calldate";s:19:"2014-11-18 21:27:32";s:5:"ramal";s:10:"3137692000";s:5:"nota1";s:1:"4";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"3";s:10:"agent_code";s:3:"157";}i:32;O:8:"stdClass":8:{s:2:"id";s:3:"111";s:10:"id_chamada";s:13:"1416353203.57";s:8:"calldate";s:19:"2014-11-18 21:27:32";s:5:"ramal";s:10:"3137692000";s:5:"nota1";s:1:"4";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"3";s:10:"agent_code";s:3:"157";}i:33;O:8:"stdClass":8:{s:2:"id";s:3:"110";s:10:"id_chamada";s:13:"1416341452.54";s:8:"calldate";s:19:"2014-11-18 18:11:23";s:5:"ramal";s:4:"2064";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"3";s:10:"agent_code";s:3:"127";}i:34;O:8:"stdClass":8:{s:2:"id";s:3:"109";s:10:"id_chamada";s:13:"1416317682.51";s:8:"calldate";s:19:"2014-11-18 11:35:07";s:5:"ramal";s:4:"2039";s:5:"nota1";s:1:"3";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"5";s:10:"agent_code";s:3:"666";}i:35;O:8:"stdClass":8:{s:2:"id";s:3:"108";s:10:"id_chamada";s:13:"1416317532.49";s:8:"calldate";s:19:"2014-11-18 11:32:47";s:5:"ramal";s:4:"2039";s:5:"nota1";s:1:"4";s:7:"servico";s:0:"";s:5:"nota2";s:0:"";s:10:"agent_code";s:3:"666";}i:36;O:8:"stdClass":8:{s:2:"id";s:3:"107";s:10:"id_chamada";s:13:"1416317491.48";s:8:"calldate";s:19:"2014-11-18 11:31:57";s:5:"ramal";s:4:"2002";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"5";s:10:"agent_code";s:3:"102";}i:37;O:8:"stdClass":8:{s:2:"id";s:3:"106";s:10:"id_chamada";s:13:"1416317449.47";s:8:"calldate";s:19:"2014-11-18 11:31:13";s:5:"ramal";s:4:"2002";s:5:"nota1";s:1:"5";s:7:"servico";s:0:"";s:5:"nota2";s:0:"";s:10:"agent_code";s:3:"102";}i:38;O:8:"stdClass":8:{s:2:"id";s:3:"105";s:10:"id_chamada";s:13:"1416317289.46";s:8:"calldate";s:19:"2014-11-18 11:28:31";s:5:"ramal";s:4:"2002";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"5";s:10:"agent_code";s:3:"102";}i:39;O:8:"stdClass":8:{s:2:"id";s:3:"104";s:10:"id_chamada";s:13:"1416001608.33";s:8:"calldate";s:19:"2014-11-14 19:47:59";s:5:"ramal";s:3:"VRT";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"4";s:10:"agent_code";s:1:"5";}i:40;O:8:"stdClass":8:{s:2:"id";s:3:"103";s:10:"id_chamada";s:13:"1416001608.33";s:8:"calldate";s:19:"2014-11-14 19:47:10";s:5:"ramal";s:10:"3137692000";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"4";s:10:"agent_code";s:3:"157";}i:41;O:8:"stdClass":8:{s:2:"id";s:3:"102";s:10:"id_chamada";s:13:"1416001127.32";s:8:"calldate";s:19:"2014-11-14 19:39:08";s:5:"ramal";s:12:"553139392199";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"4";s:10:"agent_code";s:3:"127";}i:42;O:8:"stdClass":8:{s:2:"id";s:3:"101";s:10:"id_chamada";s:13:"1415995465.29";s:8:"calldate";s:19:"2014-11-14 18:04:39";s:5:"ramal";s:4:"2064";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"5";s:10:"agent_code";s:3:"127";}i:43;O:8:"stdClass":8:{s:2:"id";s:3:"100";s:10:"id_chamada";s:13:"1415981606.26";s:8:"calldate";s:19:"2014-11-14 14:13:41";s:5:"ramal";s:4:"2039";s:5:"nota1";s:1:"1";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"1";s:10:"agent_code";s:3:"666";}i:44;O:8:"stdClass":8:{s:2:"id";s:2:"99";s:10:"id_chamada";s:13:"1415981481.25";s:8:"calldate";s:19:"2014-11-14 14:11:34";s:5:"ramal";s:4:"2039";s:5:"nota1";s:1:"2";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"2";s:10:"agent_code";s:3:"666";}i:45;O:8:"stdClass":8:{s:2:"id";s:2:"98";s:10:"id_chamada";s:13:"1415973360.22";s:8:"calldate";s:19:"2014-11-14 11:56:14";s:5:"ramal";s:4:"2020";s:5:"nota1";s:1:"5";s:7:"servico";s:0:"";s:5:"nota2";s:0:"";s:10:"agent_code";s:2:"56";}i:46;O:8:"stdClass":8:{s:2:"id";s:2:"97";s:10:"id_chamada";s:13:"1415972827.18";s:8:"calldate";s:19:"2014-11-14 11:47:30";s:5:"ramal";s:4:"2079";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"5";s:10:"agent_code";s:3:"175";}i:47;O:8:"stdClass":8:{s:2:"id";s:2:"96";s:10:"id_chamada";s:13:"1415972530.17";s:8:"calldate";s:19:"2014-11-14 11:42:36";s:5:"ramal";s:4:"2051";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"4";s:10:"agent_code";s:3:"162";}i:48;O:8:"stdClass":8:{s:2:"id";s:2:"95";s:10:"id_chamada";s:13:"1415972447.15";s:8:"calldate";s:19:"2014-11-14 11:41:15";s:5:"ramal";s:4:"2097";s:5:"nota1";s:1:"3";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"3";s:10:"agent_code";s:3:"129";}i:49;O:8:"stdClass":8:{s:2:"id";s:2:"94";s:10:"id_chamada";s:13:"1415972371.14";s:8:"calldate";s:19:"2014-11-14 11:39:46";s:5:"ramal";s:4:"2101";s:5:"nota1";s:1:"4";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"3";s:10:"agent_code";s:3:"444";}i:50;O:8:"stdClass":8:{s:2:"id";s:2:"93";s:10:"id_chamada";s:13:"1415972119.11";s:8:"calldate";s:19:"2014-11-14 11:35:41";s:5:"ramal";s:4:"2039";s:5:"nota1";s:1:"3";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"5";s:10:"agent_code";s:3:"666";}i:51;O:8:"stdClass":8:{s:2:"id";s:2:"92";s:10:"id_chamada";s:13:"1415970569.10";s:8:"calldate";s:19:"2014-11-14 11:09:51";s:5:"ramal";s:4:"2039";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"5";s:10:"agent_code";N;}i:52;O:8:"stdClass":8:{s:2:"id";s:2:"91";s:10:"id_chamada";s:3:"700";s:8:"calldate";s:19:"2014-11-14 10:53:35";s:5:"ramal";s:0:"";s:5:"nota1";s:17:"1415969561.5#2039";s:7:"servico";s:0:"";s:5:"nota2";s:0:"";s:10:"agent_code";N;}i:53;O:8:"stdClass":8:{s:2:"id";s:2:"90";s:10:"id_chamada";s:12:"1415964839.2";s:8:"calldate";s:19:"2014-11-14 09:34:17";s:5:"ramal";s:4:"2039";s:5:"nota1";s:1:"4";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"3";s:10:"agent_code";N;}i:54;O:8:"stdClass":8:{s:2:"id";s:2:"89";s:10:"id_chamada";s:12:"1415964624.1";s:8:"calldate";s:19:"2014-11-14 09:30:43";s:5:"ramal";s:4:"2039";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"5";s:10:"agent_code";N;}i:55;O:8:"stdClass":8:{s:2:"id";s:2:"88";s:10:"id_chamada";s:14:"1415660132.169";s:8:"calldate";s:19:"2014-11-10 20:55:50";s:5:"ramal";s:4:"2051";s:5:"nota1";s:1:"4";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"3";s:10:"agent_code";s:0:"";}i:56;O:8:"stdClass":8:{s:2:"id";s:2:"87";s:10:"id_chamada";s:14:"1415657432.167";s:8:"calldate";s:19:"2014-11-10 20:10:48";s:5:"ramal";s:12:"553139392199";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"4";s:10:"agent_code";s:0:"";}i:57;O:8:"stdClass":8:{s:2:"id";s:2:"86";s:10:"id_chamada";s:14:"1415656087.166";s:8:"calldate";s:19:"2014-11-10 19:48:23";s:5:"ramal";s:4:"2078";s:5:"nota1";s:1:"2";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"2";s:10:"agent_code";s:0:"";}i:58;O:8:"stdClass":8:{s:2:"id";s:2:"85";s:10:"id_chamada";s:14:"1415653934.164";s:8:"calldate";s:19:"2014-11-10 19:12:36";s:5:"ramal";s:4:"2051";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"3";s:10:"agent_code";s:0:"";}i:59;O:8:"stdClass":8:{s:2:"id";s:2:"84";s:10:"id_chamada";s:14:"1415653530.163";s:8:"calldate";s:19:"2014-11-10 19:05:46";s:5:"ramal";s:10:"3137692000";s:5:"nota1";s:1:"4";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"4";s:10:"agent_code";s:0:"";}i:60;O:8:"stdClass":8:{s:2:"id";s:2:"83";s:10:"id_chamada";s:14:"1415646975.162";s:8:"calldate";s:19:"2014-11-10 17:17:07";s:5:"ramal";s:10:"3137692000";s:5:"nota1";s:1:"4";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"3";s:10:"agent_code";s:0:"";}i:61;O:8:"stdClass":8:{s:2:"id";s:2:"82";s:10:"id_chamada";s:14:"1415637833.161";s:8:"calldate";s:19:"2014-11-10 14:44:12";s:5:"ramal";s:4:"2063";s:5:"nota1";s:1:"4";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"3";s:10:"agent_code";s:0:"";}i:62;O:8:"stdClass":8:{s:2:"id";s:2:"81";s:10:"id_chamada";s:14:"1415637266.160";s:8:"calldate";s:19:"2014-11-10 14:34:43";s:5:"ramal";s:4:"2060";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"5";s:10:"agent_code";s:0:"";}i:63;O:8:"stdClass":8:{s:2:"id";s:2:"80";s:10:"id_chamada";s:14:"1415567704.159";s:8:"calldate";s:19:"2014-11-09 19:15:42";s:5:"ramal";s:10:"3137692000";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"5";s:10:"agent_code";s:0:"";}i:64;O:8:"stdClass":8:{s:2:"id";s:2:"79";s:10:"id_chamada";s:14:"1415462067.156";s:8:"calldate";s:19:"2014-11-08 13:54:57";s:5:"ramal";s:10:"3137692000";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"5";s:10:"agent_code";s:0:"";}i:65;O:8:"stdClass":8:{s:2:"id";s:2:"78";s:10:"id_chamada";s:14:"1415462019.155";s:8:"calldate";s:19:"2014-11-08 13:54:14";s:5:"ramal";s:12:"553139392199";s:5:"nota1";s:1:"4";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"3";s:10:"agent_code";s:0:"";}i:66;O:8:"stdClass":8:{s:2:"id";s:2:"77";s:10:"id_chamada";s:14:"1415460980.153";s:8:"calldate";s:19:"2014-11-08 13:36:36";s:5:"ramal";s:12:"553139392199";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"5";s:10:"agent_code";s:0:"";}i:67;O:8:"stdClass":8:{s:2:"id";s:2:"76";s:10:"id_chamada";s:14:"1415459971.150";s:8:"calldate";s:19:"2014-11-08 13:19:47";s:5:"ramal";s:12:"553139392199";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"5";s:10:"agent_code";s:0:"";}i:68;O:8:"stdClass":8:{s:2:"id";s:2:"75";s:10:"id_chamada";s:14:"1415458527.148";s:8:"calldate";s:19:"2014-11-08 12:55:50";s:5:"ramal";s:12:"553139392199";s:5:"nota1";s:1:"4";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"3";s:10:"agent_code";s:0:"";}i:69;O:8:"stdClass":8:{s:2:"id";s:2:"74";s:10:"id_chamada";s:14:"1415454712.147";s:8:"calldate";s:19:"2014-11-08 11:52:08";s:5:"ramal";s:12:"553139392199";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"4";s:10:"agent_code";s:0:"";}i:70;O:8:"stdClass":8:{s:2:"id";s:2:"73";s:10:"id_chamada";s:14:"1415454310.145";s:8:"calldate";s:19:"2014-11-08 11:45:45";s:5:"ramal";s:10:"3137692000";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"4";s:10:"agent_code";s:0:"";}i:71;O:8:"stdClass":8:{s:2:"id";s:2:"72";s:10:"id_chamada";s:14:"1415453760.142";s:8:"calldate";s:19:"2014-11-08 11:36:28";s:5:"ramal";s:10:"3137692000";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"4";s:10:"agent_code";s:0:"";}i:72;O:8:"stdClass":8:{s:2:"id";s:2:"71";s:10:"id_chamada";s:14:"1415453760.142";s:8:"calldate";s:19:"2014-11-08 11:36:28";s:5:"ramal";s:10:"3137692000";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"4";s:10:"agent_code";s:0:"";}i:73;O:8:"stdClass":8:{s:2:"id";s:2:"70";s:10:"id_chamada";s:14:"1415453577.141";s:8:"calldate";s:19:"2014-11-08 11:33:15";s:5:"ramal";s:10:"3137692000";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"4";s:10:"agent_code";s:0:"";}i:74;O:8:"stdClass":8:{s:2:"id";s:2:"69";s:10:"id_chamada";s:14:"1415453500.140";s:8:"calldate";s:19:"2014-11-08 11:31:56";s:5:"ramal";s:4:"2088";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"5";s:10:"agent_code";s:0:"";}i:75;O:8:"stdClass":8:{s:2:"id";s:2:"68";s:10:"id_chamada";s:14:"1415453478.139";s:8:"calldate";s:19:"2014-11-08 11:31:37";s:5:"ramal";s:10:"3137692000";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"4";s:10:"agent_code";s:0:"";}i:76;O:8:"stdClass":8:{s:2:"id";s:2:"67";s:10:"id_chamada";s:14:"1415453323.138";s:8:"calldate";s:19:"2014-11-08 11:28:58";s:5:"ramal";s:12:"553139392199";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"5";s:10:"agent_code";s:0:"";}i:77;O:8:"stdClass":8:{s:2:"id";s:2:"66";s:10:"id_chamada";s:14:"1415453245.137";s:8:"calldate";s:19:"2014-11-08 11:28:02";s:5:"ramal";s:10:"3137692000";s:5:"nota1";s:1:"3";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"4";s:10:"agent_code";s:0:"";}i:78;O:8:"stdClass":8:{s:2:"id";s:2:"65";s:10:"id_chamada";s:14:"1415452711.136";s:8:"calldate";s:19:"2014-11-08 11:18:47";s:5:"ramal";s:12:"553139392199";s:5:"nota1";s:1:"4";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"4";s:10:"agent_code";s:0:"";}i:79;O:8:"stdClass":8:{s:2:"id";s:2:"64";s:10:"id_chamada";s:14:"1415451995.135";s:8:"calldate";s:19:"2014-11-08 11:07:39";s:5:"ramal";s:3:"VRT";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"5";s:10:"agent_code";s:0:"";}i:80;O:8:"stdClass":8:{s:2:"id";s:2:"63";s:10:"id_chamada";s:14:"1415451995.135";s:8:"calldate";s:19:"2014-11-08 11:07:11";s:5:"ramal";s:10:"3137692000";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"5";s:10:"agent_code";s:0:"";}i:81;O:8:"stdClass":8:{s:2:"id";s:2:"62";s:10:"id_chamada";s:14:"1415451922.134";s:8:"calldate";s:19:"2014-11-08 11:05:40";s:5:"ramal";s:10:"3137692000";s:5:"nota1";s:1:"2";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"2";s:10:"agent_code";s:0:"";}i:82;O:8:"stdClass":8:{s:2:"id";s:2:"61";s:10:"id_chamada";s:14:"1415451922.134";s:8:"calldate";s:19:"2014-11-08 11:05:40";s:5:"ramal";s:10:"3137692000";s:5:"nota1";s:1:"2";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"2";s:10:"agent_code";s:0:"";}i:83;O:8:"stdClass":8:{s:2:"id";s:2:"60";s:10:"id_chamada";s:14:"1415451821.133";s:8:"calldate";s:19:"2014-11-08 11:04:15";s:5:"ramal";s:10:"3137692000";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"2";s:10:"agent_code";s:0:"";}i:84;O:8:"stdClass":8:{s:2:"id";s:2:"59";s:10:"id_chamada";s:14:"1415451690.131";s:8:"calldate";s:19:"2014-11-08 11:02:24";s:5:"ramal";s:10:"3137692000";s:5:"nota1";s:1:"4";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"3";s:10:"agent_code";s:0:"";}i:85;O:8:"stdClass":8:{s:2:"id";s:2:"58";s:10:"id_chamada";s:14:"1415451690.131";s:8:"calldate";s:19:"2014-11-08 11:02:23";s:5:"ramal";s:10:"3137692000";s:5:"nota1";s:1:"4";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"3";s:10:"agent_code";s:0:"";}i:86;O:8:"stdClass":8:{s:2:"id";s:2:"57";s:10:"id_chamada";s:14:"1415449577.127";s:8:"calldate";s:19:"2014-11-08 10:26:53";s:5:"ramal";s:12:"553139392199";s:5:"nota1";s:1:"4";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"4";s:10:"agent_code";s:0:"";}i:87;O:8:"stdClass":8:{s:2:"id";s:2:"56";s:10:"id_chamada";s:14:"1415448852.126";s:8:"calldate";s:19:"2014-11-08 10:14:47";s:5:"ramal";s:10:"3137692000";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"5";s:10:"agent_code";s:0:"";}i:88;O:8:"stdClass":8:{s:2:"id";s:2:"55";s:10:"id_chamada";s:14:"1415448515.125";s:8:"calldate";s:19:"2014-11-08 10:09:11";s:5:"ramal";s:10:"3137692000";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"4";s:10:"agent_code";s:0:"";}i:89;O:8:"stdClass":8:{s:2:"id";s:2:"54";s:10:"id_chamada";s:14:"1415447954.124";s:8:"calldate";s:19:"2014-11-08 09:59:31";s:5:"ramal";s:4:"2079";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"2";s:10:"agent_code";s:0:"";}i:90;O:8:"stdClass":8:{s:2:"id";s:2:"53";s:10:"id_chamada";s:14:"1415444146.121";s:8:"calldate";s:19:"2014-11-08 08:56:05";s:5:"ramal";s:4:"2085";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"5";s:10:"agent_code";s:0:"";}i:91;O:8:"stdClass":8:{s:2:"id";s:2:"52";s:10:"id_chamada";s:14:"1415444127.116";s:8:"calldate";s:19:"2014-11-08 08:56:03";s:5:"ramal";s:4:"2064";s:5:"nota1";s:1:"2";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"5";s:10:"agent_code";s:0:"";}i:92;O:8:"stdClass":8:{s:2:"id";s:2:"51";s:10:"id_chamada";s:14:"1415444143.120";s:8:"calldate";s:19:"2014-11-08 08:56:00";s:5:"ramal";s:4:"2095";s:5:"nota1";s:1:"5";s:7:"servico";s:0:"";s:5:"nota2";s:0:"";s:10:"agent_code";s:0:"";}i:93;O:8:"stdClass":8:{s:2:"id";s:2:"50";s:10:"id_chamada";s:14:"1415444138.119";s:8:"calldate";s:19:"2014-11-08 08:55:59";s:5:"ramal";s:3:"VRT";s:5:"nota1";s:1:"5";s:7:"servico";s:0:"";s:5:"nota2";s:0:"";s:10:"agent_code";s:0:"";}i:94;O:8:"stdClass":8:{s:2:"id";s:2:"49";s:10:"id_chamada";s:14:"1415444138.119";s:8:"calldate";s:19:"2014-11-08 08:55:54";s:5:"ramal";s:4:"2086";s:5:"nota1";s:1:"5";s:7:"servico";s:0:"";s:5:"nota2";s:0:"";s:10:"agent_code";s:0:"";}i:95;O:8:"stdClass":8:{s:2:"id";s:2:"48";s:10:"id_chamada";s:14:"1415404494.115";s:8:"calldate";s:19:"2014-11-07 21:55:10";s:5:"ramal";s:4:"2051";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"5";s:10:"agent_code";s:0:"";}i:96;O:8:"stdClass":8:{s:2:"id";s:2:"47";s:10:"id_chamada";s:14:"1415404424.114";s:8:"calldate";s:19:"2014-11-07 21:54:01";s:5:"ramal";s:4:"2064";s:5:"nota1";s:1:"4";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"3";s:10:"agent_code";s:0:"";}i:97;O:8:"stdClass":8:{s:2:"id";s:2:"46";s:10:"id_chamada";s:14:"1415395254.111";s:8:"calldate";s:19:"2014-11-07 19:21:10";s:5:"ramal";s:12:"553139392199";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"2";s:10:"agent_code";s:0:"";}i:98;O:8:"stdClass":8:{s:2:"id";s:2:"45";s:10:"id_chamada";s:14:"1415383126.110";s:8:"calldate";s:19:"2014-11-07 15:58:56";s:5:"ramal";s:4:"2101";s:5:"nota1";s:1:"2";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"4";s:10:"agent_code";s:0:"";}i:99;O:8:"stdClass":8:{s:2:"id";s:2:"44";s:10:"id_chamada";s:14:"1415382659.109";s:8:"calldate";s:19:"2014-11-07 15:51:14";s:5:"ramal";s:4:"2063";s:5:"nota1";s:1:"3";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"3";s:10:"agent_code";s:0:"";}i:100;O:8:"stdClass":8:{s:2:"id";s:2:"43";s:10:"id_chamada";s:14:"1415378969.108";s:8:"calldate";s:19:"2014-11-07 14:49:46";s:5:"ramal";s:4:"2061";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"2";s:10:"agent_code";s:0:"";}i:101;O:8:"stdClass":8:{s:2:"id";s:2:"42";s:10:"id_chamada";s:14:"1415313705.107";s:8:"calldate";s:19:"2014-11-06 20:42:03";s:5:"ramal";s:4:"2051";s:5:"nota1";s:1:"4";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"3";s:10:"agent_code";s:0:"";}i:102;O:8:"stdClass":8:{s:2:"id";s:2:"41";s:10:"id_chamada";s:14:"1415311184.105";s:8:"calldate";s:19:"2014-11-06 20:00:00";s:5:"ramal";s:4:"2064";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"5";s:10:"agent_code";s:0:"";}i:103;O:8:"stdClass":8:{s:2:"id";s:2:"40";s:10:"id_chamada";s:14:"1415310998.104";s:8:"calldate";s:19:"2014-11-06 19:56:56";s:5:"ramal";s:10:"3137692000";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"2";s:10:"agent_code";s:0:"";}i:104;O:8:"stdClass":8:{s:2:"id";s:2:"39";s:10:"id_chamada";s:14:"1415309730.102";s:8:"calldate";s:19:"2014-11-06 19:35:59";s:5:"ramal";s:10:"3137692000";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"3";s:10:"agent_code";s:0:"";}i:105;O:8:"stdClass":8:{s:2:"id";s:2:"38";s:10:"id_chamada";s:14:"1415306045.101";s:8:"calldate";s:19:"2014-11-06 18:34:23";s:5:"ramal";s:10:"3137692000";s:5:"nota1";s:1:"5";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"5";s:10:"agent_code";s:0:"";}i:106;O:8:"stdClass":8:{s:2:"id";s:2:"37";s:10:"id_chamada";s:13:"1415293929.98";s:8:"calldate";s:19:"2014-11-06 15:12:28";s:5:"ramal";s:12:"553139392199";s:5:"nota1";s:1:"4";s:7:"servico";s:3:"VRT";s:5:"nota2";s:1:"4";s:10:"agent_code";s:0:"";}}s:6:"idUser";s:1:"8";}'),
('accef086e4de3caf7acce83b064c38ef', '192.168.2.11', 'Mozilla/5.0 (Windows NT 6.1; WOW64; rv:34.0) Gecko/20100101 Firefox/34.0', 1420123290, 'a:1:{s:9:"user_data";s:0:"";}');

-- --------------------------------------------------------

--
-- Estrutura da tabela `webpbxip_usuario`
--

CREATE TABLE IF NOT EXISTS `webpbxip_usuario` (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `login` varchar(45) NOT NULL,
  `senha` text NOT NULL,
  `ativo` tinyint(1) NOT NULL DEFAULT '1',
  `email` varchar(60) DEFAULT NULL,
  `id_perfil` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE KEY `login` (`login`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

--
-- Extraindo dados da tabela `webpbxip_usuario`
--

INSERT INTO `webpbxip_usuario` (`id_usuario`, `nome`, `login`, `senha`, `ativo`, `email`, `id_perfil`) VALUES
(5, 'GESTORES', 'gestores', '7bb9a0405b472aa42be054bf91cebcde', 1, 'telefonia@viareal.com.br', 7),
(8, 'ADMINISTRADOR', 'admin', '21232f297a57a5a743894a0e4a801fc3', 1, 'suporte@delphini.com.br', 5),
(9, 'OPERADOR', 'operador', '06d4f07c943a4da1c8bfe591abbc3579', 1, 'suporte@delphini.com.br', 8);

--
-- Constraints for dumped tables
--

--
-- Limitadores para a tabela `log_acesso`
--
ALTER TABLE `log_acesso`
  ADD CONSTRAINT `fk_log_acesso_usuario1` FOREIGN KEY (`id_usuario`) REFERENCES `webpbxip_usuario` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
