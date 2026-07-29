select
	sk_decisor,
	idempresa,
	idtanque,
    idtanque || ' - ' || tipocombustivel as codnometanque,
	cdProduto as 	"cdProduto",
	tipocombustivel,
	case 
		when volumemedicao = 0 or volumemedicao isnull  then volumeestoque
		else volumemedicao
	end as volumeestoque,
	volumemedicao,
	datamedicao::date+1 as datamedicao,
	capacidade
from
	dw.fato_estoque_comb
where sk_decisor in (select sk_decisor from vw_clientes_decisor)