require("ggplot2")

source("intervalos-de-confianca.R")

# Read input data
data.file <- commandArgs(trailingOnly = TRUE)[1]
data <- read.table(file = data.file, header = TRUE)

# Summarize time data
data$execution.time = data$end.time - data$start.time

# Tamanho da saída varia de acordo com a quantidade de movimento do video. Config: 500 240p (low | high) 
## Boxplots

### Fatores 500 quadros e 240p
vp8OutputSizeLowMotion <- data[data$encoder == "vp8" & data$frames == 500 & data$resolution == "240p" & data$motion == "low", ]$output.size
h264OutputSizeLowMotion <- data[data$encoder == "h264" & data$frames == 500 & data$resolution == "240p" & data$motion == "low", ]$output.size
theoraOutputSizeLowMotion <- data[data$encoder == "theora" & data$frames == 500 & data$resolution == "240p" & data$motion == "low", ]$output.size
xvidOutputSizeLowMotion <- data[data$encoder == "xvid" & data$frames == 500 & data$resolution == "240p" & data$motion == "low", ]$output.size

vp8OutputSizeHighMotion <- data[data$encoder == "vp8" & data$frames == 500 & data$resolution == "240p" & data$motion == "high", ]$output.size
h264OutputSizeHighMotion <- data[data$encoder == "h264" & data$frames == 500 & data$resolution == "240p" & data$motion == "high", ]$output.size
theoraOutputSizeHighMotion <- data[data$encoder == "theora" & data$frames == 500 & data$resolution == "240p" & data$motion == "high", ]$output.size
xvidOutputSizeHighMotion <- data[data$encoder == "xvid" & data$frames == 500 & data$resolution == "240p" & data$motion == "high", ]$output.size

outputSizeDataFrame <- data.frame(vp8OutputSizeLowMotion, vp8OutputSizeHighMotion,
								h264OutputSizeLowMotion, h264OutputSizeHighMotion,
								theoraOutputSizeLowMotion, theoraOutputSizeHighMotion,
								xvidOutputSizeLowMotion, xvidOutputSizeHighMotion)

png("boxplot-videomotion-outputsize-500f-240p.png")
boxplot(outputSizeDataFrame, main="500 quadros e resolucao 240p", names=c("vLow", "vHigh", "hLow", "hHigh", "tLow", "tHigh", "xLow", "xHigh"), xlab="Codec e Quantidade de Movimento", ylab="Tamanho da saida (KB)")
dev.off()

### Fatores 2000 quadros e resolucao 480p

vp8OutputSizeLowMotion <- data[data$encoder == "vp8" & data$frames == 2000 & data$resolution == "480p" & data$motion == "low", ]$output.size
h264OutputSizeLowMotion <- data[data$encoder == "h264" & data$frames == 2000 & data$resolution == "480p" & data$motion == "low", ]$output.size
theoraOutputSizeLowMotion <- data[data$encoder == "theora" & data$frames == 2000 & data$resolution == "480p" & data$motion == "low", ]$output.size
xvidOutputSizeLowMotion <- data[data$encoder == "xvid" & data$frames == 2000 & data$resolution == "480p" & data$motion == "low", ]$output.size

vp8OutputSizeHighMotion <- data[data$encoder == "vp8" & data$frames == 2000 & data$resolution == "480p" & data$motion == "high", ]$output.size
h264OutputSizeHighMotion <- data[data$encoder == "h264" & data$frames == 2000 & data$resolution == "480p" & data$motion == "high", ]$output.size
theoraOutputSizeHighMotion <- data[data$encoder == "theora" & data$frames == 2000 & data$resolution == "480p" & data$motion == "high", ]$output.size
xvidOutputSizeHighMotion <- data[data$encoder == "xvid" & data$frames == 2000 & data$resolution == "480p" & data$motion == "high", ]$output.size

outputSizeDataFrame <- data.frame(vp8OutputSizeLowMotion, vp8OutputSizeHighMotion,
								h264OutputSizeLowMotion, h264OutputSizeHighMotion,
								theoraOutputSizeLowMotion, theoraOutputSizeHighMotion,
								xvidOutputSizeLowMotion, xvidOutputSizeHighMotion)

png("boxplot-videomotion-outputsize-2000f-480p.png")								
boxplot(outputSizeDataFrame, main="2000 quadros e resolucao 480p", names=c("vLow", "vHigh", "hLow", "hHigh", "tLow", "tHigh", "xLow", "xHigh"), xlab="Codec e Quantidade de Movimento", ylab="Tamanho da saida (KB)")
dev.off()



