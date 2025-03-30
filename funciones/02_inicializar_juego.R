# ===== inicializar_juego() =====
# Inicializa el estado del juego con opción de mensajes

inicializar_juego <- function(capital_inicial = 2000, verbose = TRUE) {
  datos <- cargar_datos()
  
  # Añadir columna de PrecioActual
  datos$empresas$PrecioActual <- datos$empresas$PrecioInicial
  
  estado <- list(
    dia = 1,
    capital = capital_inicial,
    cartera = data.frame(
      ID = integer(),
      Empresa = character(),
      Cantidad = integer(),
      PrecioCompra = numeric(),
      stringsAsFactors = FALSE
    ),
    historial_noticias = character(),
    datos_empresas = datos$empresas,
    noticias = datos$noticias
  )
  
  if (isTRUE(verbose)) {
    cat("🎮 Bienvenido al Simulador de Bolsa\n")
    cat("💰 Capital inicial:", estado$capital, "euros\n")
    cat("📈 Turnos: 20 días\n")
    cat("📦 Acciones disponibles:", nrow(estado$datos_empresas), "empresas\n")
  }
  
  return(estado)
}
