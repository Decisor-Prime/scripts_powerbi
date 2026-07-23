SELECT
	    d.codcliente || '-' || coalesce(sfr.idempresarateio,d.idempresa::bigint )								AS bkey_empresa,
	    d.emissao::date,

case
		    when d.codcliente = 2 and d.emissao >= '20260401' then coalesce(d.dataentrada::date, d.emissao::date)											
		    else d.emissao::date
		END AS dtEmissao,
	   	d.codcliente || '-' ||  d.centrocusto AS idconta,
	    d.contadebitar 																		AS conta,
	   sp.razaosocial,
	    d.vencimento::date,
		d.documento,
	    d.observacao,
	    d.situacao,
	    cast(CASE
	        WHEN d.rateiodre = false and sfr.percentualrateio IS NULL THEN d.valor
	        ELSE d.valor * (sfr.percentualrateio / 100)
        end		AS NUMERIC(18, 4))																	AS vlrDespesa
FROM stg.stg_fdespesas d
	left join stg.stg_pessoas sp 
		on sp.codcliente = d.codcliente 
		and sp.idpessoa = d.idpessoa
	LEFT JOIN stg.stg_fdespesas_rateios sfr
	     ON d.codcliente = sfr.codcliente 
	     AND d.idempresa = sfr.idempresadespesa 
	     AND d.pk = sfr.iddespesa 
	    and sfr.id_ativo
WHERE d.id_ativo
	  and d.emissao::date >= '20250101' 
	  and d.codcliente::int IN (2,77)
union
select 
sk_decisor || '-' || idempresa	AS bkey_empresa,
dtemissao emissao,
dtemissao,
sk_decisor || '-' || idconta as idconta,
conta,
razaosocial,
dtvencimento as vencimento ,
documento,
observacao,
situacao,
vlrdespesa
from dre.fat_despesas_el