SELECT
	sk_decisor
	,idvendedor "idVendedor"
	,nmvendedor "nmVendedor"
	,nmcpf "numCpfCnpj"
	,oficio
	,coalesce(tt.função,'Vendedor Pista') "Função"
FROM
	dw.dim_vendedor dv  
left join stg_tradicao.temp_tradicao_trocadores tt 
	on tt.cpf = dv.nmcpf 
		
WHERE
	dv.sk_decisor in (2,77)