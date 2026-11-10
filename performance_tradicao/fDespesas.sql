
select
	""Identificador""::text,
	""dtEmissao"",
	""idCentroCusto""::text,
	""idFornecedor""::text,
	""numDocumento"",
	""dtVencimento"",
    case when ""dtEmissao"" >= '2026-04-01' and ""dtCompetencia"" isnull then coalesce(""dtCompetencia"",""dtEmissao"")
    	else ""dtEmissao"" end as ""dtCompetencia"",
	cast(""vlrPendente"" AS NUMERIC(18, 4)) ""vlrAPagar"",
	""nmSituacao"",
	""desObservacao"",
	cast(""vlrDespesa"" - coalesce(desconto,0) AS NUMERIC(18, 4))  ""vlrDespesa"",
	case 
		when ""idEmpresaRateada"" is null then ""idEmpresa""
		else ""idEmpresaRateada""
	end  							as ""idEmpresaDespesa""
-------------------------------
from
	stg_tradicao.fat_despesas