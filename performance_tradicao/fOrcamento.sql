select
	'2' sk_decisor,
	'2-'||posto idempresa,
	split_part("apConta Lanc", ' ', 1) as conta,
	dp.idconta,
	"apConta Lanc",
	data::Date,
	case 
		when orcamento = ' R$                        -  ' then null
		when orcamento like '% %'
		or orcamento = ' ' then null
		else replace(orcamento, ',', '.')::numeric
	end as 
	orcamento,
	0 as qtd,
	null as tipo_orcamento
from
	stg_tradicao.temp_tradicao_orcamento orc
left join dw.dim_plancontas dp 
	on dp.codcliente = 2 
	and dp.conta = split_part(orc."apConta Lanc", ' ', 1)
where not orc.orcamento is null 
union all
select
	'2' sk_decisor,
	'2-'||posto idempresa,
	orc25.conta,
	idconta,
	orc25.conta || ' - ' || nmconta as "apConta Lanc",
	data::date,
	- orcamento as orcamento,
	0 as qtd,
	null as tipo_orcamento
from
	stg_tradicao.temp_tradicao_orcamento25 orc25
left join dw.dim_plancontas dp2 
	on dp2.codcliente = 2 
	and dp2.conta = orc25.conta 
where not orc25.orcamento is null 
union ALL
select
	'2' sk_decisor,
	'2-'||idempresa idempresa,
	null as conta,
	null as idconta,
	grupo as "apConta Lanc",
	dtlcto::date as data,
	vlr as orcamento,
	qtd,
	cod_conta_nv2 as tipo_orcamento
from
	stg_tradicao.temp_tradicao_orcamento_receitas orc
where
	cod_conta_nv2 in ('1.01', '1.02', '1.03', '1.04', '1.05', '1.06','5.01', '5.02', '5.03', '5.04', '5.05', '5.06')
	and not orc.vlr is null 

