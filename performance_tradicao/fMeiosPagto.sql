with qtd_pgtos as (
	select 
		pk,
		idempresa,
		meiopagamento,
		sum(sfp.valortransacao) valortransacao
	from stg.stg_fvenda_pagamentos sfp
	where sfp.codcliente = 2
	and sfp.datalcto >= '20260101'
	group by 1,2, meiopagamento
)
select
	fv.codcliente,
	fv.idempresa,
	date_trunc('month',fv.datalcto)::date data,
	sfp.meiopagamento,
	case
		when sfp.meiopagamento like any(array['%DINHEIRO%']) then 'DINHEIRO'
		when sfp.meiopagamento like any(array['%PIX%']) then 'PIX'
		when sfp.meiopagamento like any(array['%CARTA%','%FRETE%']) then 'CARTA FRETE'
		when sfp.meiopagamento like any(array['%PRAZO%']) then 'Á PRAZO'
		when sfp.meiopagamento like any(array['%ANTECIP%']) then 'VENDA ANTECIPADA'
		when sfp.meiopagamento like any(array['%DÉBIT%','%DEBIT%']) then 'CARTÃO DÉBITO'
		when sfp.meiopagamento like any(array['%CRÉD%','%CRED%']) then 'CARTÃO CRÉDITO'
		when sfp.meiopagamento like any(array['%VOUCHER%','%ALIMENT%', '%REFEI%','%BENEF%']) then 'CARTÃO VOUCHER'
		when sfp.meiopagamento like any(array['%DATADO%','%CHEQUE%']) then 'CHEQUE'
		when sfp.meiopagamento like any(array['%FROTA%','%SENF%','%GOOD%','%TICKET%','%FLEET%']) then 'CARTÃO FROTAS'
		when sfp.meiopagamento like any(array['%SHELL%','%BARAT%','%99%']) then 'APP'
		when SFP.meiopagamento = null then 'VENDAS A PRAZO'
		else 'OUTRO'
	end forma_recebimento,
	Sum(sfp.valortransacao) vlr_pagamento
from stg.stg_fvenda fv 
	inner join qtd_pgtos sfp 
		on sfp.idempresa = fv.idempresa 
		and sfp.pk = fv.pk
where (fv.nota_estornada = false or fv.nota_estornada is null)
	and (fv.baixa_para_consumo = false or fv.baixa_para_consumo is null)
	and fv.is_active
	and fv.trasmissaodocumento = 'Transmitido'
	and fv.codcliente = 2
	and fv.datalcto >= '20260101'
group by 1,2,3,4
union all
select 
	fv.codcliente,
	fv.idempresa,
	date_trunc('month',fv.datalcto)::date data,
	'VENDAS A PRAZO' as meiopagamento,
	'VENDAS A PRAZO' as forma_recebimento,
	sum(sfi.vrltotal) vlr_pagamento
from stg.stg_fvenda_pagamentos fv 
inner join stg.stg_fvenda_itens sfi
	on sfi.codcliente = fv.codcliente  
	and sfi.idempresa = fv.idempresa
	and sfi.pk = fv.pk
inner join stg.stg_fvenda sf 
	on sf.codcliente = sfi.codcliente
	and sf.idempresa = sfi.idempresa
	and sf.pk = sfi.pk
where 
	fv.meiopagamento is null
	and (sf.nota_estornada = false or sf.nota_estornada is null)
	and (sf.baixa_para_consumo = false or sf.baixa_para_consumo is null)	
	and sf.trasmissaodocumento = 'Transmitido'
	and sf.is_active
	and fv.codcliente = 2 
	and sf.datalcto  >= '20260101'
group by 1,2,3,4