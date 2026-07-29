select
	sk_decisor,
	dtlcto::date,
	idempresa,
	cdproduto,
	pkid,
	qtde
from
	dw.fvendas_fato_crossell
where
	sk_decisor in (select sk_decisor from vw_clientes_decisor)