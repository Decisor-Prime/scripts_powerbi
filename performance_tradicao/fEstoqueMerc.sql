select
	em.sk_decisor,
	em.idempresa "idEmpresa",
	em.idproduto "idProduto",
	em.qtdeestoque "qtdeEstoque",
	current_date::date as "Data",
	dm.idgrupo
from
	dw.fato_estoque_produto em
left join dw.dim_produtos dm 
	on em.sk_decisor = dm.sk_decisor 
	and em.idproduto = dm.idproduto 
where
	em.sk_decisor in (2,77)
	and em.qtdeestoque <> 0
	and dm.idgrupo <> '2-440'