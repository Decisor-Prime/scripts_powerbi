select
	dp.sk_decisor,
	dp.idPessoa as "idPessoa",
	dp.nmRazao as "nmRazao",
	split_part(dp.idPessoa, '-', 2) || ' - ' || dp.nmRazao as CodNome
from
	dw.dim_pessoas dp
where
	sk_decisor in (select sk_decisor from vw_clientes_decisor)