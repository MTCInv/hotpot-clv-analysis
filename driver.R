options(width = 90)
blocks <- c("q3","q7","q8","q9","q10","q11","sens")
for (b in blocks) {
  out <- capture.output(source(paste0(b, ".R"), echo = TRUE, max.deparse.length = Inf, spaced = FALSE, keep.source = TRUE))
  writeLines(out, paste0(b, ".out"))
}
