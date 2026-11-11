select
	sk_decisor,
	sk_decisor|| '-' || id_empresa  idempresa,
	sk_decisor|| '-' ||'C' || id_empresa || pk as idproduto,
	volume as qtdestoque,
	--tipo_combustivel,
	dt_posicao as data,
	preco_custo as preco_custo,
	custo_ultima_compra as ultimoprecocusto,
	capacidade
from
	dw.fato_posicao_estoque_comb
where
	sk_decisor IN (2,77)
	and volume <> 0
union all
select
	sk_decisor,
	sk_decisor||'-'||id_empresa as idempresa,
	sk_decisor||'-'||id_produto::text as idproduto,
	qtdeestoque,
	data_geracao as data,
	precocusto,
	ultimoprecocusto,
	null as capacidade
from
	dw.f_posicao_estoque_merc
where
	sk_decisor IN (2,77)
	and qtdeestoque <> 0
	and id_ativo