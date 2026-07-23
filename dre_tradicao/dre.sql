with DRE_2026 as (
	WITH FATURAMENTO AS (
	--FATURAMENTO COMB E MERC 1.0--
		SELECT
			ff.sk_decisor			,
			ff.idempresa			,
			ff.dtlcto				,
			cod_conta_nv2,
			ff.grupo				,
			ff.subgrupo 			,
			sum(ff.vlr_faturamento)		AS vlr,	
			sum(ff.qtde)		AS qtd
		from dre.final_faturamento ff
		where cod_conta_nv2 is not null
			and ff.sk_decisor in (2,77,80,84,85)
			GROUP BY 
			sk_decisor			,
			idempresa			,
			dtlcto				,
			cod_conta_nv2		,
			grupo,		
			subgrupo
		UNION ALL
	--RECEITAS COMPANHIAS (REBATES) 1.8--
		SELECT
			sk_decisor,
			idempresa,
			dtlcto,
			cod_conta_nv2,
			grupo,
			subgrupo,
			vlr,
			0 as qtd
		from dre.final_despesas fd
		where cod_conta_nv2 is not null
			 AND cod_conta_nv2 in ('1.08')
			 and fd.sk_decisor in (2,77,80,84,85)
		UNION ALL
	--PERDAS 1.9--
		select
			sk_decisor,
			idempresa,
			dtlcto,
			'1.09'::text as cod_conta_nv2,
			grupo,
			subgrupo,
			0 as vlr,
			0 as qtd
		from dre.final_perdas fp
		where cod_conta_nv2 is not null
		and fp.sk_decisor in (2,77,80,84,85)
	--RECEITAS DIVERSAS 1.10--
		union ALL
			select
			sk_decisor,
			idempresa,
			dtlcto,
			cod_conta_nv2,
			grupo,
			subgrupo,
			vlr,
			0 as qtd
		from dre.final_notas_avulcas
		where cod_conta_nv2 in ('1.10')
		and sk_decisor in (2,77,80,84,85)
	--FRETE CUSTO TRR--
		union ALL
			select
			sk_decisor,
			idempresa,
			dtlcto,
			'1.11' cod_conta_nv2,
			grupo,
			subgrupo,
			0 vlr,
			0 qtd
		from dre.final_despesas fd2 
		where cod_conta_nv2 in ('4.11')
		and sk_decisor in (80)
	),
	
	CUSTO AS (
	--CUSTO COMB E MERC 4.0--	
		SELECT
			sk_decisor						,
			idempresa						,
			dtlcto							,
			concat('4.',split_part(cod_conta_nv2,'.',2)) AS 					cod_conta_nv2,
			grupo							,
			subgrupo 						,
			-sum(vlr_custo)		AS vlr		,
			sum(qtde)			as qtd
		from dre.final_faturamento cff
		where cod_conta_nv2 is not null
			and cff.sk_decisor in (2,77,80,84,85)
			GROUP BY 
			sk_decisor						,
			idempresa						,
			dtlcto							,
			cod_conta_nv2					,
			grupo							,		
			subgrupo 
		UNION ALL 
	--CUSTO COMPANHIAS (REBATES) 1.8--
		select
			sk_decisor,
			idempresa,
			dtlcto,
			concat('4.',split_part(cod_conta_nv2,'.',2)) AS 				cod_conta_nv2	,
			grupo,
			subgrupo,
			0 vlr,
			0 qtd
		from dre.final_despesas cfd
		where cod_conta_nv2 in ('1.08')
			and cfd.sk_decisor in (2,77,80,84,85)
		union all 
	--CUSTO PERDAS 1.9--
		select
			sk_decisor,
			idempresa,
			dtlcto,
			'4.09'::text as cod_conta_nv2 ,
			grupo,
			subgrupo,
			vlr,
			0 as qtd
		from dre.final_perdas cfp
		where 
		 cfp.sk_decisor in (2,77,80,84,85)
	--CUSTO RECEITAS DIVERSAS 1.10--
		union ALL
		select
			sk_decisor,
			idempresa,
			dtlcto,
			'4.10' cod_conta_nv2,
			grupo,
			subgrupo,
			0 vlr,
			0 qtd
		from dre.final_notas_avulcas
		where cod_conta_nv2 in ('1.10')
		and sk_decisor in (2,77,80,84,85)
	--CUSTO FRETE TRR--
		union ALL
			select
			sk_decisor,
			idempresa,
			dtlcto,
			'4.11' cod_conta_nv2,
			grupo,
			subgrupo,
			vlr,
			0 qtd
		from dre.final_despesas fd2 
		where cod_conta_nv2 in ('4.11')
		and sk_decisor in (80)
	 ),
	MARGEM AS (
		SELECT 
			ft.sk_decisor						,
			ft.idempresa						,
			ft.dtlcto							,
			concat('5.',split_part(ft.cod_conta_nv2,'.',2)) 	AS cod_conta_nv2,
			ft.grupo							,
			ft.subgrupo 						,
			sum(ft.vlr) + sum(ct.vlr)	AS vlr	,
			0 as qtd
		FROM FATURAMENTO ft
		left join CUSTO ct on ct.sk_decisor = ft.sk_decisor
			and ct.idempresa = ft.idempresa
			and ct.dtlcto = ft.dtlcto
			and ct.grupo = ft.grupo
			and ct.subgrupo = ft.subgrupo	
		where ft.cod_conta_nv2 is not null
		group by 
			ft.sk_decisor,
			ft.idempresa,
			ft.dtlcto,
			concat('5.',split_part(ft.cod_conta_nv2,'.',2)),
			ft.grupo,
			ft.subgrupo
	)
	
	------------------------
	-- INÍCIO FATURAMENTO -
	------------------------
	
	--FATURAMENTO--
		SELECT 
			ft.sk_decisor						,
			ft.idempresa						,
			ft.dtlcto							,
			ft.cod_conta_nv2,
			ft.grupo							,
			ft.subgrupo 						,
			sum(ft.vlr)		AS vlr			,
			sum(ft.qtd)		as qtd,
			'faturamento' origem
		FROM FATURAMENTO ft
		where ft.cod_conta_nv2 is not null
		GROUP BY 
			sk_decisor						,
			idempresa						,
			dtlcto							,
			cod_conta_nv2,
			grupo							,
			subgrupo 
		--CUSTO--
		union ALL
			SELECT 
			ct.sk_decisor						,
			ct.idempresa						,
			ct.dtlcto							,
			ct.cod_conta_nv2,
			ct.grupo							,
			ct.subgrupo 						,
			sum(ct.vlr)		AS vlr			,
			sum(ct.qtd)		as qtd,
			'custo' origem
		FROM CUSTO CT
		where ct.cod_conta_nv2 is not null
		GROUP BY 
			sk_decisor						,
			idempresa						,
			dtlcto							,
			cod_conta_nv2,
			grupo							,
			subgrupo
			--MARGEM--
		union ALL
			SELECT 
			mg.sk_decisor						,
			mg.idempresa						,
			mg.dtlcto							,
			mg.cod_conta_nv2,
			mg.grupo							,
			mg.subgrupo 						,
			sum(mg.vlr)		AS vlr			,
			0 				as qtd,
			'margem' origem
		FROM MARGEM mg
		where mg.cod_conta_nv2 is not null
		GROUP BY 
			sk_decisor						,
			idempresa						,
			dtlcto							,
			cod_conta_nv2,
			grupo							,
			subgrupo 		
			
	-----------------------
	-- FINAL FATURAMENTO --
	-----------------------			
		
	-----------------------
	--INÍCIO DESPESAS--
	-----------------------		
	
	union ALL
		SELECT
			sk_decisor,
			idempresa,
			dtlcto,
			cod_conta_nv2,
			grupo,
			subgrupo,
			case
				when cod_conta_nv2 = '13.01' and vlr < 0 then vlr*-1
				else vlr
			end vlr,
			0 as qtd,
			'final_despesas' origem
		from dre.final_despesas
			WHERE cod_conta_nv2 not in ('1.01','1.02','1.03','1.04','1.05','1.08','1.10','4.11')
			and cod_conta_nv2 is not null
			and sk_decisor in (2,77,80,84,85)
			AND ((idempresa IN (1019) AND dtlcto >= '20251201')
			   OR 
			    (idempresa NOT IN (1019)))
		-- CASHBACK --
		union all 
			select
			sk_decisor,
			idempresa,
			dtlcto,
			cod_conta_nv2,
			grupo,
			subgrupo,
			vlr,
			0 as qtd,
			'cashback' origem
		from dre.final_cashback
		where cod_conta_nv2 is not null
		and sk_decisor in (2,77,80,84,85)
		-- TAXAS DE CARTÕES --
		union all 
			select
			sk_decisor,
			idempresa,
			dtlcto,
			cod_conta_nv2,
			grupo,
			subgrupo,
			vlr,
			0 as qtd,
			'txs_cartoes' origem
		from dre.final_taxas_cartoes
		where cod_conta_nv2 is not null
		and sk_decisor in (2,77,80,84,85)
	--DESPESAS DIVERSAS 1.10--
		union ALL
			select
			sk_decisor,
			idempresa,
			dtlcto,
			'21.03' cod_conta_nv2,
			grupo,
			subgrupo,
			vlr,
			0 as qtd,
			'notas_avulcas' origem
		from dre.final_notas_avulcas
		where cod_conta_nv2 not in ('1.10')
		and sk_decisor in (2,77,80,84,85)
	-- JUROS RECEBIDOS --
		union all 
			select
			sk_decisor,
			idempresa,
			dtlcto,
			cod_conta_nv2,
			grupo,
			subgrupo,
			vlr,
			0 as qtd,
			'juros_rcbidos' origem
		from dre.final_juros_recebidos
		where cod_conta_nv2 is not null
		and sk_decisor in (2,77,80,84,85)
	)
	select * from DRE_2026
	where dtlcto >= '20260101'
	and sk_decisor in (2,77,80,84,85)
union ALL
select * from dre.resultado_consolidado_2025 rc 