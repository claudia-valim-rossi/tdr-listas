install.packages(c("here", "targets", "tarchetypes"))

## Lê o CSV e acrescenta o nome do mês como fator.
ler_dados <- function(arquivo) {
  dados <- read.csv(arquivo)
  dados$Mes <- factor(dados$Month, levels = 5:9,
                      labels = c("Maio", "Junho", "Julho", "Agosto", "Setembro"))
  dados
}

## Média mensal das duas variáveis escolhidas (aqui: Ozone e Wind).
resumir <- function(dados) {
  medias <- aggregate(cbind(Ozone, Wind) ~ Mes, data = dados, FUN = mean,
                      na.action = na.pass, na.rm = TRUE)
  medias[, -1] <- round(medias[, -1], 1)
  medias
}

## Ajusta o modelo linear resposta ~ preditor.
modelar <- function(dados) {
  lm(Ozone ~ Wind, data = dados)
}

## Desenha a dispersão com a reta ajustada e devolve o caminho do PNG.
desenhar <- function(dados, modelo, arquivo = "saidas/dispersao.png") {
  dir.create(dirname(arquivo), showWarnings = FALSE, recursive = TRUE)
  png(arquivo, width = 1400, height = 900, res = 180)
  on.exit(dev.off())
  plot(Ozone ~ Wind, data = dados, pch = 20, col = "steelblue",
       xlab = "Vento (mph)", ylab = "Ozônio (ppb)")
  abline(modelo, col = "tomato", lwd = 2)
  arquivo
}

#Roda as funções
source("R/funcoes.R")
dados <- ler_dados("dados/airquality.csv")
medias <- resumir(dados)
modelo <- modelar(dados)
desenhar(dados, modelo)

#verificar se o arquivo existe
file.exists("saidas/dispersao.png")
