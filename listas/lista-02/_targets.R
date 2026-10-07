library(targets)
library(tarchetypes)

tar_source("R")

list(
  tar_target(arquivo, "dados/airquality.csv", format = "file"),
  tar_target(dados, ler_dados(arquivo)),
  tar_target(medias, resumir(dados)),
  tar_target(modelo, modelar(dados)),
  tar_target(figura, desenhar(dados, modelo), format = "file"),
  tar_target(csv_medias, exportar_csv(medias), format = "file"),
  tar_quarto(relatorio, "relatorio.qmd")
)