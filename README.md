# Gerenciamento de Usuários e Familiares

Este projeto foi desenvolvido como parte de um processo seletivo para aprender e aplicar os fundamentos de desenvolvimento em Flutter. Ele implementa um sistema simples para gerenciar usuários e seus dependentes, permitindo o cadastro, busca e gerenciamento de familiares diretamente no sistema.

## 🎯 Objetivo do Projeto

O objetivo principal é criar uma aplicação que permita:
- Cadastrar novos usuários no sistema.
- Gerenciar familiares de um usuário logado.
- Listar todos os usuários registrados no sistema.
- Prover um perfil detalhado do usuário logado.

## 📱 Funcionalidades

### **1. Login**
- Permite que o usuário entre no sistema utilizando e-mail e senha.
- Possibilidade de login anônimo para explorar as funcionalidades do sistema sem cadastro.

### **2. Registro de Usuários**
- Tela para criação de novos usuários, solicitando nome, e-mail e senha.
- Validações para evitar e-mails duplicados e senhas fracas.

### **3. Lista de Usuários**
- Exibe todos os usuários cadastrados no sistema.
- Funcionalidade de busca por nome.
- Indica se um usuário é um dependente (familiar) do usuário logado.

### **4. Gerenciamento de Familiares**
- Permite adicionar familiares ao perfil do usuário logado.
- Adiciona familiares como novos usuários no sistema.
- Remove familiares do perfil e do sistema, caso necessário.

### **5. Perfil do Usuário**
- Exibe informações do usuário logado, como nome e e-mail.
- Permite personalização do ícone de perfil.
- Função de logout.

## 🛠️ Dependências Utilizadas

1. **Provider**:
   - Gerenciamento de estado reativo para ViewModels.

2. **Shared Preferences**:
   - Persistência local dos dados do sistema para manter usuários salvos entre sessões.

3. **Equatable**:
   - Comparação simplificada de objetos, garantindo maior consistência no gerenciamento de usuários.

## ⚙️ Arquitetura

O projeto segue uma abordagem baseada em **MVVM (Model-View-ViewModel)**:

- **Model**:
  Representa os dados do sistema, como o modelo `User`.

- **View**:
  As telas da aplicação, construídas utilizando widgets do Flutter.

- **ViewModel**:
  Camada intermediária entre o modelo e a view, responsável por:
  - Gerenciar o estado da aplicação.
  - Implementar a lógica de negócio.
  - Comunicar-se com o repositório.

### **Coesão entre as camadas**
- **Repository Pattern**:
  Abstração da fonte de dados, permitindo que o sistema funcione independentemente de como ou onde os dados estão armazenados (neste caso, usando `Shared Preferences`).

## 🌟 Estrutura do Projeto
    lib/
    ├── main.dart                      # Arquivo principal do projeto
    ├── app.dart                       # Configurações iniciais do app
    ├── models/                        # Modelos de dados
    │   ├── user.dart                  # Modelo de dados para o usuário
    │   ├── mock_user_data.dart        # Dados mockados para teste inicial
    ├── repositories/                  # Camada de repositórios
    │   ├── user_repository.dart       # Interface do repositório
    │   ├── local_user_repository.dart # Implementação do repositório local
    ├── viewmodels/                    # Gerenciamento de estado e lógica
    │   ├── auth_login_viewmodel.dart  # Gerenciamento de login
    │   ├── user_list_viewmodel.dart   # Gerenciamento da lista de usuários
    │   ├── family_list_viewmodel.dart # Gerenciamento de familiares
    ├── views/                         # Telas do aplicativo
    │   ├── login/
    │   │   ├── login_view.dart        # Tela de login
    │   ├── register/
    │   │   ├── register_view.dart     # Tela de registro de usuários
    │   ├── user/
    │   │   ├── user_list_view.dart    # Lista de usuários
    │   │   ├── user_profile_view.dart # Tela de perfil do usuário
    │   ├── family/
    │       ├── family_list_view.dart  # Tela de gerenciamento de familiares


## Explicação dos Diretórios

- **`lib/`**: Diretório principal do projeto.
- **`main.dart`**: Ponto de entrada da aplicação.
- **`app.dart`**: Configurações de inicialização, como o tema global.
- **`models/`**: Contém as classes que representam os dados do sistema.
- **`repositories/`**: Implementação e abstração de acesso a dados.
- **`viewmodels/`**: Lógica de negócio e gerenciamento de estado.
- **`views/`**: Interface do usuário (UI), dividida por contexto.

### Detalhamento

#### **`models/`**
- **`user.dart`**: Representa o modelo de usuário com atributos como UID, nome, email, etc.
- **`mock_user_data.dart`**: Fornece dados mockados para testes iniciais.

#### **`repositories/`**
- **`user_repository.dart`**: Interface que define métodos para acesso a dados dos usuários.
- **`local_user_repository.dart`**: Implementação que utiliza `SharedPreferences` para persistência local.

#### **`viewmodels/`**
- **`auth_login_viewmodel.dart`**: Lida com autenticação e estado do login.
- **`user_list_viewmodel.dart`**: Gerencia a lista de usuários e a busca por nome.
- **`family_list_viewmodel.dart`**: Gerencia os dependentes associados a um usuário logado.

#### **`views/`**
- **`login/`**
- **`login_view.dart`**: Tela de login com autenticação e suporte a login anônimo.
- **`register/`**
- **`register_view.dart`**: Tela para registrar novos usuários.
- **`user/`**
- **`user_list_view.dart`**: Lista todos os usuários cadastrados no sistema, com suporte a busca.
- **`user_profile_view.dart`**: Exibe detalhes do usuário logado e oferece a opção de logout.
- **`family/`**
- **`family_list_view.dart`**: Tela para adicionar ou remover dependentes do usuário logado.

## Organização do Código

Essa estrutura modular garante que cada componente tenha responsabilidades bem definidas, facilitando a manutenção e escalabilidade do projeto.


## 🚀 Como Executar

### Pré-requisitos:
1. **Flutter SDK** instalado.
2. Dependências instaladas via `flutter pub get`.

### Passos:
1. Clone este repositório.
2. Execute o comando abaixo para instalar as dependências:
```bash
flutter pub get

3.	Inicie o aplicativo com:
```bash
flutter run
