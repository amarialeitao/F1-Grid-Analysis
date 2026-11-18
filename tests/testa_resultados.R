# Roda a análise completa e confere os números publicados no README.
# Uso, a partir da raiz do repositório: Rscript tests/testa_resultados.R

source("scripts/analise_f1.r")

r2 <- summary(modelo_linear)$r.squared
inclinacao <- unname(coef(modelo_linear)["grid"])
corridas <- length(unique(resultados_f1$raceId[
  suppressWarnings(!is.na(as.numeric(resultados_f1$position))) & resultados_f1$grid > 0
]))

cat("\n--- Conferência dos números do README ---\n")
cat("Resultados analisados:", nrow(dados_limpos), "\n")
cat("Corridas:", corridas, "\n")
cat("Correlação de Pearson:", round(correlacao, 2), "\n")
cat("R²:", round(r2, 2), "\n")
cat("Inclinação:", round(inclinacao, 2), "\n")

stopifnot(
  nrow(dados_limpos) == 15746,
  corridas == 1125,
  round(correlacao, 2) == 0.65,
  round(r2, 2) == 0.42,
  round(inclinacao, 2) == 0.47,
  file.exists("plots/relacao_grid_posicao.png")
)

cat("OK: os resultados conferem com o README.\n")
