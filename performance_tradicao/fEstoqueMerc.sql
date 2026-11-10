select
	em.codcliente,
	em.idempresa,
	em.idproduto,
	dm.idgrupo,
	em.estoque,
	em.data_registro as data_estoque
from
	stg.stg_dproduto_estoque_merc em
	left join stg.stg_dproduto_merc dm on em.codcliente = dm.codcliente and em.idproduto = dm.idproduto 

where
	em.codcliente = 2