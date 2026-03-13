USE clinic_db;

-- RESPONSAVEL
INSERT INTO responsavel (
    nome_completo, cpf, rg, telefone_principal, telefone_secundario, email, grau_parentesco
) VALUES
(
    'Maria de Souza', '111.222.333-44', 'MG1234567', '(61)99999-1111', '(61)3333-1111', 'maria.souza@email.com', 'Mae'
),
(
    'Carlos Oliveira', '555.666.777-88', 'DF7654321', '(61)99999-2222', NULL, 'carlos.oliveira@email.com', 'Pai'
);

-- PROFISSIONAL
INSERT INTO profissional (
    nome_completo, data_nascimento, cpf, rg,
    endereco_logradouro, endereco_numero, endereco_complemento,
    endereco_bairro, endereco_cidade, endereco_uf, endereco_cep,
    telefone_principal, telefone_secundario, email,
    tipo_profissional, registro_profissional, funcao_cargo,
    ativo
) VALUES
(
    'Dra. Ana Beatriz Lima', '1985-04-12', '123.456.789-00', 'DF123456',
    'Rua das Flores', '120', 'Sala 201',
    'Centro', 'Brasilia', 'DF', '70000-100',
    '(61)99999-3333', NULL, 'ana.lima@clinica.com',
    'Medica', 'CRM-DF-12345', 'Clinica Geral',
    TRUE
),
(
    'Dr. Pedro Henrique Costa', '1980-09-30', '987.654.321-00', 'DF654321',
    'Avenida Central', '450', NULL,
    'Asa Sul', 'Brasilia', 'DF', '70200-200',
    '(61)99999-4444', '(61)3222-4444', 'pedro.costa@clinica.com',
    'Medico', 'CRM-DF-54321', 'Pediatra',
    TRUE
),
(
    'Juliana Martins', '1990-02-14', '222.333.444-55', 'DF999888',
    'Quadra 10', '55', 'Bloco B',
    'Taguatinga', 'Brasilia', 'DF', '72000-300',
    '(61)99999-5555', NULL, 'juliana.martins@clinica.com',
    'Psicologa', 'CRP-DF-10203', 'Psicologa Clinica',
    TRUE
);

-- PACIENTE
INSERT INTO paciente (
    nome_completo, data_nascimento, cpf, rg,
    endereco_logradouro, endereco_numero, endereco_complemento,
    endereco_bairro, endereco_cidade, endereco_uf, endereco_cep,
    telefone_principal, telefone_secundario, email,
    historico_medico_pregresso, alergias_conhecidas,
    id_responsavel, id_profissional_referencia
) VALUES
(
    'Lucas Almeida Souza', '2015-06-18', '101.202.303-40', 'DF111222',
    'Rua A', '10', NULL,
    'Samambaia', 'Brasilia', 'DF', '72300-001',
    '(61)99911-1111', NULL, 'lucas.almeida@email.com',
    'Historico de rinite alergica', 'Penicilina',
    1, 2
),
(
    'Fernanda Rocha Silva', '1998-11-25', '404.505.606-70', 'DF333444',
    'Rua B', '200', 'Apto 302',
    'Aguas Claras', 'Brasilia', 'DF', '71900-002',
    '(61)99922-2222', '(61)3344-2222', 'fernanda.rocha@email.com',
    'Sem historico clinico relevante', 'Nenhuma',
    NULL, 1
),
(
    'Mateus Oliveira Costa', '2012-03-08', '707.808.909-10', 'DF555666',
    'Rua C', '85', NULL,
    'Ceilandia', 'Brasilia', 'DF', '72200-003',
    '(61)99933-3333', NULL, 'mateus.costa@email.com',
    'Asma controlada', 'Dipirona',
    2, 2
);

-- AGENDAMENTO
INSERT INTO agendamento (
    id_paciente, id_profissional, data_hora_inicio, data_hora_fim_estimada,
    tipo_atendimento, status_agendamento, observacoes
) VALUES
(
    1, 2, '2026-03-15 09:00:00', '2026-03-15 09:30:00',
    'Consulta presencial', 'Agendado', 'Primeira consulta pediatrica do semestre'
),
(
    2, 1, '2026-03-15 10:00:00', '2026-03-15 10:40:00',
    'Consulta presencial', 'Concluido', 'Retorno para avaliacao clinica'
),
(
    3, 2, '2026-03-16 14:00:00', '2026-03-16 14:30:00',
    'Teleatendimento', 'Agendado', 'Acompanhamento respiratorio'
);

-- PLANO_TRATAMENTO
INSERT INTO plano_tratamento (
    id_paciente, id_profissional_responsavel, descricao_tratamento, metas,
    data_inicio, data_previsao_termino, status_plano
) VALUES
(
    1, 2, 'Controle de sintomas respiratorios com acompanhamento pediatrico',
    'Reduzir crises alergicas e melhorar qualidade do sono',
    '2026-03-15', '2026-06-15', 'Ativo'
),
(
    3, 2, 'Acompanhamento para controle de asma leve',
    'Reduzir episodios e melhorar resposta ao tratamento',
    '2026-03-16', '2026-07-16', 'Ativo'
);

-- MEDICAMENTO
INSERT INTO medicamento (
    nome_generico, nome_comercial, concentracao_padrao, forma_farmaceutica_padrao,
    laboratorio, codigo_anvisa
) VALUES
(
    'Loratadina', 'Claritin', '10 mg', 'Comprimido',
    'Bayer', 'ANV123456'
),
(
    'Salbutamol', 'Aerolin', '100 mcg/dose', 'Spray',
    'GSK', 'ANV654321'
),
(
    'Paracetamol', 'Tylenol', '750 mg', 'Comprimido',
    'Janssen', 'ANV111222'
);

