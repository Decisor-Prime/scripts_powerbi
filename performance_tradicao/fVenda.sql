SELECT
	"sk_decisor",
	"pkId",
	cpf,
	"idEmpresa",
	"dtLcto"::date,
	datahora,
	"HoraVenda",
	COALESCE("idCliente",-1) "idCliente",
	idvendedor,
	"cdProd",
	"Qtde",
	"prUnitario",
	vrdesconto,
	"prCusto"
FROM
	stg_tradicao.vendas_tradicao
WHERE
	sk_decisor = 2