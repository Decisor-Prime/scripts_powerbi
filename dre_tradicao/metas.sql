select
	sf.codcliente || '-' || idempresa bkey_empresa,
	('01/0' || data_meta)::date data,
	metapor,
	sf.tipometa,
	sigla,
	idsubgrupo,
	case
		when tipometa = 'Combustível' then 'Comb' 
		when idsubgrupo = 447 then 'CV'
		when idsubgrupo = 1 then 'PA'
	end grupo_meta,
	quantidadevalor valor
	from stg.stg_fmetas sf
where
	codcliente = 2
order by sf.idempresa