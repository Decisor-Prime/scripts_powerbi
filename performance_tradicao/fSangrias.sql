select
	idempresa,
	idcaixa,
	idfuncionario,
	data,
	observacao,
	numeroenvelope,
	case 
		when conciliada = true then 'Sim'
	else 'Não' end as conciliada,
	datadeposito,
	valor,
	id
from
	stg.stg_sangrias 
where codcliente = 2 and data >= '20260401' and is_active