# My Storage App - QSD 21
[<img src="/public/qsd2021.png"/>](/images/qsd2021.png)

## Sobre o projeto

Sistema de Gestão de Estoques em desenvolvimento com Ruby on Rails para o programa Quero Ser Dev Locaweb 2021 com parceria da Campus Code

## Preparação de ambiente

```bash
bin/setup
```
## Rodando o projeto com Docker

### Comando para rodar com Docker puro

```bash
docker build . -t warehouse

docker run -it -p 3000:3000 -v ~/caminho_ate_o_projeto/my-storage-app:/app warehouse:latest bash
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
    "address":"Av Rio Branco",
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
  "name":"Juiz de Fora",
  "code":"JDF",
  "description":"Ótimo Galpão",
  "address":"Av Rio Branco",
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
    "address":"Av Rio Branco",
    "city":"Juiz de Fora",
    "state":"MG",
    "postal_code":"36000-000",
    "total_area":5000,
    "useful_area":3000
  }
]

```

### Fornecedores

#### Listar todos os fornecedores

**Requisição:**

```
GET /api/v1/suppliers
```

**Resposta:**

```
Status: 200 (OK)

[
  {
    "id":1,
    "fantasy_name":"Fábrica Geek",
    "legal_name":"Fábrica Geek LTDA",
    "eni":"32.245.145/0001-77",
    "address":"Av Josias",
    "email":"contato@geek.com",
    "phone":"11 4184-6588"
  }
]
```

#### Criar um fornecedor

**Requisição:**

```
POST /api/v1/suppliers
```

**Parâmetros:**

```
{
  "fantasy_name":"Fábrica Geek",
  "legal_name":"Fábrica Geek LTDA",
  "eni":"32.245.145/0001-77",
  "address":"Av Josias",
  "email":"contato@geek.com",
  "phone":"11 4184-6588"
}
```

**Resposta:**

```
Status: 201 (Criado)

[
  {
    "id":1,
    "fantasy_name":"Fábrica Geek",
    "legal_name":"Fábrica Geek LTDA",
    "eni":"32.245.145/0001-77",
    "address":"Av Josias",
    "email":"contato@geek.com",
    "phone":"11 4184-6588"
  }
]
```

### Modelos de produtos

#### Listar todos os modelos de produtos

**Requisição:**

```
GET /api/v1/product_models
```

**Resposta:**

```
Status: 200 (OK)

[
  {
    "id":1,
    "name":"Caneta Miranha",
    "weight":100,
    "height":10,
    "length":21,
    "width":25,
    "sku":"D522614F4FC2BE534465CB0531227111E6A8F35C","dimensions":"10 x 25 x 21",
    "supplier":
      {
        "id":1,
        "fantasy_name":"Curitibox",
        "legal_name":"Curitibox LTDA",
        "eni":"32.245.145/0001-77",
        "address":"Av Josias",
        "email":"contato@curitibox.com",
        "phone":"11 4184-6588"
      },
    "category":
      {
        "name":"Utensílios"
      }
  }
]
```

#### Criar um modelo de produto

**Requisição:**

```
POST /api/v1/product_models
```

**Parâmetros:**

```
{
  "name":"Pelúcia Dumbo",
  "weight":"200",
  "height":"18",
  "length":"8",
  "width":"10",
  "supplier_id":"1",
  "category_id":"1",
}
```

**Resposta:**

```
Status: 201 (Criado)

[
  {
    "id":1,
    "name":"Caneta Miranha",
    "weight":100,
    "height":10,
    "length":21,
    "width":25,
    "sku":"D522614F4FC2BE534465CB0531227111E6A8F35C","dimensions":"10 x 25 x 21",
    "supplier":
      {
        "id":1,
        "fantasy_name":"Curitibox",
        "legal_name":"Curitibox LTDA",
        "eni":"32.245.145/0001-77",
        "address":"Av Josias",
        "email":"contato@curitibox.com",
        "phone":"11 4184-6588"
      },
    "category":
      {
        "name":"Utensílios"
      }
  }
]