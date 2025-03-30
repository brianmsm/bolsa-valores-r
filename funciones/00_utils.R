# ===== entrada_id_valida() =====
# Verificar que se está ingresando una opción válida

entrada_id_valida <- function(prompt, ids_validos) {
  repeat {
    entrada <- readline(prompt)
    
    if (entrada == "0") {
      cat("🔙 Operación cancelada. Volviendo al menú.\n")
      return(0)
    }
    
    if (grepl("^[0-9]+$", entrada)) {
      id <- as.integer(entrada)
      if (id %in% ids_validos) {
        return(id)
      }
    }
    
    cat("❌ ID no válido. Elige uno de los siguientes:", paste(ids_validos, collapse = ", "), "\n")
    cat("💡 Ingresa 0 para cancelar y volver al menú.\n")
  }
}

# ===== cartera_con_valor_actual() =====
# Devuelve la cartera con columna PrecioActual unida desde datos_empresas

cartera_con_valor_actual <- function(estado) {
  cartera_extendida <- merge(
    estado$cartera,
    estado$datos_empresas[, c("ID", "PrecioActual")],
    by = "ID"
  )
  cartera_extendida <- cartera_extendida[, c("ID", "Empresa", "Cantidad", "PrecioCompra", "PrecioActual")]
  return(cartera_extendida)
}
