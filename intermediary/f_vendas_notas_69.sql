select
	v.codcliente || '-' || v.idempresa as idempresa,
	COUNT(distinct v.numero) as qtd,
	v.datalcto
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
	v.codcliente in (4)
	and v.is_active
	and v.trasmissaodocumento = 'Transmitido'
group by 1,2