SELECT
	*
FROM
	stg.stg_vendedores sv
WHERE
	codcliente::int = 2
	AND id_ativo = TRUE