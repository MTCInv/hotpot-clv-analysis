options(width = 90)
# Run from the repo root. Scripts live under scripts/.
blocks <- c("q3","q7","q8","q9","q10","q11","sens")
for (b in blocks) {
  path <- file.path("scripts", paste0(b, ".R"))
  out <- capture.output(source(path, echo = TRUE, max.deparse.length = Inf, spaced = FALSE, keep.source = TRUE))
  writeLines(out, file.path("scripts", paste0(b, ".out")))
}
