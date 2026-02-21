# Perceptron
Esse repositório tem por objetivo explicitar o menor nó de uma rede neural - Perceptron - utilizando de exemplos computacionais.
# O que são os perceptrons?
É normal não saber ao certo o que são perceptrons, a duvida é viva em muitos que chegaram agora em redes neurais.<br>
Perceptrons são o menor nó de uma rede neural - o que significa? - significa que o perceptron em uma rede neural assume o mesmo papel de um neurônio humano.<br>
Entender isso é fundamental para entender o perceptron em sua base.

# Composição de um neurônio
Um neurônio no cerebro humano assume o papel de celula básica responsavel por receber uma informação, utiliza-la e envia-la adiante.<br>

# Composição de um perceptron
Perceptron é um classificador binário linear, que realiza o mesmo procedimento de receber uma informação, utiliza-la e envia-la adiante. <br>
Esse processo é caracterizado por 3 procedimentos fundamentais que constroem o perceptron.

# 3 Processos Fundamentais
### Amostragem:
O procedimento de amostragem do perceptron é onde escolhemos dados para treinar o perceptron - dados esses que precisam estar previamente classificados em uma distinção binária de 0 ou 1 - esses dados será utilizado a frente no treinamento.

### Treinamento:
Com o dado(s) da amostragem utilizaremos da caracteristica de linearidade do perceptron para gerar uma estrutura linear de N dimensões para ser capaz de "cortar" os dados e dividi-los.<br>

### Classificação:
Esse processo de cortar os dados e dividi-los vai ser finalizado na classificação ao se utilizar o plano de corte previamente gerado para classificar os dados de acordo a posição relativa à estrutura linear.<br>

# Conclusão
O perceptron por sua caracteristica binária linear tem por fundamento simular o funcionamento do cerebro humano, ao longo deste material didático desenvolvido haverá demonstrações uteis para o entendimento geral do Perceptron. <br>
E para estudo mais amplo, seguindo adiante entederá ao fim disto onde o perceptron se encaixa nas rede neurais.

# Execução
Para o processamento dos dados por meio de Perceptrons, foram desenvolvidos três modelos distintos, cada um responsável por uma etapa específica na limpeza de imagens bidimensionais. Essas imagens devem permitir uma separação binária simples, requisito essencial para a correta segmentação da região de interesse.

Como base para os experimentos, foi utilizado o conjunto de dados **Visible Human Data Male**, disponibilizado publicamente pela U.S. National Library of Medicine, garantindo padronização e reprodutibilidade dos testes.

Os modelos implementados são descritos a seguir:

* **Perceptron RGB** – Responsável pela segmentação inicial da região de interesse a partir da separação dos canais RGB da imagem.
  Diretório: `01-RGB Perceptron/Perceptron_01`
  Para sua execução completa, é necessária a realização dos três processos definidos no pipeline.

* **Perceptron Horizontal** – Responsável pela remoção de ruídos com orientação predominantemente horizontal na região segmentada.
  Diretório: `02-Horizontal Perceptron/PipelinePerc`
  Também requer a execução dos três processos estabelecidos.

* **Perceptron Vertical** – Responsável pela eliminação de ruídos com orientação predominantemente vertical na região de interesse.
  Diretório: `03-Vertical Perceptron`
  Assim como os anteriores, demanda a execução dos três processos correspondentes.

Essa abordagem modular permite um refinamento progressivo da imagem, combinando segmentação por cor e filtragem direcional para aprimorar a qualidade da separação binária final.
