SELECT
	sk_decisor,
	idEmpresa			AS "idEmpresa",
	idPessoa			AS "idPessoa",
	dtLcto				AS "dtLcto",
	nmTransportador		AS "nmTransportador",
	cdProduto			AS "cdProduto",
	qtde,
	vlrLcto				AS "vlrLcto",
	vlrDesconto	AS		"vlrDesconto",
	vlrUnit 			AS "vlrUnit",
	nmOperacao 			AS "nmOperacao"
FROM
	dw.fato_compras 
where sk_decisor in (select sk_decisor from vw_clientes_decisor)
and idpessoa <> '3-4552'