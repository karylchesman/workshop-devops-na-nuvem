# Kubernetes

Orquestrador de containers

## Deployment

Define a **'especificação' de uma implantação** e o k8s garante que a estrutura especificada vai ser criada no cluster.
**Labels** são utilizadas para definir quais **Pods** serão gerenciados por determinado **Deployment**.

### Replica Set

Um layer entre o **Deployment** e o **Pod** e criado automaticamente.
Gerencia a quantidade de **Pods** especificada, **em uma determinada versão**.

Num exemplo com nginx:

- Se mudar de nginx:1.14 -> 1.15
- O **ReplicaSet** atual é escalado para 0/0
- E um novo **ReplicaSet** é criado é criado

Isso possibilita o **Fast Rollback** usando por exemplo: `kubectl rollout undo deploy/xyz --revision x`!
Se um problema acontecer você não perde tempo com o tempo de um novo build para voltar a versão anterior.
Isso também possibilita outras estratégias de deploy: BlueGreen, Canário e etc.

Por padrão é mantido até 6 versões (ou réplicas).

## Pod

**Menor unidade** do cluster k8s que contém um ou mais containers.
Os containers são gerenciados pelo **container runtime**, cuja interação se dá pelo CRI (container runtime interface).

Os **containers** NÃO SÃO gerenciados pelo k8s, isso é trabalho do **container runtime**.

## Service

Os **Service** abstraem a comunicação com os **Pods** expondo e distribuindo tráfego, seja:

- expondo os serviços para tráfego externo, ou;
- possibilitando comunicação entre Pods.

É criado um artefato chamado **Endpoint**, de forma automática.

### 3 tipos

ClusterIP - Interno
Node Port - <IP_INSTANCE:NODE_PORT> - expõe em todos nos **Nodes**
LoadBalancer - Normalmente integrado com o CloudProvider

## Ingress

Atua internamente dentro do Cluster fazendo roteamento para os serviços (Nginx, Traefik, ALB).

## Conectando ao Cluster AWS

1. Pegar ARN da entidade IAM que vai ter acesso, por exemplo, as sua local, usando `aws sts get-caller-identity`.
2. Adiciona o acesso no painel em: Cluster -> Aba Acesso -> Entradas de acesso do IAM -> Criar.
3. Executa:

```sh
aws eks update-kubeconfig --name <CLUSTER_NAME>
```

4. Em seguida você pode rodar `kubectl get nodes`.

## Criando e Aplicando Deployments

Para aplicar no cluster os deployments criados: `kubectl apply -f frontend/deploy.yml -f frontend/service.yml`.
Com kustomization: `kubectl apply -k .` na pasta onde está o arquivo kustomization.yml.
Para acessar os pods localmente via port forwarding: `kubectl port-forward frontend-5f796d598c-bb9xw 8080:80`.

Aqui tem uma lista completa de comandos úteis para usar no cluster:
https://kubernetes.io/pt-br/docs/reference/kubectl/cheatsheet/
