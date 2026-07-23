#!/usr/bin/env node
import { execFileSync } from "node:child_process";
import { mkdirSync, readdirSync, readFileSync, rmSync, writeFileSync } from "node:fs";
import path from "node:path";

const repoRoot = process.cwd();
const tutorialsDir = path.join(repoRoot, "docs/tutorials");
const exportDir = path.join(tutorialsDir, "export");
const typstDir = path.join(exportDir, "typst");
const pdfDir = path.join(exportDir, "pdf");
const assetsDir = path.join(exportDir, "assets");
const buildDir = path.join(exportDir, "build");
const npmCacheDir = path.join(buildDir, "npm-cache");

mkdirSync(typstDir, { recursive: true });
mkdirSync(pdfDir, { recursive: true });
mkdirSync(assetsDir, { recursive: true });
rmSync(buildDir, { recursive: true, force: true });
mkdirSync(buildDir, { recursive: true });

const files = readdirSync(tutorialsDir)
  .filter((file) => /^\d{2}-.+\.md$/.test(file))
  .sort();

if (files.length === 0) {
  throw new Error(`No tutorial markdown files found in ${tutorialsDir}`);
}

for (const file of files) {
  const sourcePath = path.join(tutorialsDir, file);
  const slug = file.replace(/\.md$/, "");
  const assetSubdir = path.join(assetsDir, slug);
  mkdirSync(assetSubdir, { recursive: true });

  const markdown = readFileSync(sourcePath, "utf8");
  const title = markdown.match(/^#\s+(.+)$/m)?.[1]?.trim() ?? slug;
  const processed = renderMermaid(markdown, slug, assetSubdir);
  const processedPath = path.join(buildDir, `${slug}.md`);
  writeFileSync(processedPath, processed);

  const body = execFileSync(
    "pandoc",
    [processedPath, "-f", "gfm", "-t", "typst"],
    { cwd: repoRoot, encoding: "utf8", maxBuffer: 10 * 1024 * 1024 },
  );
  const polishedBody = polishTypstBody(body);

  const typstPath = path.join(typstDir, `${slug}.typ`);
  const pdfPath = path.join(pdfDir, `${slug}.pdf`);
  writeFileSync(
    typstPath,
    [
      '#import "theme.typ": tutorial-doc',
      `#show: body => tutorial-doc(title: ${typstString(title)}, source: ${typstString(`docs/tutorials/${file}`)}, body)`,
      "",
      polishedBody,
    ].join("\n"),
  );

  execFileSync("typst", ["compile", "--root", repoRoot, typstPath, pdfPath], {
    cwd: repoRoot,
    stdio: "inherit",
  });
  console.log(`exported ${path.relative(repoRoot, pdfPath)}`);
}

function renderMermaid(markdown, slug, assetSubdir) {
  let index = 0;
  return markdown.replace(/```mermaid\n([\s\S]*?)```/g, (_match, diagramSource) => {
    index += 1;
    const basename = `diagram-${String(index).padStart(2, "0")}`;
    const mmdPath = path.join(assetSubdir, `${basename}.mmd`);
    const pngPath = path.join(assetSubdir, `${basename}.png`);
    writeFileSync(mmdPath, sanitizeMermaid(diagramSource).trimEnd() + "\n");
    execFileSync(
      "npx",
      [
        "-y",
        "@mermaid-js/mermaid-cli",
        "-i",
        mmdPath,
        "-o",
        pngPath,
        "-b",
        "transparent",
        "--scale",
        "2",
      ],
      {
        cwd: repoRoot,
        stdio: "inherit",
        env: { ...process.env, npm_config_cache: npmCacheDir },
      },
    );
    const relPath = `../assets/${slug}/${basename}.png`;
    return `![Mermaid diagram ${index}](${relPath})`;
  });
}

function sanitizeMermaid(source) {
  return source.replace(/\b([A-Za-z][\w]*)\[([^\n]*\[[^\n]*\][^\n]*)\]/g, (_match, id, label) => {
    const escaped = label.replace(/\\/g, "\\\\").replace(/"/g, '\\"');
    return `${id}["${escaped}"]`;
  });
}

function polishTypstBody(body) {
  return body.replace(
    /#box\(image\("([^"]+\.png)", alt: "([^"]+)"\)\)/g,
    '#align(center)[#image("$1", alt: "$2")]',
  );
}

function typstString(value) {
  return `"${value.replace(/\\/g, "\\\\").replace(/"/g, '\\"')}"`;
}
