/* 1- Exibir lista de alunos e seus cursos*/

CREATE VIEW ListaAlunosDisciplinas AS
SELECT 
    alunos.nome AS nomeAluno,
    disciplinas.nome AS nomeDisciplina,
    cursos.nome AS nomeCurso
FROM 
    matriculas
JOIN 
    alunos ON ,matriculas.aluno_id = alunos.id
JOIN 
    disciplinas ON matriculas.disciplina_id = disciplinas.id
JOIN 
    cursos ON disciplinas.curso_id = cursos.id;


/* 2- Exibir total de alunos por disciplina*/

CREATE VIEW TotalAlunosPorDisciplina AS
SELECT 
    disciplinas.nome AS nomeDisciplina,
    COUNT(matriculas.aluno_id) AS qntdAlunos
FROM 
    matriculas
JOIN 
    disciplinas ON matriculas.disciplina_id = disciplinas.id
GROUP BY 
    disciplinas.nome;


/* 3- Exibir alunos e status das suas matrículas*/

CREATE VIEW AlunosStatusMatriculas AS
SELECT 
    Alunos.nome AS NomeAluno,
    Disciplinas.nome AS NomeDisciplina,
    Matriculas.status AS StatusMatricula
FROM 
    Matriculas
JOIN 
    Alunos ON Matriculas.aluno_id = Alunos.id
JOIN 
    Disciplinas ON Matriculas.disciplina_id = Disciplinas.id;


/* 4- Exibir professores e suas turmas:*/

CREATE VIEW ProfessoresTurmas AS
SELECT 
    Professores.nome AS NomeProfessor,
    Disciplinas.nome AS NomeDisciplina,
    Turmas.horario AS HorarioTurma
FROM 
    Professores
JOIN 
    Disciplinas ON Professores.id = Disciplinas.professor_id
JOIN 
    Turmas ON Disciplinas.id = Turmas.disciplina_id;


/* 5- Exibir alunos maiores de 20 anos:*/

CREATE VIEW AlunosMaioresDe20 AS
SELECT 
    nome AS NomeAluno,
    data_nascimento AS DataNascimento
FROM 
    Alunos
WHERE 
    DATEDIFF(YEAR, data_nascimento, GETDATE()) > 20;


    /* 6- Exibir disciplinas e carga horária total por curso:*/

    CREATE VIEW CargaHorariaTotalPorCurso AS
SELECT 
    Cursos.nome AS NomeCurso,
    COUNT(Disciplinas.id) AS QuantidadeDisciplinas,
    SUM(Disciplinas.carga_horaria) AS CargaHorariaTotal
FROM 
    Cursos
JOIN 
    Disciplinas ON Cursos.id = Disciplinas.curso_id
GROUP BY 
    Cursos.nome;


/* 7- Exibir professores e suas especialidades:*/

CREATE VIEW ProfessoresEspecialidades AS
SELECT 
    nome AS NomeProfessor,
    especialidade AS Especialidade
FROM 
    Professores;


/* 8- Exibir alunos matriculados em mais de uma disciplina:*/

CREATE VIEW AlunosMaisDeUmaDisciplina AS
SELECT 
    Alunos.nome AS NomeAluno,
    COUNT(Matriculas.disciplina_id) AS QuantidadeDisciplinas
FROM 
    Matriculas
JOIN 
    Alunos ON Matriculas.aluno_id = Alunos.id
GROUP BY 
    Alunos.nome
HAVING 
    COUNT(Matriculas.disciplina_id) > 1;


 /* 9- Exibir alunos e o número de disciplinas que concluíram:*/

CREATE VIEW AlunosDisciplinasConcluidas AS
SELECT 
    Alunos.nome AS NomeAluno,
    COUNT(Matriculas.disciplina_id) AS DisciplinasConcluidas
FROM 
    Matriculas
JOIN 
    Alunos ON Matriculas.aluno_id = Alunos.id
