# Classificador horizontal

O estágio final está no sketch `PipelinePerc/Classificacao` e lê imagens de `Resultados/RGB-Imagens`. Seus parâmetros estão registrados em `Classificacao/configuracao.tsv`; a saída é gravada em `Resultados/HOR-Imagens`.

Os sketches `Amostras` e `Treinamento` preservam o experimento didático histórico. O treinamento gera `pesos_treinados.tsv`, mas não altera automaticamente a configuração aplicada ao lote final. Consulte o `README.md` da raiz para requisitos, ordem de execução e limitações.
