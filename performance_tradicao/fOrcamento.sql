select
	posto,
	split_part(""apConta Lanc"", ' ', 1) as conta,
	""apConta Lanc"",
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
	stg_tradicao.temp_tradicao_orcamento
union all
select
	posto,
	conta,
	conta || ' - ' || nmconta as ""apConta Lanc"",
	data::date,
	- orcamento as orcamento,
	0 as qtd,
	null as tipo_orcamento
from
	stg_tradicao.temp_tradicao_orcamento25