create view vw_clientes_decisor as (
select
	sk_decisor,
	'REDE ' || nome as "apCliente"
from
	public.cliente_empresa
where
	ativo
	and sk_decisor not in (1,2,30,55,65,66,67,73,80,84,85,86)
order by
	sk_decisor)