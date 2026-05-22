object liga{
    const guardianes = []
    const candidatos = []
    var property rolDestacado = inicial // consulta para Zoe, indicación para la liga.


    method fuerzaTotal() = guardianes.sum({g => g.fuerza()})
    method puedeSoportarAtaque(fuerzaAtaque) = self.fuerzaTotal() > fuerzaAtaque*2
    method losQueSuperaranEvaluacionPara(unRol) = candidatos.filter({c => unRol.cumpleRequisitos(c)}) // punto 6


    method entrenarCandidatos(){
        candidatos.forEach({c => c.entrenar()})
    }

    method superarEvaluacionPara(unRol){
        guardianes.addAll(self.losQueSuperaranEvaluacionPara(unRol))
        candidatos.removeAll(self.losQueSuperaranEvaluacionPara(unRol))
    }


}
object ayudante{
    var valorMinimo = 0
    var valorMaximo = 100

    method cumpleRequisitos(unCandidato) = unCandidato.fuerza().between(valorMinimo, valorMaximo)
    
    method cambiarValorMinimo(unValor){ // Si el nuevo mínimo es más grande, se queda al mismo valor que el máximo.
        valorMinimo = 0.max(unValor).min(valorMaximo)
    }
    method cambiarValorMaximo(unValor){ // Si el nuevo maximo es más chico, se queda al mismo valor que el mínimo.
        valorMaximo = valorMinimo.max(unValor)
    }
}
object estratega{
    method cumpleRequisitos(unCandidato) = unCandidato.tieneEstudiosAvanzados()
}
object inicial{
    method cumpleRequisitos(unCandidato) = true
}


object helia{
    method fuerza() = 22
    method tieneEstudiosAvanzados() = false
    method entrenar(){}
}
object astro{
    var armasManejadas = 0

    method fuerza() = armasManejadas * 10
    method tieneEstudiosAvanzados() = armasManejadas > 5
    method entrenar(){
        armasManejadas += 1
    }
}
object zoe{
    const rolesAprendidos = []

    method fuerza() = 8 + self.rolesDistintosAprendidos().size()
    method rolesDistintosAprendidos() = rolesAprendidos.withoutDuplicates()
    method tieneEstudiosAvanzados() = rolesAprendidos.contains(estratega)
    method entrenar(){
        rolesAprendidos.add(liga.rolDestacado())
    }
}