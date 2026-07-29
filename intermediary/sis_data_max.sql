select
	sk_decisor,
	max(dtlcto) as dt_lcto
FROM
	dw.fvendas where sk_decisor in (select sk_decisor from vw_clientes_decisor)
group by 1
ORDER by 1 asc

