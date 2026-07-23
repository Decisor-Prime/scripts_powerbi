select
	sk_decisor || '-' || id_empresa bkey_empresa,
	date_trunc('month', fpem.data_geracao)::date data,
	split_part(sdg.grupocompleto, ' /',1) grupo,
	case 
		when split_part(sdg.grupocompleto, ' /',1) like 'AUT%' then '4.04'
		else '4.05'
	end cod_conta_nv2,
	sum(fpem.qtdeestoque * fpem.precocusto) custo
from
	dw.f_posicao_estoque_merc fpem
left join stg.stg_dproduto_merc sdm
	on sdm.codcliente = fpem.sk_decisor
	and sdm.idproduto = fpem.id_produto
left join
    stg.stg_dproduto_grupo sdg 
        on sdm.codcliente = sdg.codcliente
        and sdg.idgrupo = sdm.idgrupo
where
	fpem.sk_decisor in (2, 77)
	and fpem.qtdeestoque <> 0
	and fpem.data_geracao >= '20260101'
	and fpem.data_geracao = date_trunc('month', fpem.data_geracao)
	and sdg.grupocompleto like any(array['%AUT%', '%CONVENIÊNCIA%'])
group by
	bkey_empresa,
	data,
	split_part(sdg.grupocompleto, ' /',1)