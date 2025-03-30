entrada_id_valida <- function(prompt_text, ids_validos) {
  repeat {
    entrada <- readline(prompt = prompt_text)
    
    if (!grepl("^[0-9]+$", entrada)) {
      cat("❌ Entrada inválida. Debes ingresar un número.\n")
    } else {
      id <- as.integer(entrada)
      if (id %in% ids_validos) {
        return(id)
      } else {
        cat("❌ ID no válido. Elige uno de los siguientes:", paste(ids_validos, collapse = ", "), "\n")
      }
    }
  }
}
