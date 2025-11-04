# Librerías necesarias
library(Biostrings)
library(stringr)

# Ruta al archivo FASTA
ruta <- "C:/Users/Luis Castañeda/Documents/Data/Helicasas/Helicasas.faa"

# Cargar secuencias
secuencias <- readAAStringSet(ruta)

# Generar tetrapéptidos completos
urh49_variants <- as.vector(outer(outer(c("R", "K"), c("S", "T"), paste0), 
                                  outer(c("F", "Y"), c("S", "T", "N"), paste0), paste0))
uap56_variants <- as.vector(outer(outer(c("S", "T"), c("L", "F", "Y"), paste0), 
                                  c("N", "S", "T"), paste0))
uap56_variants <- paste0("K", uap56_variants)

# Bipéptidos iniciales de interés (primeros 2 aa)
bipeptidos <- unique(substr(c(urh49_variants, uap56_variants), 1, 2))

# Función de búsqueda
buscar_motivos <- function(seq, id) {
  resultados <- list()
  
  # Buscar tetrapéptidos exactos
  hits_4aa <- lapply(c(urh49_variants, uap56_variants), function(motif) {
    pos <- gregexpr(motif, seq, fixed = TRUE)[[1]]
    if (pos[1] != -1) {
      data.frame(ID = id, Motivo = motif, Posición = pos, Tipo = "Exacto_4aa", stringsAsFactors = FALSE)
    } else {
      NULL
    }
  })
  hits_4aa <- do.call(rbind, Filter(Negate(is.null), hits_4aa))
  
  # Buscar bipéptidos si no hay tetrapéptidos
  hits_2aa <- lapply(bipeptidos, function(bp) {
    pos <- gregexpr(bp, seq, fixed = TRUE)[[1]]
    if (pos[1] != -1) {
      data.frame(ID = id, Motivo = bp, Posición = pos, Tipo = "Parcial_2aa", stringsAsFactors = FALSE)
    } else {
      NULL
    }
  })
  hits_2aa <- do.call(rbind, Filter(Negate(is.null), hits_2aa))
  
  # Retornar lo encontrado o nota de ausencia
  if (!is.null(hits_4aa)) {
    return(hits_4aa)
  } else if (!is.null(hits_2aa)) {
    return(hits_2aa)
  } else {
    return(data.frame(ID = id, Motivo = NA, Posición = NA, Tipo = "No encontrado", stringsAsFactors = FALSE))
  }
}

# Ejecutar en todas las secuencias
resultado <- do.call(rbind, lapply(seq_along(secuencias), function(i) {
  buscar_motivos(as.character(secuencias[[i]]), names(secuencias)[i])
}))

# Mostrar resultado
print(resultado)

