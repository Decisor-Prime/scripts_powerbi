SELECT
	sk_decisor,
	idproduto,
	idgrupo,
	idsubgrupo,
	nmGrupo AS "nmGrupo",
	produto_nv1,
	produto_nv2,
	produto_nv3,
	produto_nv4,
	produto_nv5,
	apGrupo AS "apGrupo",
	nmProduto AS "nmProduto",
	codnome,
	apProduto AS "apProduto",
	case
		when produto_nv1 LIKE '%COMBUST%' and apProduto like any(array['%GC%']) then 'GC'
		when produto_nv1 LIKE '%COMBUST%' and apProduto like any(array['%ET%']) then 'ET'
		when produto_nv1 LIKE '%COMBUST%' and apProduto like any(array['%GNV%','%GÁS%','%POWER%']) then 'GNV'
		when produto_nv1 LIKE '%COMBUST%' and apProduto like any(array['%ARL%']) then 'ARL'
		when produto_nv1 LIKE '%COMBUST%' and apProduto like any(array['%10%','%DSA%']) then 'DS'
		when produto_nv1 LIKE '%COMBUST%' and apProduto like any(array['%500%', '%DCA%']) then 'DC'
		when produto_nv1 LIKE '%COMBUST%' and apProduto like any(array['%GA%','%GP%']) then 'GA'
	else ''
	end as sigla_meta    
FROM
	dw.dim_produtos where sk_decisor in (4)