select
	idempresa,
	datavenda,
	dataprevistapagamento,
	sum(valorbruto) as valorbruto,
        sum(valorliquido) as valorliquido,
	sum(valorbruto - valorliquido) as taxavalor,
	operadora,
	rede,
	formapagamento,
 case 
 when situacao = 0 then 'Pendente'
 when situacao = 1 then 'Parcial'
 else 'Recebido' end as situacao from
	stg.stg_vendas_taxa_cartoes
	where codcliente = 2
	and datavenda >= '20250101'
group by 
	idempresa,
	datavenda,
	dataprevistapagamento,
	operadora,
	rede,
	formapagamento, situacao