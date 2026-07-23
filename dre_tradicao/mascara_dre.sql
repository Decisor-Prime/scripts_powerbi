select
	sk_decisor,
	conta_nv1,
	conta_nv2,
	ord,
	cod_conta_nv1 as conta_pai,
	nome_codigo,
	subtotal,
	codigo_contabil as cod_conta_nv2
from dre.dim_dre_contas
where sk_decisor in (2)