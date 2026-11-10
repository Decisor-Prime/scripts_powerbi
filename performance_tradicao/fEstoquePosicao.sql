select
	id_empresa as idempresa,
	'C-' || id_empresa || '-' || pk as idproduto,
	volume as qtdestoque,
	--tipo_combustivel,
	dt_posicao as data,
	preco_custo as preco_custo,
	custo_ultima_compra as ultimoprecocusto,
	capacidade
from
	dw.fato_posicao_estoque_comb
where
	sk_decisor = 2
	and volume <> 0
union all
select
	id_empresa as idempresa,
	id_produto::text as idproduto,
	qtdeestoque,
	data_geracao as data,
	precocusto,
	ultimoprecocusto,
	null as capacidade
from
	dw.f_posicao_estoque_merc
where
	sk_decisor = 2
	and qtdeestoque <> 0
	and id_ativo