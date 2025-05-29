# Aplicativo TechBarber

## Relatório do Projeto

Este projeto consiste em um aplicativo Flutter que permite o agendamento de horarios de um barbeiro através de uma API REST. O aplicativo foi desenvolvido utilizando o framework Flutter e integra-se com a api desenvolvida em flask.

### Funcionalidades Implementadas:

1. **Tela Inicial**
   - Botão para acessar o formulário de cadastro
   - Botão para visualizar lista de horários agendados

2. **Formulário de Cadastro/Edição**
   - Campos para nome, telefone, data e horário
   - Validação de campos obrigatórios
   - Suporte para criação e edição de usuários
   - Feedback visual de sucesso/erro nas operações

3. **Lista de Horarios**
   - Exibição dos horarios em cards expansíveis
   - Ao expandir, mostra os dados
   - Botões para editar e excluir 
   - Confirmação antes da exclusão
   - Atualização automática após edição/exclusão

### Tecnologias Utilizadas:
- Flutter/Dart
- HTTP para requisições à API
- Material Design para interface
- Python para desenvolvimento da API

## Instruções para Execução

### Pré-requisitos:
- Flutter SDK instalado
- Dart SDK instalado
- Navegador web (Firefox, Chrome, etc.)
- Docker / Docker compose

### Passos para Execução:

1. Clone o repositório:
```bash
git clone [URL_DO_REPOSITÓRIO]
cd form_app
```

2. Instale as dependências:
```bash
flutter pub get
```
3. Navegue até a pasta UI
```bash
cd ui
```

4. Execute o aplicativo:
```bash
flutter run -d web-server
```
5. Navegue ate a pasta API
```bash
cd api
```
6. Execute o aplicativo
```bash
docker compose up --build
```

7. Acesse o aplicativo:
- Abra seu navegador
- Acesse o endereço mostrado no terminal (geralmente http://localhost:XXXXX)

### Comandos Úteis durante a Execução:
- `r` - Recarregar o aplicativo (hot reload)
- `R` - Reiniciar o aplicativo (hot restart)
- `q` - Encerrar a execução
