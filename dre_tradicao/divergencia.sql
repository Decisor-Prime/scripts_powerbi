select
	date_trunc('month',de.data::date)::date data,
	date_trunc('month',datatransmissaoinventario::date)::date datatransmissao,
	de.codcliente || '-' ||idempresa idempresa,
	split_part(sdg.grupocompleto,' /',1) grupo,
	sum(diferencaprecocusto) valor
from
	stg.stg_divergencia_estoques de
left join stg.stg_dproduto_grupo sdg 
        on de.codcliente = sdg.codcliente
        and de.idgrupo = sdg.idgrupo
where de.codcliente = 2
and "data" >= '20260701'
--and not sdg.grupocompleto LIKE 'ARLA'
group by 1,2,3,4