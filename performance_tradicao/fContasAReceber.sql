select 
	codcliente sk_decisor
	,idempresa "idEmpresa"
	,fc.dtlcto::date "dtLcto"
	,fc.idpessoa "idPessoa"
	,fc.dtvencimento::date "dtVencimento"
	,fc.dt_baixa::date "dtPagamento"
	,fc.nmstatus "nmStatus"
	,fonte "Fonte"
	,numdocumento "Documento"
	,fc.vlrlcto "vlrLcto"
	,fc.vlrliquido "vlrLiquido"
from dw.fato_contasreceber fc
where fc.codcliente in (2,77)