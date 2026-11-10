select
	de.idempresa,
	datalcto data,
	split_part(de.idproduto::text,'.',1)::bigint idproduto,
	de.tipoavaria,
de.numero,
	sum(qtdlcto) qtd,
	-sum(qtdlcto * vrlcto) valor
from
…	and datalcto >= '20250101'
	and not sdm.descricao like any(array['LANC%','CAF%','%FOOD%'])
group by  1,2,3,4,5