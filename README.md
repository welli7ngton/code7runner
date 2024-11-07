# code7runner

code7runner é um plugin para LunarVim que permite executar arquivos de código diretamente do editor, suportando diversas linguagens de programação.

## Funcionalidades

Execução de arquivos de código com base em sua extensão.

Suporte para múltiplas linguagens, incluindo JavaScript, TypeScript, Python, Java, C, C++, Robot Framework, Lua, PHP e Ruby.
Integração com o terminal embutido do Neovim para exibir a saída dos programas.

## Instalação

Para instalar o code7runner, adicione o seguinte ao seu arquivo de configuração do LunarVim:

``plugins.lua``
```lua
{ "welli7ngton/code7runner",
  config = funcyion()
    require('code7runner')
  end
},
```
# Uso

Para executar o arquivo de código atual, utilize o comando:

```bash
:Code7Run
```

Ou crie uma bind personalizada:

```lua
lvim.keys.insert_mode["<F5>"] = ":Code7Run<CR>"
```

A saída do programa será exibida no terminal embutido do Neovim.

## Suporte a Linguagens

O code7runner suporta as seguintes linguagens e extensões de arquivo:

- JavaScript (.js)
- TypeScript (.ts)
- Python (.py)
- Java (.java)
- C (.c)
- C++ (.cpp)
- Robot Framework (.robot)
- Lua (.lua)
- PHP (.php)
- Ruby (.rb)

Para cada extensão, o plugin define o comando apropriado para compilar e/ou executar o código.

## Contribuição
Contribuições são bem-vindas! Sinta-se à vontade para abrir issues ou pull requests no repositório do GitHub.

TODO's:
- Adicionar suporte a mais linguagens.
- Adicionar suporte dinâmico de linguagens configuradas pelos usuários.
- Criar função para facilitar mais ainda a criação de uma bind personalizada para o plugin.
- Melhorar o terminal em que é mostrado o output dos arquivos, para ficar mais natural do editor e parecido com o do vscode.
