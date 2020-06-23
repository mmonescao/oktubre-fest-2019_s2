import marcas.*
import carpas.*

class Persona {
	var property peso = 0
	const property jarras = []
	const property carpasDondeTomo =[]
	var property leGustaLaMusica = true
	var property nivelDeAguante = 0
	var property carpaActual = []
	
	method nacionalidad()
	
	method gastoTotalEnCerveza(){
		return jarras.map({jarra => jarra.precio()}).sum()
	}
	
	method jarraMasCara(){
		return jarras.map({jarra => jarra.precio()}).max()
	}
	
	method alcoholIngerido(){
		return jarras.sum({jarra=> jarra.contenidoDeAlcohol()})
	}
	
	method seEmborracho(){
		return self.alcoholIngerido() * peso > nivelDeAguante
	}
	
	method tomar(jarra){ 
		jarras.add(jarra)
		carpasDondeTomo.add(jarra.deLaCarpa())
	}
	
	method entrar(carpa){
		if(carpa.puedeEntrar(self) and carpaActual.isEmpty()){
			carpa.entra(self)
			carpaActual.add(carpa)
		} else {
			 self.error("La persona no puede entrar a la carpa")
		}
	}
	
	method salirDeCarpa(){
		if (not carpaActual.isEmpty()){
			carpaActual.first().sale(self)
			carpaActual.clear()
		} else {
			self.error("La persona no esta en la carpa")
		}
	}
	
	method leGusta(cerveza){return true}
	
	method quiereEntrarA(carpa){
		return self.leGusta(carpa.cervezaQueVende().marca()) and carpa.tieneMusica() == self.leGustaLaMusica()
	}
	
	method ebrioEmpedernido(){
		return jarras.all({jarra => jarra.litrosDeJarra() >= 1})
	}
	
	method esPatriota(){
		return jarras.all({jarra=> jarra.cerveza().paisDeOrigen() == self.nacionalidad()})
	}
	
	method marcasQueCompro(){
		return jarras.map({jarra=> jarra.marcaDeJarra()}).asSet()
	}
	
	method coincidenciasCon(otraPersona){
		return self.marcasQueCompro().intersection(otraPersona.marcasQueCompro()) 
	}
	
	method diferenciasCon(otraPersona){
		return self.marcasQueCompro().difference(otraPersona.marcasQueCompro())
	}
	
	method esCompatibleCon(otraPersona){
		return self.coincidenciasCon(otraPersona).asList().size() > self.diferenciasCon(otraPersona).asList().size()
	}
	
	method enQueCarpasTomo(){return carpasDondeTomo.withoutDuplicates()}
	
	method tomoEnCarpa(carpa){return carpasDondeTomo.contains(carpa)}
	
	method estaEntrandoEnVicio(){
		if(jarras.size() <= 1){
			return false
		} else {
			return (1..jarras.size() - 1).all({n => jarras.get(n).litrosDeJarra() >= jarras.get(n-1).litrosDeJarra()})
		}
	}

}

class Belga inherits Persona {
	override method leGusta(cerveza){return cerveza.lupulo() > 4}
	
	override method nacionalidad(){return belgica}
}

class Checo inherits Persona {
	override method leGusta(cerveza){return cerveza.graduacion() > 8}
	
	override method nacionalidad(){return repCheca}
}

class Aleman inherits Persona {
	override method quiereEntrarA(carpa){
		return super(carpa) and carpa.hayGentePar()
	}
	
	override method nacionalidad(){return alemania}
}