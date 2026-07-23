select
	competencia,
	'2-'||filial filial,
	orcado,
	"final" quadro,
	admissao,
	demissao,
demissao_voluntario,
demissao_pela_empresa,
termino_contrato
from
	stg_tradicao.temp_tradicao_funcionarios