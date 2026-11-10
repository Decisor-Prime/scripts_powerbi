select 
codcliente
,dw_idconta idconta
,descricao
,conta
,nivel
,codcliente||'-'||idcentrocustopai idcentrocustopai
,conta_1 "Conta Nv1"
,conta_2 "Conta Nv2"
,conta_3 "Conta Nv3"
,conta_4 "Conta Nv4"
,conta_5 "Conta Nv5"
,descricao_1 "apConta Nv1"
,descricao_2 "apConta Nv2"
,descricao_3 "apConta Nv3"
,descricao_4 "apConta Nv4"
,descricao_5 "apConta Nv5"
,case
	when not conta_5 isnull then conta_5
	when not conta_4 isnull then conta_4
	when not conta_3 isnull then conta_3
	when not conta_2 isnull then conta_2
	else conta_1
end "idConta Lanc"
,conta||' - '||descricao "apConta Lanc" 
from dw.dim_plancontas dp 
where dp.codcliente in (2,77)
and dre = true
and dp.conta like '90%'