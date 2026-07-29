select
sk_decisor,
meiopagamento,
forma_pagamento,
sk_decisor||'-'||idempresa as idempresa,
conciliadora,
forma_recebimento,
date_trunc('month',data_pagamento)::date as data_pagamento,
sum(qtd) as qtd,
sum(vlr_taxa) as vlr_taxa,
sum(vlr_pagamento) as vlr_pagamento
from
	dw.fvendas_fato_pagamentos
	where sk_decisor in (74,76)
group by 1,2,3,4,5,6,7