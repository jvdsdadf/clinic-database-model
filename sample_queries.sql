USE clinic_db;

-- 1. Listar todos os pacientes cadastrados
SELECT 
    id_paciente,
    nome_completo,
    cpf,
    data_nascimento,
    telefone_principal,
    email
FROM paciente;

-- 2. Listar pacientes com seu responsável (quando houver)
SELECT 
    p.id_paciente,
    p.nome_completo AS paciente,
    r.nome_completo AS responsavel,
    r.grau_parentesco,
    r.telefone_principal AS telefone_responsavel
FROM paciente p
LEFT JOIN responsavel r
    ON p.id_responsavel = r.id_responsavel;

-- 3. Listar profissionais ativos da clínica
SELECT
    id_profissional,
    nome_completo,
    tipo_profissional,
    registro_profissional,
    funcao_cargo,
    email
FROM profissional
WHERE ativo = TRUE;

-- 4. Listar agendamentos com paciente e profissional
SELECT
    a.id_agendamento,
    p.nome_completo AS paciente,
    pr.nome_completo AS profissional,
    a.data_hora_inicio,
    a.data_hora_fim_estimada,
    a.tipo_atendimento,
    a.status_agendamento
FROM agendamento a
JOIN paciente p
    ON a.id_paciente = p.id_paciente
JOIN profissional pr
    ON a.id_profissional = pr.id_profissional
ORDER BY a.data_hora_inicio;

-- 5. Buscar agendamentos futuros
SELECT
    a.id_agendamento,
    p.nome_completo AS paciente,
    pr.nome_completo AS profissional,
    a.data_hora_inicio,
    a.status_agendamento
FROM agendamento a
JOIN paciente p
    ON a.id_paciente = p.id_paciente
JOIN profissional pr
    ON a.id_profissional = pr.id_profissional
WHERE a.data_hora_inicio >= NOW()
ORDER BY a.data_hora_inicio;

-- 6. Listar planos de tratamento ativos
SELECT
    pt.id_plano_tratamento,
    p.nome_completo AS paciente,
    pr.nome_completo AS profissional_responsavel,
    pt.descricao_tratamento,
    pt.metas,
    pt.data_inicio,
    pt.data_previsao_termino,
    pt.status_plano
FROM plano_tratamento pt
JOIN paciente p
    ON pt.id_paciente = p.id_paciente
JOIN profissional pr
    ON pt.id_profissional_responsavel = pr.id_profissional
WHERE pt.status_plano = 'Ativo';

-- 7. Listar prescrições com paciente e profissional prescritor
SELECT
    pm.id_prescricao_medica,
    p.nome_completo AS paciente,
    pr.nome_completo AS profissional_prescritor,
    pm.data_prescricao,
    pm.data_validade_prescricao,
    pm.observacoes_gerais
FROM prescricao_medica pm
JOIN paciente p
    ON pm.id_paciente = p.id_paciente
JOIN profissional pr
    ON pm.id_profissional_prescritor = pr.id_profissional
ORDER BY pm.data_prescricao DESC;

-- 8. Listar itens prescritos por prescrição
SELECT
    ip.id_item_prescricao,
    pm.id_prescricao_medica,
    m.nome_generico,
    m.nome_comercial,
    ip.dosagem,
    ip.posologia,
    ip.via_administracao,
    ip.duracao_tratamento
FROM item_prescricao ip
JOIN prescricao_medica pm
    ON ip.id_prescricao_medica = pm.id_prescricao_medica
JOIN medicamento m
    ON ip.id_medicamento = m.id_medicamento
ORDER BY pm.id_prescricao_medica;

-- 9. Histórico de diagnósticos por paciente
SELECT
    p.nome_completo AS paciente,
    d.codigo_cid,
    d.descricao_cid,
    pr.nome_completo AS profissional,
    pd.data_diagnostico,
    pd.observacoes
FROM paciente_diagnostico pd
JOIN paciente p
    ON pd.id_paciente = p.id_paciente
