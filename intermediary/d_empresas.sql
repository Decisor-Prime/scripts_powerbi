select
	sk_decisor,
	idEmpresa	AS "idEmpresa",
	split_part(idEmpresa, '-', array_length(string_to_array(idEmpresa, '-'), 1))::int bkey_empresa,
	nmCpfCnpj AS "nmCpfCnpj",
	nmRazao AS "nmRazao",
	nmEmpresa AS "nmEmpresa",
	nmCidade AS "nmCidade",
	nmUf AS "nmUf",
	apempresa as "apEmpresa",
	row_number() over (order by split_part(idEmpresa, '-', array_length(string_to_array(idEmpresa, '-'), 1))::int) as Ord 
from
	dw.dim_empresas 
where sk_decisor in (select sk_decisor from vw_clientes_decisor)