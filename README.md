# My Storage App - QSD 21
[<img src="/public/qsd2021.png"/>](/images/qsd2021.png)

## Sobre o projeto

Sistema de Gestão de Estoques em desenvolvimento com Ruby on Rails para o programa Quero Ser Dev Locaweb 2021 com parceria da Campus Code

## Preparação de ambiente

```bash
bin/setup
```
## API

### Galpões

#### Listar todos os galpões

**Requisição:**

```
GET /api/v1/warehouses
```

**Resposta:**

```
Status: 200 (OK)

[
  {
    "id":1,
    "name":"Juiz de Fora",
    "code":"JDF",
    "description":"Ótimo Galpão",
    "city":"Juiz de Fora",
    "state":"MG",
    "postal_code":"36000-000",
    "total_area":5000,
    "useful_area":3000
  }
]
```

#### Criar um galpão

**Requisição:**

```
POST /api/v1/warehouses
```

**Parâmetros:**

```
{
  "id":1,
  "name":"Juiz de Fora",
  "code":"JDF",
  "description":"Ótimo Galpão",
  "city":"Juiz de Fora",
  "state":"MG",
  "postal_code":"36000-000",
  "total_area":5000,
  "useful_area":3000
}
```

**Resposta:**

```
Status: 201 (Criado)

[
  {
    "id":1,
    "name":"Juiz de Fora",
    "code":"JDF",
    "description":"Ótimo Galpão",
    "city":"Juiz de Fora",
    "state":"MG",
    "postal_code":"36000-000",
    "total_area":5000,
    "useful_area":3000
  }
]