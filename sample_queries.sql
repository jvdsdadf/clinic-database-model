-- Listar todos os pacientes
SELECT * FROM pacientes;

-- Listar médicos e suas especialidades
SELECT 
    m.nome AS medico,
    e.nome AS especialidade
FROM medicos m
JOIN especialidades e 
ON m.especialidade_id = e.id;

-- Listar consultas com paciente e médico
SELECT 
    c.id,
    p.nome AS paciente,
    m.nome AS medico,
    c.data_consulta
FROM consultas c
JOIN pacientes p 
ON c.paciente_id = p.id
JOIN medicos m 
ON c.medico_id = m.id;

-- Buscar histórico de consultas de um paciente
SELECT 
    p.nome AS paciente,
    m.nome AS medico,
    c.data_consulta,
    c.observacoes
FROM consultas c
JOIN pacientes p 
ON c.paciente_id = p.id
JOIN medicos m 
ON c.medico_id = m.id
WHERE p.id = 1;

-- Listar consultas de um médico específico
SELECT 
    m.nome AS medico,
    p.nome AS paciente,
    c.data_consulta
FROM consultas c
JOIN pacientes p 
ON c.paciente_id = p.id
JOIN medicos m 
ON c.medico_id = m.id
WHERE m.id = 1;
