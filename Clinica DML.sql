INSERT INTO `agendamento` (`idAgendamento`, `idPaciente`, `idProfissional`, `dataHoraInicio`, `dataHoraFim`, `tipoAtendimento`, `statusAgendamento`, `observacoes`) VALUES
(1, 1, 2, '2025-06-10 14:00:00', '2025-06-10 15:00:00', 'Consulta Psicológica', 'Confirmado', NULL);

INSERT INTO `diagnosticocid` (`codigoCID`, `descricaoCID`, `categoriaCID`) VALUES
('F32.9', 'Episódio depressivo não especificado', 'Transtornos mentais e comportamentais'),
('J00', 'Nasofaringite aguda (resfriado comum)', 'Doenças do aparelho respiratório');

INSERT INTO `itemprescricao` (`idItemPrescricao`, `idPrescricao`, `idMedicamento`, `nomeMedicamento`, `dosagem`, `formaFaceutica`, `posologia`, `viaAdministracao`, `quantidade`, `duracaoTratamento`, `observacoesItem`) VALUES
(1, 1, 2, NULL, '50mg', NULL, 'Tomar 1 comprimido pela manhã, após o café.', NULL, NULL, '30 dias', NULL);

INSERT INTO `logauditoria` (`idLog`, `timestampLog`, `idUsuario`, `tipoAcao`, `tabelaAfetada`, `idRegistroAfetado`, `dadosAntigos`, `dadosNovos`, `descricaoAdicional`, `enderecoIP`) VALUES
(1, NULL, 2, 'CREATE', 'Agendamento', '1', NULL, '{\"idPaciente\": 1, \"idProfissional\": 2, \"status\": \"Confirmado\"}', NULL, '192.168.1.10');

INSERT INTO `medicamento` (`idMedicamento`, `nomeGenerico`, `nomeComercial`, `concentracaoPadrao`, `formaFarmaceuticaPadrao`, `laboratorio`, `codigoANVISA`) VALUES
(1, 'Paracetamol', 'Tylenol', NULL, 'Comprimido 750mg', NULL, NULL),
(2, 'Sertralina', 'Zoloft', NULL, 'Comprimido 50mg', NULL, NULL);

INSERT INTO `paciente` (`id_paciente`, `nomeCompleto`, `dataNascimento`, `cpf`, `rg`, `endereco_logradouro`, `endereco_numero`, `endereco_complemento`, `endereco_bairro`, `endereco_cidade`, `enderecoUF`, `enderecoCEP`, `telefonePrincipal`, `telefoneSecundario`, `email`, `historicoMedicoPregresso`, `alergiasConhecidas`, `idResponsavel`, `idProfissionalReferencia`, `dataCadastro`) VALUES
(1, 'João da Silva', '2005-08-15', '444.444.444-44', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, 1, '2025-06-05 21:42:28');

INSERT INTO `pacientediagnostico` (`idPacienteDiagnostico`, `idPaciente`, `idDiagnosticoCID`, `dataDiagnostico`, `statusDiagnostico`, `idProfissional`, `idAgendamento`, `observacoes`) VALUES
(1, 1, 2, '2025-06-10', 'Ativo', 2, NULL, NULL);

INSERT INTO `perfilacesso` (`idPerfilAcesso`, `nomePerfil`, `descricaoPerfil`) VALUES
(1, 'Administrador', 'Acesso total ao sistema.'),
(2, 'Médico', 'Acesso a prontuários, agendamentos e prescrições.'),
(3, 'Recepção', 'Acesso a agendamentos e cadastro de pacientes.');

INSERT INTO `planotratamento` (`idPlanoTratamento`, `idPaciente`, `idProfissionalResponsavel`, `descricaoTratamento`, `metas`, `dataInicio`, `dataPrevisaoTermino`, `statusPlano`) VALUES
(1, 1, '2', 'Terapia Cognitivo-Comportamental para ansiedade e sintomas depressivos.', 'Reduzir sintomas de ansiedade em 50% em 3 meses.', '2025-06-10', NULL, NULL);

INSERT INTO `prescricaomedica` (`idPrescricaoMedica`, `idPaciente`, `idProfissionalPrescritor`, `idPlanoTratamento`, `dataPrescricao`, `validadePrescricao`, `observacoesGerais`) VALUES
(1, 1, 1, 1, '2025-06-11', '2025-07-11', NULL);

INSERT INTO `profissional` (`id_profissional`, `nomecompleto`, `datanascimento`, `cpf`, `rg`, `endereco_logradouro`, `endereco_numero`, `endereco_complemento`, `endereco_bairro`, `endereco_cidade`, `enderecoUF`, `enderecoCEP`, `telefonePrincipal`, `telefoneSecundario`, `email`, `tipoProfissional`, `profissionalcol`, `funcaoCargo`, `numeroConselho`, `ufConselho`, `dataAdmissao`, `ativo`) VALUES
(1, 'Dr. Carlos Andrade', NULL, '222.222.222-22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'carlos.andrade@clinica.com', 'Médico', NULL, 'Clínico Geral', NULL, NULL, NULL, 1),
(2, 'Dra. Ana Oliveira', NULL, '333.333.333-33', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'ana.oliveira@clinica.com', 'Psicólogo', NULL, 'Psicóloga Clínica', NULL, NULL, NULL, 1);

INSERT INTO `prontuarioevolucao` (`idProntuarioEvolucao`, `idPaciente`, `idProfissional`, `idAgendamento`, `dataHoraRegistro`, `observacoesClinicas`, `diagnosticosFormaisTexto`, `planoTerapeutico`) VALUES
(1, 1, 2, 1, '2025-06-05 21:42:28', 'Paciente relata humor deprimido e falta de interesse nas atividades. Apresenta-se colaborativo na sessão.', NULL, 'Manter TCC semanal, iniciar técnicas de ativação comportamental.');

INSERT INTO `responsavel` (`idResponsavel`, `nomeCompleto`, `cpf`, `rg`, `telefonePrincipal`, `email`, `parentesco`, `dataNascimento`) VALUES
(1, 'Maria Souza', '111.111.111-11', '11.111.111-1', '11987654321', NULL, 'Mãe', NULL);

INSERT INTO `usuario` (`idUsuario`, `login`, `senhaHash`, `idProfissional`, `Profissional`, `nomeExibicao`, `emailUsuario`, `ativo`, `ultimoLogin`, `Usuariocol`) VALUES
(1, 'carlos.andrade', 'hash_senha_segura_123', 1, NULL, 'Dr. Carlos', 'carlos.andrade@clinica.com', 1, NULL, NULL),
(2, 'ana.oliveira', 'hash_senha_segura_456', 2, NULL, 'Dra. Ana', 'ana.oliveira@clinica.com', 1, NULL, NULL);

INSERT INTO `usuarioperfil` (`idUsuarioPerfil`, `idUsuario`, `idPerfil`) VALUES
(1, 1, '1'),
(2, 2, '2');