select
	sk_decisor,
	sk_decisor || '-' || id_empresa idempresa,
	data_emissao dtEmissao,
	vencimento dtVencimento,
	data_recebimento dtRecebimento,
	left(hora_emissao::text,5) hora,
	situacao,
	nome_cliente_argo360 cliente,
        cpf_cliente_argo360 cpf,
        valor_total vlrGerado,
	(valor_total - valor_utilizado) vlrLiquido
from
	dw.dw_vendas_antecipadas va
where
	sk_decisor = 69
	and va.data_emissao::date >= '20250101'
        and va.nome_cliente_argo360  NOTNULL
	and is_active