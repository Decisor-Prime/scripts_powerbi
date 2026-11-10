select
	grupoid as idGrupoPromo,
	grupodescricao as nmGrupoPromo,
	mercadoriaid as idProduto
from
	stg.stg_dgrupos_mercadoria_promo
where
	codcliente = 2 /*and id_ativo = true*/