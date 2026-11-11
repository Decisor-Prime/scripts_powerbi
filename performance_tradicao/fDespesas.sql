
select
	'2' sk_decisor,
	"Identificador",
	"dtEmissao"::date,
	'2-'||"idCentroCusto" "idCentroCusto",
	'2-'||"idFornecedor" "idFornecedor",
	"numDocumento",
	"dtVencimento"::date,
    case when "dtEmissao" >= '2026-04-01' and "dtCompetencia" isnull then coalesce("dtCompetencia","dtEmissao")
    	else "dtEmissao" end :: date "dtCompetencia",
	cast("vlrPendente" AS NUMERIC(18, 4)) "vlrAPagar",
	"nmSituacao",
	"desObservacao",
	cast("vlrDespesa" - coalesce(desconto,0) AS NUMERIC(18, 4))  "vlrDespesa",
	case 
		when "idEmpresaRateada" is null then '2-'||"idEmpresa"
		else '2-'||"idEmpresaRateada"
	end  							as "idEmpresaDespesa"
-------------------------------
from
	stg_tradicao.fat_despesas