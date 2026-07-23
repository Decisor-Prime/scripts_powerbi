with DEPARA AS(
SELECT																		
    distinct d.centrocusto AS idCentroCusto,
  d.contadebitar AS idConta,
    d.codcliente 
   FROM stg.stg_fdespesas d
   LEFT JOIN stg.stg_fdespesas_rateios sfr
     ON d.codcliente = sfr.codcliente 
     AND d.idempresa = sfr.idempresadespesa 
     AND d.pk = sfr.iddespesa 
     AND true = sfr.id_ativo
  LEFT JOIN 
  	dre.st_contas_obtidas sco ON d.codcliente = sco.codcliente AND d.centrocusto::bigint  = sco.idconta
INNER JOIN dre.dim_filial_rateio dfr
	ON d.codcliente = dfr.sk_decisor
	AND d.idempresa = dfr.idempresa
	AND dfr.dre IS true
  WHERE d.id_ativo = TRUE
  AND sco.idconta notnull
)
select
	st.sk_decisor,
	st.sk_decisor || '-' || st.idempresa as bkey_empresa,
	st.idempresa,
	codcliente || '-' || st.idconta as idconta,
	dp.idConta as conta,
	st.justificativa,
	st."data" as dtcompetencia,
	st.dt_insert as dtregistro,
	st.nome as responsavel
from dre.orc_justificado_st st
left join depara dp on dp.codcliente = st.sk_decisor 
	and dp.idcentrocusto::int = st.idconta::int
	where ativa 