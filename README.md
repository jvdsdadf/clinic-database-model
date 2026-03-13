# Clinic Database Model

Projeto de modelagem de banco de dados relacional para um sistema de gestão clínica.

O objetivo deste projeto é demonstrar a estrutura de dados necessária para suportar operações comuns em uma clínica médica, incluindo:

- cadastro de pacientes e responsáveis
- gestão de profissionais de saúde
- agendamento de consultas
- prescrição médica
- prontuário clínico
- diagnósticos baseados em CID
- controle de acesso de usuários
- auditoria de ações no sistema

Este projeto foi desenvolvido como exercício acadêmico de modelagem de banco de dados e estruturação de consultas SQL.

---

# Tecnologias utilizadas

- SQL (MySQL)
- Modelagem relacional
- GitHub para versionamento

---

# Estrutura do projeto
```
clinic-database-model
│
├── schema.sql
├── seed.sql
├── sample_queries.sql
│
└── docs
└── clinica-diagrama-logico.png
```

### Descrição dos arquivos

**schema.sql**

Contém toda a estrutura do banco de dados:

- criação das tabelas
- chaves primárias
- chaves estrangeiras
- índices

---

**seed.sql**

Contém dados de exemplo para popular o banco e permitir testes das consultas.

Inclui:

- pacientes
- profissionais
- responsáveis
- agendamentos
- medicamentos
- prescrições
- diagnósticos
- usuários do sistema
- logs de auditoria

---

**sample_queries.sql**

Contém consultas SQL demonstrando o uso do banco de dados, incluindo:

- consultas de pacientes
- consultas de agendamentos
- histórico clínico
- prescrições médicas
- relatórios simples
- consultas com JOIN entre tabelas

---

# Diagrama lógico do banco

![Diagrama lógico](docs/clinica-diagrama-logico.png)

O diagrama representa as principais entidades do sistema e seus relacionamentos.

---

# Principais entidades do sistema

### Paciente

Armazena dados do paciente atendido pela clínica.

Exemplos de dados:

- nome
- CPF
- data de nascimento
- endereço
- contatos
- histórico médico
- alergias

---

### Responsável

Representa o responsável legal por pacientes menores ou dependentes.

---

### Profissional

Cadastro de profissionais da clínica.

Exemplos:

- médicos
- psicólogos
- especialistas

---

### Agendamento

Controla o agendamento de consultas entre pacientes e profissionais.

---

### Plano de tratamento

Define o planejamento terapêutico para determinado paciente.

---

### Prescrição médica

Armazena prescrições realizadas durante consultas.

Relaciona:

- paciente
- profissional prescritor
- medicamentos prescritos

---

### Medicamento

Catálogo de medicamentos utilizados nas prescrições.

---

### Diagnóstico CID

Tabela de classificação internacional de doenças utilizada para registro de diagnósticos.

---

### Prontuário clínico

Registro da evolução clínica do paciente durante atendimentos.

---

### Usuários do sistema

Controla acesso ao sistema da clínica.

Inclui:

- login
- perfil de acesso
- associação com profissional

---

### Log de auditoria

Tabela responsável por registrar ações realizadas no sistema.

Exemplos:

- inserções
- atualizações
- alterações em registros clínicos

---

# Exemplos de consultas implementadas

Algumas consultas presentes no arquivo `sample_queries.sql`:

### Listar agendamentos com paciente e profissional

```sql
SELECT
    a.id_agendamento,
    p.nome_completo AS paciente,
    pr.nome_completo AS profissional,
    a.data_hora_inicio
FROM agendamento a
JOIN paciente p
    ON a.id_paciente = p.id_paciente
JOIN profissional pr
    ON a.id_profissional = pr.id_profissional;

```

```sql
SELECT
    p.nome_completo,
    pe.data_hora_registro,
    pe.observacoes_clinicas
FROM prontuario_evolucao pe
JOIN paciente p
    ON pe.id_paciente = p.id_paciente;
```
```sql
SELECT
    pr.nome_completo,
    COUNT(a.id_agendamento)
FROM profissional pr
LEFT JOIN agendamento a
    ON pr.id_profissional = a.id_profissional
GROUP BY pr.nome_completo;
```
