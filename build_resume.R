# build_resume.R - Build CV with iframe wrapper

# Ensure output folder exists
if (!dir.exists("docs")) dir.create("docs")

langs <- c("fr", "en")

cat("🔨 Building CV in both languages...\n\n")

# Step 1: Render HTML for each language
for (lang in langs) {
  cat(paste0("  📄 Rendering HTML (", toupper(lang), ")...\n"))
  
  rmarkdown::render(
    "resume.Rmd",
    output_file = paste0("docs/resume_", lang, ".html"),
    params = list(lang = lang),
    envir = new.env(),
    quiet = TRUE
  )
}

# Step 2: Generate PDFs
cat("\n📑 Generating PDFs...\n")
for (lang in langs) {
  cat(paste0("  📄 Generating PDF (", toupper(lang), ")...\n"))
  
  pagedown::chrome_print(
    input = paste0("docs/resume_", lang, ".html"),
    output = paste0("docs/resume_", lang, ".pdf"),
    verbose = 0
  )
}

# Step 3: Copy wrapper files to docs
cat("\n📦 Copying wrapper files...\n")

# Copy index.html
if (file.exists("index.html")) {
  file.copy("index.html", "docs/index.html", overwrite = TRUE)
  cat("  ✓ index.html\n")
} else {
  cat("  ⚠️  index.html not found in root\n")
}

# Copy wrapper-styles.css
if (file.exists("utils/wrapper-styles.css")) {
  file.copy("utils/wrapper-styles.css", "docs/wrapper-styles.css", overwrite = TRUE)
  cat("  ✓ wrapper-styles.css\n")
} else {
  cat("  ⚠️  utils/wrapper-styles.css not found\n")
}

cat("\n✅ Build complete!\n")
cat("\n📂 Generated files:\n")
cat("  • docs/resume_fr.html\n")
cat("  • docs/resume_en.html\n")
cat("  • docs/resume_fr.pdf\n")
cat("  • docs/resume_en.pdf\n")
cat("  ⭐ docs/index.html (MAIN FILE - wrapper with iframe)\n")
cat("  • docs/wrapper-styles.css\n")
cat("\n🌐 Open docs/index.html in your browser\n")