select
	pk,
	sk_decisor,
	idempresa as "idEmpresa",
	OrigemDespesa as "OrigemDespesa",
	dtEmissao as "dtEmissao",
	dtVcto as "dtVcto",
	left(dtPgto, 10) as "dtPgto",
	nmSituacao as "nmSituacao",
	idFornecedor as "idFornecedor",
	idCentroCusto as "idCentroCusto",
	idConta as "idConta",
	numDocumento as "numDocumento",
	vlrDespesa as "vlrDespesa",
	vlrAPagar as "vlrAPagar",
	vlrJuros as "vlrJuros",
	descObservacao as "descObservacao"
from
	dw.fato_despesas_rateadas dr
	where dr.sk_decisor in (select sk_decisor from vw_clientes_decisor)