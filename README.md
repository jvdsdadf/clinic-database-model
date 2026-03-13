# Clinic Database Model

Modelo de banco de dados relacional para gerenciamento de uma clínica médica.

Este projeto demonstra a modelagem de um banco de dados para controle de pacientes, médicos, especialidades e consultas médicas.

---

# Objetivo

O objetivo deste projeto é representar a estrutura de dados necessária para o funcionamento básico de um sistema de gestão de clínica médica.

Ele permite:

- cadastro de pacientes
- cadastro de médicos
- associação de médicos a especialidades
- agendamento de consultas
- consulta de histórico de atendimento

---

# Entidades principais

O banco de dados possui as seguintes entidades:

### Pacientes
Armazena informações dos pacientes da clínica.

### Médicos
Armazena dados dos médicos que atendem na clínica.

### Especialidades
Lista de especialidades médicas disponíveis.

### Consultas
Registra consultas realizadas entre pacientes e médicos.

---

# Relacionamentos

- Um **médico** pertence a uma **especialidade**
- Um **paciente** pode ter **várias consultas**
- Um **médico** pode atender **várias consultas**
- Cada **consulta** pertence a um paciente e a um médico

---

# Tecnologias utilizadas

- SQL
- MySQL (modelo compatível com outros bancos relacionais)

---

# Estrutura do projeto
