select
	idempresa,
	date_trunc('month',dataentrada::date)::date as dataentrada,
	idpessoa,
	idproduto as ""cdProduto"",
	sum(qtdlcto) as qtdlcto,
	avg(vrlcto) as vrlcto,
	avg(vrunit) as vrunit,
	operacao
from
	stg.stg_compras
where
	codcliente = '2'
	and mercadoria = true
	and dataentrada::date >= '20250101'
group by 
	idempresa,
	date_trunc('month',dataentrada::date),
	idpessoa,
	idproduto,
	operacao