WHERE 
    Matriculas.status = 'Concluído'
GROUP BY 
    Alunos.nome;


/* 10- Exibir todas as turmas de um semestre específico:*/

CREATE VIEW TurmasPorSemestre AS
SELECT 
    Turmas.*
FROM 
    Turmas
WHERE 
    Turmas.semestre = '2024.1';


/* 11- Exibir alunos com matrículas trancadas:*/

CREATE VIEW AlunosMatriculasTrancadas AS
SELECT 
    Alunos.nome AS NomeAluno
FROM 
    Matriculas
JOIN 
    Alunos ON Matriculas.aluno_id = Alunos.id
WHERE 
    Matriculas.status = 'Trancado';


/* 12- Exibir disciplinas que não têm alunos matriculados:*/

CREATE VIEW DisciplinasSemAlunos AS
SELECT 
    Disciplinas.nome AS NomeDisciplina
FROM 
    Disciplinas
LEFT JOIN 
    Matriculas ON Disciplinas.id = Matriculas.disciplina_id
WHERE 
    Matriculas.aluno_id IS NULL;


/* 13- Exibir a quantidade de alunos por status de matrícula:*/

CREATE VIEW QuantidadeAlunosPorStatus AS
SELECT 
    Matriculas.status AS StatusMatricula,
    COUNT(Matriculas.aluno_id) AS QuantidadeAlunos
FROM 
    Matriculas
GROUP BY 
    Matriculas.status;


/* 14- Exibir o total de professores por especialidade:*/

CREATE VIEW TotalProfessoresPorEspecialidade AS
SELECT 
    Professores.especialidade AS Especialidade,
    COUNT(Professores.id) AS QuantidadeProfessores
FROM 
    Professores
GROUP BY 
    Professores.especialidade;


/* 15- Exibir lista de alunos e suas idades:*/

CREATE VIEW ListaAlunosIdades AS
SELECT 
    nome AS NomeAluno,
    DATEDIFF(YEAR, data_nascimento, GETDATE()) AS Idade
FROM 
    Alunos;


/* 16- Exibir alunos e suas últimas matrículas:*/

CREATE VIEW AlunosUltimasMatriculas AS
SELECT 
    Alunos.nome AS NomeAluno,
    MAX(Matriculas.data_matricula) AS UltimaMatricula
FROM 
    Matriculas
JOIN 
    Alunos ON Matriculas.aluno_id = Alunos.id
GROUP BY 
    Alunos.nome;


/* 17- Exibir todas as disciplinas de um curso específico:*/

CREATE VIEW DisciplinasCursoEspecifico AS
SELECT 
    Disciplinas.*
FROM 
    Disciplinas
WHERE 
    Disciplinas.curso_id = (SELECT id FROM Cursos WHERE nome = 'Engenharia de Software');


/* 18- Exibir os professores que não têm turmas:*/

CREATE VIEW ProfessoresSemTurmas AS
SELECT 
    Professores.nome AS NomeProfessor
FROM 
    Professores
LEFT JOIN 
    Disciplinas ON Professores.id = Disciplinas.professor_id
LEFT JOIN 
    Turmas ON Disciplinas.id = Turmas.disciplina_id
WHERE 
    Turmas.id IS NULL;


/* 19- Exibir lista de alunos com CPF e email:*/

CREATE VIEW ListaAlunosCPFEmail AS
SELECT 
    nome AS NomeAluno,
    cpf AS CPF,
    email AS Email
FROM 
    Alunos;


/* 20- Exibir o total de disciplinas por professor:*/

CREATE VIEW TotalDisciplinasPorProfessor AS
SELECT 
    Professores.nome AS NomeProfessor,
    COUNT(Disciplinas.id) AS QuantidadeDisciplinas
FROM 
    Professores
JOIN 
    Disciplinas ON Professores.id = Disciplinas.professor_id
GROUP BY 
    Professores.nome;
