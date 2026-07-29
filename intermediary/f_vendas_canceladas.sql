SELECT
    v.codcliente as sk_decisor,           
	v.codcliente||'-'||v.idempresa as idempresa,
   v.datalcto,
   left(v.horalcto,2)::TEXT || 'h' as Hora,
   left(v.horalcto,2)::numeric as "HoraNum",
   case 
	   when v.idpessoa is null then null 
	   else v.codcliente || '-' || split_part(COALESCE(v.idpessoa::text, ''), '.', 1) end as idpessoa,
   case 
   		when v.idvendedor is null then null
   		else v.codcliente || '-' || split_part(COALESCE(v.idvendedor::text, ''), '.', 1) end as idvendedor,
   sum(i.qtdlcto) as qtd,
   sum(i.vrlcto) as vlr,
   v.trasmissaodocumento,
   p.meiopagamento
 FROM stg.stg_fvenda v
 left join stg.stg_fvenda_itens i
   on i.pk = v.pk and i.codcliente = v.codcliente and i.idempresa = v.idempresa
 left join stg.stg_fvenda_pagamentos p
   on p.codcliente = v.codcliente and p.idempresa = v.idempresa and p.pk = v.pk
 where v.codcliente in (select sk_decisor from vw_clientes_decisor)
   and v.trasmissaodocumento = 'Cancelada'            
   and v.is_active
   group by 1,2,3,4,5,6,7,8,9,10,11,12