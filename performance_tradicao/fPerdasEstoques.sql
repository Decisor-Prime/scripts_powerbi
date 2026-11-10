select
	c.numero::text,
	c.idempresa,
	c.dataLcto as data,
	split_part(coalesce(i.idproduto::text, ''), '.', 1) as idProduto,
	sum(i.qtdLcto) as qtd,
	-sum(i.vrlcto*i.qtdLcto) as valor
from
	stg.stg_fvenda_itens i
left join stg.stg_fvenda c
on
	i.pk = c.pk
	and i.codcliente = c.codcliente
	and i.idempresa = c.idempresa
left join stg.stg_dproduto_merc sdm
	on sdm.codcliente = i.codcliente 
	and sdm.idproduto = i.idproduto
left join
    stg.stg_dproduto_grupo sdg 
        on sdm.codcliente = sdg.codcliente
        and sdg.idgrupo = sdm.idgrupo
left join stg.stg_pessoas sp 
	on 	c.codcliente = sp.codcliente
	and nullif(c.idpessoa,'NaN')::numeric::bigint = sp.idpessoa 
left join stg.stg_dempresas de
	on de.codcliente = 	sp.codcliente
	and de.cnpj = sp.cpfcnpj
and not de.idempresa in (202,204)
where
	c.baixa_para_consumo = true
	and c.codcliente = 2
	and c.trasmissaodocumento = 'Transmitido'
	and sp.cpfcnpj = de.cnpj
	and c.datalcto >='20250101'
	and sdg.grupocompleto   like ('CONVENI%')
	and sdm.descricao like any(array['LANC%', 'CAF%', 'FOOD%'])
group by 1,2,3,4