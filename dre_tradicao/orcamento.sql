	
with contas as(SELECT																		
    distinct
	d.codcliente as sk_decisor,
  d.codcliente || '-' ||   d.idconta as idconta,
    d.descricao,
   trim(d.conta) conta
  FROM stg.stg_contasfinanceiras d
  where id_ativo 
  	and d.codcliente in (select sk_decisor from dre.cliente_empresa_dre)
) 
select
	t.*,
	ct.idconta,
	2 as sk_decisor
from stg_tradicao.temp_tradicao_orcamento25 t
left join contas ct on ct.sk_decisor = 2
	and ct.conta = t.conta