select
	rede,filial ,
	bandeira,
	ga,
	tipo,
	""Assessor Loja"" as assessor,
	loja
	
from
	stg_tradicao.temp_tradicao_bandeiras where rede = 2