SELECT
codcliente sk_decisor,
codcliente||'-'||idempresa idempresa ,
data_meta,
idsubgrupo,
metapor,
quantidadevalor,
tipometa,
sigla,
mix,
metamarkup
FROM
	stg.stg_fmetas sf
WHERE
	codcliente in (2,77)