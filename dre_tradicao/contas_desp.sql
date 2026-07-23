with contas as(
select
	distinct d.codcliente,
	d.idconta as idconta,
	d.descricao,
	d.conta
from
	stg.stg_contasfinanceiras d
where
	id_ativo
	and d.codcliente in (2,77)
),
contas2 as(
select
	distinct d.codcliente,
	d.idconta as idconta,
	d.descricao,
	d.conta
from
	dre.dim_contas_el d
)
select
	distinct 
	st.codcliente as sk_decisor,
	st.codcliente || '-' ||  st.idconta as idconta,
	dp.conta,
	dp.descricao,
	trim(dp.conta || ' - ' || dp.descricao) as subgrupo,
	trim(ct.descricao) as grupo,
	dc.codigo_contabil as cod_conta_nv2
from
	dre.dim__hierarquacontas st
inner join contas dp on
	dp.codcliente = st.codcliente
	and dp.idconta = st.idconta::int
inner join dre.st_contas_obtidas sco on
	sco.codcliente = st.codcliente
	and sco.idconta = st.idconta
inner join dre.dim_dre_contas dc on
	dc.sk_decisor = sco.codcliente
	and dc.cod_conta_nv2::int = sco.conta_para::int
inner join contas ct on
	ct.codcliente = st.codcliente
	and ct.idconta = st.idconta_2
	
union all	

select
	distinct 
	st.codcliente as sk_decisor,
	st.codcliente || '-' || st.idconta as idconta,
	dp.conta,
	dp.descricao,
	trim(dp.conta || ' - ' || dp.descricao) as subgrupo,
	trim(ct.descricao) as grupo,
	dc.codigo_contabil as cod_conta_nv2
from
	dre.dim__hierarquacontas st
inner join contas2 dp on
	dp.codcliente = st.codcliente
	and dp.idconta = st.idconta::int
inner join dre.st_contas_obtidas sco on
	sco.codcliente = st.codcliente
	and sco.idconta = st.idconta
inner join dre.dim_dre_contas dc on
	dc.sk_decisor = sco.codcliente
	and dc.cod_conta_nv2::int = sco.conta_para::int
inner join contas2 ct on
	ct.codcliente = st.codcliente
	and ct.idconta = st.idconta_3