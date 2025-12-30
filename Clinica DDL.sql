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

CREATE TABLE `diagnosticocid` (
  `codigoCID` varchar(10) NOT NULL,
  `descricaoCID` text DEFAULT NULL,
  `categoriaCID` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

CREATE TABLE `medicamento` (
  `idMedicamento` int(11) NOT NULL,
  `nomeGenerico` varchar(255) DEFAULT NULL,
  `nomeComercial` varchar(45) DEFAULT NULL,
  `concentracaoPadrao` varchar(45) DEFAULT NULL,
  `formaFarmaceuticaPadrao` varchar(45) DEFAULT NULL,
  `laboratorio` varchar(45) DEFAULT NULL,
  `codigoANVISA` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

I

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

CREATE TABLE `perfilacesso` (
  `idPerfilAcesso` int(11) NOT NULL,
  `nomePerfil` varchar(45) DEFAULT NULL,
  `descricaoPerfil` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

CREATE TABLE `prescricaomedica` (
  `idPrescricaoMedica` int(11) NOT NULL,
  `idPaciente` int(11) DEFAULT NULL,
  `idProfissionalPrescritor` int(11) DEFAULT NULL,
  `idPlanoTratamento` int(11) DEFAULT NULL,
  `dataPrescricao` date DEFAULT NULL,
  `validadePrescricao` date DEFAULT NULL,
  `observacoesGerais` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

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

CREATE TABLE `usuarioperfil` (
  `idUsuarioPerfil` int(11) NOT NULL,
  `idUsuario` int(11) DEFAULT NULL,
  `idPerfil` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

