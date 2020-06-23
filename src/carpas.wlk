import personas.*
import marcas.*

class Carpa {
	var property limiteDeGente = 0
	const property personasEnCarpa = []
	var property tieneMusica = false
	var property cervezaQueVende
	var property tipoDeRecargo = recargoFijo
	
	method precioDeVenta(){
		return tipoDeRecargo.recargo(self) * cervezaQueVende.precioSinRecargo()
	}
	method cuantosEbriosHay(){
		return personasEnCarpa.count({persona => persona.seEmborracho()})
	}
	
	method porcentajeDeEbriedad(){
		return (self.cuantosEbriosHay() * 100) / personasEnCarpa.size()
	}
	
	method hayGentePar(){
		return personasEnCarpa.size().even()
	}
	
	method superaLimiteDeGente(){
		return (personasEnCarpa.size() + 1) > limiteDeGente
	}
	
	method dejaEntrarA(persona){
		return not self.superaLimiteDeGente() and not persona.seEmborracho()
	}
	
	method puedeEntrar(persona){
		return persona.quiereEntrarA(self) and self.dejaEntrarA(persona)
	}
	
	method entra(persona){
		if(self.puedeEntrar(persona)){
			personasEnCarpa.add(persona)
		} else {
			self.error("La persona no puede entrar a la carpa")
		}
	}
	
	method sale(persona){
		if(self.estaEnLaCarpa(persona)){
			personasEnCarpa.remove(persona)
		} else {
			self.error("La persona no esta en la carpa")
		}
	}
	
	method estaEnLaCarpa(persona){
		return personasEnCarpa.contains(persona)
	}
	
	method servir(persona, litros){
		if(self.estaEnLaCarpa(persona)){
			persona.tomar(new Jarra(cerveza = cervezaQueVende, litrosDeJarra = litros, deLaCarpa = self, precio = self.precioDeVenta()))
		} else {
			self.error("La persona no esta en la carpa")
		}
	}
	
	method cantidadDeEbriosEmpedernidos(){
		return personasEnCarpa.count({persona => persona.ebrioEmpedernido()})
	}
	
	method esHomogenea(){
		const primeraPersona = personasEnCarpa.get(0)
		return personasEnCarpa.all({persona => persona.nacionalidad() == primeraPersona.nacionalidad()})
	}
	
	method quienesNoTomaron(){
		return personasEnCarpa.filter({persona => not persona.tomoEnCarpa(self)})
	}
	
		
	method unaRonda(){
		personasEnCarpa.forEach({persona => self.servir(persona, 1)})
	}
}

object recargoFijo{
	method recargo(carpa){return 1.3}
}

object recargoPorCantidad {
	
	method recargo(carpa){
		if(carpa.personasEnCarpa().size() >= carpa.limiteDeGente() / 2){
			return 1.4
		} else {
			return 1.25
		}
	}
}

object recargoPorEbriedad {

	method recargo(carpa){
		if(carpa.porcentajeDeEbriedad() >= 75){
			return 1.5
		} else {
			return 1.2
		}
	}
}