select
	hx.*,
	'2-' || split_part(posto::text, '.', 1) idempresa
from
	stg_tradicao.temp_tradicao_horas_extras hx