select
	dp.sk_decisor
	,dp.idpessoa "idPessoa"
	,dp.nmgrupoconsumo grupoconsumo
	,dp.nmrazao "nmRazao"
	,dp.nmpessoa "nmPessoa"
	,dp.codnome "CodNome"
	,dp.vlrlimitecredito limitecredito
	,dp.nmtabelapreco tabelapreco
	,dp.nmperiodicidadefatura tipofaturamento
	,dp.numcpfcnpj "numCpfCnpj"
	,dp.nmcidade "nmCidade"
	,dp.nmuf "nmUF"
	,contato
	,dp.contrato
	,dp.nmvendedor "Vendedor"
	,case
		when numcpfcnpj like '%/%' or dp.numcpfcnpj is NULL then 'B2B'
		else 'B2C'
	end "Canal"
	,de.nmrazao "Filial"
FROM
	dw.dim_pessoas dp
left join dw.dim_empresas de 
	on de.sk_decisor = dp.sk_decisor 
	and de.nmcpfcnpj = dp.numcpfcnpj
WHERE
	dp.sk_decisor IN (2,77)
union all
SELECT *
	FROM (
    	VALUES
     	   (2,'2--1',null,'CONSUMIDOR FINAL','CONSUMIDOR FINAL','2--1 - CONSUMIDOR FINAL',null::int,null,null,null,null,null,null,null,null,'B2C',null),
     	   (77,'77--1',null,'CONSUMIDOR FINAL','CONSUMIDOR FINAL','77--1 - CONSUMIDOR FINAL',null,null,null,null,null,null,null,null,null,'B2C',null)
) AS t("sk_decisor","idPessoa",grupoconsumo,"nmRazao","nmPessoa","CodNome",limitecredito,tabelapreco,tipofaturamento,"numCpfCnpj","nmCidade","nmUF",contato,contrato,"Vendedor","Canal","Filial")