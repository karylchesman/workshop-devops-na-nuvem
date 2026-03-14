# Terraform

## Principais pontos

Ferramenta de IaC
Ajuda a documentar a infraestrutura e facilita a integração de novos membros na equipe, versionamento da infra
Simplifica a criação de infra para projetos
Criação de vários ambientes de forma eficiente
Vários providers (AWS, GCP e etc.)
Tem própria arquivo de config e sintaxe própria parecida com yaml

## Convenções

https://www.terraform-best-practices.com/

- Usar underscore (\_) em vez de dashes (-)
- Lower casing
- Não repetir o tipo de recurso no nome dele
- Recomenda usar `this` caso você não tenha um nome muito descritivo ou só tenha uma unidade do tipo de recurso

## Autenticação

Pode ser feito com usuário IAM ou Role, há várias maneiras de se fazer, consultar docs para isso.
É configurado no bloco do provider.

## Alguns comandos iniciais

`terraform init` na raiz onde o terraform vai ser configurado;
`terraform validate` para checar arquivos;
`terraform fmt` para formatar;
`terraform apply` para aplicar a estrutura atual, ele irá apresentar um resumo das mudanças e pedir confirmação.

## TF State

Mantém o **estado atual** da estrutura para que todo o trabalho da ferramenta possa ser realizado.
Arquivo extramente crítico e deve ser mantido em segurança.

**NÃO DEVE SER MANTIDO COMMITADO NO GITHUB**

Manter no github pode causar problemas de concorrência e duplicidade do estado; por exemplo, se dois devs fizerem pull e tentarem aplicar ao mesmo tempo pode resultar em corrupção de infra, do state ou dos dois ao mesmo tempo.

### Remote Backend

Terraform dá o nome de **backend** ao TF State.

Armazenamento centralizado do arquivo de estado do Terraform em local remoto (como S3), permitindo colaboração em equipe.
Usamos essa técnica para evitar problemas com o TF State.

### State Locking

Mecanismo que impede execuções simultâneas do Terraform, evitando conflitos e corrupção do estado (geralmente usando DynamoDB).
Usado na aplicação do **Remote Backend**.

### Remote backend com S3

Seguindo a documentação: https://developer.hashicorp.com/terraform/language/backend/s3

**Atenção** para o `bucket versioning`!

`terraform init --migrate-state` para migrar para o backend depois de configurado os recursos para isso.
`terraform init --reconfigure` para aplicar o uso do próprio s3 como state locker
