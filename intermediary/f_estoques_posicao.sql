select
	sk_decisor || '-' || id_empresa as idempresa,
	sk_decisor || '-' || id_produto::text as idproduto,
	qtdeestoque,
	data_geracao as data,
	precocusto,
	ultimoprecocusto,
	null as capacidade
from
	dw.f_posicao_estoque_merc
where qtdeestoque <> 0 and id_ativo = true
and sk_decisor in (select sk_decisor from vw_clientes_decisor)