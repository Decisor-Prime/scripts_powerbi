select
	sk_decisor as codcliente,
	sk_decisor||'-'||idempresa idempresa,
	sk_decisor||'-'||idconta idconta,
	justificativa,
	nome as usuario,
	"data"
from
	dre.orc_justificado_st
where ativa = true
and sk_decisor = 2

