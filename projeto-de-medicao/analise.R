# read data from file
data <- read.table(file = "factorialdata.txt", header = TRUE)


# summarize time data

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
absolute.time <- real.time - real.time[1]  # time since the beggining of the experiment


summarized.time.data <- cbind(process.user.time = process.times$user.time,
                              process.sys.time = process.times$sys.time,
                              process.total.time = process.times$total.time,
                              cpu.total.time = cpu.times$total.time,
                              absolute.time)


# CPU usage

t0.time.data <- head(summarized.time.data, -1)
t1.time.data <- tail(summarized.time.data, -1)

process.time.between.t0.and.t1 <- t1.time.data[, 'process.total.time'] - t0.time.data[, 'process.total.time']
    cpu.time.between.t0.and.t1 <- t1.time.data[, 'cpu.total.time']     - t0.time.data[, 'cpu.total.time']

cpu.usage <- process.time.between.t0.and.t1 / cpu.time.between.t0.and.t1

cpu.usage.and.time <- cbind(absolute.time = t1.time.data[,'absolute.time'],
                            cpu.usage)


summary(cpu.usage.and.time)
plot(cpu.usage.and.time, type = 'l')
