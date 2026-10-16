select
	competencia::date,
	'2-'||filial filial,
	orcado,
	"final" quadro,
	admissao,
	demissao,
	demissao_voluntario,
	demissao_pela_empresa,
	termino_contrato,
	intervalares_11h,
	estouro_10h,
	intrajornada
from
	stg_tradicao.temp_tradicao_funcionarios
