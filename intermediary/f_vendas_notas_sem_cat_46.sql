select
	v.codcliente || '-' || i.idempresa as idempresa,
	v.datalcto data,
	COUNT(distinct v.numero) notas,
	SUM((qtdlcto * vrlcto)-vrdesconto) vlr
from
	stg.stg_fvenda v
left join stg.stg_fvenda_itens i on
	i.pk = v.pk
	and i.codcliente = v.codcliente
	and i.idempresa = v.idempresa
left join dw.dim_produtos dp 
	on
	dp.idproduto = case 
					when i.combustivel then v.codcliente || '-C' || v.idempresa::text || i.idproduto::TEXT
					else v.codcliente || '-' || i.idproduto::TEXT
	end
where
	v.codcliente = '46'
	and v.trasmissaodocumento = 'Transmitido'
	and v.is_active
	and v.tipodocumento in ( '0','1')
	and i.cfop not in ('5949', '5927')
	and substr(dp.produto_nv1,1,3) not in ('L -')
group by 1,2