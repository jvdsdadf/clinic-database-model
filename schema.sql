CREATE DATABASE IF NOT EXISTS clinic_db;
USE clinic_db;

CREATE TABLE responsavel (
    id_responsavel INT AUTO_INCREMENT PRIMARY KEY,
    nome_completo VARCHAR(255) NOT NULL,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    rg VARCHAR(20),
    telefone_principal VARCHAR(20),
    telefone_secundario VARCHAR(20),
    email VARCHAR(255),
    grau_parentesco VARCHAR(50)
);

CREATE TABLE profissional (
    id_profissional INT AUTO_INCREMENT PRIMARY KEY,
    nome_completo VARCHAR(255) NOT NULL,
    data_nascimento DATE,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    rg VARCHAR(20),
    endereco_logradouro VARCHAR(255),
    endereco_numero VARCHAR(10),
    endereco_complemento VARCHAR(100),
    endereco_bairro VARCHAR(100),
    endereco_cidade VARCHAR(100),
    endereco_uf CHAR(2),
    endereco_cep VARCHAR(9),
    telefone_principal VARCHAR(20),
    telefone_secundario VARCHAR(20),
    email VARCHAR(255),
    tipo_profissional VARCHAR(45),
    registro_profissional VARCHAR(45),
    funcao_cargo VARCHAR(100),
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE paciente (
    id_paciente INT AUTO_INCREMENT PRIMARY KEY,
    nome_completo VARCHAR(255) NOT NULL,
    data_nascimento DATE,
    cpf VARCHAR(14) NOT NULL UNIQUE,
    rg VARCHAR(20),
    endereco_logradouro VARCHAR(255),
    endereco_numero VARCHAR(10),
    endereco_complemento VARCHAR(100),
    endereco_bairro VARCHAR(100),
    endereco_cidade VARCHAR(100),
    endereco_uf CHAR(2),
    endereco_cep VARCHAR(9),
    telefone_principal VARCHAR(20),
    telefone_secundario VARCHAR(20),
    email VARCHAR(255),
    historico_medico_pregresso TEXT,
    alergias_conhecidas TEXT,
    id_responsavel INT,
    id_profissional_referencia INT,
    data_cadastro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_paciente_responsavel
        FOREIGN KEY (id_responsavel) REFERENCES responsavel(id_responsavel),
    CONSTRAINT fk_paciente_profissional_referencia
        FOREIGN KEY (id_profissional_referencia) REFERENCES profissional(id_profissional)
);

CREATE TABLE agendamento (
    id_agendamento INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT NOT NULL,
    id_profissional INT NOT NULL,
    data_hora_inicio DATETIME NOT NULL,
    data_hora_fim_estimada DATETIME,
    tipo_atendimento VARCHAR(50),
    status_agendamento VARCHAR(30),
    observacoes TEXT,
    CONSTRAINT fk_agendamento_paciente
        FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente),
    CONSTRAINT fk_agendamento_profissional
        FOREIGN KEY (id_profissional) REFERENCES profissional(id_profissional)
);

CREATE TABLE plano_tratamento (
    id_plano_tratamento INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT NOT NULL,
    id_profissional_responsavel INT NOT NULL,
    descricao_tratamento TEXT NOT NULL,
    metas TEXT,
    data_inicio DATE,
    data_previsao_termino DATE,
    status_plano VARCHAR(45),
    CONSTRAINT fk_plano_tratamento_paciente
        FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente),
    CONSTRAINT fk_plano_tratamento_profissional
        FOREIGN KEY (id_profissional_responsavel) REFERENCES profissional(id_profissional)
);

CREATE TABLE medicamento (
    id_medicamento INT AUTO_INCREMENT PRIMARY KEY,
    nome_generico VARCHAR(100) NOT NULL,
    nome_comercial VARCHAR(100),
    concentracao_padrao VARCHAR(100),
    forma_farmaceutica_padrao VARCHAR(100),
    laboratorio VARCHAR(100),
    codigo_anvisa VARCHAR(45)
);

CREATE TABLE prescricao_medica (
    id_prescricao_medica INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT NOT NULL,
    id_profissional_prescritor INT NOT NULL,
    id_plano_tratamento INT,
    data_prescricao DATE NOT NULL,
    data_validade_prescricao DATE,
    observacoes_gerais TEXT,
    CONSTRAINT fk_prescricao_paciente
        FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente),
    CONSTRAINT fk_prescricao_profissional
        FOREIGN KEY (id_profissional_prescritor) REFERENCES profissional(id_profissional),
    CONSTRAINT fk_prescricao_plano
        FOREIGN KEY (id_plano_tratamento) REFERENCES plano_tratamento(id_plano_tratamento)
);

