select
	codcliente || '-' ||idempresa as idempresa,
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
	where codcliente in (select sk_decisor from vw_clientes_decisor)
	and datavenda >= '20250101'
group by 1,2,3,4,5,6