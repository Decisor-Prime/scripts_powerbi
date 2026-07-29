select
	ep.sk_decisor,
	ep.idempresa as "idEmpresa",
	ep.idproduto as "idProduto",
	ep.qtdeEstoque as "qtdeEstoque",
	preco_custo precocusto,
	preco_venda precovenda
from
	dw.fato_estoque_produto ep
where
	sk_decisor in (select sk_decisor from vw_clientes_decisor)