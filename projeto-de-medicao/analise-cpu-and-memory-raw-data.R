# CPU and Memory usage analysis
#
# Usage: Rscript analise-cpu-and-memory-raw-data.R input-data-file number-of-cpus
#

# Read input data
data.file <- commandArgs(trailingOnly = TRUE)[1]
data <- read.table(file = data.file, header = TRUE)
data <- rbind(head(data, 1), tail(data, 1))  # As we are interested only in the average CPU and Memory usage, only the
                                             # first and the latest states are needed for the calc.

number.of.cpus <- as.numeric(commandArgs(trailingOnly = TRUE)[2])


# Summarize time data

process.times <- data[, 1:4]
process.times$user.time <- process.times$utime + process.times$cutime
process.times$sys.time <- process.times$stime + process.times$cstime
process.times$total.time <- process.times$user.time + process.times$sys.time

cpu.times <- data[, 5:8]
cpu.times$total.time <- cpu.times$umode +
                        cpu.times$umodelowpriority +
                        cpu.times$smode +
                        cpu.times$idle

real.time <- data[, 9]
absolute.time <- real.time - real.time[1]  # time since the beginning of the experiment


summarized.time.data <- cbind(process.user.time = process.times$user.time,
                              process.sys.time = process.times$sys.time,
                              process.total.time = process.times$total.time,
                              cpu.total.time = cpu.times$total.time,
                              absolute.time)


# CPU usage

t0.time.data <- head(summarized.time.data, -1)
t1.time.data <- tail(summarized.time.data, -1)

process.time.between.t0.and.t1 <- t1.time.data[, 'process.user.time'] - t0.time.data[, 'process.user.time']
    cpu.time.between.t0.and.t1 <- t1.time.data[, 'cpu.total.time']     - t0.time.data[, 'cpu.total.time']

cpu.usage <- number.of.cpus * process.time.between.t0.and.t1 / cpu.time.between.t0.and.t1

cpu.usage.and.time <- cbind(absolute.time = t1.time.data[,'absolute.time'],
                            cpu.usage)


#summary(cpu.usage.and.time)
#plot(cpu.usage.and.time, type = 'l')


# Memory usage

mem.peak.size <- data[, 10]
mem.size <- data[, 11]

memory.usage.and.time <- cbind(absolute.time, mem.size, mem.peak.size)

#summary(memory.usage.and.time)
#plot(memory.usage.and.time, type = 'l')

# Show only average cpu usage and mem peak size at the end of the execution
cat(cpu.usage, mem.peak.size[-1], "\n")

