select 
	sk_decisor
	,idproduto "idProduto"
	,case
		when apgrupo = 'PA' then '2-1'
		else idsubgrupo end	idsubgrupo
	,nmproduto "nmProduto"
	,approduto "apProduto"
	,apgrupo "nmGrupo"
	,produto_nv1 "Grupo"
	,produto_nv2 "nmCategoria"
	,produto_nv3 "nmSubgrupo"
	,produto_nv4 "intSubgrupo"
from dw.dim_produtos
where sk_decisor in (2,77)