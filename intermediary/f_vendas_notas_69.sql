select
	v.codcliente || '-' || v.idempresa as idempresa,
		v.datalcto,
	COUNT(distinct v.numero) as qtd
from
	stg.stg_fvenda v
left join stg.stg_fvenda_itens i on
	i.pk = v.pk
	and i.codcliente = v.codcliente
	and i.idempresa = v.idempresa
left join stg.stg_fvenda_pagamentos p on
	p.codcliente = v.codcliente
	and p.idempresa = v.idempresa
	and p.pk = v.pk
where
	v.codcliente in (select sk_decisor from vw_clientes_decisor)
	and v.is_active
	and v.trasmissaodocumento = 'Transmitido'
group by 1,2