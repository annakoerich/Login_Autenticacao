# Login_google

## Integrantes do Grupo
- Anna Cristina Koerich
- Eduardo Alberto Dal´Piaz

## Funcionalidades por Tela

### Tela de Login
- Campo de Texto para Login: Permite ao usuário inserir seu nome de usuário.
- Campo de Texto para Senha: Permite ao usuário inserir sua senha.
- Botão "Entrar": Navega para a tela principal (`MyHomePage`) com o nome de usuário digitado.
- Botão "Entrar com Google": Permite ao usuário fazer login usando sua conta do Google.

### Tela Principal (`MyHomePage`)
- Exibição do Nome do Usuário: Mostra o nome do usuário logado.
- Exibição do Email do Usuário: Mostra o email do usuário logado (se disponível).
- Exibição da Foto do Usuário: Mostra a foto do usuário logado (se disponível).
- Botão "Sair": Permite ao usuário deslogar e voltar para a tela de login.

## Tipos de Erros do Provedor Escolhido (Google Sign-In e Firebase Auth)
- Erro de Conexão: Problemas ao conectar com os serviços do Google.
- Erro de Autenticação: Credenciais inválidas ou problemas ao autenticar com o Firebase.
- Erro de Permissão: Falta de permissões necessárias para acessar os serviços do Google.
- Erro de Configuração: Problemas na configuração do cliente OAuth2 no Google Cloud Console.

## Dependências Utilizadas e suas Versões
- flutter: SDK do Flutter
- cupertino_icons: ^1.0.8
- google_sign_in: ^6.2.2
- firebase_auth: ^5.3.4
- firebase_core: ^3.8.1
- flutter_svg: ^2.0.16

## Instruções para Configuração/Importação do Projeto

### Pré-requisitos
- Flutter: Versão mínima 3.5.4
- Dart: Versão mínima 2.18.0
- SDK do Android: Certifique-se de que o SDK do Android está instalado e configurado.

### Passos para Configuração
1. Clone o Repositório:
   ```sh
   git clone https://github.com/annakoerich/Login_Autenticacao.git
   cd Login_Autenticacao
   ```

2. Instale as Dependências:
   ```sh
   flutter pub get
   ```

3. Configure o Firebase:
   - Siga as instruções no Firebase Console para adicionar seu aplicativo Flutter.
   - Baixe o arquivo `google-services.json` e coloque-o na pasta `android/app`.

4. Atualize o `pubspec.yaml`:
   - Certifique-se de que todas as dependências estão listadas corretamente no arquivo `pubspec.yaml`.

5. Execute o Projeto:
   ```sh
   flutter run
   ```

### Configuração do Google Sign-In
- Google Cloud Console:
  - Crie um novo projeto no Google Cloud Console.
  - Ative a API do Google Sign-In.
  - Configure a tela de consentimento OAuth.
  - Crie credenciais OAuth 2.0 e obtenha o `clientId`.

### Problemas Comuns e Soluções
- Erro de Conexão: Verifique sua conexão com a internet e as configurações de rede.
- Erro de Autenticação: Certifique-se de que as credenciais estão corretas e que o Firebase está configurado corretamente.
- Erro de Permissão: Verifique se todas as permissões necessárias estão concedidas no dispositivo.