JOIN diagnostico_cid d
    ON pd.codigo_cid = d.codigo_cid
JOIN profissional pr
    ON pd.id_profissional = pr.id_profissional
ORDER BY pd.data_diagnostico DESC;

-- 10. Histórico completo de prontuário por paciente
SELECT
    p.nome_completo AS paciente,
    pr.nome_completo AS profissional,
    pe.data_hora_registro,
    pe.observacoes_clinicas,
    pe.diagnostico_formal_texto,
    pe.conduta_texto
FROM prontuario_evolucao pe
JOIN paciente p
    ON pe.id_paciente = p.id_paciente
JOIN profissional pr
    ON pe.id_profissional = pr.id_profissional
ORDER BY pe.data_hora_registro DESC;

-- 11. Quantidade de consultas por paciente
SELECT
    p.nome_completo AS paciente,
    COUNT(a.id_agendamento) AS total_agendamentos
FROM paciente p
LEFT JOIN agendamento a
    ON p.id_paciente = a.id_paciente
GROUP BY p.id_paciente, p.nome_completo
ORDER BY total_agendamentos DESC;

-- 12. Quantidade de consultas por profissional
SELECT
    pr.nome_completo AS profissional,
    COUNT(a.id_agendamento) AS total_agendamentos
FROM profissional pr
LEFT JOIN agendamento a
    ON pr.id_profissional = a.id_profissional
GROUP BY pr.id_profissional, pr.nome_completo
ORDER BY total_agendamentos DESC;

-- 13. Usuários do sistema com seus perfis de acesso
SELECT
    u.login,
    u.nome_exibicao,
    pa.nome_perfil,
    pa.descricao_perfil
FROM usuario_perfil up
JOIN usuario u
    ON up.id_usuario = u.id_usuario
JOIN perfil_acesso pa
    ON up.id_perfil_acesso = pa.id_perfil_acesso
ORDER BY u.login;

-- 14. Logs de auditoria com usuário responsável
SELECT
    la.id_log,
    u.login,
    la.tipo_acao,
    la.tabela_afetada,
    la.id_registro_afetado,
    la.timestamp_log,
    la.descricao_adicional,
    la.endereco_ip
FROM log_auditoria la
JOIN usuario u
    ON la.id_usuario = u.id_usuario
ORDER BY la.timestamp_log DESC;

-- 15. Consultar medicamentos prescritos para um paciente específico
SELECT
    p.nome_completo AS paciente,
    pm.id_prescricao_medica,
    m.nome_generico,
    m.nome_comercial,
    ip.dosagem,
    ip.posologia,
    pm.data_prescricao
FROM prescricao_medica pm
JOIN paciente p
    ON pm.id_paciente = p.id_paciente
JOIN item_prescricao ip
    ON pm.id_prescricao_medica = ip.id_prescricao_medica
JOIN medicamento m
    ON ip.id_medicamento = m.id_medicamento
WHERE p.id_paciente = 1
ORDER BY pm.data_prescricao DESC;

-- 16. Consultar agendamentos por status
SELECT
    status_agendamento,
    COUNT(*) AS total
FROM agendamento
GROUP BY status_agendamento
ORDER BY total DESC;

-- 17. Consultar pacientes com profissional de referência
SELECT
    p.nome_completo AS paciente,
    pr.nome_completo AS profissional_referencia,
    pr.funcao_cargo
FROM paciente p
LEFT JOIN profissional pr
    ON p.id_profissional_referencia = pr.id_profissional;

-- 18. Buscar diagnósticos realizados em um agendamento específico
SELECT
    a.id_agendamento,
    p.nome_completo AS paciente,
    d.codigo_cid,
    d.descricao_cid,
    pd.data_diagnostico
FROM paciente_diagnostico pd
JOIN agendamento a
    ON pd.id_agendamento = a.id_agendamento
JOIN paciente p
    ON pd.id_paciente = p.id_paciente
JOIN diagnostico_cid d
    ON pd.codigo_cid = d.codigo_cid
WHERE a.id_agendamento = 1;
