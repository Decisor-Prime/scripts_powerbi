select
	sk_decisor,
	idempresa,
	dtlcto,
	vlr_ticket,
	qtd_compras,
	qtd_vendas,
	tipo,
	idvendedor
from
	dw.fvendas_fato_ticket_medio
where
	sk_decisor in (select sk_decisor from vw_clientes_decisor)