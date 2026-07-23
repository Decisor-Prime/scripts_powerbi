WITH BASE_FATURAMENTO AS (
       SELECT 
        case 
        	WHEN SK_DECISOR = 80 then 80
        	when SK_DECISOR = 84 then 84
        	when SK_DECISOR = 85 then 85
        	else null end as SK_DECISOR,
        CASE 
            WHEN SK_DECISOR = 80 AND SUBGRUPO LIKE '%DIESEL%' THEN '1.01' 
            when SK_DECISOR = 84 THEN '1.05'
			when SK_DECISOR = 85 THEN '1.04'
			else '1.04'
        END as COD_CONTA_NV2,
        CASE 
            WHEN SK_DECISOR = 80 and SUBGRUPO LIKE '%DIESEL%' THEN 'DIESEL' 
            ELSE GRUPO 
        END as GRUPO_AJUSTADO,
        CASE 
            WHEN SUBGRUPO LIKE '%10%'  THEN 'DIESEL S10'
            WHEN SUBGRUPO LIKE '%500%'  THEN 'DIESEL S500'
            ELSE SUBGRUPO 
        END as SUBGRUPO_AJUSTADO
    FROM DRE.FINAL_FATURAMENTO ff
    WHERE ff.SK_DECISOR IN (80,84,85) and not SUBGRUPO isnull
    union all
      SELECT 
        case 
        	WHEN SK_DECISOR = 80 then 80
        	when SK_DECISOR = 84 then 84
        	when SK_DECISOR = 85 then 85
        	else null end as SK_DECISOR,
        CASE 
            WHEN SK_DECISOR = 80 AND SUBGRUPO LIKE '%DIESEL%' THEN '4.01' 
            when SK_DECISOR = 84 THEN '4.05'
			when SK_DECISOR = 85 THEN '4.04'
			else '4.04'
        END as COD_CONTA_NV2,
        CASE 
            WHEN SK_DECISOR = 80 and SUBGRUPO LIKE '%DIESEL%' THEN 'DIESEL' 
            ELSE GRUPO 
        END as GRUPO_AJUSTADO,
        CASE 
            WHEN SUBGRUPO LIKE '%10%'  THEN 'DIESEL S10'
            WHEN SUBGRUPO LIKE '%500%'  THEN 'DIESEL S500'
            ELSE SUBGRUPO 
        END as SUBGRUPO_AJUSTADO
    FROM DRE.FINAL_FATURAMENTO ff
    WHERE ff.SK_DECISOR IN (80,84,85) and not SUBGRUPO isnull
      union all
      SELECT 
        case 
        	WHEN SK_DECISOR = 80 then 80
        	when SK_DECISOR = 84 then 84
        	when SK_DECISOR = 85 then 85
        	else null end as SK_DECISOR,
        CASE 
            WHEN SK_DECISOR = 80 AND SUBGRUPO LIKE '%DIESEL%' THEN '5.01' 
            when SK_DECISOR = 84 THEN '5.05'
			when SK_DECISOR = 85 THEN '5.04'
			else '5.04'
        END as COD_CONTA_NV2,
        CASE 
            WHEN SK_DECISOR = 80 and SUBGRUPO LIKE '%DIESEL%' THEN 'DIESEL' 
            ELSE GRUPO 
        END as GRUPO_AJUSTADO,
        CASE 
            WHEN SUBGRUPO LIKE '%10%'  THEN 'DIESEL S10'
            WHEN SUBGRUPO LIKE '%500%'  THEN 'DIESEL S500'
            ELSE SUBGRUPO 
        END as SUBGRUPO_AJUSTADO
    FROM DRE.FINAL_FATURAMENTO ff
    WHERE ff.SK_DECISOR IN (80,84,85) and not SUBGRUPO ISNULL
)
SELECT 
    DISTINCT
    SK_DECISOR,
    COD_CONTA_NV2,
    GRUPO_AJUSTADO as GRUPO,
    SUBGRUPO_AJUSTADO as SUBGRUPO,
    SK_DECISOR || '-' || COD_CONTA_NV2 || '-' || SUBGRUPO_AJUSTADO as REL_DIM_CONTAS
FROM BASE_FATURAMENTO
union ALL
select 
distinct
codcliente sk_decisor,
cod_conta_nv2,
grupo,
subgrupo,
codcliente|| '-' || cod_conta_nv2 || '-' || subgrupo rel_dim_contas
from dre.dim_produto_dre
where cod_conta_nv2 is not null
and codcliente in (2,77)
order by cod_conta_nv2 asc