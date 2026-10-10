# Material didático sobre perceptron

Este repositório contém o código associado ao artigo **“Desenvolvimento de Material Didático para Sistemas Inteligentes: Perceptron”**. O material demonstra amostragem, treinamento e classificação binária em imagens do *Visible Human Male*.

## Requisitos

- Processing 4.3, modo Java;
- Java fornecido pelo próprio Processing;
- aproximadamente 2 GB livres para executar o conjunto completo de imagens;
- nomes e ordem dos arquivos de entrada preservados quando forem usados vários blocos RGB.

Os sketches foram testados com `processing-java.exe` do Processing 4.3 no Windows. Todos os caminhos usados pelo código são relativos ao repositório; não há dependência de OneDrive ou de uma pasta de usuário específica.

## Dados

O estudo utiliza o [Visible Human Project da U.S. National Library of Medicine](https://www.nlm.nih.gov/research/visible/visible_human.html). A NLM disponibiliza o conjunto e informa que, desde 2019, não exige registro para os dados publicados em seus servidores. Consulte os termos vigentes antes de redistribuir imagens.

Um caso pequeno está incluído em cada diretório `data` para validar a execução. O conjunto completo não foi duplicado nesses diretórios. Para reproduzir o processamento integral:

1. coloque as imagens PNG/JPG, sem alterar seus nomes, em `01-RGB Perceptron/Perceptron_01/Amostras/data/VisibleData`;
2. execute as etapas RGB na ordem indicada abaixo;
3. execute a classificação horizontal;
4. execute o filtro vertical heurístico.

## Organização e natureza das etapas

| Etapa | Implementação usada no resultado final | Observação |
|---|---|---|
| RGB | Perceptron treinado com atributos R, G e B | Cada linha de pesos é aplicada ao respectivo bloco ordenado de 50 imagens. |
| Horizontal | Classificador linear com parâmetros registrados em `configuracao.tsv` | A amostragem e o treinamento históricos permanecem disponíveis para estudo, mas não substituem automaticamente a configuração usada nos resultados do artigo. |
| Vertical | Filtro geométrico por limiar horizontal | Não é um perceptron treinado. O nome da pasta foi mantido apenas por compatibilidade histórica. |

Essa distinção é deliberada: o código não deve ser usado para afirmar que o estágio vertical foi aprendido por um perceptron.

## Execução

Abra cada pasta de sketch no Processing ou utilize `processing-java`. Dentro de cada módulo, a ordem é:

### 1. RGB

1. `01-RGB Perceptron/Perceptron_01/Amostras`
2. `01-RGB Perceptron/Perceptron_01/Treinamento`
3. `01-RGB Perceptron/Perceptron_01/Classificacao`

Saída: `Resultados/RGB-Imagens`.

A amostragem usa semente fixa (`202408`), produz até 4096 exemplos balanceados por bloco de 50 imagens e rejeita blocos incompletos. O treinamento avalia quatro taxas de aprendizado, grava `pesos.txt` e registra os resultados em `metricas.tsv`.

### 2. Classificador horizontal

Para reproduzir o estágio aplicado no artigo, execute:

`02-Horizontal Perceptron/PipelinePerc/Classificacao`

Saída: `Resultados/HOR-Imagens`.

Os parâmetros anteriormente embutidos no código agora estão em `Classificacao/configuracao.tsv`. As pastas `Amostras` e `Treinamento` preservam o experimento histórico e geram `pesos_treinados.tsv`, mas esse arquivo não é consumido automaticamente pela classificação final porque a engenharia de atributos histórica não coincide integralmente com a configuração aplicada ao lote final.

### 3. Filtro vertical heurístico

Execute:

`03-Vertical Perceptron/PipelinePerc/Classificacao`

Saída: `Resultados/VER-Imagens`.

O limiar utilizado está em `Classificacao/configuracao.txt`. Para um teste rápido com apenas uma imagem no PowerShell, defina temporariamente:

```powershell
$env:PERCEPTRON_LIMITE_IMAGENS = '1'
```

Sem essa variável, todas as imagens são processadas. As pastas `Amostras` e `Treinamento` dessa etapa são mantidas como experimento histórico e não fazem parte do filtro final descrito no artigo.

## Validação automática dos sketches

O script abaixo compila os nove sketches sem processar o conjunto completo:

```powershell
.\validar_sketches.ps1
```

É possível informar outra instalação do Processing:

```powershell
.\validar_sketches.ps1 -ProcessingJava 'D:\Processing\processing-java.exe'
```

Em 9 de outubro de 2026, os nove sketches compilaram com Processing 4.3. Também foram executados com sucesso: as três amostragens, os três treinamentos, a classificação RGB, a classificação horizontal sobre o conjunto local e o filtro vertical limitado a uma imagem. Essa verificação não substitui a reprodução estatística integral do artigo sobre as 1.878 imagens.

## Saídas e rastreabilidade

- `Resultados/RGB-Imagens`: segmentação inicial por cor;
- `Resultados/HOR-Imagens`: resultado após o classificador horizontal;
- `Resultados/VER-Imagens`: resultado após o limiar vertical;
- `Treinamento/metricas.tsv` ou `pesos_*`: parâmetros e métricas produzidos nos testes;
- `Exemplos`: arquivos originais fornecidos para inspeção e comparação.

Não exclua nem reordene imagens entre a amostragem e a classificação RGB: a associação entre bloco e linha de pesos depende da ordenação alfabética dos nomes.

## Limitações conhecidas

- O repositório contém exemplos e resultados intermediários, mas não uma cópia integral e imutável das 1.878 imagens de entrada.
- O classificador horizontal final utiliza uma configuração histórica registrada, não um encadeamento automático a partir do treinamento incluído.
- O estágio vertical é heurístico.
- A execução completa deve registrar versão do conjunto de dados, quantidade de arquivos, hashes ou uma lista ordenada de nomes e ambiente utilizado antes da submissão do artigo.

Essas limitações devem permanecer coerentes com as seções de método, resultados, disponibilidade de materiais e ameaças à validade do artigo.

## Citação e licença

Os metadados mínimos para citação estão em `CITATION.cff`. O repositório ainda não declara uma licença de software. Antes da publicação de uma nova versão, os autores devem escolher conscientemente uma licença compatível com a política institucional e com os materiais de terceiros; a ausência de licença não concede permissão de reutilização.
