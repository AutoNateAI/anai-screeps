#let brand = "AutoNateAI Screeps League"
#let accent = rgb("#31c48d")
#let accent-dark = rgb("#0f766e")
#let gold = rgb("#f59e0b")
#let ink = rgb("#17202a")
#let muted = rgb("#5f6c7b")
#let rule = rgb("#d7dee8")
#let paper = rgb("#fbfcfe")
#let code-bg = rgb("#111827")
#let code-fg = rgb("#e5eef8")

#let branded-doc(title: "Markdown Export", source: none, subtitle: "", body) = {
  set document(title: title, author: brand)
  set page(
    paper: "us-letter",
    margin: (top: 0.78in, bottom: 0.72in, x: 0.72in),
    fill: paper,
    header: context {
      if counter(page).get().first() > 1 [
        #grid(
          columns: (1fr, auto),
          align: (left, right),
          text(size: 8pt, fill: muted, weight: "semibold")[#brand],
          text(size: 8pt, fill: muted)[#title],
        )
        #v(3pt)
        #line(length: 100%, stroke: 0.55pt + rule)
      ]
    },
    footer: context {
      line(length: 100%, stroke: 0.45pt + rule)
      v(3pt)
      grid(
        columns: (1fr, auto),
        align: (left, right),
        text(size: 7.5pt, fill: muted)[Markdown curriculum export],
        text(size: 7.5pt, fill: muted)[Page #counter(page).display()],
      )
    },
  )
  set text(font: ("Avenir Next", "Helvetica Neue", "New Computer Modern"), size: 10pt, fill: ink, lang: "en")
  set par(leading: 0.62em, spacing: 0.72em, justify: true)
  set list(indent: 1.05em, body-indent: 0.55em)
  set enum(indent: 1.05em, body-indent: 0.55em)
  set quote(block: true)
  set table(stroke: 0.45pt + rule, inset: (x: 7pt, y: 5pt), align: horizon)

  show heading.where(level: 1): it => {
    block(
      width: 100%,
      fill: rgb("#102a43"),
      inset: (x: 18pt, y: 18pt),
      radius: 3pt,
      below: 18pt,
    )[
      #text(size: 8pt, fill: accent, weight: "bold")[#upper(brand)]
      #v(9pt)
      #text(size: 23pt, fill: white, weight: "bold")[#it.body]
      #v(7pt)
      #grid(
        columns: (1fr, auto),
        align: (left, right),
        text(size: 8.5pt, fill: rgb("#bfd7ea"))[#subtitle],
        if source != none { text(size: 8pt, fill: rgb("#bfd7ea"))[#source] },
      )
    ]
  }

  show heading.where(level: 2): it => block(above: 14pt, below: 5pt)[
    #text(size: 14pt, weight: "bold", fill: accent-dark)[#it.body]
  ]

  show heading.where(level: 3): it => block(above: 9pt, below: 4pt)[
    #text(size: 11pt, weight: "semibold", fill: ink)[#it.body]
  ]

  show strong: it => text(weight: "bold", fill: ink)[#it.body]
  show emph: it => text(style: "italic", fill: rgb("#334155"))[#it.body]
  show link: it => text(fill: accent-dark)[#it.body]

  show raw.where(block: true): it => block(
    width: 100%,
    fill: code-bg,
    stroke: 0.6pt + rgb("#263244"),
    inset: 9pt,
    radius: 3pt,
    breakable: true,
    above: 6pt,
    below: 8pt,
  )[
    #text(font: ("DejaVu Sans Mono", "Menlo"), size: 7.8pt, fill: code-fg)[#it]
  ]

  show raw.where(block: false): it => box(
    fill: rgb("#e9f2ef"),
    inset: (x: 2.6pt, y: 1.2pt),
    outset: (y: 0.5pt),
    radius: 2pt,
  )[#text(font: ("DejaVu Sans Mono", "Menlo"), size: 8.5pt, fill: rgb("#1f2937"))[#it]]

  show quote: it => block(
    width: 100%,
    fill: rgb("#fff8e7"),
    stroke: (left: 2.4pt + gold, rest: 0pt),
    inset: (left: 10pt, right: 9pt, y: 7pt),
    radius: 2pt,
    above: 7pt,
    below: 9pt,
  )[
    #text(size: 9.2pt, fill: rgb("#553c00"))[#it.body]
  ]

  show figure.where(kind: table): it => block(
    width: 100%,
    fill: white,
    stroke: 0.5pt + rule,
    inset: 0pt,
    radius: 3pt,
    above: 7pt,
    below: 10pt,
  )[#it.body]

  block(width: 100%)[#body]
}