CREATE TABLE item_prescricao (
    id_item_prescricao INT AUTO_INCREMENT PRIMARY KEY,
    id_prescricao_medica INT NOT NULL,
    id_medicamento INT NOT NULL,
    nome_medicamento VARCHAR(255),
    dosagem VARCHAR(100),
    forma_farmaceutica VARCHAR(100),
    posologia VARCHAR(255),
    via_administracao VARCHAR(100),
    duracao_tratamento VARCHAR(100),
    CONSTRAINT fk_item_prescricao_prescricao
        FOREIGN KEY (id_prescricao_medica) REFERENCES prescricao_medica(id_prescricao_medica),
    CONSTRAINT fk_item_prescricao_medicamento
        FOREIGN KEY (id_medicamento) REFERENCES medicamento(id_medicamento)
);

CREATE TABLE diagnostico_cid (
    codigo_cid VARCHAR(10) PRIMARY KEY,
    descricao_cid TEXT NOT NULL,
    categoria_cid VARCHAR(100)
);

CREATE TABLE paciente_diagnostico (
    id_paciente_diagnostico INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT NOT NULL,
    codigo_cid VARCHAR(10) NOT NULL,
    id_profissional INT NOT NULL,
    id_agendamento INT,
    data_diagnostico DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    observacoes TEXT,
    CONSTRAINT fk_paciente_diagnostico_paciente
        FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente),
    CONSTRAINT fk_paciente_diagnostico_cid
        FOREIGN KEY (codigo_cid) REFERENCES diagnostico_cid(codigo_cid),
    CONSTRAINT fk_paciente_diagnostico_profissional
        FOREIGN KEY (id_profissional) REFERENCES profissional(id_profissional),
    CONSTRAINT fk_paciente_diagnostico_agendamento
        FOREIGN KEY (id_agendamento) REFERENCES agendamento(id_agendamento)
);

CREATE TABLE prontuario_evolucao (
    id_prontuario_evolucao INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT NOT NULL,
    id_profissional INT NOT NULL,
    id_agendamento INT,
    data_hora_registro DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    observacoes_clinicas TEXT,
    diagnostico_formal_texto TEXT,
    conduta_texto TEXT,
    CONSTRAINT fk_prontuario_paciente
        FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente),
    CONSTRAINT fk_prontuario_profissional
        FOREIGN KEY (id_profissional) REFERENCES profissional(id_profissional),
    CONSTRAINT fk_prontuario_agendamento
        FOREIGN KEY (id_agendamento) REFERENCES agendamento(id_agendamento)
);

CREATE TABLE usuario (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    login VARCHAR(45) NOT NULL UNIQUE,
    senha_hash VARCHAR(255) NOT NULL,
    id_profissional INT,
    nome_exibicao VARCHAR(255),
    email_usuario VARCHAR(255),
    ativo BOOLEAN NOT NULL DEFAULT TRUE,
    ultimo_login DATETIME,
    usuario_criacao VARCHAR(45),
    CONSTRAINT fk_usuario_profissional
        FOREIGN KEY (id_profissional) REFERENCES profissional(id_profissional)
);

CREATE TABLE perfil_acesso (
    id_perfil_acesso INT AUTO_INCREMENT PRIMARY KEY,
    nome_perfil VARCHAR(45) NOT NULL,
    descricao_perfil TEXT
);

CREATE TABLE usuario_perfil (
    id_usuario_perfil INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_perfil_acesso INT NOT NULL,
    CONSTRAINT fk_usuario_perfil_usuario
        FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario),
    CONSTRAINT fk_usuario_perfil_perfil
        FOREIGN KEY (id_perfil_acesso) REFERENCES perfil_acesso(id_perfil_acesso)
);

CREATE TABLE log_auditoria (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    timestamp_log DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    id_usuario INT NOT NULL,
    tipo_acao VARCHAR(100) NOT NULL,
    tabela_afetada VARCHAR(100) NOT NULL,
    id_registro_afetado VARCHAR(255),
    dados_antigos JSON,
    dados_novos JSON,
    descricao_adicional TEXT,
    endereco_ip VARCHAR(45),
    CONSTRAINT fk_log_usuario
        FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

CREATE INDEX idx_agendamento_paciente ON agendamento(id_paciente);
CREATE INDEX idx_agendamento_profissional ON agendamento(id_profissional);
CREATE INDEX idx_plano_tratamento_paciente ON plano_tratamento(id_paciente);
CREATE INDEX idx_prescricao_paciente ON prescricao_medica(id_paciente);
CREATE INDEX idx_prescricao_profissional ON prescricao_medica(id_profissional_prescritor);
CREATE INDEX idx_item_prescricao_prescricao ON item_prescricao(id_prescricao_medica);
CREATE INDEX idx_item_prescricao_medicamento ON item_prescricao(id_medicamento);
CREATE INDEX idx_paciente_diagnostico_paciente ON paciente_diagnostico(id_paciente);
CREATE INDEX idx_paciente_diagnostico_profissional ON paciente_diagnostico(id_profissional);
CREATE INDEX idx_prontuario_paciente ON prontuario_evolucao(id_paciente);
CREATE INDEX idx_prontuario_profissional ON prontuario_evolucao(id_profissional);
CREATE INDEX idx_usuario_profissional ON usuario(id_profissional);
CREATE INDEX idx_log_usuario ON log_auditoria(id_usuario);
