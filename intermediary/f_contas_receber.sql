select
	codcliente,
	idempresa,
	dtlcto,
	numdocumento,
	nullif(dtvencimento, '')::date as dtvencimento,
	idpessoa,
	nmstatus,
	fonte,
	vlrlcto,
	vlrliquido
from
	dw.fato_contasreceber
where
	codcliente in (select sk_decisor from vw_clientes_decisor)