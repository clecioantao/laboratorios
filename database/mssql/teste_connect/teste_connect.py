import os
import pandas as pd
import requests
import json
import sqlalchemy
from datetime import datetime, timedelta

conn_string = 'mssql+pyodbc://sa:Proteu690201@192.168.2.100/teste?driver=ODBC+Driver+18+for+SQL+Server' 

engineorigem = sqlalchemy.create_engine(
    conn_string,
    connect_args = {
        "TrustServerCertificate": "yes"
    }, echo=False)

if(engineorigem):
    print("sucesso")


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

# print('Token: ', resp_token)
# print('Relatorio: ', params['rel'])
# print('Tabela: ', params['tab'])

# ENTRA NA API PARA BUSCAR NUMERO DE COLUNAS
url = "https://api.desk.ms/Relatorios/imprimir"
paginador = '\"' +  '0' + '\"'

relatorio = "868"
#relatorio = "868" # Relatorio 868 DeskmanagerAF
#relatorio = "878" # Relatorio 878 DeskmanagerInteracoesAF
tabela = "DeskManagerAF"
#tabela = 'DeskManagerAF' ## nome da tabela que sera criada ou sobreposta
#tabela = 'DeskManagerInteracoesAF' ## nome da tabela que sera criada ou sobreposta

payload="{\r\n  \"Chave\" :"  + relatorio +  ", \r\n  \"APartirDe\" :" + paginador + ", \r\n  \"Total\": \"\" \r\n}"
headers = {
'Authorization': resp_token,
'Content-Type': 'application/json'
}
resp = requests.request("POST", url, headers=headers, data=payload)
resp_data = json.loads(resp.text)
root = resp_data['root']
df = pd.DataFrame(root)
colunas = len(df.columns)
############################

relatorios_pag = 0
paginas = 5000 
contador = 1

while contador >= 1:
    
    print('Paginas: ', paginas)
    print('Contador: ', contador)
    print('Linhas: ',relatorios_pag)
    
    #################################
    # LISTA DE relatorios - paginação de 5000 em 5000 
    url = "https://api.desk.ms/Relatorios/imprimir"
    paginador = '\"' +  str(relatorios_pag) + '\"'
    payload="{\r\n  \"Chave\" :"  + relatorio +  ", \r\n  \"APartirDe\" :" + paginador + ", \r\n  \"Total\": \"\" \r\n}"
    headers = {
    'Authorization': resp_token,
    'Content-Type': 'application/json'
    }
    resp = requests.request("POST", url, headers=headers, data=payload)
    resp_data = json.loads(resp.text)
    root = resp_data['root']
    df = pd.DataFrame(root)

    # EXPORTANDO DADASET PARA TABELA BANCO SQL SERVER
    # CALCULA O CHUNKSIZE MÁXIMO E VERIFICA FINAL LINHAS
    
    print(colunas, len(df.columns))
    #print(df.count())

    if len(df.columns) > 6:
        cs = 2097 // len(df.columns)  # duas barras faz a divisão e tras numero inteiro
        if cs > 1000:
            cs = 1000
        else:
            cs = cs
    else:
        print('quebrou: ', 'len(df.columns) ', len(df.columns) )
    #return  

    # INSERE DADOS TABELA SQL SEVER
    if relatorios_pag == 0:
        df.to_sql(name=tabela, con=engineorigem, if_exists='replace', chunksize=cs)
    else:
        df.to_sql(name=tabela, con=engineorigem, if_exists='append', chunksize=cs)
            
    relatorios_pag = relatorios_pag + 5000
    contador =  contador + 1
