# Filtro vertical heurístico

Apesar do nome histórico desta pasta, o estágio final em `PipelinePerc/Classificacao` não usa pesos aprendidos. Ele aplica o limiar geométrico armazenado em `Classificacao/configuracao.txt`, lê `Resultados/HOR-Imagens` e grava `Resultados/VER-Imagens`.

Os sketches `Amostras` e `Treinamento` são preservados apenas como experimento didático. Não os descreva como origem do filtro final sem uma nova validação. Consulte o `README.md` da raiz para requisitos, ordem de execução e limitações.
