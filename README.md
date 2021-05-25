# Teste Ampli

1. Em um computador com o terrafom e aws cli instalados, configure suas credencias da AWS com os comandos abaixo:

`export AWS_ACCESS_KEY_ID="..."`

`export AWS_SECRET_ACCESS_KEY="..."`

`export AWS_DEFAULT_REGION=us-east-2`

2. Execute o comando `terraform init`

3. Execute o comando `terraform apply -auto-approve`

4. Aguarde alguns minutos para que a máquina esteja pronta. 

5. Entre no serviço EC2, copie o IP Público, em um navegador faça o acesso http:\\\ippublico para acessar a página do nginx.




