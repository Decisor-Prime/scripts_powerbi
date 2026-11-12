SELECT
codcliente sk_decisor,
codcliente||'-'||idempresa "idEmpresa",
codcliente||'-'||split_part(idsubgrupo::text,'.',1) "idSubgrupo",
to_date(data_meta, 'MM/YYYY') "DataMeta",
metapor "MetaPor",
quantidadevalor "QuantidadeValor",
tipometa "TipoMeta",
sigla "Sigla",
mix "Mix",
metamarkup "MetaMrg"
FROM
	stg.stg_fmetas sf
WHERE
	codcliente in (2,77)