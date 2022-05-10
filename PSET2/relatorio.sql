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

SELECT nome_departamento, concat (primeiro_nome,' ', nome_nome,' ',ultimo_nome) as nome_completo, data_nascimento, extract(year frin age(funcionario.data_nascimento)), funcionario.salario
FROM departamento, funcionario
WHERE departamento.numero_departamento = funcionario.numero_departamento 

select nome_departamento, concat (primeiro_nome,' ', nome_meio,' ' ,ultimo_nome) as nome_completo, data_nascimento, extract(year from age (funcionario.data_nascimento)) as idade, funcionario.salario
from departamento, funcionario
where departamento.numero_departamento = funcionario.numero_departamento

-- Questão 4

select concat(primeiro_nome,' ', nome_meio,' ' ,ultimo_nome) as nome_completo, extract(year from age (funcionario.data_nascimento)) as idade, salario,
case 
	when salario < 35000 then salario * 1.2 
	else salario * 1.15
	end as reajuste
from funcionario

-- Questão 5

select nome_departamento, concat(primeiro_nome, ' ', nome_meio, ' ', ultimo_nome) as nome,
case 
when cpf = cpf_gerente then 'gerente'
else 'funcionario'
end as cargo, salario
from departamento, funcionario
where departamento.numero_departamento = funcionario.numero_departamento
order by nome_departamento, salario desc;


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
CONCAT('R$',' ', funcionario.salario) Salário
FROM funcionario
LEFT OUTER JOIN dependente
ON funcionario.cpf = dependente.cpf_funcionario
INNER JOIN departamento dpt
ON funcionario.numero_departamento = dpt.numero_departamento
WHERE dependente.cpf_funcionario IS NULL;

-- Questão 8

SELECT proj.numero_departamento AS "numero departamento" ,nome_projeto AS "nome projeto",
trab_em.horas AS "Horas",
CONCAT (func.primeiro_nome,' ', nome_meio,' ', ultimo_nome) AS "nome_completo"
FROM ((projeto AS proj
INNER JOIN trabalha_em  AS trab_em ON trab_em.numero_projeto = proj.numero_projeto)
INNER JOIN funcionario AS func ON func.cpf = trab_em.cpf_funcionario);

-- Questão 9

SELECT dpt.nome_departamento Departamento, p.nome_projeto Projeto, SUM(DISTINCT(t.horas)) "Tempo Total"
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
WHEN trabalha_em.horas > 0 THEN CONCAT('R$',' ', trabalha_em.horas * 50)
ELSE 'R$ 0.0'
END "Total Recebido"
FROM funcionario
INNER JOIN trabalha_em
ON funcionario.cpf = trabalha_em.cpf_funcionario
INNER JOIN projeto p
ON trabalha_em.numero_projeto = p.numero_projeto
ORDER BY trabalha_em.horas DESC;

-- Questão 12

SELECT departamento.nome_departamento Departamento, p.nome_projeto Projeto,
funcionario.primeiro_nome Funcionário, CONCAT(t.horas, 'h') "Horas de Trabalho"
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
END Sexo,
extract(year from age (funcionario.data_nascimento)) as idade
FROM funcionario
UNION
SELECT CONCAT(dependente.nome_dependente,' ', funcionario.nome_meio,' ', funcionario.ultimo_nome) as nome_completo,
CASE
WHEN dependente.sexo = 'M' THEN 'Masculino'
WHEN dependente.sexo = 'F' THEN 'Feminino'
END Sexo,
extract(year from age (funcionario.data_nascimento)) as idade
FROM dependente
INNER JOIN funcionario
ON dependente.cpf_funcionario = funcionario.cpf
ORDER BY idade DESC;

-- Questão 14

SELECT dpt.nome_departamento Departamento, COUNT(funcionario.numero_departamento) "Nº Funcionários"
FROM funcionario
INNER JOIN departamento dpt
ON funcionario.numero_departamento = dpt.numero_departamento
GROUP BY dpt.nome_departamento;

-- Questão 15

SELECT CONCAT (func.primeiro_nome,' ',nome_meio,' ', ultimo_nome) AS "nome_completo",
func.numero_departamento AS "departamento", proj.nome_projeto AS "nome_projeto"
FROM funcionario AS func 
INNER JOIN trabalha_em AS trab_em ON (trab_em.cpf_funcionario = func.cpf)
INNER JOIN projeto AS proj ON (proj.numero_projeto = trab_em.numero_projeto)
ORDER BY func.numero_departamento;
