# Tempo de execucao varia de acordo com a quantidade de quadros. Config: (500 | 2000) 480p high
## Boxplots
vp8ExecutionTimeShort <- data[data$encoder == "vp8" & data$frames == 500 & data$resolution == "480p" & data$motion == "high", ]$execution.time
h264ExecutionTimeShort <- data[data$encoder == "h264" & data$frames == 500 & data$resolution == "480p" & data$motion == "high", ]$execution.time
theoraExecutionTimeShort <- data[data$encoder == "theora" & data$frames == 500 & data$resolution == "480p" & data$motion == "high", ]$execution.time
xvidExecutionTimeShort <- data[data$encoder == "xvid" & data$frames == 500 & data$resolution == "480p" & data$motion == "high", ]$execution.time

vp8ExecutionTimeLong <- data[data$encoder == "vp8" & data$frames == 2000 & data$resolution == "480p" & data$motion == "high", ]$execution.time
h264ExecutionTimeLong <- data[data$encoder == "h264" & data$frames == 2000 & data$resolution == "480p" & data$motion == "high", ]$execution.time
theoraExecutionTimeLong <- data[data$encoder == "theora" & data$frames == 2000 & data$resolution == "480p" & data$motion == "high", ]$execution.time
xvidExecutionTimeLong <- data[data$encoder == "xvid" & data$frames == 2000 & data$resolution == "480p" & data$motion == "high", ]$execution.time

timeDataFrame <- data.frame(vp8ExecutionTimeShort, vp8ExecutionTimeLong,
								h264ExecutionTimeShort, h264ExecutionTimeLong,
								theoraExecutionTimeShort, theoraExecutionTimeLong,
								xvidExecutionTimeShort, xvidExecutionTimeLong)
png("boxplot-videoframe-executiontime-high-480p.png")
boxplot(timeDataFrame, main="Quantidade de movimento ALTA e resolucao 480p", names=c("vShort", "vLong", "hShort", "hLong", "tShort", "tLong", "xShort", "xLong"), xlab="Codec e Quantidade de Quadros", ylab="Tempo de execucao (segundos)")
dev.off()

# Uso de CPU varia de acordo com a resolucao do video. Config: 500 (240p | 480p) low
## Boxplots
vp8CpuUsageLowRes <- data[data$encoder == "vp8" & data$frames == 500 & data$resolution == "240p" & data$motion == "low", ]$cpu.usage
h264CpuUsageLowRes <- data[data$encoder == "h264" & data$frames == 500 & data$resolution == "240p" & data$motion == "low", ]$cpu.usage
theoraCpuUsageLowRes <- data[data$encoder == "theora" & data$frames == 500 & data$resolution == "240p" & data$motion == "low", ]$cpu.usage
xvidCpuUsageLowRes <- data[data$encoder == "xvid" & data$frames == 500 & data$resolution == "240p" & data$motion == "low", ]$cpu.usage

vp8CpuUsageHighRes <- data[data$encoder == "vp8" & data$frames == 500 & data$resolution == "480p" & data$motion == "low", ]$cpu.usage
h264CpuUsageHighRes <- data[data$encoder == "h264" & data$frames == 500 & data$resolution == "480p" & data$motion == "low", ]$cpu.usage
theoraCpuUsageHighRes <- data[data$encoder == "theora" & data$frames == 500 & data$resolution == "480p" & data$motion == "low", ]$cpu.usage
xvidCpuUsageHighRes <- data[data$encoder == "xvid" & data$frames == 500 & data$resolution == "480p" & data$motion == "low", ]$cpu.usage

cpuUsageDataFrame <- data.frame(vp8CpuUsageLowRes, vp8CpuUsageHighRes,
								h264CpuUsageLowRes, h264CpuUsageHighRes,
								theoraCpuUsageLowRes, theoraCpuUsageHighRes,
								xvidCpuUsageLowRes, xvidCpuUsageHighRes)

png("boxplot-resolution-cpuusage-500f-low.png")
boxplot(cpuUsageDataFrame, main="500 quadros e quantidade de movimento BAIXA", names=c("vLow", "vHigh", "hLow", "hHigh", "tLow", "tHigh", "xLow", "xHigh"), xlab="Codec e Resolucao do video", ylab="Uso de CPU (0.0 a 4.0)")
dev.off()



# Uso de memoria varia de acordo com a qntidade de movimoento. Config: 2000 480p high
## Boxplots
vp8MemUsageLowMotion <- data[data$encoder == "vp8" & data$frames == 2000 & data$resolution == "480p" & data$motion == "low", ]$mem.peak
h264MemUsageLowMotion <- data[data$encoder == "h264" & data$frames == 2000 & data$resolution == "480p" & data$motion == "low", ]$mem.peak
theoraMemUsageLowMotion <- data[data$encoder == "theora" & data$frames == 2000 & data$resolution == "480p" & data$motion == "low", ]$mem.peak
xvidMemUsageLowMotion <- data[data$encoder == "xvid" & data$frames == 2000 & data$resolution == "480p" & data$motion == "low", ]$mem.peak

