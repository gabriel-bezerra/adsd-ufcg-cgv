require("ggplot2")

source("intervalos-de-confianca.R")

# Read input data
data.file <- commandArgs(trailingOnly = TRUE)[1]
data <- read.table(file = data.file, header = TRUE)

# Summarize time data
data$execution.time = data$end.time - data$start.time


plot(data$encoder)
hist(data$cpu.usage)
hist(data[data$encoder == "vp8", ]$cpu.usage)
hist(data[data$encoder == "h264", ]$cpu.usage)
#hist(data[data$encoder == "theora", ]$cpu.usage)
hist(data[data$encoder == "xvid", ]$cpu.usage)
hist(data$mem.peak)
hist(data$output.size)
hist(data$execution.time)

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

