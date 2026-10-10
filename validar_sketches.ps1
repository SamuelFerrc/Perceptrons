param(
    [string]$ProcessingJava = 'C:\Program Files\processing-4.3\processing-java.exe'
)

$ErrorActionPreference = 'Stop'

if (-not (Test-Path -LiteralPath $ProcessingJava -PathType Leaf)) {
    throw "processing-java não encontrado em: $ProcessingJava"
}

$projectRoot = $PSScriptRoot
$outputRoot = Join-Path ([System.IO.Path]::GetTempPath()) 'perceptron-processing-validation'
$sketches = @(
    '01-RGB Perceptron\Perceptron_01\Amostras',
    '01-RGB Perceptron\Perceptron_01\Treinamento',
    '01-RGB Perceptron\Perceptron_01\Classificacao',
    '02-Horizontal Perceptron\PipelinePerc\Amostras',
    '02-Horizontal Perceptron\PipelinePerc\Treinamento',
    '02-Horizontal Perceptron\PipelinePerc\Classificacao',
    '03-Vertical Perceptron\PipelinePerc\Amostras',
    '03-Vertical Perceptron\PipelinePerc\Treinamento',
    '03-Vertical Perceptron\PipelinePerc\Classificacao'
)

$failures = @()
for ($index = 0; $index -lt $sketches.Count; $index++) {
    $relativePath = $sketches[$index]
    $sketchPath = Join-Path $projectRoot $relativePath
    $buildPath = Join-Path $outputRoot ("sketch_{0}" -f ($index + 1))
    & $ProcessingJava "--sketch=$sketchPath" "--output=$buildPath" --force --build
    if ($LASTEXITCODE -ne 0) {
        $failures += $relativePath
        Write-Host "FALHOU: $relativePath" -ForegroundColor Red
    } else {
        Write-Host "OK: $relativePath" -ForegroundColor Green
    }
}

if ($failures.Count -gt 0) {
    throw ("Falharam {0} sketch(es): {1}" -f $failures.Count, ($failures -join ', '))
}

Write-Host 'VALIDAÇÃO CONCLUÍDA: 9/9 sketches compilados.' -ForegroundColor Green