vp8MemUsageHighMotion <- data[data$encoder == "vp8" & data$frames == 2000 & data$resolution == "480p" & data$motion == "high", ]$mem.peak
h264MemUsageHighMotion <- data[data$encoder == "h264" & data$frames == 2000 & data$resolution == "480p" & data$motion == "high", ]$mem.peak
theoraMemUsageHighMotion <- data[data$encoder == "theora" & data$frames == 2000 & data$resolution == "480p" & data$motion == "high", ]$mem.peak
xvidMemUsageHighMotion <- data[data$encoder == "xvid" & data$frames == 2000 & data$resolution == "480p" & data$motion == "high", ]$mem.peak

memUsageDataFrame <- data.frame(vp8MemUsageLowMotion, vp8MemUsageHighMotion,
								h264MemUsageLowMotion, h264MemUsageHighMotion,
								theoraMemUsageLowMotion, theoraMemUsageHighMotion,
								xvidMemUsageLowMotion, xvidMemUsageHighMotion)
								
png("boxplot-motion-memusage-2000f-480p.png")
boxplot(memUsageDataFrame, main="2000 quadros e resolucao 480p", names=c("vLow", "vHigh", "hLow", "hHigh", "tLow", "tHigh", "xLow", "xHigh"), xlab="Codec e Quantidade de movimento", ylab="Uso de Memoria (KB)")
dev.off()






# R does not support multi-line comments. This is a workaround. ;)
if (FALSE) {
	plot(data$encoder)
	hist(data$cpu.usage)
	hist(data[data$encoder == "vp8", ]$cpu.usage)
	hist(data[data$encoder == "h264", ]$cpu.usage)
	#hist(data[data$encoder == "theora", ]$cpu.usage)
	hist(data[data$encoder == "xvid", ]$cpu.usage)
	hist(data$mem.peak)
	hist(data$output.size)
	hist(data$execution.time)

	mean(data$execution.time)
	median(data$execution.time)

	mean(data[data$resolution == "240p", ]$execution.time)
	median(data[data$resolution == "240p", ]$execution.time)
	hist(data[data$resolution == "240p", ]$execution.time)
	length(data[data$resolution == "240p", ]$execution.time)

	mean(data[data$resolution == "480p", ]$execution.time)
	median(data[data$resolution == "480p", ]$execution.time)
	hist(data[data$resolution == "480p", ]$execution.time)
	length(data[data$resolution == "480p", ]$execution.time)


	# Some analyses

	mean.confidence.interval <- function(sample) {
		confidence.interval = intervalo.de.confianca.para.a.media(sample, 0.05)
		cbind(mean(sample),
			  confidence.interval[1],
			  confidence.interval[2])
	}

	aggregate.mean.and.confidence.interval.for <- function(variable) {
		aggregated.data <-
			with(data,
				aggregate(variable,
						  by=list(encoder, frames, resolution, motion),
						  mean.confidence.interval,
						  simplify = TRUE
				)
			)
		names(aggregated.data) <- c("encoder", "frames", "resolution", "motion", "mean.cimin.cimax")
		aggregated.data
	}

	cpu.usage.means.and.cis <-
		aggregate.mean.and.confidence.interval.for(data$cpu.usage)

	memory.usage.means.and.cis <-
		aggregate.mean.and.confidence.interval.for(data$mem.peak)

	execution.time.means.and.cis <-
		aggregate.mean.and.confidence.interval.for(data$execution.time)

	output.size.means.and.cis <-
		aggregate.mean.and.confidence.interval.for(data$output.size)


	means.from <- function(aggregated.results)
		aggregated.results[, "mean.cimin.cimax"][, 1]

	ci.mins.from <- function(aggregated.results)
		aggregated.results[, "mean.cimin.cimax"][, 2]

	ci.maxs.from <- function(aggregated.results)
		aggregated.results[, "mean.cimin.cimax"][, 3]

	groups.from <- function(aggregated.results) {
		paste(aggregated.results[, 1], aggregated.results[, 2], aggregated.results[, 3], aggregated.results[, 4])
	}

	chart.for <- function(aggregated.results, chart.name) {
		means = means.from(aggregated.results)
		cis = cbind(ci.mins.from(aggregated.results), ci.maxs.from(aggregated.results))

		mean.cimin.cimax <- data.frame(encoder = groups.from(aggregated.results),
									   means = means,
									   ci.min = cis[, 1],
									   ci.max = cis[, 2])

		chart <- ggplot(mean.cimin.cimax, aes(x = encoder,
											  y = means,
											  ymin = ci.min,
											  ymax = ci.max,
											  fill = encoder)) +
						geom_bar(stat="identity") +
						geom_errorbar(aes(width = 0.2)) +
						ggtitle(paste("Intervalos de confiança para a média de", chart.name)) +
						ylab("Média") +
						xlab("Configuração")

		chart
	}

	print(chart.for(cpu.usage.means.and.cis, "uso de CPU"))
	print(chart.for(memory.usage.means.and.cis, "uso de memória"))
	print(chart.for(execution.time.means.and.cis, "tempo de execução"))
	print(chart.for(output.size.means.and.cis, "tamanho de saida"))
}




