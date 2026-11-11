SELECT
	"pkId",
	"sk_decisor",
	"sk_decisor"||'-'||"idEmpresa" "idEmpresa",
	"dtLcto"::date,
	datahora,
	"HoraVenda",
	"sk_decisor"||'-'||idvendedor idvendedor,
	"sk_decisor"||'-'||COALESCE("idCliente",-1) "idCliente",
	cpf,
	"sk_decisor"||'-'||"cdProd" "cdProd",
	"Qtde",
	"prUnitario",
	vrdesconto,
	"prCusto"
FROM
	stg_tradicao.vendas_tradicao
WHERE
	sk_decisor IN (2,77)