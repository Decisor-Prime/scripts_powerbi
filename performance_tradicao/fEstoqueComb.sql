select
	'C-' || idempresa || '-' || pk as idproduto,
em.*
from
	stg.stg_dproduto_estoque_tanques em
where
	em.codcliente = 2