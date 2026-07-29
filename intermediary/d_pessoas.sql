SELECT
	distinct dp.sk_decisor,
	dp.idPessoa					as "idPessoa",
	dp.nmRazao					as "nmRazao",
	dp.nmPessoa					as "nmPessoa",
	dp.numCpfCnpj				as "numCpfCnpj", 
	dp.nmCidade					as "nmCidade",
	dp.nmCEP					as "nmCEP",
	dp.nmUf						as "nmUf",
	dp.contato,
	dp.nmGrupoConsumo			AS "nmGrupoConsumo",
	dp.nmTabelaPreco			AS "nmTabelaPreco",
	dp.nmPeriodicidadeFatura 	AS "nmPeriodicidadeFatura",
	dp.vlrLimiteCredito 		AS "vlrLimiteCredito",
	dp.descObservacao 			AS "descObservacao",
        dp.id_vendedor                  AS id_vendedor,
	dp.nmVendedor 				AS "nmVendedor",
	dp.CodNome 					AS "CodNome",
	CASE
		WHEN de.nmCpfCnpj ISNULL THEN 'Externo'
		ELSE 'Intrarede'
	END AS "nmIntrarede"
FROM
	dw.dim_pessoas dp 
LEFT JOIN dw.dim_empresas de ON
	dp.numCpfCnpj = de.nmCpfCnpj
	AND dp.sk_decisor = de.sk_decisor 
where dp.sk_decisor in (select sk_decisor from vw_clientes_decisor)