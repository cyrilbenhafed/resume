# build_resume.R

# Ensure output folder exists
if (!dir.exists("docs")) dir.create("docs")

langs <- c("fr", "en")

for (lang in langs) {
  # Render HTML
  rmarkdown::render(
    "resume.Rmd",
    output_file = paste0("docs/resume_", lang, ".html"),
    params = list(lang = lang),
    envir = new.env()
  )
  
  # Generate PDF
  pagedown::chrome_print(
    input = paste0("docs/resume_", lang, ".html"),
    output = paste0("docs/resume_", lang, ".pdf")
  )
}

# Create a simple index.html with SVG flag icons
index_html <- '
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Cyril Benhafed - Resume</title>
  <style>
    body {
      font-family: sans-serif;
      text-align: center;
      margin-top: 10%;
    }
    a {
      margin: 0 20px;
      font-size: 1.5em;
      text-decoration: none;
    }
    img.flag {
      width: 30px;
      vertical-align: middle;
      margin-right: 8px;
    }
  </style>
</head>
<body>
  <h1>Cyril Benhafed - Resume</h1>
  <p>
    <a href="resume_fr.html">
      <img class="flag" src="https://cdnjs.cloudflare.com/ajax/libs/twemoji/14.0.2/svg/1f1eb-1f1f7.svg" /> Français
    </a>
    <a href="resume_en.html">
      <img class="flag" src="https://cdnjs.cloudflare.com/ajax/libs/twemoji/14.0.2/svg/1f1ec-1f1e7.svg" /> English
    </a>
  </p>
</body>
</html>
'
writeLines(index_html, "docs/index.html")
