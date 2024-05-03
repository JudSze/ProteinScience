mut = as.vector(read.table('mut_energies'))
wt = as.vector(read.table('wt_energies'))

delta = mut - wt

write.table(round(delta, digits=4), row.names=F, col.names=F, file='delta_energies')

stats = c(mean(delta$V1), sd(delta$V1))

write.table(t(round(stats, digits=4)), row.names=F, col.names=F, file='final_average')
