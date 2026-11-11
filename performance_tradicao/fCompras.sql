select
	codcliente sk_decisor,
	codcliente||'-'||idempresa "idEmpresa",
	date_trunc('month',dataentrada::date)::date as "dtLcto",
	codcliente||'-'||idpessoa "idPessoa",
	codcliente||'-'||idproduto "cdProduto",
	operacao "nmOperacao",
	sum(qtdlcto) as qtdlcto,
	avg(vrlcto) as "vrlcto",
	avg(vrunit) as "vrUnit"
from
	stg.stg_compras c
where
	codcliente in (2,77)
	and mercadoria = true
	and dataentrada::date >= '20250101'
group by 1,2,3,4,5,6