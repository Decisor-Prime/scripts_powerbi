SELECT
	sk_decisor,
	idVendedor AS "idVendedor",
	nmVendedor AS "nmVendedor",
	nmCpf as "nmCpf",
	oficio
FROM
	dw.dim_vendedor 
where sk_decisor in (select sk_decisor from vw_clientes_decisor)