SELECT 
	2 as codcliente,
	MAX(CASE WHEN ff.label = 'Filial' THEN fa.value END) AS idempresa,
    MAX(CASE WHEN ff.label = 'Conta Financeira' THEN fa.value END) AS idconta,
    MAX(CASE WHEN ff.label = 'Justificativa' THEN fa.value END) AS justificativa,
    u.name usuario,
    MAX(CASE WHEN ff.label = 'Mês Competência' THEN fa.value END) AS data
FROM form_submission fs
JOIN public.user u ON fs.user_id = u.id
JOIN form_answer fa ON fa.submission_id = fs.id
JOIN form_field ff ON ff.id  = fa.field_id
WHERE 
 fs.form_id = 4
GROUP BY fs.id, u.id, fs.timestamp
ORDER BY fs.timestamp desc