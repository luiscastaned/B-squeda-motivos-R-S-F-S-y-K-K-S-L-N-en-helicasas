Análisis de motivos helicasa tipo URH49/UAP56 en Entamoeba histolytica

Este repositorio contiene un script en R diseñado para identificar posibles motivos funcionales relacionados con la exportación de circRNAs en helicasas de Entamoeba histolytica, basándose en la caracterización de las helicasas DDX39A (URH49) y DDX39B (UAP56) en humanos.

🔍 Objetivo

El código busca dentro de un conjunto de secuencias proteicas (archivo FASTA) la presencia de:

Motivos tetrapéptidos exactos asociados a la preferencia de exportación de circRNAs:

Tipo URH49-like: RSFS, RSFT, etc. (motivos que predicen afinidad por circRNAs cortos).

Tipo UAP56-like: KSLN, KKLN, etc. (afinidad por circRNAs largos).

En caso de no encontrar coincidencias exactas, el script identifica secuencias que contengan al menos los dos aminoácidos iniciales de dichos motivos (p. ej., RS, KS, KT, etc.), como señal de convergencia funcional parcial.

Datos utilizados

El archivo Helicasas.faa contiene 6 helicasas de E. histolytica seleccionadas por doble criterio:

Presencia experimental en complejos de empalme (spliceosoma) documentados en el estudio:

Valdés et al., Journal of Proteomics (2014).
Proteomic analysis of Entamoeba histolytica in vivo assembled pre-mRNA splicing complexes

Similaridad por BLASTp con la helicasa humana DDX39A (URH49) —proteína especializada en la exportación de circRNAs cortos—, con buenas puntuaciones de identidad y cobertura.

📂 Contenido del repositorio

Helicasas.faa: archivo FASTA con las 6 helicasas candidatas.

analisis_motivos_helicasa.R: script en R que realiza la búsqueda de motivos exactos y parciales.
