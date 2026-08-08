select
	c.codcliente as sk_decisor,
	c.codcliente || '-' ||  c.idempresa as idEmpresa,
    c.codcliente || '-' || split_part(COALESCE(i.idproduto::text, ''), '.', 1) AS idProduto,
   	c.dataLcto as data,
	sum(i.qtdLcto) as qtd,
	avg(i.vrlcto) as vlrcusto
	
from
	stg.stg_fvenda_itens i

left join stg.stg_fvenda c
on i.pk = c.pk and i.codcliente = c.codcliente and i.idempresa = c.idempresa

where
i.cfop in ('5.927','5.949')
and c.codcliente in (select sk_decisor from vw_clientes_decisor)
and c.trasmissaodocumento = 'Transmitido'
and i.idproduto is not null
and c.dataLcto between '20230101' and '20251231'

group by
c.idempresa,
c.dataLcto,
i.idproduto,
c.codcliente


union all

select

codcliente as sk_decisor,
codcliente || '-' ||idempresa as idempresa,
codcliente || '-' ||idproduto as idproduto,
data as data,
diferencaestoque * -1 as qtd,
CASE 
    WHEN diferencaestoque > 0 THEN - (diferencaprecocusto / diferencaestoque)
    WHEN diferencaestoque < 0 THEN ABS(diferencaprecocusto / diferencaestoque)
    ELSE 0
END as vlrcusto

from stg.stg_divergencia_estoques

where
data between '20230101' and '20251231'
and diferencaestoque <> '0'
and codcliente in (select sk_decisor from vw_clientes_decisor)

union all

select 

codcliente as sk_decisor,
codcliente || '-' ||idempresa as idempresa,
codcliente || '-' || split_part(COALESCE(idproduto::text, ''), '.', 1) as idproduto,
datalcto as data,
qtdlcto as qtd,
vrlcto as vlrcusto

from stg.stg_documentosemitidos

where codcliente in (select sk_decisor from vw_clientes_decisor)
and trasmissaodocumento = 'Transmitido'
and cfop in ('5.927','5.949')
and datalcto between '20230101' and '20261231'