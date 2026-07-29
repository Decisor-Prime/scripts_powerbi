SELECT
	sk_decisor
	, idempresa
	, dtlcto
	, idcliente
	, id_vendedor_frentista idvendedor
	, idvendedor idcaixa 
	, cdproduto
	, prunitario
	, vrdesconto
	, prcusto
	, qtde
	, cupons
FROM
	dw.fvendas
where sk_decisor in (select sk_decisor from vw_clientes_decisor)