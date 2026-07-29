select
	hv.*
from
	ods.fato_horario_vendas hv
where sk_decisor in (select sk_decisor from vw_clientes_decisor)