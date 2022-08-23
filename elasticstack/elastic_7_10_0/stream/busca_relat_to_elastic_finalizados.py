# -*- coding: utf-8 -*-
"""
Created on Mon Apr  5 07:01:34 2021

@author: GREYJOY
"""
import pandas as pd
import requests
import json
import time
import datetime
from es_pandas import es_pandas

# Dados do cluster
es_host = '192.168.2.100:9200'
index = 'desk_finalizados'

# Cria instancia es_pandas 
ep = es_pandas(es_host)

# AUTENTICAÇÃO API
url = "https://api.desk.ms/Login/autenticar"
pubkey = '\"ef89a6460dbd71f2e37a999514d2543b99509d4f\"'
payload=" {\r\n  \"PublicKey\" :" + pubkey + "\r\n}"
headers = {
  'Authorization': '66e22b87364fa2946f2ce04dce1b8b59b669ab7f',
  'Content-Type': 'application/json'
}
token = requests.request("POST", url, headers=headers, data=payload)
resp_token = json.loads(token.text)

### BUSCA DADOS RELATORIOS FINALIZADOS
url = "https://api.desk.ms/Relatorios/imprimir"
paginador = '\"' +  ' ' + '\"'
relatorio ="885" # Deskmanager Finalizados ultimos 30 dias
payload="{\r\n  \"Chave\":\"885\", \r\n  \"APartirDe\":\"\", \r\n  \"Total\":\"\"\r\n}"
#payload="{\r\n  \"Chave\" :"  + relatorio + ", \r\n  \"APartirDe\" : \" " + paginador + ", \r\n  \"Total\": \"\" \r\n}"
headers = {
  'Authorization': resp_token,
  'Content-Type': 'application/json'
}
resp = requests.request("POST", url, headers=headers, data=payload)
resp_data = json.loads(resp.text)
root = resp_data['root']
df1 = pd.DataFrame(root)
df1['DataFinalizacao'] = pd.to_datetime(df1['DataFinalizacao'], format='%d%m%Y', errors='ignore')
df1['Quantidade'] = 1

# init template if you want
doc_type = 'desk_finalizados'
ep.init_es_tmpl(df1, doc_type)

# limpa os docs do indice
headers = {'Content-type': 'application/json',}
data = '{"query": {"match_all" : {}}}'
response = requests.post('http://192.168.2.100:9200/desk_finalizados/_delete_by_query', headers=headers, data=data)

# limpa indices elasticsearch
ep.to_es(df1.iloc[500000:], index, doc_type=doc_type, _op_type='delete', thread_count=2, chunk_size=10000)
# carrega dados elasticsearch
ep.to_es(df1, index, doc_type=doc_type, use_index=True)