-- PRESCRICAO_MEDICA
INSERT INTO prescricao_medica (
    id_paciente, id_profissional_prescritor, id_plano_tratamento,
    data_prescricao, data_validade_prescricao, observacoes_gerais
) VALUES
(
    1, 2, 1, '2026-03-15', '2026-04-15',
    'Usar medicacao conforme orientacao medica e retornar em 30 dias'
),
(
    3, 2, 2, '2026-03-16', '2026-04-16',
    'Manter acompanhamento e observar resposta ao broncodilatador'
);

-- ITEM_PRESCRICAO
INSERT INTO item_prescricao (
    id_prescricao_medica, id_medicamento, nome_medicamento, dosagem,
    forma_farmaceutica, posologia, via_administracao, duracao_tratamento
) VALUES
(
    1, 1, 'Loratadina', '10 mg',
    'Comprimido', '1 comprimido ao dia por 15 dias', 'Oral', '15 dias'
),
(
    2, 2, 'Salbutamol', '100 mcg/dose',
    'Spray', '2 inaloes em caso de falta de ar, ate 3x ao dia', 'Inalatoria', '30 dias'
);

-- DIAGNOSTICO_CID
INSERT INTO diagnostico_cid (
    codigo_cid, descricao_cid, categoria_cid
) VALUES
(
    'J30.4', 'Rinite alergica nao especificada', 'Doencas respiratorias'
),
(
    'J45.0', 'Asma predominantemente alergica', 'Doencas respiratorias'
),
(
    'R51', 'Cefaleia', 'Sintomas gerais'
);

-- PACIENTE_DIAGNOSTICO
INSERT INTO paciente_diagnostico (
    id_paciente, codigo_cid, id_profissional, id_agendamento, observacoes
) VALUES
(
    1, 'J30.4', 2, 1, 'Paciente apresentou sintomas compativeis com rinite alergica'
),
(
    3, 'J45.0', 2, 3, 'Historico e sinais clinicos compativeis com asma leve'
),
(
    2, 'R51', 1, 2, 'Paciente relatou episodios recorrentes de cefaleia'
);

-- PRONTUARIO_EVOLUCAO
INSERT INTO prontuario_evolucao (
    id_paciente, id_profissional, id_agendamento,
    observacoes_clinicas, diagnostico_formal_texto, conduta_texto
) VALUES
(
    1, 2, 1,
    'Paciente com obstrucao nasal leve e espirros frequentes.',
    'Quadro sugestivo de rinite alergica.',
    'Orientado uso de anti-histaminico e retorno ambulatorial.'
),
(
    2, 1, 2,
    'Paciente com queixa de cefaleia sem sinais neurologicos de alarme.',
    'Cefaleia inespecifica em investigacao.',
    'Orientado controle de sintomas e reavaliacao clinica.'
),
(
    3, 2, 3,
    'Paciente com episodios leves de dispneia e sibilancia esporadica.',
    'Asma leve controlavel com broncodilatador de resgate.',
    'Manter acompanhamento e revisar tecnica inalatória.'
);

-- USUARIO
INSERT INTO usuario (
    login, senha_hash, id_profissional, nome_exibicao,
    email_usuario, ativo, ultimo_login, usuario_criacao
) VALUES
(
    'ana.lima', '$2b$12$hash_exemplo_ana', 1, 'Dra. Ana Lima',
    'ana.lima@clinica.com', TRUE, '2026-03-14 08:10:00', 'system'
),
(
    'pedro.costa', '$2b$12$hash_exemplo_pedro', 2, 'Dr. Pedro Costa',
    'pedro.costa@clinica.com', TRUE, '2026-03-14 08:20:00', 'system'
),
(
    'juliana.martins', '$2b$12$hash_exemplo_juliana', 3, 'Juliana Martins',
    'juliana.martins@clinica.com', TRUE, '2026-03-14 08:30:00', 'system'
);

-- PERFIL_ACESSO
INSERT INTO perfil_acesso (
    nome_perfil, descricao_perfil
) VALUES
(
    'ADMIN', 'Acesso administrativo completo ao sistema'
),
(
    'MEDICO', 'Acesso clinico para registro de consultas e prescricoes'
),
(
    'PSICOLOGO', 'Acesso para evolucoes e acompanhamento psicologico'
);

-- USUARIO_PERFIL
INSERT INTO usuario_perfil (
    id_usuario, id_perfil_acesso
) VALUES
(1, 1),
(1, 2),
(2, 2),
(3, 3);

-- LOG_AUDITORIA
INSERT INTO log_auditoria (
    id_usuario, tipo_acao, tabela_afetada, id_registro_afetado,
    dados_antigos, dados_novos, descricao_adicional, endereco_ip
) VALUES
(
    1, 'INSERT', 'paciente', '1',
    NULL,
    JSON_OBJECT('nome_completo', 'Lucas Almeida Souza', 'cpf', '101.202.303-40'),
    'Cadastro inicial do paciente',
    '192.168.0.10'
),
(
    2, 'INSERT', 'prescricao_medica', '1',
    NULL,
    JSON_OBJECT('id_paciente', 1, 'data_prescricao', '2026-03-15'),
    'Nova prescricao criada durante consulta',
    '192.168.0.11'
),
(
    1, 'UPDATE', 'agendamento', '2',
    JSON_OBJECT('status_agendamento', 'Agendado'),
    JSON_OBJECT('status_agendamento', 'Concluido'),
    'Atualizacao de status apos atendimento',
    '192.168.0.10'
);
