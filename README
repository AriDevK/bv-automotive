# B&V Automotive Website

Sitio web estatico para B&V Automotive Rental Cars LLC (Woodstock, Georgia), con flujo de build basado en Make para minificar assets, optimizar imagenes y validar referencias del HTML.

## Tecnologias

- HTML5
- CSS3
- JavaScript (vanilla)
- Makefile para automatizacion
- Node.js para utilidades de build via `npx`

## Estructura del proyecto

```text
.
|-- index.html
|-- Makefile
|-- README
|-- .nvmrc
|-- assets/
|   |-- css/
|   |   |-- styles.css
|   |   `-- styles.min.css
|   |-- js/
|   |   |-- script.js
|   |   `-- script.min.js
|   `-- img/
|       |-- carrousel/
|       `-- common/
`-- .github/workflows/
	`-- deploy.yml
```

## Requisitos

- Node.js `26.4.0` (definido en `.nvmrc`)
- `make`

## Instalacion local

Si usas `nvm`:

```bash
nvm install
nvm use
```

## Comandos disponibles

### `make build`

Ejecuta el flujo completo:

1. Minifica CSS y JS.
2. Convierte imagenes `jpg/jpeg/png` en `assets/img/*/` a `webp`.
3. Actualiza `index.html` para usar:
   - imagenes `webp` en `assets/img/`
   - `styles.min.css` en `assets/css/`
   - `script.min.js` en `assets/js/`

### `make minify`

Genera:

- `assets/css/styles.min.css`
- `assets/js/script.min.js`

### `make optimize-images`

Genera archivos `.webp` a partir de:

- `assets/img/*/*.jpg`
- `assets/img/*/*.jpeg`
- `assets/img/*/*.png`

### `make validate-html`

Actualiza referencias en `index.html` para apuntar a assets optimizados.

### `make clean`

Elimina los `.webp` generados por `make optimize-images`.

### `make dev`

Ejecuta `make build` y luego levanta servidor local con `live-server`.

## Pipeline de GitHub Actions

El workflow en `.github/workflows/deploy.yml` se dispara en cada push a `main` y ejecuta en el servidor remoto:

1. `git fetch origin`
2. `git reset --hard origin/main`
3. `make build`

## Troubleshooting

### Error de permisos al minificar

Si aparece `Permission denied` al escribir archivos `.min.*`, corrige dueño/permisos:

```bash
sudo chown "$USER":staff assets/css/styles.min.css assets/js/script.min.js
```

### Node version

Valida la version activa:

```bash
node -v
```

Debe ser compatible con `26.4.0`.
