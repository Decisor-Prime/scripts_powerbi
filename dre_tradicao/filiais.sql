select
    sd.codcliente || '-' || sd.idempresa as bkey_empresa,
	sd.codcliente as sk_decisor,
	sd.idempresa,
	sd.cnpj,
	sd.nomefantasia,
	sd.cidade,
	sd.uf,
	fr.dre,
	ce.descricao as tipo_grupo,
	ttb.ga,
	ttb.bandeira 
from dre.dim_filial_rateio fr
left join dre.dim_classificacao_empresa ce on ce.sk_decisor = fr.sk_decisor
	and ce.id = fr.id_classificacao_empresa 
left join stg.stg_dempresas sd on sd.codcliente = fr.sk_decisor 
	and sd.idempresa = fr.idempresa
left join stg_tradicao.temp_tradicao_bandeiras ttb on fr.sk_decisor = 2 
	and ttb.filial = fr.idempresa 
where fr.active
	and ce.sk_decisor in (2,77)
	
union all

select
    el.sk_decisor || '-' || el.idempresa as bkey_empresa,
	el.sk_decisor as sk_decisor,
	el.idempresa,
	el.cnpj,
	el.fantasia,
	null as cidade,
	null as uf,
	true as dre,
	ce.descricao as tipo_grupo,
	null as ga,
	null as bandeira 
from dre.dim_filial_el el
left join dre.dim_classificacao_empresa ce on ce.sk_decisor = el.sk_decisor