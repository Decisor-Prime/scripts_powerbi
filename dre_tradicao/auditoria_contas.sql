select
	cf.codcliente as sk_decisor,
	cf.codcliente || '-' || cf.idconta as idconta,
	cf.descricao,
	cf.conta,
	cf.dre,
	sco.conta_para,
	dcf.nome_codigo
from
	stg.stg_contasfinanceiras cf
left join dre.st_contas_obtidas sco on sco.codcliente = cf.codcliente 
	and sco.idconta = cf.idconta
left join dre.dim_dre_contas dcf on dcf.sk_decisor  = sco.codcliente 
	and dcf.cod_conta_nv2::int = sco.conta_para::int
	where cf.codcliente in (2,77,80,84,85)
	and cf.id_ativo 
	and 
		case 
			when cf.codcliente = 2 then cf.conta like '90.%'
			else cf.conta like '90.%' or not cf.conta like '90.%'
		end
	union all
select 
	dce.codcliente,
	dce.codcliente || '-' || dce.idconta as idconta,
	dce.descricao,
	dce.conta,
	true as dre,
	sco.conta_para,
	dcf.nome_codigo
from dre.dim_contas_el dce 
	left join dre.st_contas_obtidas sco on sco.codcliente = dce.codcliente 
	and sco.idconta = dce.idconta
left join dre.dim_dre_contas dcf on dcf.sk_decisor  = sco.codcliente 
	and dcf.cod_conta_nv2::int = sco.conta_para::int