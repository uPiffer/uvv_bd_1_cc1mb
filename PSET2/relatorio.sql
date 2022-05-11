-- Questões do PSET 2

-- Questão 1

SELECT funcionario.numero_departamento, AVG(funcionario.salario) as media_salarial
FROM funcionario 
JOIN departamento 
ON departamento.numero_departamento = funcionario.numero_departamento
GROUP BY funcionario.numero_departamento;

-- Questão 2

SELECT funcionario.sexo, AVG(funcionario.salario) as media_salarial
FROM funcionario
GROUP BY funcionario.sexo;

-- Questão 3

SELECT nome_departamento, concat (primeiro_nome,' ', nome_meio,' ' ,ultimo_nome) as nome_completo, data_nascimento, extract(year from age (funcionario.data_nascimento)) as idade, funcionario.salario
FROM departamento, funcionario
WHERE departamento.numero_departamento = funcionario.numero_departamento

-- Questão 4

SELECT CONCAT(primeiro_nome,' ', nome_meio,' ' ,ultimo_nome) as nome_completo, extract(year from age (funcionario.data_nascimento)) as idade, salario,
CASE
	when salario < 35000 then salario * 1.2 
	else salario * 1.15
	end as reajuste
FROM funcionario

-- Questão 5

SELECT nome_departamento, concat(primeiro_nome, ' ', nome_meio, ' ', ultimo_nome) as nome,
CASE 
WHEN cpf = cpf_gerente then 'gerente'
ELSE 'funcionario'
END as cargo, salario
FROM departamento, funcionario
WHERE departamento.numero_departamento = funcionario.numero_departamento
ORDER BY nome_departamento, salario desc;


-- Questão 6

SELECT CONCAT(f.primeiro_nome,' ', f.nome_meio,' ', f.ultimo_nome) Funcionário, dpt.nome_departamento Departamento, 
CONCAT(d.nome_dependente,' ', f.nome_meio,' ', f.ultimo_nome) Dependente, extract(year from age (f.data_nascimento)) as idade,
CASE
WHEN d.sexo = 'M' THEN 'Masculino'
WHEN d.sexo = 'F' THEN 'Feminino'
END "Sexo do Dependente"
FROM funcionario f
INNER JOIN departamento dpt
ON f.numero_departamento = dpt.numero_departamento
INNER JOIN dependente d
ON f.cpf = d.cpf_funcionario;

-- Questão 7

SELECT CONCAT(funcionario.primeiro_nome,' ', funcionario.nome_meio,' ', funcionario.ultimo_nome) Funcionário, dpt.nome_departamento Departamento,
CONCAT(funcionario.salario) Salário
FROM funcionario
LEFT OUTER JOIN dependente
ON funcionario.cpf = dependente.cpf_funcionario
INNER JOIN departamento dpt
ON funcionario.numero_departamento = dpt.numero_departamento
WHERE dependente.cpf_funcionario IS NULL;

-- Questão 8

SELECT proj.numero_departamento as "numero departamento" ,nome_projeto as "nome projeto", trab_em.horas as "Horas",
CONCAT (func.primeiro_nome,' ', nome_meio,' ', ultimo_nome) as "nome_completo"
FROM ((projeto as proj
INNER JOIN trabalha_em  as trab_em on trab_em.numero_projeto = proj.numero_projeto)
INNER JOIN funcionario as func on func.cpf = trab_em.cpf_funcionario);

-- Questão 9

SELECT dpt.nome_departamento departamento, p.nome_projeto projeto, SUM(DISTINCT(t.horas)) "Tempo Total"
FROM trabalha_em t
INNER JOIN funcionario f
ON t.cpf_funcionario = f.cpf
INNER JOIN departamento dpt
ON f.numero_departamento = dpt.numero_departamento
INNER JOIN projeto p
ON dpt.numero_departamento = p.numero_departamento
GROUP BY dpt.nome_departamento, p.nome_projeto;

-- Questão 10

SELECT dpt.nome_departamento Departamento, CONCAT(ROUND(AVG(funcionario.salario), 2)) "Média Salarial"
FROM funcionario
INNER JOIN departamento dpt
ON dpt.numero_departamento = funcionario.numero_departamento
GROUP BY dpt.nome_departamento;

-- Questão 11

SELECT CONCAT(funcionario.primeiro_nome,' ', funcionario.nome_meio,' ', funcionario.ultimo_nome) Funcionário, p.nome_projeto Projeto,
CASE
WHEN trabalha_em.horas > 0 THEN CONCAT(trabalha_em.horas * 50)
ELSE '0.0'
END "Total Recebido"
FROM funcionario
INNER JOIN trabalha_em
ON funcionario.cpf = trabalha_em.cpf_funcionario
INNER JOIN projeto p
ON trabalha_em.numero_projeto = p.numero_projeto
ORDER BY trabalha_em.horas desc;

-- Questão 12

SELECT departamento.nome_departamento Departamento, p.nome_projeto Projeto, funcionario.primeiro_nome Funcionário, 
CONCAT(t.horas, 'h') "Horas de Trabalho"
FROM funcionario
INNER JOIN departamento
ON funcionario.numero_departamento = departamento.numero_departamento
INNER JOIN projeto p
ON departamento.numero_departamento = p.numero_departamento
INNER JOIN trabalha_em t
ON p.numero_projeto = t.numero_projeto
WHERE t.horas = 0;

-- Questão 13

SELECT CONCAT(funcionario.primeiro_nome,' ', funcionario.nome_meio,' ', funcionario.ultimo_nome) as nome_completo,
CASE
WHEN funcionario.sexo = 'M' THEN 'Masculino'
WHEN funcionario.sexo = 'F' THEN 'Feminino'
END sexo,
extract(year from age (funcionario.data_nascimento)) as idade
FROM funcionario
UNION
SELECT CONCAT(dependente.nome_dependente,' ', funcionario.nome_meio,' ', funcionario.ultimo_nome) as nome_completo,
CASE
WHEN dependente.sexo = 'M' THEN 'Masculino'
WHEN dependente.sexo = 'F' THEN 'Feminino'
END sexo,
extract(year from age (funcionario.data_nascimento)) as idade
FROM dependente
INNER JOIN funcionario
ON dependente.cpf_funcionario = funcionario.cpf
ORDER BY idade desc;

-- Questão 14

SELECT dpt.nome_departamento Departamento, COUNT(funcionario.numero_departamento) "Nº de Funcionários"
FROM funcionario
INNER JOIN departamento dpt
ON funcionario.numero_departamento = dpt.numero_departamento
GROUP BY dpt.nome_departamento;

-- Questão 15

SELECT CONCAT (func.primeiro_nome,' ',nome_meio,' ', ultimo_nome) as "nome completo",
func.numero_departamento as "departamento", proj.nome_projeto as "nome projeto"
FROM funcionario as func 
INNER JOIN trabalha_em as trab_em on (trab_em.cpf_funcionario = func.cpf)
INNER JOIN projeto as proj on (proj.numero_projeto = trab_em.numero_projeto)
ORDER BY func.numero_departamento;
















