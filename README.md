
# Consulta API e SQLite - Flutter

Este projeto Flutter permite consultar uma API externa e salvar os dados localmente em um banco de dados SQLite. Ele possui duas telas:

1. **Tela de Consulta**: Permite buscar posts da API [JSONPlaceholder](https://jsonplaceholder.typicode.com/posts) e salvá-los no banco de dados.
2. **Tela de Posts Salvos**: Exibe os posts salvos no banco de dados e permite excluí-los.

## Pré-requisitos

- Flutter instalado;
- Android Studio ou Emulador configurado;
- Visual Studio Code (VS Code) com extensões Flutter e Dart;
- Git instalado;

## Como baixar e rodar o projeto

### 1. Clonar o repositório

Abra o terminal e execute:

```sh
git clone https://github.com/WeslleyEvangelista/case-raj.git
cd case-raj
```

### 2. Instalar dependências

Execute o comando abaixo para instalar as dependências do projeto:

```sh
flutter pub get
```

### 3. Rodar o projeto

Se estiver usando um dispositivo físico, conecte-o ao PC. Se for um emulador, inicie ele antes.
Depois, execute:

```sh
flutter run
```

Caso queira rodar no VS Code, pressione **F5** ou execute `Flutter: Run` no menu de comandos.

## Estrutura do projeto

```
/lib
  ├── main.dart             # Arquivo principal
  ├── screens/              # Telas do aplicativo
  ├── models/               # Modelos de dados
  ├── database/             # Configuração do SQLite
```

## Observações

- Certifique-se de que o emulador ou dispositivo esteja com **depuração USB ativada**.
- O banco de dados SQLite será criado automaticamente ao salvar os posts.
- O projeto pode ser modificado para utilizar outras APIs ou melhorias na interface.


## Autor


<a href="https://github.com/WeslleyEvangelista">
  <img style="border-radius: 50%;" src="https://avatars.githubusercontent.com/u/113722634?v=4" width="100px" height="100px" alt=""/>
  <br />
</a>

Feito com ❤️ por Weslley Evangelista

[![Linkedin Badge](https://img.shields.io/badge/-Weslley-blue?style=flat-square&logo=Linkedin&logoColor=white&link=https://www.linkedin.com/in/weslley-evangelista/)](https://www.linkedin.com/in/weslley-evangelista/) 
[![Gmail Badge](https://img.shields.io/badge/-weslley.evangelista.dev@gmail.com-c14438?style=flat-square&logo=Gmail&logoColor=white&link=mailto:weslley.eangelista.dev@gmail.com)](mailto:weslley.eangelista.dev@gmail.com)

---
