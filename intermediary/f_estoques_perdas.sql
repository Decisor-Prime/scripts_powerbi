select
	*
from
	dw.f_comissao_produtos
where
	comissao_percentual is not null
	and comissao_valor is not null
	and sk_decisor in (select sk_decisor from vw_clientes_decisor)