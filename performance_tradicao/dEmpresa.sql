SELECT
	sk_decisor
	,idempresa "idEmpresa"
	,apempresa "apEmpresa"
	,nmcpfcnpj "nmCpfCnpj"
	,nmrazao "nmRazao"
	,nmempresa "nmPessoa"
	,nmcidade "nmCidade"
	,nmuf "nmUf"
	,idempresa_ "Ord"
	,ttb.bandeira
	,ttb.ga
	,ttb.tipo 
	,ttb."Assessor Loja" assessor
	,ttb.loja 
FROM
	dw.dim_empresas de
left join stg_tradicao.temp_tradicao_bandeiras ttb 
	on ttb.rede||'-'||ttb.filial = de.idempresa
WHERE
	sk_decisor in (2,77)
order by idempresa_