/*Consulta avançada 1:
 Visão 360° do Paciente*/

SELECT
    p.id_paciente,
    p.nomeCompleto AS NomePaciente,
    p.dataNascimento,
    p.cpf AS CpfPaciente,
    r.nomeCompleto AS NomeResponsavel,
    r.parentesco,
    pt.descricaoTratamento,
    pt.metas AS MetasTratamento,
    pt.dataInicio AS InicioPlano,
    prof_plano.nomecompleto AS ProfissionalResponsavelPlano,
    pe.dataHoraRegistro AS DataUltimaEvolucao,
    pe.observacoesClinicas,
    pe.planoTerapeutico AS PlanoTerapeuticoEvolucao,
    prof_evolucao.nomecompleto AS ProfissionalDaEvolucao,
    d.codigoCID,
    d.descricaoCID,
    pd.dataDiagnostico,
    pd.statusDiagnostico,
    presc.dataPrescricao,
    presc.validadePrescricao,
    med.nomeGenerico AS Medicamento,
    ip.dosagem,
    ip.posologia,
    ip.duracaoTratamento
FROM
    paciente AS p
LEFT JOIN
    responsavel AS r ON p.idResponsavel = r.idResponsavel
LEFT JOIN
    planotratamento AS pt ON p.id_paciente = pt.idPaciente
LEFT JOIN
    profissional AS prof_plano ON pt.idProfissionalResponsavel = prof_plano.id_profissional
LEFT JOIN
    prontuarioevolucao AS pe ON p.id_paciente = pe.idPaciente
LEFT JOIN
    profissional AS prof_evolucao ON pe.idProfissional = prof_evolucao.id_profissional
LEFT JOIN
    pacientediagnostico AS pd ON p.id_paciente = pd.idPaciente
LEFT JOIN
    diagnosticocid AS d ON d.codigoCID = 'F32.9'
LEFT JOIN
    prescricaomedica AS presc ON p.id_paciente = presc.idPaciente
LEFT JOIN
    itemprescricao AS ip ON presc.idPrescricaoMedica = ip.idPrescricao
LEFT JOIN
    medicamento AS med ON ip.idMedicamento = med.idMedicamento
WHERE
    p.id_paciente = 1
ORDER BY
    pe.dataHoraRegistro DESC
LIMIT 1;

/*Consulta avançada 2:
Relatório de Desempenho por Profissional*/

WITH AtendimentoRank AS (
    SELECT
        idProfissional,
        tipoAtendimento,
        ROW_NUMBER() OVER(PARTITION BY idProfissional ORDER BY COUNT(idAgendamento) DESC) AS rn
    FROM
        agendamento
    WHERE
        tipoAtendimento IS NOT NULL
    GROUP BY
        idProfissional,
        tipoAtendimento
)
SELECT
    p.nomecompleto AS NomeProfissional,
    p.funcaoCargo AS Funcao,
    COUNT(DISTINCT a.idPaciente) AS PacientesUnicos,
    COUNT(a.idAgendamento) AS TotalAgendamentos,
    MAX(a.dataHoraInicio) AS UltimoAgendamento,
    ar.tipoAtendimento AS PrincipalTipoAtendimento
FROM
    profissional AS p
LEFT JOIN
    agendamento AS a ON p.id_profissional = a.idProfissional
LEFT JOIN
    AtendimentoRank ar ON p.id_profissional = ar.idProfissional AND ar.rn = 1
WHERE
    p.ativo = 1
GROUP BY
    p.id_profissional,
    p.nomecompleto,
    p.funcaoCargo,
    ar.tipoAtendimento
ORDER BY
    TotalAgendamentos DESC,
    NomeProfissional;

/*Consulta Intermediaria 1:
Listar Agendamentos Confirmados da Próxima Semana*/

SELECT
    a.dataHoraInicio,
    p.nomeCompleto AS NomePaciente,
    prof.nomecompleto AS NomeProfissional,
    a.tipoAtendimento,
    a.statusAgendamento
FROM
    agendamento AS a
JOIN
    paciente AS p ON a.idPaciente = p.id_paciente
JOIN
    profissional AS prof ON a.idProfissional = prof.id_profissional
WHERE
    a.statusAgendamento = 'Confirmado'
    AND a.dataHoraInicio BETWEEN '2025-06-07' AND '2025-06-14'
ORDER BY
    a.dataHoraInicio ASC;

/*Consulta Intermediaria 2:
Encontrar Pacientes com Prescrição Ativa de um Medicamento Específico*/

SELECT
    p.nomeCompleto AS NomePaciente,
    m.nomeGenerico,
    ip.dosagem,
    ip.posologia,
    pm.dataPrescricao,
    pm.validadePrescricao,
    prof.nomecompleto AS PrescritoPor
FROM
    itemprescricao AS ip
JOIN
    medicamento AS m ON ip.idMedicamento = m.idMedicamento
JOIN
    prescricaomedica AS pm ON ip.idPrescricao = pm.idPrescricaoMedica
JOIN
    paciente AS p ON pm.idPaciente = p.id_paciente
JOIN
    profissional AS prof ON pm.idProfissionalPrescritor = prof.id_profissional
WHERE
    m.nomeGenerico LIKE 'Sertralina'
    AND pm.validadePrescricao >= '2025-06-07'
ORDER BY
    p.nomeCompleto;

/*Consulta Intermediaria 3:
Contar o Número de Diagnósticos por Categoria CID*/

SELECT
    prof.nomecompleto AS NomeDoProfissional,
    prof.funcaoCargo AS Funcao,
    COUNT(a.idAgendamento) AS NumeroDeAgendamentos
FROM
    agendamento AS a
JOIN
    profissional AS prof ON a.idProfissional = prof.id_profissional
GROUP BY
    prof.id_profissional,
    prof.nomecompleto,
    prof.funcaoCargo
ORDER BY
    NumeroDeAgendamentos DESC;

/*Consulta Basica 1:
Listar Todos os Profissionais Ativos*/

SELECT
    nomecompleto,
    funcaoCargo,
    email,
    telefonePrincipal
FROM
    profissional
WHERE
    ativo = 1
ORDER BY
    nomecompleto ASC;

/*Consulta Basica 2:
Encontrar um Paciente pelo Nome*/

SELECT
    id_paciente,
    nomeCompleto,
    dataNascimento,
    cpf
FROM
    paciente
WHERE
    nomeCompleto LIKE '%Silva%';

/*Consulta Basica 3:
Ver Todos os Tipos de Diagnóstico CID Registrados*/

SELECT
    codigoCID,
    descricaoCID,
    categoriaCID
FROM
    diagnosticocid
ORDER BY
    codigoCID ASC;

/*Consulta Basica 4:
Listar Todos os Medicamentos e suas Formas Farmacêuticas*/

SELECT
    nomeGenerico,
    nomeComercial,
    formaFarmaceuticaPadrao
FROM
    medicamento
ORDER BY
    nomeGenerico ASC;