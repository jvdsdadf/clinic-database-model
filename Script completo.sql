-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 09/06/2025 às 13:59
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `clinica`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `agendamento`
--

CREATE TABLE `agendamento` (
  `idAgendamento` int(11) NOT NULL,
  `idPaciente` int(11) DEFAULT NULL,
  `idProfissional` int(11) DEFAULT NULL,
  `dataHoraInicio` datetime DEFAULT NULL,
  `dataHoraFim` datetime DEFAULT NULL,
  `tipoAtendimento` varchar(100) DEFAULT NULL,
  `statusAgendamento` varchar(45) DEFAULT NULL,
  `observacoes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `agendamento`
--

INSERT INTO `agendamento` (`idAgendamento`, `idPaciente`, `idProfissional`, `dataHoraInicio`, `dataHoraFim`, `tipoAtendimento`, `statusAgendamento`, `observacoes`) VALUES
(1, 1, 2, '2025-06-10 14:00:00', '2025-06-10 15:00:00', 'Consulta Psicológica', 'Confirmado', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `diagnosticocid`
--

CREATE TABLE `diagnosticocid` (
  `codigoCID` varchar(10) NOT NULL,
  `descricaoCID` text DEFAULT NULL,
  `categoriaCID` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `diagnosticocid`
--

INSERT INTO `diagnosticocid` (`codigoCID`, `descricaoCID`, `categoriaCID`) VALUES
('F32.9', 'Episódio depressivo não especificado', 'Transtornos mentais e comportamentais'),
('J00', 'Nasofaringite aguda (resfriado comum)', 'Doenças do aparelho respiratório');

-- --------------------------------------------------------

--
-- Estrutura para tabela `itemprescricao`
--

CREATE TABLE `itemprescricao` (
  `idItemPrescricao` int(11) NOT NULL,
  `idPrescricao` int(11) DEFAULT NULL,
  `idMedicamento` int(11) DEFAULT NULL,
  `nomeMedicamento` varchar(255) DEFAULT NULL,
  `dosagem` varchar(100) DEFAULT NULL,
  `formaFaceutica` varchar(100) DEFAULT NULL,
  `posologia` varchar(255) DEFAULT NULL,
  `viaAdministracao` varchar(100) DEFAULT NULL,
  `quantidade` varchar(45) DEFAULT NULL,
  `duracaoTratamento` varchar(100) DEFAULT NULL,
  `observacoesItem` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `itemprescricao`
--

INSERT INTO `itemprescricao` (`idItemPrescricao`, `idPrescricao`, `idMedicamento`, `nomeMedicamento`, `dosagem`, `formaFaceutica`, `posologia`, `viaAdministracao`, `quantidade`, `duracaoTratamento`, `observacoesItem`) VALUES
(1, 1, 2, NULL, '50mg', NULL, 'Tomar 1 comprimido pela manhã, após o café.', NULL, NULL, '30 dias', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `logauditoria`
--

CREATE TABLE `logauditoria` (
  `idLog` int(11) NOT NULL,
  `timestampLog` datetime DEFAULT NULL,
  `idUsuario` int(11) DEFAULT NULL,
  `tipoAcao` varchar(100) DEFAULT NULL,
  `tabelaAfetada` varchar(100) DEFAULT NULL,
  `idRegistroAfetado` varchar(255) DEFAULT NULL,
  `dadosAntigos` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`dadosAntigos`)),
  `dadosNovos` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`dadosNovos`)),
  `descricaoAdicional` text DEFAULT NULL,
  `enderecoIP` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `logauditoria`
--

INSERT INTO `logauditoria` (`idLog`, `timestampLog`, `idUsuario`, `tipoAcao`, `tabelaAfetada`, `idRegistroAfetado`, `dadosAntigos`, `dadosNovos`, `descricaoAdicional`, `enderecoIP`) VALUES
(1, NULL, 2, 'CREATE', 'Agendamento', '1', NULL, '{\"idPaciente\": 1, \"idProfissional\": 2, \"status\": \"Confirmado\"}', NULL, '192.168.1.10');

-- --------------------------------------------------------

--
-- Estrutura para tabela `medicamento`
--

CREATE TABLE `medicamento` (
  `idMedicamento` int(11) NOT NULL,
  `nomeGenerico` varchar(255) DEFAULT NULL,
  `nomeComercial` varchar(45) DEFAULT NULL,
  `concentracaoPadrao` varchar(45) DEFAULT NULL,
  `formaFarmaceuticaPadrao` varchar(45) DEFAULT NULL,
  `laboratorio` varchar(45) DEFAULT NULL,
  `codigoANVISA` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `medicamento`
--

INSERT INTO `medicamento` (`idMedicamento`, `nomeGenerico`, `nomeComercial`, `concentracaoPadrao`, `formaFarmaceuticaPadrao`, `laboratorio`, `codigoANVISA`) VALUES
(1, 'Paracetamol', 'Tylenol', NULL, 'Comprimido 750mg', NULL, NULL),
(2, 'Sertralina', 'Zoloft', NULL, 'Comprimido 50mg', NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `paciente`
--

CREATE TABLE `paciente` (
  `id_paciente` int(11) NOT NULL,
  `nomeCompleto` varchar(45) DEFAULT NULL,
  `dataNascimento` date DEFAULT NULL,
  `cpf` varchar(14) DEFAULT NULL,
  `rg` varchar(20) DEFAULT NULL,
  `endereco_logradouro` varchar(255) DEFAULT NULL,
  `endereco_numero` varchar(10) DEFAULT NULL,
  `endereco_complemento` varchar(100) DEFAULT NULL,
  `endereco_bairro` varchar(100) DEFAULT NULL,
  `endereco_cidade` varchar(100) DEFAULT NULL,
  `enderecoUF` char(2) DEFAULT NULL,
  `enderecoCEP` varchar(9) DEFAULT NULL,
  `telefonePrincipal` varchar(20) DEFAULT NULL,
  `telefoneSecundario` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `historicoMedicoPregresso` text DEFAULT NULL,
  `alergiasConhecidas` text DEFAULT NULL,
  `idResponsavel` int(11) DEFAULT NULL,
  `idProfissionalReferencia` int(11) DEFAULT NULL,
  `dataCadastro` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `paciente`
--

INSERT INTO `paciente` (`id_paciente`, `nomeCompleto`, `dataNascimento`, `cpf`, `rg`, `endereco_logradouro`, `endereco_numero`, `endereco_complemento`, `endereco_bairro`, `endereco_cidade`, `enderecoUF`, `enderecoCEP`, `telefonePrincipal`, `telefoneSecundario`, `email`, `historicoMedicoPregresso`, `alergiasConhecidas`, `idResponsavel`, `idProfissionalReferencia`, `dataCadastro`) VALUES
(1, 'João da Silva', '2005-08-15', '444.444.444-44', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, '2025-06-05 21:42:28');

-- --------------------------------------------------------

--
-- Estrutura para tabela `pacientediagnostico`
--

CREATE TABLE `pacientediagnostico` (
  `idPacienteDiagnostico` int(11) NOT NULL,
  `idPaciente` int(11) DEFAULT NULL,
  `idDiagnosticoCID` int(11) DEFAULT NULL,
  `dataDiagnostico` date DEFAULT NULL,
  `statusDiagnostico` varchar(45) DEFAULT NULL,
  `idProfissional` int(11) DEFAULT NULL,
  `idAgendamento` int(11) DEFAULT NULL,
  `observacoes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `pacientediagnostico`
--

INSERT INTO `pacientediagnostico` (`idPacienteDiagnostico`, `idPaciente`, `idDiagnosticoCID`, `dataDiagnostico`, `statusDiagnostico`, `idProfissional`, `idAgendamento`, `observacoes`) VALUES
(1, 1, 2, '2025-06-10', 'Ativo', 2, NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `perfilacesso`
--

CREATE TABLE `perfilacesso` (
  `idPerfilAcesso` int(11) NOT NULL,
  `nomePerfil` varchar(45) DEFAULT NULL,
  `descricaoPerfil` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `perfilacesso`
--

INSERT INTO `perfilacesso` (`idPerfilAcesso`, `nomePerfil`, `descricaoPerfil`) VALUES
(1, 'Administrador', 'Acesso total ao sistema.'),
(2, 'Médico', 'Acesso a prontuários, agendamentos e prescrições.'),
(3, 'Recepção', 'Acesso a agendamentos e cadastro de pacientes.');

-- --------------------------------------------------------

--
-- Estrutura para tabela `planotratamento`
--

CREATE TABLE `planotratamento` (
  `idPlanoTratamento` int(11) NOT NULL,
  `idPaciente` int(11) DEFAULT NULL,
  `idProfissionalResponsavel` varchar(45) DEFAULT NULL,
  `descricaoTratamento` text DEFAULT NULL,
  `metas` text DEFAULT NULL,
  `dataInicio` date DEFAULT NULL,
  `dataPrevisaoTermino` date DEFAULT NULL,
  `statusPlano` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `planotratamento`
--

INSERT INTO `planotratamento` (`idPlanoTratamento`, `idPaciente`, `idProfissionalResponsavel`, `descricaoTratamento`, `metas`, `dataInicio`, `dataPrevisaoTermino`, `statusPlano`) VALUES
(1, 1, '2', 'Terapia Cognitivo-Comportamental para ansiedade e sintomas depressivos.', 'Reduzir sintomas de ansiedade em 50% em 3 meses.', '2025-06-10', NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `prescricaomedica`
--

CREATE TABLE `prescricaomedica` (
  `idPrescricaoMedica` int(11) NOT NULL,
  `idPaciente` int(11) DEFAULT NULL,
  `idProfissionalPrescritor` int(11) DEFAULT NULL,
  `idPlanoTratamento` int(11) DEFAULT NULL,
  `dataPrescricao` date DEFAULT NULL,
  `validadePrescricao` date DEFAULT NULL,
  `observacoesGerais` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `prescricaomedica`
--

INSERT INTO `prescricaomedica` (`idPrescricaoMedica`, `idPaciente`, `idProfissionalPrescritor`, `idPlanoTratamento`, `dataPrescricao`, `validadePrescricao`, `observacoesGerais`) VALUES
(1, 1, 1, 1, '2025-06-11', '2025-07-11', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `profissional`
--

CREATE TABLE `profissional` (
  `id_profissional` int(11) NOT NULL,
  `nomecompleto` varchar(45) DEFAULT NULL,
  `datanascimento` date DEFAULT NULL,
  `cpf` varchar(14) DEFAULT NULL,
  `rg` varchar(20) DEFAULT NULL,
  `endereco_logradouro` varchar(255) DEFAULT NULL,
  `endereco_numero` varchar(10) DEFAULT NULL,
  `endereco_complemento` varchar(100) DEFAULT NULL,
  `endereco_bairro` varchar(100) DEFAULT NULL,
  `endereco_cidade` varchar(100) DEFAULT NULL,
  `enderecoUF` char(2) DEFAULT NULL,
  `enderecoCEP` varchar(9) DEFAULT NULL,
  `telefonePrincipal` varchar(20) DEFAULT NULL,
  `telefoneSecundario` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `tipoProfissional` varchar(45) DEFAULT NULL,
  `profissionalcol` varchar(45) DEFAULT NULL,
  `funcaoCargo` varchar(100) DEFAULT NULL,
  `numeroConselho` varchar(20) DEFAULT NULL,
  `ufConselho` char(2) DEFAULT NULL,
  `dataAdmissao` date DEFAULT NULL,
  `ativo` tinyint(1) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `profissional`
--

INSERT INTO `profissional` (`id_profissional`, `nomecompleto`, `datanascimento`, `cpf`, `rg`, `endereco_logradouro`, `endereco_numero`, `endereco_complemento`, `endereco_bairro`, `endereco_cidade`, `enderecoUF`, `enderecoCEP`, `telefonePrincipal`, `telefoneSecundario`, `email`, `tipoProfissional`, `profissionalcol`, `funcaoCargo`, `numeroConselho`, `ufConselho`, `dataAdmissao`, `ativo`) VALUES
(1, 'Dr. Carlos Andrade', '1978-05-15', '222.222.222-22', '1.234.567 SSP/DF', 'SHLS 716, Centro Clínico Sul', 'Torre A', 'Sala 301', 'Asa Sul', 'Brasília', 'DF', '70390-700', '(61) 98446-3240', '(61) 3245-1020', 'carlos.andrade@clinica.com', 'Médico', NULL, 'Clínico Geral', '12345', 'DF', '2015-03-10', 1),
(2, 'Dra. Ana Oliveira', '1985-11-22', '333.333.333-33', '23.456.789-0 SSP/SP', 'Rua Augusta', '2500', 'Conjunto 55', 'Cerqueira César', 'São Paulo', 'SP', '01412-100', '(11) 98765-4321', NULL, 'ana.oliveira@clinica.com', 'Psicólogo', NULL, 'Psicóloga Clínica', '06/98765', 'SP', '2018-07-22', 1);

-- --------------------------------------------------------

--
-- Estrutura para tabela `prontuarioevolucao`
--

CREATE TABLE `prontuarioevolucao` (
  `idProntuarioEvolucao` int(11) NOT NULL,
  `idPaciente` int(11) DEFAULT NULL,
  `idProfissional` int(11) DEFAULT NULL,
  `idAgendamento` int(11) DEFAULT NULL,
  `dataHoraRegistro` datetime DEFAULT NULL,
  `observacoesClinicas` text DEFAULT NULL,
  `diagnosticosFormaisTexto` text DEFAULT NULL,
  `planoTerapeutico` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `prontuarioevolucao`
--

INSERT INTO `prontuarioevolucao` (`idProntuarioEvolucao`, `idPaciente`, `idProfissional`, `idAgendamento`, `dataHoraRegistro`, `observacoesClinicas`, `diagnosticosFormaisTexto`, `planoTerapeutico`) VALUES
(1, 1, 2, 1, '2025-06-05 21:42:28', 'Paciente relata humor deprimido e falta de interesse nas atividades. Apresenta-se colaborativo na sessão.', NULL, 'Manter TCC semanal, iniciar técnicas de ativação comportamental.');

-- --------------------------------------------------------

--
-- Estrutura para tabela `responsavel`
--

CREATE TABLE `responsavel` (
  `idResponsavel` int(11) NOT NULL,
  `nomeCompleto` varchar(255) DEFAULT NULL,
  `cpf` varchar(14) DEFAULT NULL,
  `rg` varchar(20) DEFAULT NULL,
  `telefonePrincipal` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `parentesco` varchar(45) DEFAULT NULL,
  `dataNascimento` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `responsavel`
--

INSERT INTO `responsavel` (`idResponsavel`, `nomeCompleto`, `cpf`, `rg`, `telefonePrincipal`, `email`, `parentesco`, `dataNascimento`) VALUES
(1, 'Maria Souza', '111.111.111-11', '11.111.111-1', '11987654321', NULL, 'Mãe', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuario`
--

CREATE TABLE `usuario` (
  `idUsuario` int(11) NOT NULL,
  `login` varchar(45) DEFAULT NULL,
  `senhaHash` varchar(255) DEFAULT NULL,
  `idProfissional` int(11) DEFAULT NULL,
  `Profissional` varchar(45) DEFAULT NULL,
  `nomeExibicao` varchar(255) DEFAULT NULL,
  `emailUsuario` varchar(45) DEFAULT NULL,
  `ativo` tinyint(4) DEFAULT NULL,
  `ultimoLogin` datetime DEFAULT NULL,
  `Usuariocol` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `usuario`
--

INSERT INTO `usuario` (`idUsuario`, `login`, `senhaHash`, `idProfissional`, `Profissional`, `nomeExibicao`, `emailUsuario`, `ativo`, `ultimoLogin`, `Usuariocol`) VALUES
(1, 'carlos.andrade', 'hash_senha_segura_123', 1, NULL, 'Dr. Carlos', 'carlos.andrade@clinica.com', 1, NULL, NULL),
(2, 'ana.oliveira', 'hash_senha_segura_456', 2, NULL, 'Dra. Ana', 'ana.oliveira@clinica.com', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `usuarioperfil`
--

CREATE TABLE `usuarioperfil` (
  `idUsuarioPerfil` int(11) NOT NULL,
  `idUsuario` int(11) DEFAULT NULL,
  `idPerfil` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Despejando dados para a tabela `usuarioperfil`
--

INSERT INTO `usuarioperfil` (`idUsuarioPerfil`, `idUsuario`, `idPerfil`) VALUES
(1, 1, '1'),
(2, 2, '2');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `agendamento`
--
ALTER TABLE `agendamento`
  ADD PRIMARY KEY (`idAgendamento`),
  ADD KEY `fk_Agendamento_Paciente` (`idPaciente`);

--
-- Índices de tabela `diagnosticocid`
--
ALTER TABLE `diagnosticocid`
  ADD PRIMARY KEY (`codigoCID`);

--
-- Índices de tabela `itemprescricao`
--
ALTER TABLE `itemprescricao`
  ADD PRIMARY KEY (`idItemPrescricao`);

--
-- Índices de tabela `logauditoria`
--
ALTER TABLE `logauditoria`
  ADD PRIMARY KEY (`idLog`);

--
-- Índices de tabela `medicamento`
--
ALTER TABLE `medicamento`
  ADD PRIMARY KEY (`idMedicamento`);

--
-- Índices de tabela `paciente`
--
ALTER TABLE `paciente`
  ADD PRIMARY KEY (`id_paciente`);

--
-- Índices de tabela `pacientediagnostico`
--
ALTER TABLE `pacientediagnostico`
  ADD PRIMARY KEY (`idPacienteDiagnostico`);

--
-- Índices de tabela `perfilacesso`
--
ALTER TABLE `perfilacesso`
  ADD PRIMARY KEY (`idPerfilAcesso`);

--
-- Índices de tabela `planotratamento`
--
ALTER TABLE `planotratamento`
  ADD PRIMARY KEY (`idPlanoTratamento`);

--
-- Índices de tabela `prescricaomedica`
--
ALTER TABLE `prescricaomedica`
  ADD PRIMARY KEY (`idPrescricaoMedica`);

--
-- Índices de tabela `profissional`
--
ALTER TABLE `profissional`
  ADD PRIMARY KEY (`id_profissional`),
  ADD UNIQUE KEY `cpf_UNIQUE` (`cpf`);

--
-- Índices de tabela `prontuarioevolucao`
--
ALTER TABLE `prontuarioevolucao`
  ADD PRIMARY KEY (`idProntuarioEvolucao`);

--
-- Índices de tabela `responsavel`
--
ALTER TABLE `responsavel`
  ADD PRIMARY KEY (`idResponsavel`);

--
-- Índices de tabela `usuario`
--
ALTER TABLE `usuario`
  ADD PRIMARY KEY (`idUsuario`),
  ADD UNIQUE KEY `login_UNIQUE` (`login`);

--
-- Índices de tabela `usuarioperfil`
--
ALTER TABLE `usuarioperfil`
  ADD PRIMARY KEY (`idUsuarioPerfil`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `agendamento`
--
ALTER TABLE `agendamento`
  MODIFY `idAgendamento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `itemprescricao`
--
ALTER TABLE `itemprescricao`
  MODIFY `idItemPrescricao` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `logauditoria`
--
ALTER TABLE `logauditoria`
  MODIFY `idLog` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `medicamento`
--
ALTER TABLE `medicamento`
  MODIFY `idMedicamento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `paciente`
--
ALTER TABLE `paciente`
  MODIFY `id_paciente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `pacientediagnostico`
--
ALTER TABLE `pacientediagnostico`
  MODIFY `idPacienteDiagnostico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `perfilacesso`
--
ALTER TABLE `perfilacesso`
  MODIFY `idPerfilAcesso` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de tabela `planotratamento`
--
ALTER TABLE `planotratamento`
  MODIFY `idPlanoTratamento` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `prescricaomedica`
--
ALTER TABLE `prescricaomedica`
  MODIFY `idPrescricaoMedica` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `profissional`
--
ALTER TABLE `profissional`
  MODIFY `id_profissional` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `prontuarioevolucao`
--
ALTER TABLE `prontuarioevolucao`
  MODIFY `idProntuarioEvolucao` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `responsavel`
--
ALTER TABLE `responsavel`
  MODIFY `idResponsavel` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de tabela `usuario`
--
ALTER TABLE `usuario`
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de tabela `usuarioperfil`
--
ALTER TABLE `usuarioperfil`
  MODIFY `idUsuarioPerfil` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `agendamento`
--
ALTER TABLE `agendamento`
  ADD CONSTRAINT `fk_Agendamento_Paciente` FOREIGN KEY (`idPaciente`) REFERENCES `paciente` (`id_paciente`) ON DELETE SET NULL ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
