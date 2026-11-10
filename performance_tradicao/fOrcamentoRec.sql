select
	idempresa as posto,
	null as conta,
	grupo as ""apConta Lanc"",
	dtlcto::date as data,
	vlr as orcamento,
	qtd,
	cod_conta_nv2 as tipo_orcamento,
    0 as idconta

from
	stg_tradicao.temp_tradicao_orcamento_receitas
where
	cod_conta_nv2 in ('1.01', '1.02', '1.03', '1.04', '1.05', '1.06','5.01', '5.02', '5.03', '5.04', '5.05', '5.06')