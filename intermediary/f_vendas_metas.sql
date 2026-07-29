WITH metas AS (
    SELECT
        codcliente                                          AS sk_decisor
      , (codcliente || '-' || idempresa)                   AS "idEmpresa"
      , (codcliente || '-' || nullif(idsubgrupo, 'NaN')::int) AS "idSubgrupo"
      , concat('01/', data_meta)::date                     AS "DataMeta"
      , metapor                                            AS "MetaPor"
      , quantidadevalor                                    AS "QuantidadeValor"
      , tipometa                                           AS "TipoMeta"
      , sigla                                              AS "Sigla"
      , mix                                               AS "Mix"
      , metamarkup                                         AS "MetaMarkup"
    FROM stg.stg_fmetas
    where codcliente in (select sk_decisor from vw_clientes_decisor)

    UNION ALL               

    SELECT
        codcliente
      , (codcliente || '-' || idempresa)
      , (codcliente || '-' || nullif(idsubgrupo, 'NaN')::int)
      , concat('01/', data_meta)::date
      , metapor
      , quantidadevalor
      , tipometa
      , sigla
      , mix
      , metamarkup
    FROM stg.stg_fmetas_2024
)
SELECT
    m.sk_decisor
  , m."idEmpresa"
  , m."idSubgrupo"
  , m."DataMeta"
  , m."MetaPor"
  , m."QuantidadeValor"
  , m."TipoMeta"
  , COALESCE(NULLIF(m."Sigla", ''), dp.apgrupo) AS "Sigla"
  , m."Mix"
  , m."MetaMarkup"
FROM metas m
LEFT JOIN (
    SELECT DISTINCT ON (idsubgrupo)
        idsubgrupo
      , apgrupo
    FROM dw.dim_produtos
) dp ON m."idSubgrupo" = dp.idsubgrupo
