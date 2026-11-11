select
	pp.codcliente sk_decisor,
	pp.codcliente||'-'||pp.unidadedenegocioid unidadedenegocioid,
	pp.codcliente||'-'||pp.idpessoa idpessoa,
	pp.sigla,
	pp.percentualprazo,
	pp.percentualvista,
	pp.valordescontoprazo,
	pp.valordescontovista,
	ts.precovenda,
pp.preco_fixo_prazo,
pp.preco_fixo_vista,
	case
		when pp.valordescontoprazo >= pp.percentualprazo then ts.precovenda - pp.valordescontoprazo
		else ts.precovenda - ((pp.percentualprazo/100)*ts.precovenda)
	end as preco_venda_prazo,
	case
		when pp.valordescontovista >= pp.percentualvista then ts.precovenda - pp.valordescontovista
		else ts.precovenda - ((pp.percentualvista/100)*ts.precovenda)
	end as preco_venda_avista,
	CASE
		WHEN sigla = 'ARL' THEN 'ARLA'
		WHEN sigla = 'DA' THEN 	'DS10'
		WHEN sigla = 'DC' THEN 	'DS500'
		WHEN sigla = 'DS' THEN 'DS10'
		ELSE sigla
	END "apProduto"
from
	stg.stg_pessoas_precos pp
left join stg.temp_stg_dproduto_tanque_siglapreco ts 
	on ts.codcliente = pp.codcliente 
	and ts.idempresa = pp.unidadedenegocioid 
	and ts.sigla = pp.sigla
where
pp.codcliente in (2,77)
	and unidadedenegocioid notnull