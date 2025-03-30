# ===== cargar_datos() =====
# Lee las bases de datos necesarias para el simulador

cargar_datos <- function(path_noticias = "noticias_bolsa.csv") {
  url_respaldo <- "https://raw.githubusercontent.com/brianmsm/bolsa-valores-r/main/noticias_bolsa.csv"

  if (!file.exists(path_noticias)) {
    warning("⚠️  Archivo de noticias no encontrado localmente. Intentando descargar desde internet...")

    tryCatch({
      download.file(url_respaldo, destfile = path_noticias, quiet = TRUE)
      cat("✅ Archivo de noticias descargado correctamente.\n")
    }, error = function(e) {
      stop("❌ No se pudo descargar el archivo de noticias desde GitHub. Verifica tu conexión.")
    })
  }
  
  # Dado que solo se puede cargar un archivo, los datos de empresa 
  # se ingresan de forman manual.
  # path_empresas = "datos_empresas.csv" # Esto se quitó de argumento
                                         # de la función
  # if (!file.exists(path_empresas)) {
  #   stop("No se encontró el archivo de empresas: ", path_empresas)
  # }

  # Leer datos
  noticias <- read.csv(path_noticias, stringsAsFactors = FALSE, encoding = "UTF-8")
  
  # empresas <- read.csv(path_empresas, stringsAsFactors = FALSE, encoding = "UTF-8")

  empresas <- data.frame(
    ID = 1:5,
    Nombre = c("TechNova", "FarmaSalud", "GeoMiner", "Renova", "VoltEner"),
    Sector = c("Tecnología", "Farmacéutica", "Minería", "Renovables", "Energía"),
    PrecioInicial = c(150, 90, 60, 110, 100),
    AccionesDisponibles = c(20, 25, 30, 22, 24),
    stringsAsFactors = FALSE
  )

  # Validaciones mínimas
  if (!all(c("ID", "Area", "Noticia", "Impacto") %in% names(noticias))) {
    stop("El archivo de noticias no contiene las columnas esperadas.")
  }

  if (!all(c("ID", "Nombre", "Sector", "PrecioInicial", "AccionesDisponibles") %in% names(empresas))) {
    stop("El archivo de empresas no contiene las columnas esperadas.")
  }

  return(list(noticias = noticias, empresas = empresas))
}
